local zoneOrder = { -- /dump WorldMapFrame.mapID
    [C_Map.GetMapInfo(1998).name] = 10-9.2,         --纳斯利亚堡
    [C_Map.GetMapInfo(1735).name] = 10-9.1,         --纳斯利亚堡
    [C_Map.GetMapInfo(1683).name] = 10-9.01,         --9.0小副本
    [C_Map.GetMapInfo(1674).name] = 10-9.02,
    [C_Map.GetMapInfo(1669).name] = 10-9.03,
    [C_Map.GetMapInfo(1679).name] = 10-9.04,
    [C_Map.GetMapInfo(1693).name] = 10-9.05,
    [C_Map.GetMapInfo(1663).name] = 10-9.06,
    [C_Map.GetMapInfo(1675).name] = 10-9.07,
    [C_Map.GetMapInfo(1666).name] = 10-9.08,
    [C_Map.GetMapInfo(1581).name] = 10-8.5,         --尼奥萨罗
    [C_Map.GetMapInfo(1512).name] = 10-8.4,         --永恒王宫
    [C_Map.GetMapInfo(1345).name] = 10-8.3,         --风暴熔炉
    [C_Map.GetMapInfo(1358).name] = 10-8.2,         --达萨罗之战
    [C_Map.GetMapInfo(1148).name] = 10-8.1,         --奥迪尔
    [C_Map.GetMapInfo(1162).name] = 10-8.01,        --8.0小副本
    [C_Map.GetMapInfo(1041).name] = 10-8.02,
    [C_Map.GetMapInfo(1038).name] = 10-8.03,
    [C_Map.GetMapInfo(974).name]  = 10-8.04,
    [C_Map.GetMapInfo(1010).name] = 10-8.05,
    [C_Map.GetMapInfo(1015).name] = 10-8.06,
    [C_Map.GetMapInfo(936).name]  = 10-8.07,
    [C_Map.GetMapInfo(1004).name] = 10-8.08,
    [C_Map.GetMapInfo(934).name]  = 10-8.09,
    [C_Map.GetMapInfo(1039).name] = 10-8.091,
    [C_Map.GetMapInfo(909).name] = 10-7.5,          --王座
    [C_Map.GetMapInfo(850).name] = 10-7.4,          --萨墓
    [C_Map.GetMapInfo(764).name] = 10-7.3,          --暗夜要塞
    [C_Map.GetMapInfo(807).name] = 10-7.2,          --勇气试炼
    [C_Map.GetMapInfo(777).name] = 10-7.1,          --翡翠梦魇
}

--luacheck: no max line length
---------------------------------------------------------
--	Library
---------------------------------------------------------
-- local bzone = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
local LibStub = _G.LibStub
local bboss = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()

---------------------------------------------------------
--	Localization
---------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusRaidDebuff")

---------------------------------------------------------
--	local
---------------------------------------------------------
local realzone, detectStatus, zonetype
local db, myClass, myDispellable
local debuff_list = {}
local refreshEventScheduled = false
local refreshTimer

--local function IsClassicWow()
--	return _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC
--end
--
--local function IsTBCWow()
--	return _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
--end

local function IsRetailWow()
    return _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE
end

local GetSpecialization = _G.GetSpecialization
local IsAddOnLoaded = _G.IsAddOnLoaded
local UnitClass = _G.UnitClass
local C_Map = _G.C_Map
local GetInstanceInfo = _G.GetInstanceInfo
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local UnitDebuff = _G.UnitDebuff
local UnitGUID = _G.UnitGUID
local UnitAura = _G.UnitAura
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local ChatEdit_GetActiveWindow = _G.ChatEdit_GetActiveWindow
local GetSpellLink = _G.GetSpellLink
local InCombatLockdown = _G.InCombatLockdown
local ChatFrame1 = _G.ChatFrame1



local colorMap = {
    ["Curse"] = { r = .6, g =  0, b = 1},
    ["Magic"] = { r = .2, g = .6, b = 1},
    ["Poison"] = {r =  0, g = .6, b =  0},
    ["Disease"] = { r = .6, g = .4, b =  0},
}

-- Priest specs: 1) Discipline, 2) Holy, 3) Shadow
-- Dispel Magic/Mass Dispel: Magic (Shadow)
-- Purify/Mass Dispel: Magic and Disease (Disc/Holy)

-- Paladin specs: 1) Holy, 2) Protection, 3) Retribution
-- Cleanse: Poison and Disease (non-Holy)
-- Cleanse: Poison, Disease, and Magic (Holy, Scared Cleansing)

-- Mage:
-- Remove Curse (all)

-- Druid specs: 1) Balance, 2) Feral, 3) Guardian, 4) Restoration
-- Remove Corruption: Curse and Poison (non-Resto)
-- Nature's Cure: Magic, Curse, Poison (Resto)

-- Shaman specs: 1) Elemental, 2) Enhancement, 3) Restoration
-- Cleanse Spirit: Curse (non-Resto)
-- Purify Spirit: Curse and Magic (Resto)

-- Monk specs: 1) Brewmaster, 2) Mistweaver, 3) Windwalker
-- Detox: Poison and Disease (non-Mistweaver)
-- Detox: Poison, Disease, and Magic (Mistweaver)

-- Cannot do GetSpecialization != 3 for priest, unspeced is also an option (nil)
if not _G.GetSpecialization then
    function GetSpecialization()
        return false
    end
end
local dispelMap = {
    ["PRIEST"] = {["Magic"] = true, ["Disease"] = ((GetSpecialization() == 1) or (GetSpecialization() == 2))},
    ["PALADIN"] = {["Disease"] = true, ["Poison"] = true, ["Magic"] = (GetSpecialization() == 1)},
    ["MAGE"] = {["Curse"] = true},
    ["DRUID"] = {["Curse"] = true, ["Poison"] = true, ["Magic"] = (GetSpecialization() == 4)},
    ["SHAMAN"] = {["Curse"] = true, ["Magic"] = (GetSpecialization() == 3)},
    ["MONK"] = {["Disease"] = true, ["Poison"] = true, ["Magic"] = (GetSpecialization() == 2)},
}

-- Spells to ignore detecting
-- Bug is causing Exhaustion to show up for some people in Blackrock Foundry (Ticket #6)
local ignore_ids = {
    [1604] = true, -- Dazed
    [6788] = true, -- Weakened Soul
    [57723] = true, -- Exhaustion
    [95809] = true, -- Insanity (hunter pet Ancient Hysteria debuff)
    [224127] = true, -- Crackling Surge Shammy Debuff
    [190185] = true, -- Feral Spirit Shammy Debuff
    [224126] = true, -- Icy Edge Shammy Debuff
    [197509] = true, -- Bloodworm DK Debuff
    [5215] = true, -- Prowl Druid Debuff
    [115191] = true, -- Stealth Rogue Debuff
    [195776] = true, -- 月羽疫病
    [304851] = true, -- 纳沙塔尔之战参战者
    [97821] = true, --虚空之触
    [313445] = true, --恩佐斯领域
    [280661] = true, --个人护盾机
    [355711] = true, --9.1大怪的DEBUFF
    [355719] = true,
    [355709] = true,
    [355714] = true,
}

--local clientVersion
--do
--	local version = GetBuildInfo() -- e.g. "4.0.6"
--	local a, b, c = strsplit(".", version) -- e.g. "4", "0", "6"
--	clientVersion = 10000*a + 100*b + c -- e.g. 40006
--end

---------------------------------------------------------
--	Core
---------------------------------------------------------
local GridFrame
local GridRoster
_G.GridStatusRaidDebuff = _G.Grid:NewStatusModule("GridStatusRaidDebuff", "AceTimer-3.0")
_G.GridStatusRaidDebuff.menuName = L["Raid Debuff"]

if (IsAddOnLoaded("Grid")) then
GridFrame = _G.Grid:GetModule("GridFrame")
GridRoster = _G.Grid:GetModule("GridRoster")
end

if (IsAddOnLoaded("Plexus")) then
GridFrame = _G.Grid:GetModule("PlexusFrame")
GridRoster = _G.Grid:GetModule("PlexusRoster")
end

local GridStatusRaidDebuff = _G.GridStatusRaidDebuff

local GetSpellInfo = _G.GetSpellInfo
local fmt = string.format
--local ssub = string.sub

GridStatusRaidDebuff.defaultDB = {
    -- Removed from Grid 1477
    -- debug = false,
    isFirst = true,

    ["alert_RaidDebuff"] = {
        text = L["Raid Debuff"],
        desc = L["Raid Debuff"],
        enable = true,
        color = { r = .0, g = .0, b = .0, a=1.0 },
        priority = 98,
        range = false,
    },

    ignDis = false,
    ignUndis = false,
    detect = true,
    frequency = 0.1,

	["debuff_options"] = {
        --9.0°ÁÂý
        [C_Map.GetMapInfo(1683).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1674).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1669).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1679).name] = {
            [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 },
            [GetSpellInfo(323687)] = { c_prior = 9, i_prior = 9, timer = true }, --ÉÌÈËÉÁµç
            [GetSpellInfo(323692)] = { c_prior = 8, i_prior = 8, timer = true }, --ÉÌÈË°ÂÊõÒ×ÉË
            [GetSpellInfo(240559)] = { disabled = true },
        },
        [C_Map.GetMapInfo(1693).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1663).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1675).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1666).name] = { [GetSpellInfo(340880)] = { c_prior = 1, i_prior = 1 }, [GetSpellInfo(240559)] = { disabled = true }, },
        [C_Map.GetMapInfo(1998).name] = { [GetSpellInfo(352394)] = { disabled = true }, },
    },
    ["detected_debuff"] = {},
}

function GridStatusRaidDebuff:OnInitialize()
    self.super.OnInitialize(self)
    self:RegisterStatuses()
    db = self.db.profile.debuff_options
    --ÖØÉËÓÅÏÈ¼¶ÏÂ½µ
    local graviousSpellId = 240559
    local spellName = GetSpellInfo(graviousSpellId)
    local detected = self.db.profile.detected_debuff
    if detected then
        for zone, t in pairs(db) do
            -- ¼ì²âµ½ÁËÖØÉËµ«Ã»ÓÐÉèÖÃ
            if detected[zone] and detected[zone][spellName] == graviousSpellId and not t[spellName] then
                t[spellName] = { c_prior = 3, i_prior = 3, }
            end
        end
    end	
end

function GridStatusRaidDebuff:OnEnable()
    -- Removed from Grid 1477
    -- self.debugging = self.db.profile.debug
    -- New variable:
    -- self.debugging = GridStatusRaidDebuff.debug

    myClass = select(2, UnitClass("player"))
    myDispellable = dispelMap[myClass]

    -- For classes that don't have a dispelMap
    -- Create an empty array
    if (myDispellable == nil) then
        myDispellable = {}
    end

    if self.db.profile.isFirst then
        GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  true, --luacheck: ignore
        GridFrame:UpdateAllFrames()
        self.db.profile.isFirst = false
    end

    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneCheck")
    self:RegisterCustomDebuff()
end

function GridStatusRaidDebuff:Reset()
    self.super.Reset(self)
    self:UnregisterStatuses()
    self:RegisterStatuses()
end

function GridStatusRaidDebuff:PLAYER_ENTERING_WORLD()
    self:ZoneCheck()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function GridStatusRaidDebuff:CheckDetectZone()
    detectStatus = self.db.profile.detect and not (zonetype == "none" or zonetype == "pvp") --check db Enable
    self:Debug("CheckDetectZone", realzone, detectStatus and "Detector On")

    if detectStatus then
        self:CreateZoneMenu(realzone)
        if not debuff_list[realzone] then debuff_list[realzone] = {} end
    -- FIXME
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "ScanNewDebuff")
    else
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

function GridStatusRaidDebuff:ZoneCheck()
    -- localzone and realzone should be the same, but sometimes they are not
    -- For example, in German Throne of Thunders
    -- localzone = "Der Thron des Donners"
    -- instzone = "Thron des Donners"
    local instzone

    -- The mapid returned by UnitPosition is not the same used by GetMapNameByID
    -- local mapid = select(4, UnitPosition("player"))

    -- Force map to right zone
    --SetMapToCurrentZone()
    local mapid = C_Map.GetBestMapForUnit("player")
    if not mapid then
        return
    end
    local localzone = C_Map.GetMapInfo(mapid).name

    -- zonetype is a module variable
    instzone, zonetype = GetInstanceInfo()

    -- Preference is for localzone, but fall back to instzone if it is all that exists
    if debuff_list[instzone] and not debuff_list[localzone] then
        realzone = instzone
    else
        realzone = localzone
    end

    -- If loading the game in Proving Grounds this seems to be the case
    if not realzone then
        return
    end

    self:UpdateAllUnits()
    self:CheckDetectZone()

if IsRetailWow() then
    if myClass == "PALADIN" or myClass == "DRUID" or myClass == "SHAMAN" or myClass == "PRIEST" or
       myClass == "MONK" then
        self:RegisterEvent("PLAYER_TALENT_UPDATE")
    end
end

    if debuff_list[realzone] then
        if not refreshEventScheduled then
            refreshTimer = self:ScheduleRepeatingTimer("UpdateAllUnits", self.db.profile.frequency)
            self:RegisterMessage("Grid_UnitJoined")
            refreshEventScheduled = true
        end
    else
        if refreshEventScheduled then
            self:CancelTimer(refreshTimer)
            self:UnregisterMessage("Grid_UnitJoined")
            refreshEventScheduled = false
        end
    end
end

function GridStatusRaidDebuff:UpdateRefresh()
    self:CancelTimer(refreshTimer)
    refreshTimer = self:ScheduleRepeatingTimer("UpdateAllUnits", self.db.profile.frequency)
end

function GridStatusRaidDebuff:RegisterStatuses()
    self:RegisterStatus("alert_RaidDebuff", L["Raid Debuff"])
    self:CreateMainMenu()
end

function GridStatusRaidDebuff:UnregisterStatuses()
    self:UnregisterStatus("alert_RaidDebuff")
end

function GridStatusRaidDebuff:Grid_UnitJoined(_, guid, unitid)
    self:ScanUnit(unitid, guid)
end

function GridStatusRaidDebuff:PLAYER_TALENT_UPDATE() --luacheck: ignore 212
    if myClass == "PALADIN" then
        myDispellable["Magic"] = (GetSpecialization() == 1)
    elseif myClass == "DRUID" then
        myDispellable["Magic"] = (GetSpecialization() == 4)
    elseif myClass == "SHAMAN" then
        myDispellable["Magic"] = (GetSpecialization() == 3)
    elseif myClass == "PRIEST" then
        myDispellable["Disease"] = ((GetSpecialization() == 1) or (GetSpecialization() == 2))
    elseif myClass == "MONK" then
        myDispellable["Magic"] = (GetSpecialization() == 2)
    end
end

function GridStatusRaidDebuff:UpdateAllUnits()
    for guid, unitid in GridRoster:IterateRoster() do
        self:ScanUnit(unitid, guid)
    end
end

function GridStatusRaidDebuff:ScanNewDebuff(_, _)
    local _, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, name, _, auraType = CombatLogGetCurrentEventInfo()
    local settings = self.db.profile["alert_RaidDebuff"]
    if (settings.enable and debuff_list[realzone]) then
        if event == "SPELL_AURA_APPLIED" and sourceGUID and auraType == "DEBUFF" and not GridRoster:IsGUIDInGroup(sourceGUID) and GridRoster:IsGUIDInGroup(destGUID)
            and not debuff_list[realzone][name] then
            if ignore_ids[spellId] then return end --Ignore Dazed

            -- Filter out non-debuff effects, only debuff effects are shown
            -- No reason to detect buffs too
            local unitid, debuff
            unitid = GridRoster:GetUnitidByGUID(destGUID)
			debuff = true --abyui8 already checked auraType
--[[			
            debuff = false
            for i=1,40 do
                local spellname = UnitDebuff(unitid, i)
                if not spellname then break end
                if spellname == name then
                    debuff = true
                else
                    self:Debug("Debuff not found", name)
                end
                --if (UnitDebuff(unitid, i)) then
                --	debuff = true
                -- else
                -- 	self:Debug("Debuff not found", name)
                --end
            end
--]]

            if not debuff then return end

            self:Debug("New Debuff", sourceName, destName, name, unitid, tostring(debuff))

            self:DebuffLocale(realzone, name, spellId, 5, 5, true, true)
            if not self.db.profile.detected_debuff[realzone] then self.db.profile.detected_debuff[realzone] = {} end
            if not self.db.profile.detected_debuff[realzone][name] then self.db.profile.detected_debuff[realzone][name] = spellId end

            self:LoadZoneDebuff(realzone, name)

        end
    end
end

function GridStatusRaidDebuff:ScanUnit(unitid, unitGuid)
    local guid = unitGuid or UnitGUID(unitid)
    --if not GridRoster:IsGUIDInGroup(guid) then	return end

    local name, icon, count, debuffType, duration, expirationTime, _, spellId
    local settings = self.db.profile["alert_RaidDebuff"]

    if (settings.enable and debuff_list[realzone]) then
        local d_name, di_prior, dc_prior, d_icon,d_color,d_startTime,d_durTime,d_count
        -- local dt_prior
        local data

        di_prior = 0
        dc_prior = 0
        -- dt_prior = 0

        local index = 0
        while true do
            index = index + 1

            -- name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellId, canApplyAura, isBuffDebuff, isCastByPlayer = UnitAura(unitid, index, "HARMFUL")
            name, icon, count, debuffType, duration, expirationTime, _, _, _, spellId = UnitAura(unitid, index, "HARMFUL")

            -- Check for end of loop
            if not name then
                break
            end

            if debuff_list[realzone][name] then
                data = debuff_list[realzone][name]

                -- The debuff from players should not be displayed
                -- Example: Ticket #6: Exhaustion from Blackrock Foundry
                -- Other method instead of ignore_ids is:
                -- not isCastByPlayer
                if not data.disable and
                   not ignore_ids[spellId] and
                   not (self.db.profile.ignDis and myDispellable[debuffType]) and
                   not (self.db.profile.ignUndis and debuffType and not myDispellable[debuffType]) then

                    if di_prior < data.i_prior then
                        di_prior = data.i_prior
                        d_name = name
                        d_icon = 	not data.noicon and icon
                        -- if data.timer and dt_prior < data.i_prior then
                        if data.timer then
                            d_startTime = expirationTime - duration
                            d_durTime = duration
                        end
                        --Stack
                        if data.stackable then
                            d_count = count
                        else
							d_count = nil
						end						
                    end
                    --Color Priority
                    if dc_prior < data.c_prior then
                        dc_prior = data.c_prior
                        d_color = (data.custom_color and data.color) or colorMap[debuffType] or settings.color
                    end
                end
            end
        end

        if d_color and not d_color.a then
            d_color.a = settings.color.a
        end

        if d_color and d_color.a == 0 then
            d_color.a = 1
        end

        if d_name then
            self.core:SendStatusGained(
            guid, "alert_RaidDebuff", settings.priority, (settings.range and 40),
            d_color, nil, nil, nil, d_icon, d_startTime, d_durTime, d_count)
        else
            self.core:SendStatusLost(guid, "alert_RaidDebuff")
        end
    else
        self.core:SendStatusLost(guid, "alert_RaidDebuff")
    end
end

---------------------------------------------------------
--	For External
---------------------------------------------------------
local function getDb(zone, name, arg, ret)
    if db[zone] and db[zone][name] and db[zone][name][arg] ~= nil then
        return db[zone][name][arg]
    end
    return ret
end

local function insertDb(zone, name, arg, value)
    if not db[zone] then db[zone] = {} end
    if not db[zone][name] then db[zone][name] = {} end

    if arg then
        db[zone][name][arg] = value
    end
end

function GridStatusRaidDebuff:DebuffLocale(zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
    local name, _, icon, id
    local data, order
    local detected

    self:CreateZoneMenu(zone)

    if type(first) == "number" then
        name, _, icon = GetSpellInfo(first)
        id = first
        order = second
    else
        name, _, icon = GetSpellInfo(second)
        id = second
        order = 9999
        detected = true
    end

    if name and not debuff_list[zone][name] then
        debuff_list[zone][name] = {}
        data = debuff_list[zone][name]

        data.debuffId = id
        data.icon = icon
        data.order = order
        data.disable = getDb(zone,name,"disable",default_disable)
        data.i_prior = getDb(zone,name,"i_prior",icon_priority)
        data.c_prior = getDb(zone,name,"c_prior",color_priority)
        data.custom_color = getDb(zone,name,"custom_color",color ~= nil)
        data.color = getDb(zone,name,"color",color)
        data.stackable = getDb(zone,name,"stackable",stackable)
        data.timer = getDb(zone,name,"timer",timer)
        data.noicon = getDb(zone,name,"noicon",noicon)
        data.detected = detected
    end
end

-- This function is dependent on libbabble-zone and is deprecated as of WoW 5.2
-- function GridStatusRaidDebuff:Debuff(en_zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
-- 	local zone = bzone[en_zone]

-- 	if (zone) then
-- 		-- Call with localized zone
-- 		self:DebuffLocale(zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
-- 	else
-- 		-- The structure is stored by localized zone
-- 		-- If we only have the English zone and not the localized one
-- 		-- we can't store it
-- 		-- self:Debug("Debuff", realzone, "en_zone translation not found")
-- 		-- warn(("LibBabble translation for zone %q not found"):format(en_zone))
-- 		self:Debug(("LibBabble translation for zone %q not found"):format(en_zone))
-- 	end
-- end

function GridStatusRaidDebuff:DebuffId(zoneid, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
    local zone = C_Map.GetMapInfo(zoneid).name
	if stackable == nil then stackable = true end

    if (zone) then
        self:DebuffLocale(zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
    else
        self:Debug(("GetMapNameByID %d not found"):format(zoneid))
    end
end

function GridStatusRaidDebuff:BossNameLocale(zone, order, en_boss)
    local boss = en_boss or order
    if (en_boss and bboss[en_boss]) then
        boss = en_boss and bboss[en_boss]
    end

    -- If both en_boss and order are defined, otherwise
    -- default to 9998 for order
    local ord = en_boss and order or 9998

    self:CreateZoneMenu(zone)

    local args = self.options.args

    args[zone].args[boss] = {
            type = "group",
            name = fmt("|cff00ff00%s%s%s|r","[ ", boss," ]"),
                        desc = L["Option for %s"]:format(boss),
            order = ord,
            guiHidden = true,
            args = {}
    }
end

-- This function is dependent on libbabble-zone and is deprecated as of WoW 5.2
-- function GridStatusRaidDebuff:BossName(en_zone, order, en_boss)
-- 	local zone = bzone[en_zone]
--
-- 	if (zone) then
-- 		self:BossNameLocale(zone, order, en_boss)
-- 	else
-- 		-- The structure is stored by localized zone
-- 		-- If we only have the English zone and not the localized one
-- 		-- we can't store it
-- 		-- self:Debug("BossName", realzone, "zone translation not found")
-- 		-- warn(("LibBabble translation for zone %q not found"):format(en_zone))
-- 		self:Debug(("LibBabble translation for zone %q not found"):format(en_zone))
-- 	end
-- end

function GridStatusRaidDebuff:BossNameId(zoneid, order, en_boss)
    local zone = C_Map.GetMapInfo(zoneid).name

    if (zone) then
        self:BossNameLocale(zone, order, en_boss)
    else
        self:Debug(("GetMapNameByID %d not found"):format(zoneid))
    end
end

-- Create a custom tooltip for debuff description
local tip = CreateFrame("GameTooltip", "GridStatusRaidDebuffTooltip", nil, "GameTooltipTemplate")
tip:SetOwner(UIParent, "ANCHOR_NONE")
for i = 1, 10 do
    tip[i] = _G["GridStatusRaidDebuffTooltipTextLeft"..i]
    if not tip[i] then
        tip[i] = tip:CreateFontString()
        tip:AddFontStrings(tip[i], tip:CreateFontString())
    end
end


function GridStatusRaidDebuff:LoadZoneMenu(zone)
    local args = self.options.args[zone].args
    --local settings = self.db.profile["alert_RaidDebuff"]

    for _,k in pairs(args) do
        if k.guiHidden then
            k.guiHidden = false
        end
    end

    for name,_ in pairs(debuff_list[zone]) do
        self:LoadZoneDebuff(zone, name)
    end
end

function GridStatusRaidDebuff:LoadZoneDebuff(zone, name)
    local description, menuName, k
    local args = self.options.args[zone].args

    -- Code by Mikk

    k = debuff_list[zone][name]


    local order = k.order

    -- Make it sorted by name. Values become 9999.0 -- 9999.99999999
    if order==9999 then
        local a,b,c = string.byte(name, 1, 3)
        order=9999 + ((a or 0)*65536 + (b or 0)*256 + (c or 0)) / 16777216
    end
    -- End of code by Mikk

    if not args[name] and k then
        description = L["Enable %s"]:format(name)

--[[
        tip:SetHyperlink("spell:"..k.debuffId)
        if tip:NumLines() > 1 then
            description = tip[tip:NumLines()]:GetText()
        end
--]]		
        local spellID = k.debuffId
        if not GetSpellInfo(spellID) then spellID = nil end

        menuName = fmt("|T%s:0|t%s", k.icon, name)

        args[name] = {
            type = "group",
            name = menuName,
            desc = function ()
                if not spellID then return end
                local tooltip = LibStub("AceConfigDialog-3.0").tooltip
                tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
                tooltip:SetHyperlink(GetSpellLink(spellID))
                tooltip:AddLine(" ")
                tooltip:AddLine("ID: " .. spellID)
                tooltip:Show()
                return tooltip --abyui modify AceConfigDialog-3.0 TreeOnButtonEnter
            end,
            order = order,
            args = {
                ["enable"] = {
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Enable %s"]:format(name),
                    order = 1,
                    get = function()
                                return not k.disable
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"disable",not v)
                                k.disable = not v
                                self:UpdateAllUnits()
                            end,
                },
                ["icon priority"] = {
                    type = "range",
                    name = L["Icon Priority"],
                    desc = L["Option for %s"]:format(L["Icon Priority"]),
                    order = 2,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function()
                                return k.i_prior
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"i_prior",v)
                                k.i_prior = v
                                self:UpdateAllUnits()
                            end,
                },
                ["color priority"] = {
                    type = "range",
                    name = L["Color Priority"],
                    desc = L["Option for %s"]:format(L["Color Priority"]),
                    order = 3,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function()
                                return k.c_prior
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"c_prior",v)
                                k.c_prior = v
                                self:UpdateAllUnits()
                            end,
                },
                ["Remained time"] = {
                    type = "toggle",
                    name = L["Remained time"],
                    desc = L["Enable %s"]:format(L["Remained time"]),
                    order = 4,
                    get = function()
                                return k.timer
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"timer",v)
                                k.timer = v
                                self:UpdateAllUnits()
                            end,
                },
                ["Stackable debuff"] = {
                    type = "toggle",
                    name = L["Stackable debuff"],
                    desc = L["Enable %s"]:format(L["Stackable debuff"]),
                    order = 5,
                    get = function()
                                return k.stackable
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"stackable",v)
                                k.stackable = v
                                self:UpdateAllUnits()
                            end,
                },
                ["only color"] = {
                    type = "toggle",
                    name = L["Only color"],
                    desc = L["Only color"],
                    order = 7,
                    get = function()
                                return k.noicon
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"noicon",v)
                                k.noicon = v
                                self:UpdateAllUnits()
                            end,
                },
                ["custom color"] = {
                    type = "toggle",
                    name = L["Custom Color"],
                    desc = L["Enable %s"]:format(L["Custom Color"]),
                    order = 7,
                    get = function()
                                return k.custom_color
                            end,
                    set = function(_, v)
                                insertDb(zone,name,"custom_color",v)
                                k.custom_color = v
                                if v then
                                    insertDb(zone,name,"color", {r = 0, g = 0, b = 0})
                                    k.color = {r = 0, g = 0, b = 0}
                                end
                                self:UpdateAllUnits()
                            end,
                },
                ["color"] = {
                    type = "color",
                    name = L["Color"],
                    desc = L["Option for %s"]:format(L["Color"]),
                    order = 8,
                    disabled = function()
                                    return not k.custom_color
                                end,
                    hasAlpha = false,
                    get = function ()
                                local t = getDb(zone,name,"color", _G.color or {r = 1, g = 0, b = 0})
                                return t.r, t.g, t.b
                            end,
                    set = function (_, ir, ig, ib)
                                local t = {r = ir, g = ig, b = ib}
                                insertDb(zone,name,"color",t)
                                k.color = t
                                self:UpdateAllUnits()
                            end,
                },
                ["remove"] = {
                    type = "execute",
                    name = L["Remove"],
                    desc = L["Remove"],
                    order = 9,
                    disabled = not k.detected,
                    func = function()
                                self.db.profile.detected_debuff[zone][name] = nil
                                debuff_list[zone][name] = nil
                                args[name] = nil
                                self:UpdateAllUnits()
                            end,
                },
                ["link"] = {
                  type = "execute",
					name = "发送链接",
                    descStyle = "none for take control of gametooltip in AceConfigDialog-3.0.lua:512",
					desc = function(info)
                        local tooltip = LibStub("AceConfigDialog-3.0").tooltip
                        tooltip:SetHyperlink(GetSpellLink(k.debuffId))
                        tooltip:AddLine(" ")
                        tooltip:AddLine("发送此BOSS技能链接到聊天窗")
                        tooltip:Show()
                    end,
                    order = 10,
                    func = function()
--[[					
                                local chatWindow = ChatEdit_GetActiveWindow()
                                if chatWindow then
                                    chatWindow:Insert(GetSpellLink(k.debuffId))
                                end
--]]
                        --abyui
                        CoreUIChatEdit_Insert(GetSpellLink(k.debuffId))								
                    end,
                },
            },
        }
    end
end


function GridStatusRaidDebuff:CreateZoneMenu(zone)
    local args
    if not debuff_list[zone] then
        debuff_list[zone] = {}

        args = self.options.args

        args[zone] = {
            type = "group",
            name = zone,
            desc = L["Option for %s"]:format(zone),
			order = zoneOrder[zone] or nil,
            args = {
                ["load zone"] = {
                    type = "execute",
                    name = L["Load"],
                    desc = L["Load"],
                    func = function()
                        self:LoadZoneMenu(zone)
                        if not args[zone].args["load zone"].disabled then args[zone].args["load zone"].disabled = true end
                    end,
                },
                ["remove all"] = {
                    type = "execute",
                    name = L["Remove detected debuff"],
                    desc = L["Remove detected debuff"],
                    func = function()
                                    if self.db.profile.detected_debuff[zone] then
                                        for name,_ in pairs(self.db.profile.detected_debuff[zone]) do
                                            self.db.profile.detected_debuff[zone][name] = nil
                                            debuff_list[zone][name] = nil
                                            args[zone].args[name] = nil
                                            self:UpdateAllUnits()
                                        end
                                    end
                    end,
                },
                ["import debuff"] = {
                    type = "input",
                    name = L["Import Debuff"],
                    desc = L["Import Debuff Desc"],
                    get = false,
                    usage = "SpellID",
                    set = function(_, v)
                        local name = GetSpellInfo(v)
                        -- self:Debug("Import", zone, name, v)
                        if name then
                                self:DebuffLocale(zone, name, v, 5, 5, true, true)
                            if not self.db.profile.detected_debuff[zone] then
                                self.db.profile.detected_debuff[zone] = {}
                            end
                            if not self.db.profile.detected_debuff[zone][name] then
                                self.db.profile.detected_debuff[zone][name] = v
                                self:LoadZoneDebuff(zone, name)
                                self:UpdateAllUnits()
                            end
                        end
                    end,
                },
            },
        }
    end
end

function GridStatusRaidDebuff:CreateMainMenu()
    local args = self.options.args

    for i,k in pairs(args["alert_RaidDebuff"].args) do
        args[i] = k
    end

    args["alert_RaidDebuff"].hidden = true

    args["Border"] = {
            type = "toggle",
            name = L["Border"],
            desc = L["Enable %s"]:format(L["Border"]),
            order = 98,
            disabled = InCombatLockdown,
            get = function() return GridFrame.db.profile.statusmap["border"].alert_RaidDebuff end,
            set = function(_, v)
                            GridFrame.db.profile.statusmap["border"].alert_RaidDebuff  =  v
                            GridFrame:UpdateAllFrames()
                        end,
    }
    args["Icon"] = {
            type = "toggle",
            name = L["Center Icon"],
            desc = L["Enable %s"]:format(L["Center Icon"]),
            order = 99,
            disabled = InCombatLockdown,
            get = function() return GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff end,
            set = function(_, v)
                            GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  v
                            GridFrame:UpdateAllFrames()
                        end,
    }
    args["Ignore dispellable"] = {
        type = "toggle",
        name = L["Ignore dispellable debuff"],
        desc = L["Ignore dispellable debuff"],
        order = 100,
        get = function() return self.db.profile.ignDis end,
        set = function(_, v)
                        self.db.profile.ignDis = v
                        self:UpdateAllUnits()
                    end,

    }
    args["Ignore undispellable"] = {
        type = "toggle",
        name = L["Ignore undispellable debuff"],
        desc = L["Ignore undispellable debuff"],
        order = 101,
        get = function() return self.db.profile.ignUndis end,
        set = function(_, v)
                        self.db.profile.ignUndis = v
                        self:UpdateAllUnits()
                    end,
    }
    args["Frequency"] = {
        type = "range",
        name = L["Aura Refresh Frequency"],
        desc = L["Aura Refresh Frequency"],
        min = 0.01,
        max = 0.5,
        order = 102,
        step = 0.01,
        get = function()
                        return self.db.profile.frequency
                    end,
        set = function(_, v)
                        self.db.profile.frequency = v
                    end,
    }
    args["Detect"] = {
        type = "toggle",
        name = L["detector"],
        desc = L["Enable %s"]:format(L["detector"]),
        order = 103,
        get = function() return self.db.profile.detect end,
        set = function()
                        self.db.profile.detect = not self.db.profile.detect
                local detectEnable = self.db.profile.detect
                        if detectEnable then
                            ChatFrame1:AddMessage(L.msgAct)
                        else
                            ChatFrame1:AddMessage(L.msgDeact)
                        end
                        self:ZoneCheck()
                    end,
    }
end

function GridStatusRaidDebuff:RegisterCustomDebuff()
    -- local en_zone
    for zone,j in pairs(self.db.profile.detected_debuff) do
        if self.db.profile.detect or self.options.args[zone] then
        self:BossNameLocale(zone, L["Detected debuff"])

        -- en_zone = bzoneRev[zone]

        for name,k in pairs(j) do
            self:DebuffLocale(zone, name, k, 5, 5, true, true)
        end
		end
    end
end

