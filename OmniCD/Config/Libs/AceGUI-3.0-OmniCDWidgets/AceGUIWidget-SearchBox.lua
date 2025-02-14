--[[-----------------------------------------------------------------------------
EditBox Widget
-------------------------------------------------------------------------------]]
local Type, Version = "SearchBox-OmniCD", 28
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local tostring, pairs = tostring, pairs

-- WoW APIs
local PlaySound = PlaySound
local GetCursorInfo, ClearCursor, GetSpellInfo = GetCursorInfo, ClearCursor, GetSpellInfo
local CreateFrame, UIParent = CreateFrame, UIParent
local _G = _G

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: AceGUIEditBoxInsertLink, ChatFontNormal, OKAY

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
if not AceGUIEditBoxInsertLink then
	-- upgradeable hook
	hooksecurefunc("ChatEdit_InsertLink", function(...) return _G.AceGUIEditBoxInsertLink(...) end)
end

function _G.AceGUIEditBoxInsertLink(text)
	for i = 1, AceGUI:GetWidgetCount(Type) do
		local editbox = _G["AceGUI-3.0SearchBox-OmniCD"..i]
		if editbox and editbox:IsVisible() and editbox:HasFocus() then
			editbox:Insert(text)
			return true
		end
	end
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
	frame.obj.editbox:SetBackdropBorderColor(0.5, 0.5, 0.5, 1) -- match range slider editbox
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
	frame.obj.editbox:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
end

local function Frame_OnShowFocus(frame)
	frame.obj.editbox:SetFocus()
	frame:SetScript("OnShow", nil)
end

local function EditBox_OnEscapePressed(frame)
	AceGUI:ClearFocus()
end

local function EditBox_OnEnterPressed(frame)
	local self = frame.obj
	local value = frame:GetText()
	local cancel = self:Fire("OnEnterPressed", value)
	if not cancel then
		PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
	end
end

local function EditBox_OnReceiveDrag(frame)
	local self = frame.obj
	local type, id, info = GetCursorInfo()
	local name
	if type == "item" then
		name = info
	elseif type == "spell" then
		name = GetSpellInfo(id, info)
	elseif type == "macro" then
		name = GetMacroInfo(id)
	end
	if name then
		self:SetText(name)
		self:Fire("OnEnterPressed", name)
		ClearCursor()
		AceGUI:ClearFocus()
	end
end

local function EditBox_OnTextChanged(frame)
	local self = frame.obj
	local value = frame:GetText()
	if tostring(value) ~= tostring(self.lasttext) then
		self:Fire("OnTextChanged", value)
		self.lasttext = value
	end
end

local function EditBox_OnFocusGained(frame)
	AceGUI:SetFocus(frame.obj)
end

local function Button_OnClick(frame)
	local editbox = frame.obj.editbox
	editbox:ClearFocus()
	EditBox_OnEnterPressed(editbox)
end

local function Button_OnEnter(frame)
	frame:SetBackdropBorderColor(0.725, 0.008, 0.008)
end

local function Button_OnLeave(frame)
	frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetWidth(200) -- height is controlled by SetLabel
		self:SetDisabled(false)
		self:SetLabel()
		self:SetText()
		self:SetMaxLetters(0)
	end,

	["OnRelease"] = function(self)
		self:ClearFocus()
	end,

	["SetDisabled"] = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.editbox:EnableMouse(false)
			self.editbox:ClearFocus()
			self.editbox:SetTextColor(0.5,0.5,0.5)
			self.label:SetTextColor(0.5,0.5,0.5)
			self.button.bg:SetTexture([[Interface\AddOns\OmniCD\Media\omnicd-bg-search-off]])
			self.button:EnableMouse(false)
		else
			self.editbox:EnableMouse(true)
			self.editbox:SetTextColor(1,1,1)
			self.label:SetTextColor(1,.82,0)
			self.button.bg:SetTexture([[Interface\AddOns\OmniCD\Media\omnicd-bg-search-on]])
			self.button:EnableMouse(true)
		end
	end,

	["SetText"] = function(self, text)
		self.lasttext = text or ""
		self.editbox:SetText(text or "")
		self.editbox:SetCursorPosition(0)
	end,

	["GetText"] = function(self, text)
		return self.editbox:GetText()
	end,

	["SetLabel"] = function(self, text)
		if text and text ~= "" then
			self.label:SetText(text)
			self.label:Show()
			self.editbox:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,-19)
			self:SetHeight(44)
			self.alignoffset = 30
		else
			self.label:SetText("")
			self.label:Hide()
			self.editbox:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,-1)
			self:SetHeight(26)
			self.alignoffset = 12
		end
	end,

	["SetMaxLetters"] = function (self, num)
		self.editbox:SetMaxLetters(num or 0)
	end,

	["ClearFocus"] = function(self)
		self.editbox:ClearFocus()
		self.frame:SetScript("OnShow", nil)
	end,

	["SetFocus"] = function(self)
		self.editbox:SetFocus()
		if not self.frame:IsShown() then
			self.frame:SetScript("OnShow", Frame_OnShowFocus)
		end
	end,

	["HighlightText"] = function(self, from, to)
		self.editbox:HighlightText(from, to)
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	local num  = AceGUI:GetNextWidgetNum(Type)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Hide()

	local editbox = CreateFrame("EditBox", "AceGUI-3.0SearchBox-OmniCD"..num, frame, BackdropTemplateMixin and "InputBoxTemplate, BackdropTemplate" or "InputBoxTemplate")
	editbox:SetPoint("BOTTOMRIGHT", 0, 3) -- height is controlled by SetLabel
	editbox.Left:SetTexture(nil)
	editbox.Right:SetTexture(nil)
	editbox.Middle:SetTexture(nil)
	OmniCD[1].BackdropTemplate(editbox)
	editbox:SetBackdropColor(0, 0, 0, 0.5)
	editbox:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
	editbox:SetFontObject("GameFontHighlight-OmniCD")
	editbox:SetTextInsets(3, 20, 3, 3)
	editbox:SetMaxLetters(256)
	editbox:SetAutoFocus(false)
	editbox:SetScript("OnEnter", Control_OnEnter)
	editbox:SetScript("OnLeave", Control_OnLeave)
	editbox:SetScript("OnEscapePressed", EditBox_OnEscapePressed)
	editbox:SetScript("OnEnterPressed", EditBox_OnEnterPressed)
	editbox:SetScript("OnTextChanged", EditBox_OnTextChanged)
	editbox:SetScript("OnReceiveDrag", EditBox_OnReceiveDrag)
	editbox:SetScript("OnMouseDown", EditBox_OnReceiveDrag)
	editbox:SetScript("OnEditFocusGained", EditBox_OnFocusGained)

	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall-OmniCD")
	label:SetPoint("TOPLEFT", 0, -2)
	label:SetPoint("TOPRIGHT", 0, -2)
	label:SetHeight(18)
	label:SetJustifyH("LEFT")

	local button = CreateFrame("Button", nil, editbox, BackdropTemplateMixin and "BackdropTemplate" or nil) -- 'Editbox' inherits UIPanelButtonTemplate>UIPanelButtonNoTooltipTemplate <Size x="40" y="22"/>
	button:SetWidth(22)
	button:SetPoint("TOPRIGHT")
	button:SetPoint("BOTTOMRIGHT")
	OmniCD[1].BackdropTemplate(button)
	button:SetBackdropColor(0, 0, 0, 0)
	button:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
	button.bg = button:CreateTexture(nil, "ARTWORK")
	OmniCD[1].DisablePixelSnap(button.bg)
	button.bg:SetPoint("TOPLEFT", button.TopEdge, "BOTTOMLEFT")
	button.bg:SetPoint("BOTTOMRIGHT", button.BottomEdge, "TOPRIGHT")
	button.bg:SetTexture([[Interface\AddOns\OmniCD\Media\omnicd-bg-search-on]])
	button:SetScript("OnClick", Button_OnClick)
	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Button_OnLeave)

	local widget = {
		alignoffset = 30,
		editbox     = editbox,
		label       = label,
		button      = button,
		frame       = frame,
		type        = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end
	editbox.obj, button.obj = widget, widget

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
