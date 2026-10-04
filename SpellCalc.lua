-- ============================================================================
-- SpellCalc - Spell Damage/Healing Calculator for Turtle WoW (1.12)
-- All ranks, cooldowns factored into DPS/HPS, talent & SP/HP support
-- Usage: /spellcalc or /sc
-- ============================================================================

SpellCalc = {}
SpellCalc.frame = nil
SpellCalc.rows = {}
SpellCalc.currentFilter = "all" -- "all", "damage", "healing"
SpellCalc.sortColumn = "avg"
SpellCalc.sortAsc = false
SpellCalc.cachedData = nil
SpellCalc.talentCache = {}
SpellCalc.spManual = nil
SpellCalc.hpManual = nil
SpellCalc.scrollOffset = 0
SpellCalc.showAllRanks = true -- toggle to show/hide lower ranks
SpellCalc.onlyLearned = false -- [patch] only show spells from the spellbook
SpellCalc.knownCache = nil

local NUM_VISIBLE_ROWS = 18
local ROW_HEIGHT = 20
local FRAME_WIDTH = 740
local FRAME_HEIGHT = 520

-- [patch] added the "Scaling" column: what percentage of spell power arrives
-- per cast. It sits right next to the average value, so you can see which
-- rank benefits from additional spell power at all.
local COL_WIDTHS = { 200, 55, 75, 55, 70, 65, 50, 45 }
local COL_HEADERS = { "Spell", "School", "Avg Value", "Scaling", "/Mana", "/Sec", "Mana", "CD" }
local COL_KEYS   = { "name", "school", "avg", "coeff", "mana", "dps", "cost", "cd" }
local COL_OFFSETS = {}

-- ============================================================================
-- UTILITY
-- ============================================================================

local function Round(val, decimals)
    local mult = 10 ^ (decimals or 1)
    return math.floor(val * mult + 0.5) / mult
end

local function GetPlayerClass()
    local _, class = UnitClass("player")
    return class
end

local function FormatCD(seconds)
    if not seconds or seconds == 0 then return "-" end
    if seconds >= 60 then
        return string.format("%dm", seconds / 60)
    end
    return string.format("%ds", seconds)
end

-- ============================================================================
-- TALENT SCANNING
-- ============================================================================

function SpellCalc:ScanTalents()
    self.talentCache = {}
    local playerClass = GetPlayerClass()
    local talentDefs = SPELLCALC_TALENTS[playerClass]
    if not talentDefs then return end

    for tab = 1, GetNumTalentTabs() do
        for i = 1, GetNumTalents(tab) do
            local tName, _, _, _, rank = GetTalentInfo(tab, i)
            if tName and rank and rank > 0 then
                for _, tDef in ipairs(talentDefs) do
                    -- [patch] buff: talent only applies with an active buff/form
                    -- (e.g. Shadowform), detected by the buff's icon
                    if tName == tDef.name and (not tDef.buff or self:HasBuff(tDef.buff)) then
                        -- [patch] "key" allows several entries per talent
                        -- (e.g. Force of Will: damage AND shield)
                        self.talentCache[tDef.key or tDef.name] = {
                            rank = rank,
                            perRank = tDef.perRank,
                            values = tDef.values,
                            maxRank = tDef.maxRank,
                            affectType = tDef.affectType,
                            affectSchool = tDef.affectSchool,
                            affectSpells = tDef.affectSpells,
                            part = tDef.part,
                            mod = tDef.mod,
                        }
                    end
                end
            end
        end
    end
end

-- [patch] Finds a player buff by part of its icon name.
-- In 1.12 UnitBuff only returns the icon, not the name.
function SpellCalc:HasBuff(iconPart)
    local needle = string.lower(iconPart)
    for i = 1, 32 do
        local tex = UnitBuff("player", i)
        if not tex then break end
        if string.find(string.lower(tex), needle, 1, true) then return true end
    end
    return false
end

-- [patch] Bonus of a talent at its current rank. "values" for talents that
-- do not scale linearly (e.g. Improved Cone of Cold 15/25/35%).
function SpellCalc:TalentBonus(tData)
    if tData.values then
        return tData.values[tData.rank] or tData.values[table.getn(tData.values)] or 0
    end
    return (tData.perRank or 0) * tData.rank
end

-- [patch] part: "direct" or "dot". Talents with a part only affect that
-- part (e.g. Genesis only periodic effects), without part they affect both.
-- part == nil means "any part" (for tooltip/display).
-- Without affectType the talent affects damage and healing spells.
function SpellCalc:TalentApplies(tData, spellName, school, isDamage, part)
    local affType = isDamage and "damage" or "healing"
    if tData.affectType and tData.affectType ~= affType and tData.affectType ~= "both" then return false end
    if part and tData.part and tData.part ~= part then return false end
    if tData.affectSpells then
        for _, sName in ipairs(tData.affectSpells) do
            if sName == spellName then return true end
        end
        return false
    elseif tData.affectSchool == "all" then
        return true
    elseif type(tData.affectSchool) == "table" then
        for _, s in ipairs(tData.affectSchool) do
            if s == school then return true end
        end
    end
    return false
end

-- damage/healing multiplier (only talents without "mod")
function SpellCalc:GetTalentMultiplier(spellName, school, isDamage, part)
    local mult = 1.0
    for tName, tData in pairs(self.talentCache) do
        if not tData.mod and self:TalentApplies(tData, spellName, school, isDamage, part or "direct") then
            mult = mult + self:TalentBonus(tData)
        end
    end
    return mult
end

-- [patch] sum of all talents of one kind ("mod"):
--   cast       cast time in seconds (negative = faster)
--   cd         cooldown in seconds
--   duration   DoT/HoT duration in seconds (more ticks)
--   cost       mana cost as a fraction (-0.05 = 5% cheaper)
--   crit       additional crit chance as a fraction (0.02 = 2%)
--   critbonus  additional crit bonus as a fraction (1.0 = crit x2 instead of x1.5)
function SpellCalc:GetTalentMod(mod, spellName, school, isDamage)
    local total = 0
    for tName, tData in pairs(self.talentCache) do
        if tData.mod == mod and self:TalentApplies(tData, spellName, school, isDamage, nil) then
            total = total + self:TalentBonus(tData)
        end
    end
    return total
end

-- ============================================================================
-- STAT READING
-- ============================================================================

-- [patch] Vanilla 1.12 does not know GetSpellBonusDamage and
-- GetSpellBonusHealing - the values only exist in item tooltips. That is why
-- this always returned 0. BetterCharacterStats already evaluates the gear,
-- so we read the values from there.
--
-- BCS separates cleanly:
--   damage_and_healing  counts for damage AND healing
--   only_damage         damage only
--   healing             healing only
--   holy/fire/...       school-specific bonus on top
local BCS_SCHOOL = { [2] = "holy", [3] = "fire", [4] = "nature",
                     [5] = "frost", [6] = "shadow", [7] = "arcane" }

function SpellCalc:BCSReady()
    if not BCS or not BCS.GetSpellPower or not BCS.GetHealingPower then return nil end
    -- BCS only rescans when dirty flags are set, so the call is cheap
    if BCS.RunScans then BCS:RunScans() end
    return true
end

function SpellCalc:GetSchoolBonus(school)
    local key = BCS_SCHOOL[school]
    if not key or not self:BCSReady() then return 0 end
    return BCS:GetSpellPower(key) or 0
end

-- spell power that applies to every school
function SpellCalc:GetGenericSpellPower()
    if not self:BCSReady() then return nil end
    local damageAndHealing, _, _, damageOnly = BCS:GetSpellPower()
    return (damageAndHealing or 0) + (damageOnly or 0)
end

function SpellCalc:GetSpellPower(school)
    if self.spManual then return self.spManual end

    local generic = self:GetGenericSpellPower()
    if generic then
        return generic + self:GetSchoolBonus(school)
    end

    -- clients that do ship the TBC API
    if GetSpellBonusDamage then
        local best = 0
        if school then
            best = GetSpellBonusDamage(school) or 0
        else
            for i = 2, 7 do
                local v = GetSpellBonusDamage(i) or 0
                if v > best then best = v end
            end
        end
        return best
    end
    return 0
end

function SpellCalc:GetHealingPower()
    if self.hpManual then return self.hpManual end

    if self:BCSReady() then
        -- damage_and_healing also applies to healing, only_damage does not
        local damageAndHealing = BCS:GetSpellPower()
        local healOnly = BCS:GetHealingPower()
        return (damageAndHealing or 0) + (healOnly or 0)
    end

    if GetSpellBonusHealing then
        return GetSpellBonusHealing() or 0
    end
    return 0
end

-- [patch] General spell crit chance in percent (base, intellect, gear,
-- buffs) from BetterCharacterStats. Spell-specific talents
-- are added by SpellCalc itself.
function SpellCalc:GetSpellCrit()
    if self.critManual then return self.critManual end
    if self:BCSReady() and BCS.GetSpellCritChance then
        return BCS:GetSpellCritChance() or 0
    end
    return 0
end

-- [patch] base mana = max mana without the part from intellect
-- (the first 20 int give 1 mana each, every further point 15).
function SpellCalc:GetBaseMana()
    local maxMana = UnitManaMax("player") or 0
    local _, int = UnitStat("player", 4)
    int = int or 0
    local fromInt = int
    if int > 20 then fromInt = 20 + (int - 20) * 15 end
    return math.max(maxMana - fromInt, 0)
end

-- ============================================================================
-- SPELL CALCULATION (with cooldown)
-- ============================================================================

function SpellCalc:CalcSpell(spellData)
    local result = {}
    result.name = spellData.name
    result.rank = spellData.rank
    result.school = spellData.school
    result.spellType = spellData.spellType
    result.isAoE = spellData.isAoE
    result.level = spellData.level or 60
    result.isHeal = false
    result.isDot = false

    local sType = spellData.spellType
    local isHealType = (sType == "heal" or sType == "hot" or sType == "dd+hot" or sType == "ch_heal")
    result.isHeal = isHealType
    local name, school, isDamage = spellData.name, spellData.school, not isHealType
    local isChannel = (sType == "ch_dmg" or sType == "ch_heal")

    -- [patch] talents affecting cast time, cooldown, duration and cost
    result.castTime = spellData.castTime or 0
    if not isChannel then
        result.castTime = math.max(0, result.castTime + self:GetTalentMod("cast", name, school, isDamage))
    end
    result.cd = math.max(0, (spellData.cd or 0) + self:GetTalentMod("cd", name, school, isDamage))

    local cost = spellData.manaCost or 0
    -- [patch] some spells cost a percentage of base mana (e.g. Chastise)
    if cost == 0 and spellData.manaPct then
        cost = self:GetBaseMana() * spellData.manaPct / 100
    end
    local costMod = self:GetTalentMod("cost", name, school, isDamage)
    result.manaCost = math.max(0, math.floor(cost * (1 + costMod) + 0.5))

    -- longer DoTs/HoTs: more ticks, so more base value and more scaling
    local dotDuration = spellData.dotDuration
    local dotTotalBase = spellData.dotTotal or 0
    local dotCoeffVal = spellData.dotCoeff or 0
    if dotDuration and dotDuration > 0 then
        local extra = self:GetTalentMod("duration", name, school, isDamage)
        if extra ~= 0 then
            local f = (dotDuration + extra) / dotDuration
            dotTotalBase = dotTotalBase * f
            dotCoeffVal = dotCoeffVal * f
            dotDuration = dotDuration + extra
        end
    end

    local sp = isHealType and self:GetHealingPower() or self:GetSpellPower(school)
    -- [patch] direct and periodic parts kept separate, because some talents
    -- only boost one of them. Channelled spells count as periodic.
    local directMult = self:GetTalentMultiplier(name, school, isDamage, "direct")
    local dotMult = self:GetTalentMultiplier(name, school, isDamage, "dot")
    local talentMult = directMult
    if sType == "dot" or sType == "hot" or isChannel then
        talentMult = dotMult
    end

    -- [patch] crit: only the direct part can crit, DoT/HoT ticks cannot.
    -- Channelled spells only if they deal individual hits
    -- (canCrit, e.g. Arcane Missiles). Absorbs (noCrit) never.
    local canCrit = (not spellData.noCrit) and (spellData.canCrit or not (sType == "dot" or sType == "hot" or isChannel))
    local critMult = 1
    if canCrit then
        local chance = (self:GetSpellCrit() / 100) + self:GetTalentMod("crit", name, school, isDamage)
        chance = math.max(0, math.min(chance, 1))
        local bonus = 0.5 * (1 + self:GetTalentMod("critbonus", name, school, isDamage))
        critMult = 1 + chance * bonus
        result.critChance = chance
        result.critDamage = 1 + bonus
    end
    result.canCrit = canCrit and true or false

    -- Effective time for per-second calculation:
    -- Use the LONGEST of: cast time, GCD (1.5s), or cooldown
    local gcd = 1.5
    local effectiveCast = math.max(result.castTime, gcd)
    local effectiveTime = math.max(effectiveCast, result.cd)

    if sType == "damage" or sType == "heal" then
        local coeff = isHealType and (spellData.hpCoeff or 0) or (spellData.spCoeff or 0)
        local baseAvg = ((spellData.minDmg or 0) + (spellData.maxDmg or 0)) / 2
        local total = (baseAvg + sp * coeff) * talentMult * critMult

        result.avgValue = Round(total, 1)
        result.perMana = Round(total / math.max(result.manaCost, 1), 2)
        result.perSecond = Round(total / effectiveTime, 1)

    elseif sType == "dot" or sType == "hot" then
        result.isDot = true
        local total = (dotTotalBase + sp * dotCoeffVal) * talentMult

        result.avgValue = Round(total, 1)
        result.perMana = Round(total / math.max(result.manaCost, 1), 2)
        -- For DoTs: effective time is the longer of dot duration or cooldown
        local dotEffective = math.max(dotDuration or 1, result.cd)
        result.perSecond = Round(total / dotEffective, 1)
        result.dotDuration = dotDuration

    elseif sType == "dd+dot" or sType == "dd+hot" then
        result.isDot = true
        local directCoeff = isHealType and (spellData.hpCoeff or 0) or (spellData.spCoeff or 0)

        local directAvg = ((spellData.minDmg or 0) + (spellData.maxDmg or 0)) / 2
        local directTotal = (directAvg + sp * directCoeff) * directMult * critMult
        local dotTotal = (dotTotalBase + sp * dotCoeffVal) * dotMult
        local grandTotal = directTotal + dotTotal

        result.avgValue = Round(grandTotal, 1)
        result.directPart = Round(directTotal, 1)
        result.dotPart = Round(dotTotal, 1)
        result.perMana = Round(grandTotal / math.max(result.manaCost, 1), 2)
        -- [patch] /Sec = sustained DPS when casting only this spell:
        -- a direct hit every "cycle" seconds; the DoT is refreshed before
        -- it expires, so it adds at most DoT/duration per second. Before,
        -- this was total / (cast time + DoT duration), which spread e.g.
        -- Pyroblast over 18 s and Moonfire over 19.5 s.
        local cycle = effectiveTime
        local dur = dotDuration or 0
        local dotPerSec = 0
        if dur > 0 then
            dotPerSec = dotTotal / math.max(dur, cycle)
        end
        result.perSecond = Round(directTotal / cycle + dotPerSec, 1)
        -- for the tooltip: value per cast time (when the DoT runs out fully
        -- alongside other spells) and the DoT part per second
        result.perCastTime = Round(grandTotal / cycle, 1)
        result.dotPerSecond = Round(dotPerSec, 1)
        result.dotDuration = dotDuration

    elseif isChannel then
        local coeff = isHealType and (spellData.hpCoeff or 0) or (spellData.spCoeff or 0)
        local baseAvg = ((spellData.minDmg or 0) + (spellData.maxDmg or 0)) / 2
        local total = (baseAvg + sp * coeff) * talentMult * critMult

        result.avgValue = Round(total, 1)
        result.perMana = Round(total / math.max(result.manaCost, 1), 2)
        -- Channel time is the cast, but cooldown might be longer
        local chanTime = math.max(result.castTime, result.cd)
        result.perSecond = Round(total / chanTime, 1)
    end

    -- [patch] scaling: share of spell power that arrives per cast.
    -- For direct damage plus DoT combinations both count together,
    -- because both parts come from the same cast.
    local directCoeff = isHealType and (spellData.hpCoeff or 0) or (spellData.spCoeff or 0)
    if sType == "dot" or sType == "hot" then
        result.coeffDirect, result.coeffDot = 0, dotCoeffVal
    elseif sType == "dd+dot" or sType == "dd+hot" then
        result.coeffDirect, result.coeffDot = directCoeff, dotCoeffVal
    else
        result.coeffDirect, result.coeffDot = directCoeff, 0
    end
    result.coeff = result.coeffDirect + result.coeffDot

    return result
end

function SpellCalc:CalcAllSpells()
    local playerClass = GetPlayerClass()
    local spells = SPELLCALC_SPELLS[playerClass]
    if not spells then return {} end

    self:ScanTalents()
    local results = {}
    for _, spellData in ipairs(spells) do
        table.insert(results, self:CalcSpell(spellData))
    end
    self.cachedData = results
    return results
end

-- [patch] Reads the spellbook.
-- Returns a table with two kinds of keys:
--   ["Renew|2"] = true   -> exactly this rank is learned
--   ["Renew"]   = 2      -> highest learned rank
function SpellCalc:GetKnownSpells()
    if self.knownCache then return self.knownCache end
    local known = {}
    local i = 1
    while true do
        local name, rankText = GetSpellName(i, BOOKTYPE_SPELL)
        if not name then break end
        local rank = 1
        if rankText then
            local _, _, r = string.find(rankText, "(%d+)")
            if r then rank = tonumber(r) or 1 end
        end
        known[name .. "|" .. rank] = true
        if not known[name] or known[name] < rank then
            known[name] = rank
        end
        i = i + 1
    end
    self.knownCache = known
    return known
end

function SpellCalc:GetFilteredSorted()
    if not self.cachedData then self:CalcAllSpells() end
    if not self.cachedData then return {} end

    local filtered = {}
    -- [patch] fetch only once per pass
    local known = nil
    if self.onlyLearned then known = self:GetKnownSpells() end
    for _, r in ipairs(self.cachedData) do
        local show = false
        if self.currentFilter == "all" then show = true
        elseif self.currentFilter == "damage" and not r.isHeal then show = true
        elseif self.currentFilter == "healing" and r.isHeal then show = true
        end
        -- [patch] the rank must be in the spellbook exactly
        -- "Holy Shock (Heal)" etc. appear in the spellbook without the suffix
        local bookName = string.gsub(r.name, " %(Heal%)$", "")
        if show and known and not known[bookName .. "|" .. r.rank] then
            show = false
        end
        if show then table.insert(filtered, r) end
    end

    local col = self.sortColumn
    local asc = self.sortAsc
    table.sort(filtered, function(a, b)
        local va, vb
        if col == "name" then va, vb = a.name .. a.rank, b.name .. b.rank
        elseif col == "avg" then va, vb = a.avgValue or 0, b.avgValue or 0
        elseif col == "coeff" then va, vb = a.coeff or 0, b.coeff or 0
        elseif col == "mana" then va, vb = a.perMana or 0, b.perMana or 0
        elseif col == "dps" then va, vb = a.perSecond or 0, b.perSecond or 0
        elseif col == "cost" then va, vb = a.manaCost or 0, b.manaCost or 0
        elseif col == "cd" then va, vb = a.cd or 0, b.cd or 0
        else va, vb = a.name, b.name end
        if asc then return va < vb else return va > vb end
    end)
    return filtered
end

-- ============================================================================
-- UI CREATION
-- ============================================================================

function SpellCalc:CreateUI()
    if self.frame then return end

    local xOff = 10
    for i, w in ipairs(COL_WIDTHS) do
        COL_OFFSETS[i] = xOff
        xOff = xOff + w + 4
    end

    -- Main Frame
    local f = CreateFrame("Frame", "SpellCalcFrame", UIParent)
    f:SetWidth(FRAME_WIDTH)
    f:SetHeight(FRAME_HEIGHT)
    f:SetPoint("CENTER", 0, 0)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function() this:StartMoving() end)
    f:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
    f:SetFrameStrata("DIALOG")
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    f:SetBackdropColor(0, 0, 0, 0.92)
    self.frame = f

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -14)
    title:SetText("SpellCalc")

    -- Info line
    local infoText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    infoText:SetPoint("TOPLEFT", 16, -36)
    infoText:SetJustifyH("LEFT")
    self.infoText = infoText

    -- Close
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    closeBtn:SetScript("OnClick", function() SpellCalc:Toggle() end)

    -- Refresh
    local refreshBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    refreshBtn:SetWidth(70)
    refreshBtn:SetHeight(20)
    refreshBtn:SetPoint("TOPRIGHT", -36, -34)
    refreshBtn:SetText("Refresh")
    refreshBtn:SetScript("OnClick", function()
        SpellCalc.cachedData = nil
        SpellCalc:UpdateList()
    end)

    -- Filter buttons
    local filterY = -56
    local filters = {
        { text = "All",     filter = "all" },
        { text = "Damage",  filter = "damage" },
        { text = "Healing", filter = "healing" },
    }
    for i, fd in ipairs(filters) do
        local btn = CreateFrame("Button", "SpellCalcFilter"..i, f, "UIPanelButtonTemplate")
        btn:SetWidth(68)
        btn:SetHeight(20)
        btn:SetPoint("TOPLEFT", 10 + (i-1) * 74, filterY)
        btn:SetText(fd.text)
        -- [patch] store the filter on the button and read it via "this". The
        -- upvalue "fd" was nil at click time -> "attempt to index a nil value".
        btn.scFilter = fd.filter
        btn:SetScript("OnClick", function()
            local key = this and this.scFilter
            if not key then return end
            SpellCalc.currentFilter = key
            SpellCalc:UpdateFilterHighlight()
            SpellCalc:UpdateList()
        end)
        fd.btn = btn
    end
    self.filterButtons = filters

    -- [patch] "Learned only" checkbox: hides everything that is not in the
    -- spellbook. Applies on top of All/Damage/Healing.
    local cb = CreateFrame("CheckButton", "SpellCalcOnlyLearned", f, "UICheckButtonTemplate")
    cb:SetWidth(20)
    cb:SetHeight(20)
    cb:SetPoint("TOPLEFT", 10 + 3 * 74, filterY)
    local cbText = getglobal("SpellCalcOnlyLearnedText")
    if cbText then
        cbText:SetText("Learned only")
        cbText:SetFontObject(GameFontNormalSmall)
    end
    cb:SetChecked(SpellCalc.onlyLearned)
    cb:SetScript("OnClick", function()
        SpellCalc.onlyLearned = this:GetChecked() and true or false
        if type(SpellCalcSettings) == "table" then
            SpellCalcSettings.onlyLearned = SpellCalc.onlyLearned
        end
        SpellCalc.knownCache = nil
        SpellCalc:UpdateList()
    end)
    self.onlyLearnedCB = cb

    -- Column Headers
    local headerY = -80
    self.headerButtons = {}
    for i, hdr in ipairs(COL_HEADERS) do
        local hBtn = CreateFrame("Button", nil, f)
        hBtn:SetWidth(COL_WIDTHS[i])
        hBtn:SetHeight(16)
        hBtn:SetPoint("TOPLEFT", COL_OFFSETS[i], headerY)
        local hText = hBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        hText:SetPoint("LEFT", 0, 0)
        hText:SetJustifyH(i >= 3 and "RIGHT" or "LEFT")
        hText:SetWidth(COL_WIDTHS[i])
        hBtn.text = hText
        local colKey = COL_KEYS[i]
        hBtn.scKey = colKey          -- [patch] see filter buttons
        hBtn:SetScript("OnClick", function()
            local key = this and this.scKey
            if not key or key == "school" then return end
            if SpellCalc.sortColumn == key then
                SpellCalc.sortAsc = not SpellCalc.sortAsc
            else
                SpellCalc.sortColumn = key
                SpellCalc.sortAsc = (key == "name")
            end
            SpellCalc:UpdateHeaders()
            SpellCalc:UpdateList()
        end)
        table.insert(self.headerButtons, { btn = hBtn, text = hText, key = colKey })
    end

    -- Separator
    local sep = f:CreateTexture(nil, "ARTWORK")
    sep:SetTexture(1, 0.82, 0, 0.4)
    sep:SetHeight(1)
    sep:SetPoint("TOPLEFT", 10, headerY - 16)
    sep:SetPoint("TOPRIGHT", -10, headerY - 16)

    -- Scroll Frame
    local scrollParent = CreateFrame("Frame", nil, f)
    scrollParent:SetPoint("TOPLEFT", 4, headerY - 18)
    scrollParent:SetPoint("BOTTOMRIGHT", -28, 36)

    local scrollFrame = CreateFrame("ScrollFrame", "SpellCalcScrollFrame", scrollParent, "FauxScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -4, 0)
    scrollFrame:SetScript("OnVerticalScroll", function()
        FauxScrollFrame_OnVerticalScroll(ROW_HEIGHT, function() SpellCalc:UpdateList() end)
    end)
    self.scrollFrame = scrollFrame

    -- Rows
    self.rows = {}
    for i = 1, NUM_VISIBLE_ROWS do
        local row = CreateFrame("Frame", "SpellCalcRow"..i, scrollParent)
        row:SetHeight(ROW_HEIGHT)
        row:SetPoint("TOPLEFT", 6, -((i - 1) * ROW_HEIGHT))
        row:SetPoint("RIGHT", scrollFrame, "RIGHT", 0, 0)

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints(row)
        hl:SetTexture(1, 1, 1, math.mod(i, 2) == 0 and 0.03 or 0.06)
        row.hl = hl
        row.hlDefault = math.mod(i, 2) == 0 and 0.03 or 0.06

        row.cols = {}
        for c = 1, table.getn(COL_WIDTHS) do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            fs:SetWidth(COL_WIDTHS[c])
            fs:SetPoint("LEFT", COL_OFFSETS[c] - 6, 0)
            fs:SetJustifyH(c >= 3 and "RIGHT" or "LEFT")
            row.cols[c] = fs
        end

        row:EnableMouse(true)
        -- [patch] via "this" instead of the loop upvalue
        row:SetScript("OnEnter", function()
            if not this or not this.hl then return end
            this.hl:SetTexture(1, 1, 1, 0.15)
            SpellCalc:ShowTooltip(this)
        end)
        row:SetScript("OnLeave", function()
            if not this or not this.hl then return end
            this.hl:SetTexture(1, 1, 1, this.hlDefault)
            GameTooltip:Hide()
        end)

        self.rows[i] = row
    end

    -- Footer
    local footer = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    footer:SetPoint("BOTTOMLEFT", 14, 12)
    footer:SetPoint("BOTTOMRIGHT", -14, 12)
    footer:SetJustifyH("LEFT")
    self.footerText = footer

    f:Hide()
end

-- ============================================================================
-- UI UPDATE
-- ============================================================================

function SpellCalc:UpdateHeaders()
    for _, h in ipairs(self.headerButtons) do
        local arrow = ""
        if h.key == self.sortColumn then
            arrow = self.sortAsc and " |cFFAAAAAAv|r" or " |cFFAAAAAAAA|r"
        end
        h.text:SetText("|cFFFFD100" .. COL_HEADERS[_] .. arrow .. "|r")
    end
    -- fix: iterate with index
    for idx = 1, table.getn(self.headerButtons) do
        local h = self.headerButtons[idx]
        local arrow = ""
        if h.key == self.sortColumn then
            arrow = self.sortAsc and " v" or " ^"
        end
        h.text:SetText("|cFFFFD100" .. COL_HEADERS[idx] .. arrow .. "|r")
    end
end

function SpellCalc:UpdateFilterHighlight()
    for _, fd in ipairs(self.filterButtons) do
        if fd.filter == self.currentFilter then
            fd.btn:LockHighlight()
        else
            fd.btn:UnlockHighlight()
        end
    end
end

function SpellCalc:UpdateList()
    local data = self:GetFilteredSorted()
    local numItems = table.getn(data)

    FauxScrollFrame_Update(self.scrollFrame, numItems, NUM_VISIBLE_ROWS, ROW_HEIGHT)
    local offset = FauxScrollFrame_GetOffset(self.scrollFrame)

    -- Info
    local _, localizedClass = UnitClass("player")

    -- [patch] show general spell power and the highest school-specific bonus
    -- separately. Before, this showed the maximum over all schools, which
    -- was too high for every spell but one.
    local genericSP = self:GetSpellPower(nil)
    local bestExtra, bestName = 0, nil
    local i
    for i = 2, 7 do
        local extra = self:GetSchoolBonus(i)
        if extra > bestExtra then
            bestExtra = extra
            bestName = SPELLCALC_SCHOOLS[i] and SPELLCALC_SCHOOLS[i].name or nil
        end
    end

    local spText = string.format("|cFFFFFF00%d|r", genericSP)
    if bestExtra > 0 and bestName then
        spText = spText .. string.format(" |cFF888888(+%d %s)|r", bestExtra, bestName)
    end
    if not self:BCSReady() and not self.spManual and not GetSpellBonusDamage then
        spText = "|cFFFF6644n/a|r |cFF888888(BetterCharacterStats fehlt)|r"
    end

    self.infoText:SetText(string.format(
        "|cFF00FF00%s|r  |  SP: %s  |  HP: |cFF00FF88%d|r  |  Crit: |cFFFFFF00%.1f%%|r  |  Talents: |cFFFFFF00%d|r  |  Spells: |cFFAAAAFF%d|r",
        localizedClass or GetPlayerClass(), spText, self:GetHealingPower(), self:GetSpellCrit(),
        self:CountActiveTalents(), numItems
    ))

    self:UpdateHeaders()

    for i = 1, NUM_VISIBLE_ROWS do
        local idx = offset + i
        local row = self.rows[i]

        if idx <= numItems then
            local d = data[idx]
            row.data = d

            -- Col 1: Name + Rank
            local nameColor = d.isHeal and "|cFF40FF70" or "|cFFFFFFFF"
            local marks = ""
            if d.isAoE then marks = marks .. " |cFFFF8800[AoE]|r" end
            if d.isDot then marks = marks .. " |cFFCC88FF*|r" end
            row.cols[1]:SetText(nameColor .. d.name .. " R" .. d.rank .. "|r" .. marks)

            -- Col 2: School
            local schoolInfo = d.isHeal and SPELLCALC_SCHOOL_HEAL or SPELLCALC_SCHOOLS[d.school]
            if schoolInfo then
                local cr, cg, cb = schoolInfo.color[1], schoolInfo.color[2], schoolInfo.color[3]
                row.cols[2]:SetText(string.format("|cFF%02x%02x%02x%s|r", cr*255, cg*255, cb*255, schoolInfo.name))
            else
                row.cols[2]:SetText("?")
            end

            -- Col 3: Avg Value
            row.cols[3]:SetText(string.format("|cFFFFFFFF%.0f|r", d.avgValue or 0))

            -- [patch] Col 4: Scaling
            local coeff = (d.coeff or 0) * 100
            local coColor = "|cFF999999"
            if coeff >= 100 then coColor = "|cFF66FF88"
            elseif coeff >= 60 then coColor = "|cFFFFFFFF"
            elseif coeff >= 30 then coColor = "|cFFCCCC88" end
            row.cols[4]:SetText(coColor .. string.format("%.0f%%", coeff) .. "|r")

            -- Col 5: Per Mana
            local dpmColor = d.isHeal and "|cFF88FFAA" or "|cFF88CCFF"
            row.cols[5]:SetText(dpmColor .. string.format("%.2f", d.perMana or 0) .. "|r")

            -- Col 6: Per Second
            row.cols[6]:SetText(string.format("|cFFFFDD44%.1f|r", d.perSecond or 0))

            -- Col 7: Mana Cost
            row.cols[7]:SetText(string.format("|cFF4488FF%d|r", d.manaCost or 0))

            -- Col 8: Cooldown
            local cdText = FormatCD(d.cd)
            local cdColor = (d.cd and d.cd > 0) and "|cFFFF6644" or "|cFF666666"
            row.cols[8]:SetText(cdColor .. cdText .. "|r")

            row:Show()
        else
            row.data = nil
            for c = 1, table.getn(COL_WIDTHS) do row.cols[c]:SetText("") end
            row:Hide()
        end
    end

    self:UpdateFooter()
end

function SpellCalc:CountActiveTalents()
    local count = 0
    for _ in pairs(self.talentCache) do count = count + 1 end
    return count
end

-- [patch] readable talent value depending on its kind
function SpellCalc:TalentLabel(tName, tData)
    local v = self:TalentBonus(tData)
    local m = tData.mod
    if m == "cast" or m == "cd" or m == "duration" then
        local what = (m == "cast" and " cast") or (m == "cd" and " CD") or " duration"
        return tName .. " " .. string.format("%+.1fs", v) .. what
    elseif m == "cost" then
        return tName .. " " .. Round(v * 100, 1) .. "% mana"
    elseif m == "crit" then
        return tName .. " +" .. Round(v * 100, 1) .. "% crit"
    elseif m == "critbonus" then
        return tName .. " +" .. Round(v * 100, 0) .. "% crit bonus"
    end
    return tName .. " +" .. Round(v * 100, 1) .. "%"
end

function SpellCalc:UpdateFooter()
    local parts = {}
    for tName, tData in pairs(self.talentCache) do
        table.insert(parts, tName)
    end
    table.sort(parts)
    if table.getn(parts) > 0 then
        self.footerText:SetText("|cFFAAAAFFTalents: " .. table.concat(parts, ", ") .. "  (details in tooltip)|r")
    else
        self.footerText:SetText("|cFF888888No relevant talents detected|r")
    end
end

function SpellCalc:ShowTooltip(row)
    if not row.data then return end
    local d = row.data

    GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
    GameTooltip:ClearLines()

    local label = d.isHeal and "Healing" or "Damage"
    GameTooltip:AddLine(d.name .. " (Rank " .. d.rank .. ")", 1, 0.82, 0)

    local schoolInfo = d.isHeal and SPELLCALC_SCHOOL_HEAL or SPELLCALC_SCHOOLS[d.school]
    if schoolInfo then
        GameTooltip:AddLine("School: " .. schoolInfo.name, schoolInfo.color[1], schoolInfo.color[2], schoolInfo.color[3])
    end
    GameTooltip:AddLine("Level learned: " .. (d.level or "?"), 0.6, 0.6, 0.6)

    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("Avg " .. label .. ":", string.format("%.0f", d.avgValue or 0), 0.8, 0.8, 0.8, 1, 1, 1)

    if d.directPart then
        GameTooltip:AddDoubleLine("  Direct:", string.format("%.0f", d.directPart), 0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
        local dotLabel = d.isHeal and "  HoT:" or "  DoT:"
        GameTooltip:AddDoubleLine(dotLabel, string.format("%.0f", d.dotPart), 0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
    end

    if d.dotDuration then
        GameTooltip:AddDoubleLine("Duration:", d.dotDuration .. "s", 0.8, 0.8, 0.8, 1, 1, 1)
    end

    -- [patch] scaling broken down
    if d.coeff then
        local powerLabel = d.isHeal and "healing power" or "spell power"
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Scaling:", string.format("%.1f%%", d.coeff * 100),
            0.8, 0.8, 0.8, 1, 1, 1)
        if d.coeffDirect and d.coeffDot and d.coeffDirect > 0 and d.coeffDot > 0 then
            GameTooltip:AddDoubleLine("  Direct:", string.format("%.1f%%", d.coeffDirect * 100),
                0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
            GameTooltip:AddDoubleLine(d.isHeal and "  HoT:" or "  DoT:",
                string.format("%.1f%%", d.coeffDot * 100), 0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
        end
        GameTooltip:AddLine(string.format("100 %s add %.0f to this spell",
            powerLabel, d.coeff * 100), 0.5, 0.5, 0.5)
    end

    local castLabel = d.castTime > 0 and string.format("%.1fs", d.castTime) or "Instant"
    GameTooltip:AddDoubleLine("Cast time:", castLabel, 0.8, 0.8, 0.8, 1, 1, 1)
    GameTooltip:AddDoubleLine("Mana cost:", d.manaCost, 0.8, 0.8, 0.8, 0.3, 0.5, 1)

    if d.cd and d.cd > 0 then
        GameTooltip:AddDoubleLine("Cooldown:", FormatCD(d.cd), 0.8, 0.8, 0.8, 1, 0.4, 0.3)
        -- Show what effective time is used for /Sec
        local gcd = 1.5
        local effCast = math.max(d.castTime, gcd)
        local effTime = math.max(effCast, d.cd)
        GameTooltip:AddDoubleLine("Effective cycle:", string.format("%.1fs", effTime), 0.6, 0.6, 0.6, 1, 0.7, 0.3)
    end

    GameTooltip:AddLine(" ")
    local effLabel = d.isHeal and "HPM" or "DPM"
    GameTooltip:AddDoubleLine(effLabel .. " (per mana):", string.format("%.2f", d.perMana or 0), 0.5, 0.8, 1, 1, 1, 1)
    local dpsLabel = d.isHeal and "HPS" or "DPS"
    GameTooltip:AddDoubleLine(dpsLabel .. " (per second):", string.format("%.1f", d.perSecond or 0), 1, 0.87, 0.3, 1, 1, 1)
    -- [patch] direct + DoT/HoT broken down
    if d.perCastTime then
        local dotLabel = d.isHeal and "HoT" or "DoT"
        GameTooltip:AddLine("  = spamming only this spell (" .. dotLabel .. " refreshed)", 0.5, 0.5, 0.5)
        GameTooltip:AddDoubleLine("  " .. dotLabel .. " part per second:", string.format("%.1f", d.dotPerSecond or 0),
            0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
        GameTooltip:AddDoubleLine("  Per cast time (in rotation):", string.format("%.1f", d.perCastTime),
            0.6, 0.6, 0.6, 0.9, 0.9, 0.9)
        GameTooltip:AddLine("  = full " .. dotLabel .. " ticks while you cast other spells", 0.5, 0.5, 0.5)
    end

    -- [patch] Crit
    if d.canCrit and d.critChance then
        GameTooltip:AddDoubleLine("Crit chance:", string.format("%.1f%% (x%.2f)", d.critChance * 100, d.critDamage or 1.5),
            0.8, 0.8, 0.8, 1, 1, 1)
        GameTooltip:AddLine("Avg includes crits" .. (d.directPart and " (direct part only)" or ""), 0.5, 0.5, 0.5)
    end

    if d.isAoE then
        GameTooltip:AddLine("|cFFFF8800AoE spell - values per target|r")
    end

    -- Talent bonuses
    local bonuses = {}
    for tName, tData in pairs(self.talentCache) do
        if self:TalentApplies(tData, d.name, d.school, not d.isHeal, nil) then
            local txt = self:TalentLabel(tName, tData)
            if tData.part == "dot" then
                txt = txt .. (d.isHeal and " (HoT)" or " (DoT)")
            elseif tData.part == "direct" then
                txt = txt .. " (direct)"
            end
            table.insert(bonuses, txt)
        end
    end
    if table.getn(bonuses) > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cFF88AAFFTalents:|r")
        for _, txt in ipairs(bonuses) do
            GameTooltip:AddLine("  " .. txt, 0.53, 0.67, 1)
        end
    end

    GameTooltip:Show()
end

-- ============================================================================
-- TOGGLE / SLASH COMMANDS
-- ============================================================================

function SpellCalc:Toggle()
    if not self.frame then self:CreateUI() end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.cachedData = nil
        self:UpdateFilterHighlight()
        self:UpdateList()
        self.frame:Show()
    end
end

function SpellCalc:SetManualSP(val)
    if val and val > 0 then
        self.spManual = val
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r SP manually set to " .. val)
    else
        self.spManual = nil
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r SP reset to auto-detect.")
    end
    self.cachedData = nil
    if self.frame and self.frame:IsShown() then self:UpdateList() end
end

function SpellCalc:SetManualHP(val)
    if val and val > 0 then
        self.hpManual = val
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r HP manually set to " .. val)
    else
        self.hpManual = nil
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r HP reset to auto-detect.")
    end
    self.cachedData = nil
    if self.frame and self.frame:IsShown() then self:UpdateList() end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
initFrame:RegisterEvent("PLAYER_AURAS_CHANGED")
initFrame:RegisterEvent("SPELLS_CHANGED")  -- [patch] spellbook changed
initFrame:SetScript("OnEvent", function()
    if event == "PLAYER_LOGIN" then
        -- [patch] apply the saved setting
        if type(SpellCalcSettings) ~= "table" then SpellCalcSettings = {} end
        if SpellCalcSettings.onlyLearned == nil then SpellCalcSettings.onlyLearned = false end
        SpellCalc.onlyLearned = SpellCalcSettings.onlyLearned

        SLASH_SPELLCALC1 = "/spellcalc"
        SLASH_SPELLCALC2 = "/sc"
        SlashCmdList["SPELLCALC"] = function(msg)
            if not msg or msg == "" then
                SpellCalc:Toggle()
                return
            end
            -- [patch] string.match is Lua 5.1; 1.12 runs on 5.0
            local _, _, cmd, val = string.find(msg, "^(%S+)%s*(%S*)$")
            if not cmd then cmd = msg end
            cmd = string.lower(cmd)

            if cmd == "learned" then
                SpellCalc.onlyLearned = not SpellCalc.onlyLearned
                if type(SpellCalcSettings) == "table" then
                    SpellCalcSettings.onlyLearned = SpellCalc.onlyLearned
                end
                SpellCalc.knownCache = nil
                if SpellCalc.onlyLearnedCB then
                    SpellCalc.onlyLearnedCB:SetChecked(SpellCalc.onlyLearned)
                end
                DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r Learned only = "
                    .. (SpellCalc.onlyLearned and "on" or "off"))
                if SpellCalc.frame and SpellCalc.frame:IsShown() then SpellCalc:UpdateList() end
            elseif cmd == "sp" then
                SpellCalc:SetManualSP(tonumber(val))
            elseif cmd == "hp" then
                SpellCalc:SetManualHP(tonumber(val))
            elseif cmd == "crit" then
                -- [patch] set crit chance manually (percent), 0 = automatic
                local v = tonumber(val)
                SpellCalc.critManual = (v and v > 0) and v or nil
                SpellCalc.cachedData = nil
                DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r Crit "
                    .. (SpellCalc.critManual and (SpellCalc.critManual .. "%") or "auto"))
                if SpellCalc.frame and SpellCalc.frame:IsShown() then SpellCalc:UpdateList() end
            elseif cmd == "reset" then
                SpellCalc.spManual = nil
                SpellCalc.hpManual = nil
                SpellCalc.critManual = nil
                SpellCalc.cachedData = nil
                DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc:|r Manual values cleared.")
                if SpellCalc.frame and SpellCalc.frame:IsShown() then SpellCalc:UpdateList() end
            elseif cmd == "help" then
                DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc Commands:|r")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc - Toggle window")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc sp 300 - Set spell power manually")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc hp 400 - Set healing power manually")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc crit 15 - Set spell crit % manually")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc reset - Clear manual overrides")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc learned - Toggle \"Learned only\"")
                DEFAULT_CHAT_FRAME:AddMessage("  /sc help - Show this help")
            else
                SpellCalc:Toggle()
            end
        end

        local playerClass = GetPlayerClass()
        if SPELLCALC_SPELLS[playerClass] then
            local count = table.getn(SPELLCALC_SPELLS[playerClass])
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc|r loaded. " .. count .. " spells for your class. Type |cFFFFFF00/sc|r to open.")
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00SpellCalc|r loaded. No spell data available for your class.")
        end
    elseif event == "SPELLS_CHANGED" then
        -- [patch] new spell learned -> re-read the spellbook
        SpellCalc.knownCache = nil
        if SpellCalc.frame and SpellCalc.frame:IsShown() then SpellCalc:UpdateList() end
    elseif event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_AURAS_CHANGED" then
        SpellCalc.cachedData = nil
        if SpellCalc.frame and SpellCalc.frame:IsShown() then SpellCalc:UpdateList() end
    end
end)
