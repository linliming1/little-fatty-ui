local ADDON_NAME, namespace = ... 	--localization
local L = namespace.L 				--localization
local _,addon = ...
local doll_tooltip_format = PAPERDOLLFRAME_TOOLTIP_FORMAT
namespace.doll_tooltip_format = doll_tooltip_format
local highlight_code = HIGHLIGHT_FONT_COLOR_CODE
namespace.highlight_code = highlight_code
local font_color_close = FONT_COLOR_CODE_CLOSE
namespace.font_color_close = font_color_close
--local _, private = ...
--local _, gdbprivate = ...
--[[]
--seems like shared upvaluing of tables isn't so easy
local _, dcs_format = ...
dcs_format = format
local _, char_ctats_pane = ...
char_ctats_pane = CharacterStatsPane
--]]
local dcs_format = format
local char_ctats_pane = CharacterStatsPane
local _, DCS_TableData = ...
_G.DCS_TableData = DCS_TableData
local _, gdbprivate = ...
local ilvl_two_decimals, ilvl_one_decimals, ilvl_eq_av, ilvl_class_color
local unitclass, classColorString
	gdbprivate.gdbdefaults.gdbdefaults.dejacharacterstatsItemLevelChecked = {
		ItemLevelEQ_AV_SetChecked = true,
		ItemLevelDecimalsSetChecked = true,
		ItemLevelTwoDecimalsSetChecked = false,
		ItemLevelClassColorSetChecked = false,
	}	
	
-----------------------
-- Item Level Checks --
-----------------------

	local DCS_ILvl_EQ_AV_Check = CreateFrame("CheckButton", "DCS_ILvl_EQ_AV_Check", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ILvl_EQ_AV_Check:RegisterEvent("PLAYER_LOGIN")
	DCS_ILvl_EQ_AV_Check:ClearAllPoints()
	--DCS_ILvl_EQ_AV_Check:SetPoint("TOPLEFT", 30, -55)
	DCS_ILvl_EQ_AV_Check:SetPoint("TOPLEFT", "dcsILvlPanelCategoryFS", 7, -15)
	DCS_ILvl_EQ_AV_Check:SetScale(1)
	DCS_ILvl_EQ_AV_Check.tooltipText = L["Displays Equipped/Available item levels unless equal."] --Creates a tooltip on mouseover.
	_G[DCS_ILvl_EQ_AV_Check:GetName() .. "Text"]:SetText(L["Equipped/Available"])
	
	DCS_ILvl_EQ_AV_Check:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			--local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked
			--self:SetChecked(checked)
			ilvl_eq_av = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked
			self:SetChecked(ilvl_eq_av)
		end
	end)

	DCS_ILvl_EQ_AV_Check:SetScript("OnClick", function(self)
		--local checked = self:GetChecked()
		--gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked = checked
		ilvl_eq_av = not ilvl_eq_av
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked = ilvl_eq_av
		--[[
		if self:GetChecked(true) then
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked = true
		else
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelEQ_AV_SetChecked = false
		end
		--]]
		PaperDollFrame_UpdateStats()
	end)

local DCS_ItemLevelDecimalPlacesCheck = CreateFrame("CheckButton", "DCS_ItemLevelDecimalPlacesCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ItemLevelDecimalPlacesCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ItemLevelDecimalPlacesCheck:ClearAllPoints()
	--DCS_ItemLevelDecimalPlacesCheck:SetPoint("TOPLEFT", 30, -95)
	DCS_ItemLevelDecimalPlacesCheck:SetPoint("TOPLEFT", "dcsILvlPanelCategoryFS", 7, -55)
	DCS_ItemLevelDecimalPlacesCheck:SetScale(1.00)
	DCS_ItemLevelDecimalPlacesCheck.tooltipText = L["Displays average item level to one decimal place."] --Creates a tooltip on mouseover.
	_G[DCS_ItemLevelDecimalPlacesCheck:GetName() .. "Text"]:SetText(L["One Decimal Place"])
	
	DCS_ItemLevelDecimalPlacesCheck:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			--[[
			local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked
			ilvl_one_decimals = checked
			self:SetChecked(checked)
			--]]
			ilvl_one_decimals = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked
			self:SetChecked(ilvl_one_decimals)
		end
	end)

	DCS_ItemLevelDecimalPlacesCheck:SetScript("OnClick", function(self)
		--[[
		local checked = self:GetChecked()
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = checked
		ilvl_one_decimals = checked
		--]]
		ilvl_one_decimals = self:GetChecked() --can't be improved into ilvl_one_decimals = not ilvl_one_decimals ?
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = ilvl_one_decimals
		if ilvl_one_decimals then
			DCS_ItemLevelTwoDecimalsCheck:SetChecked(false)
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = false
			ilvl_two_decimals = false
		end
		--[[
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked
		if self:GetChecked(true) then
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = true
			DCS_ItemLevelTwoDecimalsCheck:SetChecked(false)
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = false
		else
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = false
		end
		--]]
		PaperDollFrame_UpdateStats()
	end)
	
local DCS_ItemLevelTwoDecimalsCheck = CreateFrame("CheckButton", "DCS_ItemLevelTwoDecimalsCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ItemLevelTwoDecimalsCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ItemLevelTwoDecimalsCheck:ClearAllPoints()
	--DCS_ItemLevelTwoDecimalsCheck:SetPoint("TOPLEFT", 30, -115)
	DCS_ItemLevelTwoDecimalsCheck:SetPoint("TOPLEFT", "dcsILvlPanelCategoryFS", 7, -75)
	DCS_ItemLevelTwoDecimalsCheck:SetScale(1.00)
	DCS_ItemLevelTwoDecimalsCheck.tooltipText = L["Displays average item level to two decimal places."] --Creates a tooltip on mouseover.
	_G[DCS_ItemLevelTwoDecimalsCheck:GetName() .. "Text"]:SetText(L["Two Decimal Places"])
	
	DCS_ItemLevelTwoDecimalsCheck:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			--[[
			local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked
			self:SetChecked(checked)
			ilvl_two_decimals = checked
			--]]
			ilvl_two_decimals = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked
			self:SetChecked(ilvl_two_decimals)
		end
	end)

	DCS_ItemLevelTwoDecimalsCheck:SetScript("OnClick", function(self)
		--[[
		local checked = self:GetChecked()
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = checked
		ilvl_two_decimals = checked
		--]]
		ilvl_two_decimals = self:GetChecked()
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = ilvl_two_decimals
		if ilvl_two_decimals then
			DCS_ItemLevelDecimalPlacesCheck:SetChecked(false)
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = false
			ilvl_one_decimals = false
		end
		--[[
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked
		if self:GetChecked(true) then
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = true
			DCS_ItemLevelDecimalPlacesCheck:SetChecked(false)
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelDecimalsSetChecked = false
		else
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelTwoDecimalsSetChecked = false
		end
		--]]
		PaperDollFrame_UpdateStats()
	end)

local DCS_ILvl_Class_Color_Check = CreateFrame("CheckButton", "DCS_ILvl_Class_Color_Check", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ILvl_Class_Color_Check:RegisterEvent("PLAYER_LOGIN")
	DCS_ILvl_Class_Color_Check:ClearAllPoints()
	--DCS_ILvl_Class_Color_Check:SetPoint("TOPLEFT", 30, -75)
	DCS_ILvl_Class_Color_Check:SetPoint("TOPLEFT", "dcsILvlPanelCategoryFS", 7, -35)
	DCS_ILvl_Class_Color_Check:SetScale(1)
	--DCS_ILvl_Class_Color_Check.tooltipText = L["Displays total average item level with class colors."] --Creates a tooltip on mouseover.
	DCS_ILvl_Class_Color_Check.tooltipText = L["Displays average item level with class colors."] --Creates a tooltip on mouseover.
	_G[DCS_ILvl_Class_Color_Check:GetName() .. "Text"]:SetText(L["Class Colors"]) --wording for both texts is really bad
	
	DCS_ILvl_Class_Color_Check:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			_, unitclass = UnitClass("player");
			--TODO: use of gotten unitclass in other places as well (including DCSDecimals.lua). Will need to wait for this puill to be merged.
			--TODO: rethinking of checkbox placement. Maybe there's more natural order.
			classColorString = "|c"..RAID_CLASS_COLORS[unitclass].colorStr;
			ilvl_class_color = gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelClassColorSetChecked
			self:SetChecked(ilvl_class_color)
		end
	end)

	DCS_ILvl_Class_Color_Check:SetScript("OnClick", function(self)
		ilvl_class_color = not ilvl_class_color
		gdbprivate.gdb.gdbdefaults.dejacharacterstatsItemLevelChecked.ItemLevelClassColorSetChecked = ilvl_class_color
		PaperDollFrame_UpdateStats()
	end)

	
----------------------------
-- DCS Functions & Arrays --
----------------------------

function DCS_TableData:CopyTable(tab)
	local copy = {}
	for k, v in pairs(tab) do
		if k == "RUNE_REGEN" or k == "ATTACK_ATTACKSPEED" or k == "POWER" or k == "ALTERNATEMANA" then
			tab [k] = nil
		else
			copy[k] = (type(v) == "table") and DCS_TableData:CopyTable(v) or v
			--print(k)
		end	
	end
	return copy
end

function DCS_TableData:MergeTable(tab, defaultForSort)
    local exists
	for i, v in ipairs(tab) do
        if (not self.StatData[v.statKey]) then
            table.remove(tab, i)
        end
    end
    local new = {}
    for k in pairs(self.StatData) do
        exists = false 
        for _, v in ipairs(tab) do
            if (k == v.statKey) then exists = true end
        end
        if (not exists) then
            --table.insert(tab, { statKey = k })
            new[k] = true
        end
    end
    --abyui better sort when new attribute
    if defaultForSort then
        for _, v in ipairs(defaultForSort) do
            if new[v.statKey] and not v.hidden then table.insert(tab, { statKey = v.statKey }) end
        end
    else
        for k in pairs(self.StatData) do
            if new[k] then table.insert(tab, { statKey = k }) end
        end
    end
    return tab
end

function DCS_TableData:SwapStat(tab, statKey, dst)
    local src
    for i, v in ipairs(tab) do
        if (v.statKey == statKey) then
            src = v
            table.remove(tab, i)
        end
    end
    for i, v in ipairs(tab) do
        if (v.statKey == dst.statKey) then
            table.insert(tab, i, src or {statKey = statKey})
            break
        end
    end
    return tab
end

DCS_TableData.StatData = DCS_TableData:CopyTable(PAPERDOLL_STATINFO)

DCS_TableData.StatData.ItemLevelFrame = {
    category   = true,
    frame      = char_ctats_pane.ItemLevelFrame,
    updateFunc = function(statFrame)
		-- Check for DejaCharacterStats. Lets hide the frame if the AddOn is not loaded.
		if IsAddOnLoaded("ElvUI") then
			_G.CharacterStatsPane.ItemLevelFrame.Value:Show()
			_G.CharacterFrame.ItemLevelText:SetText('')
		end
		local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvP = GetAverageItemLevel();
		local DCS_DecimalPlaces
		local multiplier
		--if DCS_ItemLevelTwoDecimalsCheck:GetChecked(true) then
		if ilvl_two_decimals then
			DCS_DecimalPlaces = ("%.2f")
			multiplier = 100
		elseif ilvl_one_decimals then
		--elseif DCS_ItemLevelDecimalPlacesCheck:GetChecked(true) then
			DCS_DecimalPlaces = ("%.1f")
			multiplier = 10
		else
			DCS_DecimalPlaces = ("%.0f")
			multiplier = 1
		end
		avgItemLevel = floor(multiplier*avgItemLevel)/multiplier;
		avgItemLevelEquipped = floor(multiplier*avgItemLevelEquipped)/multiplier;
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, STAT_AVERAGE_ITEM_LEVEL).." "..dcs_format(DCS_DecimalPlaces, avgItemLevel);

		--[[-
		if not DCS_ILvl_EQ_AV_Check:GetChecked(true) or (avgItemLevel == avgItemLevelEquipped) then
			PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, dcs_format(DCS_DecimalPlaces,avgItemLevelEquipped), false, avgItemLevelEquipped)
		else
			PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, dcs_format(DCS_DecimalPlaces .. ("/") .. DCS_DecimalPlaces,avgItemLevelEquipped,avgItemLevel), false, avgItemLevelEquipped)
			local temp = DCS_DecimalPlaces .. ")"
			local format_for_avg_equipped = gsub(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, "d%)", temp,  1)
			statFrame.tooltip = statFrame.tooltip .. "  " .. dcs_format(format_for_avg_equipped, avgItemLevelEquipped);
		end
		-]]
		
		--if ilvl_eq_av and (avgItemLevel ~= avgItemLevelEquipped) then
		if ilvl_eq_av and (avgItemLevel > avgItemLevelEquipped) then
			if ilvl_class_color then
				PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, classColorString .. dcs_format(DCS_DecimalPlaces .. ("/") .. DCS_DecimalPlaces,avgItemLevelEquipped,avgItemLevel), false, avgItemLevelEquipped)
			else
				PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, dcs_format(DCS_DecimalPlaces .. ("/") .. DCS_DecimalPlaces,avgItemLevelEquipped,avgItemLevel), false, avgItemLevelEquipped)
			end
			local temp = DCS_DecimalPlaces .. ")"
			local format_for_avg_equipped = gsub(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, "d%)", temp,  1)
			statFrame.tooltip = statFrame.tooltip .. "  " .. dcs_format(format_for_avg_equipped, avgItemLevelEquipped);
		else
			if ilvl_class_color then
				PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, classColorString .. dcs_format(DCS_DecimalPlaces,avgItemLevelEquipped), false, avgItemLevelEquipped)
			else
				PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, dcs_format(DCS_DecimalPlaces,avgItemLevelEquipped), false, avgItemLevelEquipped)
			end
		end
		statFrame.tooltip = statFrame.tooltip .. font_color_close;
		statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
		if ( avgItemLevel ~= avgItemLevelPvP ) then
			statFrame.tooltip2 = statFrame.tooltip2.."\n\n"..STAT_AVERAGE_PVP_ITEM_LEVEL:format(avgItemLevelPvP);
		end
		statFrame:Show()
    end
}

--[[
DCS_TableData.StatData.ActiBlizzWalkout = {
    category   = true,
    frame      = char_ctats_pane.ActiBlizzWalkout,
    updateFunc = function()	end
}
]]

DCS_TableData.StatData.GeneralCategory = {
    category   = true,
    frame      = char_ctats_pane.GeneralCategory,
    updateFunc = function()	end
}

DCS_TableData.StatData.CorruptionCategory = {
    category   = true,
    frame      = char_ctats_pane.CorruptionCategory,
    updateFunc = function() end
}

DCS_TableData.StatData.AttributesCategory = {
    category   = true,
    frame      = char_ctats_pane.AttributesCategory,
    updateFunc = function() end
}

DCS_TableData.StatData.EnhancementsCategory = {
    category   = true,
    frame      = char_ctats_pane.EnhancementsCategory,
    updateFunc = function() end
}

DCS_TableData.StatData.OffenseCategory = {
    category   = true,
    frame      = char_ctats_pane.OffenseCategory,
    updateFunc = function()	end
}

DCS_TableData.StatData.DefenseCategory = {
    category   = true,
    frame      = char_ctats_pane.DefenseCategory,
    updateFunc = function()	end
}

DCS_TableData.StatData.RatingCategory = {
    category   = true,
    frame      = char_ctats_pane.RatingCategory,
    updateFunc = function()	end
}


DCS_TableData.StatData.HonorCategory = {
    category   = true,
    frame      = char_ctats_pane.HonorCategory,
    updateFunc = function()	end
}

DCS_TableData.StatData.ConquestCategory = {
    category   = true,
    frame      = char_ctats_pane.ConquestCategory,
    updateFunc = function()	end
}

function MovementSpeed_OnUpdate(statFrame, elapsedTime) --Added this so Vehicles update as well. Shouldn't be too bad if other addons access this function, but still not as clean as I would like.
	local unit = statFrame.unit;
	local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit);
	runSpeed = runSpeed/BASE_MOVEMENT_SPEED*100;
	flightSpeed = flightSpeed/BASE_MOVEMENT_SPEED*100;
	swimSpeed = swimSpeed/BASE_MOVEMENT_SPEED*100;
	currentSpeed = currentSpeed/BASE_MOVEMENT_SPEED*100;
	
	-- Pets seem to always actually use run speed
	if (unit == "pet") then
		swimSpeed = runSpeed;
	end

	-- Determine whether to display running, flying, or swimming speed
	local speed = runSpeed;
	local swimming = IsSwimming(unit);
	if (UnitInVehicle(unit)) then
		local vehicleSpeed = GetUnitSpeed("Vehicle")/BASE_MOVEMENT_SPEED*100;
		speed = vehicleSpeed
	elseif (swimming) then
		speed = swimSpeed;
	elseif (UnitOnTaxi("player") ) then
		speed = currentSpeed;
	elseif (IsFlying(unit)) then
		speed = flightSpeed;
	end

	-- Hack so that your speed doesn't appear to change when jumping out of the water
	if (IsFalling(unit)) then
		if (statFrame.wasSwimming) then
			speed = swimSpeed;
		end
	else
		statFrame.wasSwimming = swimming;
	end

	local valueText = format("%d%%", speed+0.5);
	PaperDollFrame_SetLabelAndText(statFrame, STAT_MOVEMENT_SPEED, valueText, false, speed);
	statFrame.speed = speed;
	statFrame.runSpeed = runSpeed;
	statFrame.flightSpeed = flightSpeed;
	statFrame.swimSpeed = swimSpeed;
end

local move_speed  --Needs a colon like all other stats have. Concatenated so we don't have to redo every localization to include a colon.
if namespace.locale == "zhTW" then
	move_speed = L["Movement Speed"] .. "：" --Chinese colon
else
	move_speed = L["Movement Speed"] .. ":"
end
hooksecurefunc("MovementSpeed_OnUpdate", function(statFrame)
	statFrame.Label:SetText(move_speed)
end)


local SPELL_POWER_MANA = Enum.PowerType.Mana
DCS_TableData.StatData.DCS_POWER = {
	updateFunc = function(statFrame, unit)
		local powerType = SPELL_POWER_MANA --changing here as well for similarity
		local power = UnitPowerMax(unit,powerType);
		local powerText = BreakUpLargeNumbers(power);
		if power > 0 then
			PaperDollFrame_SetLabelAndText(statFrame, MANA, powerText, false, power);
			statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, MANA).." "..powerText..font_color_close;
			statFrame.tooltip2 = _G["STAT_MANA_TOOLTIP"];
			statFrame:Show();
		else
			statFrame:Hide();
		end
	end
}

DCS_TableData.StatData.DCS_ALTERNATEMANA = {
	updateFunc = function(statFrame, unit)
		local powerType, powerToken = UnitPowerType(unit);
		if (powerToken == "MANA") then
			statFrame:Hide();
			return;
		end
		local power = UnitPowerMax(unit,powerType);
		local powerText = BreakUpLargeNumbers(power);
		
		if (powerToken and _G[powerToken]) then
			PaperDollFrame_SetLabelAndText(statFrame, _G[powerToken], powerText, false, power);
			statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, _G[powerToken]).." "..powerText..font_color_close;
			statFrame.tooltip2 = _G["STAT_"..powerToken.."_TOOLTIP"];
			statFrame:Show();
		else
			statFrame:Hide();
		end
	end
}

--Appears to be duplicate unless for vehicles but above function appears to include vehicles as well.
-- DCS_TableData.StatData.DCS_MOVESPEED = { --Added this so Vehicles update as well
-- 	updateFunc = function(statFrame, unit)
-- 		if ( unit ~= "player" ) then
-- 			statFrame:Hide();
-- 			return;
-- 		end

-- 		statFrame.wasSwimming = nil;
-- 		statFrame.unit = unit;
-- 		statFrame:Show();
-- 		MovementSpeed_OnUpdate(statFrame);

-- 		statFrame.onEnterFunc = MovementSpeed_OnEnter;
-- 	end
-- }

DCS_TableData.StatData.DCS_ATTACK_ATTACKSPEED = {
	updateFunc = function(statFrame, unit)
		local meleeHaste = GetMeleeHaste();
		local speed, offhandSpeed = UnitAttackSpeed(unit);

		local displaySpeed = dcs_format("%.2f", speed);
		if ( offhandSpeed ) then
			offhandSpeed = dcs_format("%.2f", offhandSpeed);
		end
		if ( offhandSpeed ) then
			displaySpeed =  BreakUpLargeNumbers(displaySpeed).." / ".. offhandSpeed;
		else
			displaySpeed =  BreakUpLargeNumbers(displaySpeed);
		end
		PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false, speed);

		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, ATTACK_SPEED).." "..displaySpeed..font_color_close;
		statFrame.tooltip2 = dcs_format(STAT_ATTACK_SPEED_BASE_TOOLTIP, BreakUpLargeNumbers(meleeHaste));

		statFrame:Show();
	end
}

DCS_TableData.StatData.DCS_RUNEREGEN = {
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end

		local _, class = UnitClass(unit);
		if (class ~= "DEATHKNIGHT") then
			statFrame:Hide();
			return;
		end

		local _, regenRate = GetRuneCooldown(1); -- Assuming they are all the same for now
		if regenRate == nil then
			regenRate = 0
		end
		regenRate = tonumber(regenRate)
		
		local regenRateText = (dcs_format(STAT_RUNE_REGEN_FORMAT, regenRate));
		PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRateText, false, regenRate);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, STAT_RUNE_REGEN).." "..regenRateText..font_color_close;
		statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
		statFrame:Show();
	end
}

local offhand_string = "/"..L["Off Hand"]
local white_damage_string = " "..L["weapon auto attack (white) DPS."]
DCS_TableData.StatData.WEAPON_DPS = {
    updateFunc = function(statFrame, unit)
		local function JustGetDamage(unit)
			if IsRangedWeapon() then
				local attackTime, minDamage, maxDamage = UnitRangedDamage(unit);
				return minDamage, maxDamage, nil, nil;
			else
				return UnitDamage(unit);
			end
		end
		local speed, offhandSpeed = UnitAttackSpeed(unit);
		local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage = JustGetDamage(unit);
		local fullDamage = (minDamage + maxDamage)/2;
		local white_dps = fullDamage/speed
		local main_oh_dps = dcs_format("%.2f", white_dps)
		local tooltip2 = (L["Main Hand"])
		-- If there's an offhand speed then add the offhand info to the tooltip
		if ( offhandSpeed and minOffHandDamage and maxOffHandDamage ) then
			local offhandFullDamage = (minOffHandDamage + maxOffHandDamage)/2;
			local oh_dps = offhandFullDamage/offhandSpeed
			main_oh_dps = main_oh_dps .. "/" .. dcs_format("%.2f",oh_dps)
			white_dps = (white_dps + oh_dps)*(1-DUAL_WIELD_HIT_PENALTY/100)
			tooltip2 = tooltip2 .. offhand_string
		end
		tooltip2 = tooltip2 .. white_damage_string
		local misses_etc = (1+BASE_MISS_CHANCE_PHYSICAL[3]/100)*(1+BASE_ENEMY_DODGE_CHANCE[3]/100)*(1+BASE_ENEMY_PARRY_CHANCE[3]/100) -- hopefully the right formula
		white_dps = white_dps*(1 + GetCritChance()/100)/misses_etc --assumes crits do twice as damage
		white_dps = dcs_format("%.2f", white_dps)
		PaperDollFrame_SetLabelAndText(statFrame, L["Weapon DPS"], white_dps, false, white_dps)
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(L["Weapon DPS"], main_oh_dps)).." "..dcs_format("%s", main_oh_dps)..font_color_close;
		statFrame.tooltip2 = (tooltip2);
	end
}

local function casterGCD()
	local haste = GetHaste()
	local gcd = max(0.75, 1.5 * 100 / (100+haste))
	return gcd
end

DCS_TableData.StatData.GCD = {
    updateFunc = function(statFrame)
		local spec = GetSpecialization();
		local primaryStat = select(6, GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player")));
		local gcd
		local _, classfilename = UnitClass("player")
		--print(classfilename)
		if (classfilename == "DRUID") then
			local id = GetShapeshiftFormID()
			if (id == 1) then --cat form
				gcd = 1
			else 
				-- strangely, bear form seems to have the same formula for gcd as casters
				gcd = casterGCD()
			end
		else
			if (primaryStat == LE_UNIT_STAT_INTELLECT) or (classfilename == "HUNTER") or (classfilename == "SHAMAN") or (primaryStat == LE_UNIT_STAT_STRENGTH) or (classfilename == "DEMONHUNTER")then 
				-- adding wariors, paladins
				-- tested with Crusader Strike, Judgment on retribution paladin
				-- tested with Consecration, Avenger's Shield, Judgment on protection paladin
				-- tested with Slam on level 1 warior
				-- tested with Cobra shot and Multi-shot for hunter. Have troll hunter but don't have pet with Ancient Hysteria //Kakjens
				-- adding DK-s as reported by Mpstark
				-- tested enhancement shaman with several spells including Lighnting Shield. Wind Shear appears not to induce GCD
				gcd = casterGCD()
			else
				gcd = 1 -- tested with mutilate for assasination rogues.
			end
		end
		PaperDollFrame_SetLabelAndText(statFrame, L["Global Cooldown"], dcs_format("%.2fs",gcd), false, gcd)
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(L["Global Cooldown"], gcd)).." "..dcs_format("%.2fs", gcd)..font_color_close;
		statFrame.tooltip2 = (L["General global cooldown refresh time."]);
	end
}

DCS_TableData.StatData.REPAIR_COST = {
    updateFunc = function(statFrame, unit)
        if (not statFrame.scanTooltip) then
            statFrame.scanTooltip = CreateFrame("GameTooltip", "StatRepairCostTooltip", statFrame, "GameTooltipTemplate")
            statFrame.scanTooltip:SetOwner(statFrame, "ANCHOR_NONE")
            statFrame.MoneyFrame = CreateFrame("Frame", "StatRepairCostMoneyFrame", statFrame, "TooltipMoneyFrameTemplate")
            MoneyFrame_SetType(statFrame.MoneyFrame, "TOOLTIP")
            statFrame.MoneyFrame:SetPoint("RIGHT", 3, -1)
            local font, size, flag = statFrame.Label:GetFont()
			--print (font, size, flag)
            statFrame.Label:SetFont(font, size, flag)
        end
		--beware of strange mathematical calculations below
		--[[local try_to_predict_more_accurately = false -- placeholder for the checkbox
		--local multiplier
		local upperbound, lowerbound
		local reaction
		if try_to_predict_more_accurately then
			reaction = UnitReaction("target", "player")
			if not UnitIsPVP("target") then reaction = 4 end -- should take care of repair bots/repair mounts
			--if not reaction then reaction = 4 end --if no target then neutral faction; seems like isn't needed
			multiplier = (24 - reaction)/20 -- friendly faction has 5% discount, and exalted 20% discount
			--print("mult= ",multiplier)
			upperbound, lowerbound = 0, 0
		end
		--]]
        local totalCost = 0
        local _, repairCost
        for _, index in ipairs({1,3,5,6,7,8,9,10,16,17}) do
            statFrame.scanTooltip:ClearLines()
            _, _, repairCost = statFrame.scanTooltip:SetInventoryItem(unit, index)
            if (repairCost and repairCost > 0) then
                totalCost = totalCost + repairCost
				--if try_to_predict_more_accurately then
				--	upperbound = upperbound + floor((repairCost+0.5)/multiplier)
				--	lowerbound = lowerbound + ceil((repairCost-0.5)/multiplier)
				--end
            end
        end

		--local repairAllCost, canRepair = GetRepairAllCost()
		--print(repairAllCost)
--		print("----")
		--if try_to_predict_more_accurately then
			--print("between ",lowerbound," and ",upperbound)
		--	totalCost = floor(0.5+multiplier*(upperbound + lowerbound)/2)
			--print(totalCost)
		--end
        MoneyFrame_Update(statFrame.MoneyFrame, totalCost)
		statFrame.MoneyFrame:Hide()
		
		local totalRepairCost = GetCoinTextureString(totalCost)
		--are variables gold, silver, copper, and , consequently, displayRepairTotal needed? by uncommenting next line I see no difference
		--totalCost = 0 
		--local gold = floor(abs(totalCost / 10000))
		--local silver = floor(abs(mod(totalCost / 100, 100)))
		--local copper = floor(abs(mod(totalCost, 100)))
		local gold = floor(totalCost / 10000)
		local silver = floor(mod(totalCost / 100, 100)) 
		local copper = mod(totalCost, 100)
		--print(dcs_format("I have %d gold %d silver %d copper.", gold, silver, copper))
		local displayRepairTotal = dcs_format("%dg %ds %dc", gold, silver, copper);

		--STAT_FORMAT
		-- PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage, numericValue) -- Formatting

		PaperDollFrame_SetLabelAndText(statFrame, (L["Repair Total"]), totalRepairCost, false, displayRepairTotal);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(L["Repair Total"], totalRepairCost)).." "..dcs_format("%s", totalRepairCost)..font_color_close;
		statFrame.tooltip2 = (L["Total equipped item repair cost before discounts."]);
    end
}
local dura_format = L["Durability"] .." %s"
DCS_TableData.StatData.DURABILITY_STAT = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end

		DCS_Mean_DurabilityCalc()
		--print(addon.duraMean)
		
		local displayDura = dcs_format("%.2f%%", addon.duraMean);

		PaperDollFrame_SetLabelAndText(statFrame, (L["Durability"]), displayDura, false, addon.duraMean);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(dura_format, displayDura));
		statFrame.tooltip2 = (L["Average equipped item durability percentage."]);

		--local duraFinite = 0
		statFrame:Show();
	end
}

local rating_and_percentage = L["%s of %s increases %s by %.2f%%"]

local statnames = {
 --[CR_HASTE_MELEE] = {name1 = L["Haste Rating"], name2 = L["haste"]},
 [CR_HASTE_MELEE] = {name1 = L["Haste Rating"], name2 = STAT_HASTE},
 --[CR_LIFESTEAL] = {name1 = L["Leech Rating"], name2 = L["leech"]},
 [CR_LIFESTEAL] = {name1 = L["Leech Rating"], name2 = STAT_LIFESTEAL},
 --[CR_AVOIDANCE] = {name1 = L["Avoidance Rating"], name2 = L["avoidance"]},
 [CR_AVOIDANCE] = {name1 = L["Avoidance Rating"], name2 = STAT_AVOIDANCE},
  --[CR_DODGE] = {name1 = L["Dodge Rating"], name2 = L["dodge"]},
  [CR_DODGE] = {name1 = L["Dodge Rating"], name2 = STAT_DODGE},
 --[CR_PARRY] = {name1 = L["Parry Rating"], name2 = L["parry"]},
 [CR_PARRY] = {name1 = L["Parry Rating"], name2 = STAT_PARRY},
 [CR_SPEED] = {name1 = L["Speed Rating"], name2 = L["Movement Speed"]},--need tests with items that increase it, for example, Mark of Supreme Doom from Supreme Lord Kazzak
}

local function statframeratings(statFrame, unit, stat)
	--outliers crit, versatility, mastery
	--don't see items/enchnats that increase block chance
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local rating = GetCombatRating(stat)
	local percentage = GetCombatRatingBonus(stat)
	local ratingname = statnames [stat].name1
	local name = statnames [stat].name2
	PaperDollFrame_SetLabelAndText(statFrame, ratingname, rating, false, rating);
	statFrame.tooltip = highlight_code..ratingname.." "..rating..font_color_close;
	statFrame.tooltip2 = dcs_format(rating_and_percentage, ratingname, BreakUpLargeNumbers(rating), name, percentage);
	statFrame:Show();
end

DCS_TableData.StatData.CRITCHANCE_RATING = { -- maybe add 3 different stats - melee, ranged and spell crit ratings?
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local stat;
		local ratingname = L["Critical Strike Rating"]
		local spellCrit, rangedCrit, meleeCrit;
		-- Start at 2 to skip physical damage
		local holySchool = 2;
		local minCrit = GetSpellCritChance(holySchool);
		statFrame.spellCrit = {};
		statFrame.spellCrit[holySchool] = minCrit;
		--local spellCrit;
		for i=(holySchool+1), MAX_SPELL_SCHOOLS do
			spellCrit = GetSpellCritChance(i);
			minCrit = min(minCrit, spellCrit);
			statFrame.spellCrit[i] = spellCrit;
		end
		spellCrit = minCrit
		rangedCrit = GetRangedCritChance();
		meleeCrit = GetCritChance();

		if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
			stat = CR_CRIT_SPELL;
		elseif (rangedCrit >= meleeCrit) then
			stat = CR_CRIT_RANGED;
		else
			stat = CR_CRIT_MELEE;
		end
		local rating = GetCombatRating(stat);
		local percentage = dcs_format("%.2f",GetCombatRatingBonus(stat));
		PaperDollFrame_SetLabelAndText(statFrame, ratingname, rating, false, rating);
		statFrame.tooltip = highlight_code..ratingname.." "..rating..font_color_close;
		--statFrame.tooltip2 = dcs_format("Critical Strike Rating of %s increases chance to crit by %.2f%%", BreakUpLargeNumbers(rating), percentage);
		--statFrame.tooltip2 = dcs_format(rating_and_percentage, ratingname, BreakUpLargeNumbers(rating), L["crit"], percentage);
		statFrame.tooltip2 = dcs_format(rating_and_percentage, ratingname, BreakUpLargeNumbers(rating), STAT_CRITICAL_STRIKE, percentage);
		statFrame:Show();
	end
}

DCS_TableData.StatData.VERSATILITY_RATING = {
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local ratingname = L["Versatility Rating"]
		local versatility = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
		local versatilityDamageBonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
		--local versatilityDamageTakenReduction = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN);
		PaperDollFrame_SetLabelAndText(statFrame, ratingname, versatility, false, versatility);
		statFrame.tooltip = highlight_code..ratingname.." "..versatility..font_color_close;
		--statFrame.tooltip2 = dcs_format(rating_and_percentage,L["Versatility Rating"], BreakUpLargeNumbers(versatility), L["versatility"], versatilityDamageBonus);
		statFrame.tooltip2 = dcs_format(rating_and_percentage,ratingname, BreakUpLargeNumbers(versatility), STAT_VERSATILITY, versatilityDamageBonus);
		--statFrame.tooltip2 = dcs_format("Versatility Rating of %s increases damage and healing done by %.2f%% and reduces damage taken by %.2f%%", BreakUpLargeNumbers(versatility), versatilityDamageBonus, versatilityDamageTakenReduction);
		statFrame:Show();
	end
}

DCS_TableData.StatData.MASTERY_RATING = {

	--localisation of font colors (highlight_code and font_color_close)

	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local color_rating1 = L["Mastery Rating"]
		local color_rating2 
		if namespace.locale == "zhTW" then
			color_rating2 = color_rating1 .. "：" --Chinese colon
		else
			color_rating2 = color_rating1 .. ":"
		end
		local color_format = "%d"
		local add_text = ""
		--if (UnitLevel("player") < SHOW_MASTERY_LEVEL) then
		--	statFrame.numericValue = 0;
		--	statFrame:Hide();
		--	return;
		--end
		local _, bonuscoeff = GetMasteryEffect();
		local stat = CR_MASTERY
		local rating = GetCombatRating(stat)
		-- Mastery is always shown now in Shadowlands
		-- if (UnitLevel("player") < SHOW_MASTERY_LEVEL) then
		-- 	if not namespace.configMode then
		-- 		if namespace.hidemastery then
		-- 			statFrame:Hide();
		-- 			--print("hiding")
		-- 			return;
		-- 		end
		-- 	end
		-- 	color_rating1 = "|cff7f7f7f" .. color_rating1 .. "|r"
		-- 	color_rating2 = "|cff7f7f7f" .. color_rating2 .. "|r"
		-- 	color_format = "|cff7f7f7f" .. color_format .. "|r"
		-- 	local requires = L["Requires Level "]
		-- 	add_text = " |cffff0000(" .. requires .. SHOW_MASTERY_LEVEL ..")|r"
		-- end
		local percentage = dcs_format("%.2f",GetCombatRatingBonus(stat)*bonuscoeff)
		PaperDollFrame_SetLabelAndText(statFrame, "", dcs_format(color_format,rating), false, rating);
		statFrame.Label:SetText(color_rating2)
		statFrame.tooltip = highlight_code..color_rating1.." "..dcs_format(color_format,rating)..add_text..font_color_close;
		--statFrame.tooltip2 = dcs_format("Mastery Rating of %s increases mastery by %.2f%%", BreakUpLargeNumbers(rating), percentage);
		--statFrame.tooltip2 = dcs_format(rating_and_percentage, L["Mastery Rating"], BreakUpLargeNumbers(rating), L["mastery"], percentage);
		statFrame.tooltip2 = dcs_format(rating_and_percentage, L["Mastery Rating"], BreakUpLargeNumbers(rating), STAT_MASTERY, percentage);
		statFrame:Show();
	end
}

DCS_TableData.StatData.HASTE_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_HASTE_MELEE)
	end
}

DCS_TableData.StatData.LIFESTEAL_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_LIFESTEAL)
	end
}

DCS_TableData.StatData.AVOIDANCE_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_AVOIDANCE)
	end
}

DCS_TableData.StatData.DODGE_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_DODGE)
	end
}

DCS_TableData.StatData.PARRY_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_PARRY)
	end
}
DCS_TableData.StatData.SPEED_RATING = {
	updateFunc = function(statFrame, unit)
		statframeratings(statFrame, unit, CR_SPEED)
	end
}

DCS_TableData.StatData.CR_CORRUPTION = {
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local ratingname = L["Base Corruption"]
		local basecorruption = GetCorruption()

		local c, r = GetCorruption(), GetCorruptionResistance()
		CR_CORRUPTION = max(0, c - r)  -- max to prevent negative values

		PaperDollFrame_SetLabelAndText(statFrame, ratingname, basecorruption, false, basecorruption);
		statFrame.tooltip = highlight_code..ratingname.." "..basecorruption..font_color_close;
		statFrame:Show();
	end
}

DCS_TableData.StatData.CR_CORRUPTION_RESISTANCE = {
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local ratingname = L["Corruption Resistance"]
		local corruptionresistance = GetCorruptionResistance()

		CR_CORRUPTION_RESISTANCE = corruptionresistance

		PaperDollFrame_SetLabelAndText(statFrame, ratingname, corruptionresistance, false, corruptionresistance);
		statFrame.tooltip = highlight_code..ratingname.." "..corruptionresistance..font_color_close;
		statFrame:Show();
	end
}

DCS_TableData.StatData.CR_TOTAL_CORRUPTION = {
	updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		local ratingname = L["Total Corruption"]
		local c, r = GetCorruption(), GetCorruptionResistance()
		local totalcorruption = max(0, c - r) -- max to prevent negative values
		
		local c, r = GetCorruption(), GetCorruptionResistance()
		CR_TOTAL_CORRUPTION = max(0, c - r)  -- max to prevent negative values

		PaperDollFrame_SetLabelAndText(statFrame, "|cff8787ED"..ratingname.."|r", "|cff8787ED"..totalcorruption.."|r", false, totalcorruption);
		statFrame.tooltip = "|cff8787ED" .. ratingname .. " " .. totalcorruption .. "|r";
		statFrame:Show();
	end
}

local function UpdateRatingFrame(statFrame, unit, bracketIndex, bracketString, bracketCodeName)
	return function(statFrame, unit)
		RequestRatedInfo();
		local rating = select(1, GetPersonalRatedInfo(bracketIndex));
		local ratingStr = tostring(rating);

		PaperDollFrame_SetLabelAndText(statFrame, bracketString, ratingStr, false, rating);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, bracketString).." "..ratingStr..font_color_close;
		statFrame.tooltip2 = _G["STAT_"..bracketCodeName.."_TOOLTIP"];
		statFrame:Show();
	end
end

DCS_TableData.StatData.RATING_2V2 = {
	updateFunc = UpdateRatingFrame(statFrame, unit, 1, L["2v2 Rating"], "RATING_2V2");
}

DCS_TableData.StatData.RATING_3V3 = {
	updateFunc = UpdateRatingFrame(statFrame, unit, 2, L["3v3 Rating"], "RATING_3V3");
}

DCS_TableData.StatData.RATING_RBG = {
	updateFunc = UpdateRatingFrame(statFrame, unit, 4, L["RBG Rating"], "RATING_RBG");
}

local function RoundNumber(value, decimalPlaces)
	local roundedValue;
	local scale = 10 ^ decimalPlaces;

	roundedValue = (floor(value * scale + 0.5))/scale;

	return roundedValue;
end

local function BuildProgressAndPercentString(current, maximum)
	local str;

	if (maximum and not (maximum == 0)) then
		local percent = 100 * (current / maximum);
		local rounded = RoundNumber(percent, 2);
		str = current .. "/" .. maximum .. " (" .. rounded .. "%)";
	else
		str = "-"
	end

	return str;
end

DCS_TableData.StatData.CONQUEST_PROGRESS = {
	updateFunc = function(statFrame, unit)
		local currentValue, maxValue, questID = PVPGetConquestLevelInfo();
		local conquestStr = BuildProgressAndPercentString(currentValue, maxValue);

		PaperDollFrame_SetLabelAndText(statFrame, L["Conquest"], conquestStr, false, currentValue);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, L["Conquest"]).." "..conquestStr..font_color_close;
		statFrame.tooltip2 = _G["STAT_CONQUEST_TOOLTIP"];
		statFrame:Show();
	end
}

DCS_TableData.StatData.HONOR_PROGRESS = {
	updateFunc = function(statFrame, unit)
		local currentValue = UnitHonor("player");
		local maxValue = UnitHonorMax("player");
		local honorProgressStr = BuildProgressAndPercentString(currentValue, maxValue);

		PaperDollFrame_SetLabelAndText(statFrame, L["Honor"], honorProgressStr, false, currentValue);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, L["Honor"]).." "..honorProgressStr..font_color_close;
		statFrame.tooltip2 = _G["STAT_HONOR_PROGRESS_TOOLTIP"];
		statFrame:Show();
	end
}

DCS_TableData.StatData.HONOR_LEVEL = {
	updateFunc = function(statFrame, unit)
		local honorLevel = UnitHonorLevel("player");
		local honorLevelStr = tostring(honorLevel);

		PaperDollFrame_SetLabelAndText(statFrame, L["Honor Level"], honorLevelStr, false, honorLevel);
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, L["Honor Level"]).." "..honorLevelStr..font_color_close;
		statFrame.tooltip2 = _G["STAT_HONOR_LEVEL_TOOLTIP"];
		statFrame:Show();
	end
}

--[[
local BGC_format = L['|cffffffffBlack Girls CODE|r'] .." %s"
DCS_TableData.StatData.BLACK_GIRLS_CODE = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "77"

		PaperDollFrame_SetLabelAndText(statFrame, (L["Black Girls CODE"]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(BGC_format, ""));
		statFrame.tooltip2 = ('\n|cffffffff"The future looks like me."|r\n\n|cffffffffhttps://www.blackgirlscode.com|r\n\nWe build pathways for young women of color to embrace the current tech marketplace as builders and creators by introducing them to skills in computer programming and technology.\n\nRadical action is needed if we are to close the opportunity gap for Black women and girls. We lead a global movement to establish equal representation in the tech sector. Black Girls CODE is devoted to showing the world that Black girls can code and do so much more. Together, we are creating stronger economies and more equitable societies—ultimately realizing the true potential of democracy through diversity and inclusion.\n\nWomen and girls make up |cffffffff70%|r of the people living on less than $1/day.\n\nWomen worldwide... perform |cffffffff66%|r of the world\'s work.\n\n|cffffffff41 million|r girls are sill denied a primary education.\n\nWomen make only |cff00c0ff77 cents|r for every dollar made by their male counterparts.\n\nPoverty rate were roughly |cffffffff3x|r for african american and latina girls over thoses of white girls, as of 2010.\n\nWomen hold |cffffffff< 14%|r of executive officer positions of fortune 100 companies and represent |cffffffff< 1%|r of startup founders.\n\nStudents earning degrees in computer science\n|cffffffff<1%|r Latina & Native American Women\n|cffffffff<3%|r African American Women\n|cffffffff18%|r White Women\n\nOver |cffffffff50%|r of middle school girls are interested in computer\nBut high school fewer than |cffffffff2%|r plan to major in computer');

		statFrame:Show();
	end
}

local FUTURES_format = L['Futures without Violence'] .." %s"
DCS_TableData.StatData.FUTURES = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "1/4"

		PaperDollFrame_SetLabelAndText(statFrame, (L["Futures without Violence"]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(FUTURES_format, ""));
		statFrame.tooltip2 = ('\n|cff8DB856"Our vision is a future without violence that provides education, safety, justice, and hope."|r\n\n|cffffffffhttps://www.futureswithoutviolence.org|r\n\n|cffffffffOur Mission & Values|r\n\nFor more than 30 years, FUTURES has been providing groundbreaking programs, policies, and campaigns that empower individuals and organizations working to end violence against women and children around the world.\n\nProviding leadership from offices in San Francisco, Washington D.C. and Boston, we’ve established a state-of-the-art Center for Leadership and Action in the Presidio of San Francisco to foster ongoing dialogue about gender-based violence and child abuse.\n\nStriving to reach new audiences and transform social norms, we train professionals such as doctors, nurses, judges, and athletic coaches on improving responses to violence and abuse. We also work with advocates, policymakers, and others to build sustainable community leadership and educate people everywhere about the importance of respect and healthy relationships.\n\nOur vision is a future without violence that provides education, safety, justice, and hope.\n\n|cff00c0ff1 in 4|r US Women has experienced violence by a partner at some point in her life.\n\n|cff00c0ff1 in 4|r teens is harassed or abused through technology.\n\nEach year, |cffffffff15 million|r girls are married before the age of 18.\n\n|cffffffff16 to 20 percent|r of female college students are sexually assaulted while in college.\n\nWomen & girls account for |cffffffff75%|r of trafficking victims globally.\n\nWomen who talk to a provider about abuse are |cffffffff2.6X|r likely to exit an abusive relationship.');

		statFrame:Show();
	end
}

local GIRLS_WHO_CODE_format = L['|cffffffffGirls Who Code|r'] .." %s"
DCS_TableData.StatData.GIRLS_WHO_CODE = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "|cffffffff24%|r"

		PaperDollFrame_SetLabelAndText(statFrame, (L["Girls Who Code"]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(GIRLS_WHO_CODE_format, ""));
		statFrame.tooltip2 = ('\n|cff83CDC6"We\'re on a mission\n     to close the gender gap in tech."|r\n\n|cffffffffhttps://girlswhocode.com|r\n\nThe gender gap in computing is getting worse.\nIn 1995, |cffffffff37%|r of computer scientists were women. Today, it’s only |cff00c0ff24%|r. The percent will continue to decline if we do nothing. We know that the biggest drop off of girls in computer science is between the ages of 13 and 17.\n\nGirls Who Code is changing the game\nWe\'re reaching girls around the world and are on track to close the gender gap in new entry-level tech jobs by 2030.\n\n|cffffffff500M|r\nPeople Reached\nThrough our online resources, campaigns, books, and advocacy work - in the U.S. and around the world.\n\n|cffffffff450,000|r\nGirls Served\nThrough our in-person programming including our Summer Immersion Program, Clubs, and College Loops.\n\n|cffffffff50%|r\nHUGs\nHalf of the girls we serve come from historically underrepresented groups, including girls who are Black, Latinx, or from low-income backgrounds.');

		statFrame:Show();
	end
}

local RAINN_format = L['RAINN'] .." %s"
DCS_TableData.StatData.RAINN = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "3,500,000"

		PaperDollFrame_SetLabelAndText(statFrame, (L["RAINN"]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(RAINN_format, ""));
		statFrame.tooltip2 = ('\n  |cff00c0ff"We\’re here when you need us."|r\n\n|cffffffffhttps://www.rainn.org|r\n\n|cffffffffRAINN\'S MISSION|r\n\nRAINN (Rape, Abuse & Incest National Network) is the nation\'s largest anti-sexual violence organization. RAINN created and operates the |cffffffffNational Sexual Assault Hotline (800.656.HOPE, online.rainn.org y rainn.org/es)|r in partnership with more than 1,000 local sexual assault service providers across the country and operates the DoD Safe Helpline for the Department of Defense. RAINN also carries out programs to prevent sexual violence, help survivors, and ensure that perpetrators are brought to justice.\n\nIn 26 years RAINN has helped |cff00c0ff3.5 million|r survivors and their loved ones.\n\n|cffffffff95¢|r of every $1 goes to helping survivors and preventing sexual violence."');

		statFrame:Show();
	end
}

local WOMEN_IN__ANIMATION_format = L['Women in Animation'] .." %s"
DCS_TableData.StatData.WOMEN_IN__ANIMATION = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "50/50"

		PaperDollFrame_SetLabelAndText(statFrame, (L["Women in Animation"]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(WOMEN_IN__ANIMATION_format, ""));
		statFrame.tooltip2 = ('\n|cffffffffhttps://womeninanimation.org|r\n\n|cffffffffOUR MISSION|r\n\nFounded in 1995, WIA is the only organization dedicated to advancing women in the field of animation. We envision a world where women share equally in the creation, production and rewards of animation, and we provide resources and connections to make it happen.\n\n|cffffffffWHY IT MATTERS|r\n\nAs the popularity of animation has grown, it now reaches audiences of diverse age, gender, ethnicity, and culture. As this growth continues, so does the need to ensure that animation content represents the world as it should be – a world where women are equally represented, both behind the scenes and on the screen, to move culture forward.\n\nWomen are known for the ability to value, tap into, and use our creativity and abilities to influence. And women’s influence in animation is one that rounds out the industry, grows revenues, and contributes to that forward cultural momentum.\n\nJoin the cause with WIA to help realize the goal of |cff00c0ff50/50 by 2025|r.  By working together and bringing awareness to the issue of inequality in the animation industry we can make this happen.');

		statFrame:Show();
	end
}

local WOMEN_IN_GAMES_INTL_format = L['Women in Games International'] .." %s"
DCS_TableData.StatData.WOMEN_IN_GAMES_INTL = {
    updateFunc = function(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end
		
		local displayDura = "46%"

		PaperDollFrame_SetLabelAndText(statFrame, (L["Women in Games Intl."]), displayDura, false, "");
		statFrame.tooltip = highlight_code..dcs_format(doll_tooltip_format, dcs_format(WOMEN_IN_GAMES_INTL_format, ""));
		statFrame.tooltip2 = ('\n|cffffffffhttps://www.getwigi.com|r\n\n|cffffffffWho We Are|r\n\nWomen in Games International (WIGI) is a 501(c)(3) nonprofit organization based in Los Angeles, California, with a mission to cultivate resources to advance economic equality and diversity in the global games industry.\n\n|cffffffffTurning Interest Into Action|r\n\nWhen women weren\'t recognized for their contributions in the past, they were often omitted from history altogether. Since our inception in 2005, Women in Games International has been committed to investing our expertise and resources to highlight and celebrate women making an impact in the global games industry.\n\nWIGI utilizes seasoned industry professionals to activate and empower a global community of women and allies. Our WIGI Weekly newsletter is distributed to thousands of gaming professionals, promoting our mission, highlighting meaningful partnerships, and elevating job opportunities within the industry.\n\nBy cultivating resources such as advanced knowledge sharing, access to technology, and actionable mentorship programs, Women in Games International works to normalize women in the video game industry through increased representation. In doing so, we aim to create superior products and a stronger industry, with diverse games and greater female representation that reflect the growing population of female gamers.\n\n|cffffffffGaming Industry Conferences|r\n\nWomen in Games International creates conference sessions for video game and tech industry conferences that highlight issues of interest to women in tech and video games. Our conference sessions have covered issues such as how to succeed in a male-dominated workplace, career advancement and salary negotiations, self-advocacy and overcoming imposter syndrome, and how to create diverse content in a globalized market.\n\n|cffffffffThe Why|r\n\nAt |cff00c0ff46%|r, women today make up almost half of gamers worldwide; however, if you look at the 144 executives in the Top 14 gaming companies, only 23 or |cffffffff16%|r are women. According to the 2020 Bryter Female Gamer Survey, |cffffffffmore than half|r of those polled felt that the games industry wasn\'t doing enough to support and welcome women gamers or women interested in gaming careers, and |cffffffff62%|r didn\'t feel women were well-represented in the industry currently.');

		statFrame:Show();
	end
}
--]]