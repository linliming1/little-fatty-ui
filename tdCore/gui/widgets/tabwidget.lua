
local GUI= tdCore('GUI')

local TabWidget = GUI:NewModule('TabWidget', CreateFrame('Frame'), 'UIObject', 'View')
local TabButton = GUI:NewModule('TabButton', CreateFrame('Button'), 'UIObject')

local function PageOnClick(self)
    PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
    self:GetParent():UpdateTabIndex(self.y)
end

function TabWidget:New(parent)
    local obj = self:Bind(CreateFrameAby('Frame', nil, parent))
    
    local tl = obj:CreateTexture(nil, 'OVERLAY')
    local bl = obj:CreateTexture(nil, 'OVERLAY')
    local br = obj:CreateTexture(nil, 'OVERLAY')
    local tr = obj:CreateTexture(nil, 'OVERLAY')
    local l = obj:CreateTexture(nil, 'OVERLAY')
    local r = obj:CreateTexture(nil, 'OVERLAY')
    local b = obj:CreateTexture(nil, 'OVERLAY')
    local t = obj:CreateTexture(nil, 'OVERLAY')
    
    tl:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    bl:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    br:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    tr:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    l:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    r:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
    b:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-Spacer]])
    t:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-Spacer]])
    
    tl:SetTexCoord(0.5,   0.625, 0, 1)
    bl:SetTexCoord(0.75,  0.875, 0, 1)
    br:SetTexCoord(0.875, 1,     0, 1)
    tr:SetTexCoord(0.625, 0.75,  0, 1)
    l:SetTexCoord(0,      0.125, 0, 1)
    r:SetTexCoord(0.125,  0.25,  0, 1)
    
    tl:SetSize(16, 16)
    bl:SetSize(16, 16)
    br:SetSize(16, 16)
    tr:SetSize(16, 16)
    
    b:SetHeight(16)
    t:SetHeight(16)
    
    tl:SetPoint('TOPLEFT', 0, -21)
    bl:SetPoint('BOTTOMLEFT')
    br:SetPoint('BOTTOMRIGHT')
    tr:SetPoint('TOPRIGHT', 0, -21)
    
    l:SetPoint('TOPLEFT', tl, 'BOTTOMLEFT')
    l:SetPoint('BOTTOMRIGHT', bl, 'TOPRIGHT')
    
    r:SetPoint('TOPLEFT', tr, 'BOTTOMLEFT')
    r:SetPoint('BOTTOMRIGHT', br, 'TOPRIGHT')
    
    b:SetPoint('BOTTOMLEFT', bl, 'BOTTOMRIGHT', 0, -2)
    b:SetPoint('BOTTOMRIGHT', br, 'BOTTOMLEFT')
    
    t:SetPoint('TOPRIGHT', tr, 'TOPLEFT', 0, 7)

    local next = CreateFrame('Button', nil, obj)
    next:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
    next:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]])
    next:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]])
    next:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
    next:SetSize(24, 24)
    next:SetPoint('TOPRIGHT', 0, -2)
    next:SetScript('OnClick', PageOnClick)
    next.y = 1
    
    local prev = CreateFrame('Button', nil, obj)
    prev:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
    prev:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]])
    prev:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]])
    prev:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
    prev:SetSize(24, 24)
    prev:SetPoint('RIGHT', next, 'LEFT')
    prev:SetScript('OnClick', PageOnClick)
    prev.y = -1
    
    obj.__prevButton = prev
    obj.__nextButton = next
    obj.__textureTop = t
    obj.__children = {}
    
    obj:SetBackdrop{
        bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
        insets = {left = 4, right = 4, top = 24, bottom = 4},
    }
    obj:SetBackdropColor(0, 0, 0, 0.4)
    obj:GetLabelFontString():SetPoint('BOTTOMLEFT', obj, 'TOPLEFT', 0, -20)
    obj:SetScript('OnShow', self.OnShow)
    
    return obj
end

function TabWidget:AddWidget(obj)
    if GUI:IsWidgetType(obj, 'Widget') or GUI:IsWidgetType(obj, 'TabWidget') or GUI:IsWidgetType(obj, 'ListWidget') then
        local button = TabButton:New(self)
        button.__widget = obj
        button.__idx = #self.__children + 1
        
        obj:SetLabelFontString(button)
        obj.__inTabWidget = true
        obj:SetParent(self)
        obj:ClearAllPoints()
        
        local spacing = obj:IsWidgetType('TabWidget') and 10 or 0
        
        obj:SetPoint('TOPLEFT', spacing, -24 - spacing / 2)
        obj:SetPoint('BOTTOMRIGHT', -spacing, spacing)
        obj:SetBackdrop(nil)
        
        tinsert(self.__children, button)
    else
        error('wrong obj type into tab obj' .. GUI:GetWidgetType(obj))
    end
end

function TabWidget:OnShow()
    self:UpdateTabs()
    self:UpdateTabIndex()
end

function TabWidget:UpdateTabIndex(y)
    local count = self:GetChildrenCount()
    if count == 0 then
        return
    end
    
    local start = (self.__startTab or 1) + (y or 0)
    start = (start < 1 and 1) or (start >= count and count) or start

    self.__startTab = start
    
    local rightTab
    for i, tab in self:IterateChildren() do
        if i < start then
            tab:Hide()
        elseif i == start then
            tab:ClearAllPoints()
            tab:SetPoint('TOPLEFT', self, 'TOPLEFT', 7, 0)
            tab:Show()
            rightTab = tab
        else
            tab:ClearAllPoints()
            tab:SetPoint('LEFT', self:GetChild(i - 1), 'RIGHT', -16, 0)
            
            if (tab:GetRight() or 0) > (self:GetRight() or 3000) - ((i == count and start == 1) and 0 or 50) then
                tab:Hide()
            else
                tab:Show()
                rightTab = tab
            end
        end
    end
    self.__textureTop:SetPoint('LEFT', rightTab, 'RIGHT', -9, 0)
    
    local firstShown, lastShown = self:GetFirstChild():IsShown(), self:GetLastChild():IsShown()
    if firstShown and lastShown then
        self.__prevButton:Hide()
        self.__nextButton:Hide()
    else
        self.__prevButton:Show()
        self.__nextButton:Show()
        if firstShown then
            self.__prevButton:Disable()
        else
            self.__prevButton:Enable()
        end
        if lastShown then
            self.__nextButton:Disable()
        else
            self.__nextButton:Enable()
        end
    end
end

function TabWidget:UpdateTabs(tab)
    self.__selectedTab = tab or self.__selectedTab
    
    if not self.__selectedTab or self.__selectedTab:IsDisabled() then
        for i, tab in self:IterateChildren() do
            if not tab:IsDisabled() then
                self.__selectedTab = tab
                break
            end
        end
    end
    
    for i, tab in self:IterateChildren() do
        if tab == self.__selectedTab then
            tab:SetStatus('SELECTED')
        elseif tab:IsDisabled() then
            tab:SetStatus('DISABLED')
        else
            tab:SetStatus('NORMAL')
        end
    end
end

local FINDTABS = setmetatable({
    table = function(self, obj)
        if not GUI:IsWidgetType(obj, 'TabButton') then
            return
        end
        for _, tab in self:IterateChildren() do
            if tab == obj then
                return tab
            end
        end
    end,
    number = function(self, index)
        if index < 1 or index > self:GetChildrenCount() then
            return
        end
        for i, tab in self:IterateChildren() do
            if index == i then
                return tab
            end
        end
    end,
    string = function(self, text)
        for _, tab in self:IterateChildren() do
            if text == tab:GetText() then
                return tab
            end
        end
    end,
    default = function()
        return
    end
}, {
    __index = function(o, k)
        return o.default
    end
})

function TabWidget:FindTab(arg1)
    return FINDTABS[type(arg1)](self, arg1)
end

function TabWidget:SelectTab(tab)
    tab = self:FindTab(tab)
    if tab then
        tab:SetStatus('SELECTED')
    end
end

function TabWidget:DisableTab(tab)
    tab = self:FindTab(tab)
    if tab then
        tab:SetStatus('DISABLED')
    end
end

function TabWidget:EnableTab(tab)
    tab = self:FindTab(tab)
    if tab then
        tab:SetStatus('NORMAL')
    end
end

function TabWidget:GetSelectedText()
    return self.__selectedTab:GetLabelText()
end

function TabWidget:GetSelectedIndex()
    return self.__selectedTab.__idx
end

---- TabButton

function TabButton:New(parent)
    local obj = self:Bind(CreateFrame('Button', nil, parent))

    obj.textureLeft = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureMiddle  = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureRight = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureDisabledLeft = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureDisabledMiddle = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureDisabledRight = obj:CreateTexture(nil, 'OVERLAY')
    obj.textureSpacer = obj:CreateTexture(nil, 'OVERLAY')
    
    obj.textureDisabledLeft:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]])
    obj.textureDisabledMiddle:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]])
    obj.textureDisabledRight:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]])
    obj.textureLeft:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]])
    obj.textureMiddle:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]])
    obj.textureRight:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]])
    obj.textureSpacer:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-Spacer]])
    
    obj.textureDisabledLeft:SetTexCoord(0, 0.15625, 0, 1)
    obj.textureDisabledMiddle:SetTexCoord(0.15625, 0.84375, 0, 1)
    obj.textureDisabledRight:SetTexCoord(0.84375, 1, 0, 1)
    obj.textureLeft:SetTexCoord(0, 0.15625, 0, 1)
    obj.textureMiddle:SetTexCoord(0.15625, 0.84375, 0, 1)
    obj.textureRight:SetTexCoord(0.84375, 1, 0, 1)
    
    obj.textureDisabledLeft:SetPoint('BOTTOMLEFT', 0, -3)
    obj.textureDisabledMiddle:SetPoint('LEFT', obj.textureDisabledLeft, 'RIGHT')
    obj.textureDisabledRight:SetPoint('LEFT', obj.textureDisabledMiddle, 'RIGHT')
    obj.textureLeft:SetPoint('TOPLEFT')
    obj.textureMiddle:SetPoint('LEFT', obj.textureLeft, 'RIGHT')
    obj.textureRight:SetPoint('LEFT', obj.textureMiddle, 'RIGHT')
    obj.textureSpacer:SetPoint('BOTTOMLEFT', 7, -6)
    obj.textureSpacer:SetPoint('BOTTOMRIGHT', -7, -6)
    
    obj.textureDisabledLeft:SetSize(20, 24)
    obj.textureDisabledRight:SetSize(20, 24)
    obj.textureDisabledMiddle:SetHeight(24)
    obj.textureLeft:SetSize(20, 24)
    obj.textureRight:SetSize(20, 24)
    obj.textureMiddle:SetHeight(24)
    obj.textureSpacer:SetHeight(16)
    obj:SetHeight(24)
    
    obj:GetLabelFontString():SetPoint('CENTER', 0, -3)
    obj:SetFontString(obj:GetLabelFontString())
    obj:SetNormalFontObject('GameFontNormalSmall')
    obj:SetHighlightFontObject('GameFontHighlightSmall')
    obj:SetDisabledFontObject('GameFontDisableSmall')
    
    obj:SetHighlightTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]])
    obj:GetHighlightTexture():SetPoint('TOPLEFT', 10, -1)
    obj:GetHighlightTexture():SetPoint('BOTTOMRIGHT', -10, -8)
    
    obj:EnableMouseWheel(true)
    
    obj:SetScript('OnShow', self.OnShow)
    obj:SetScript('OnClick', self.OnClick)
    obj:SetScript('OnMouseWheel', self.OnMouseWheel)
    
    return obj
end

function TabButton:SetStatus(status)
    if status == 'SELECTED' then
        self.__widget:Show()
        self:SetDisabledFontObject('GameFontHighlightSmall')
        self:Disable()
        self:GetLabelFontString():SetPoint('CENTER', 0, -3)
        
        self.textureLeft:Hide()
        self.textureMiddle:Hide()
        self.textureRight:Hide()
        
        self.textureDisabledLeft:Show()
        self.textureDisabledMiddle:Show()
        self.textureDisabledRight:Show()
        
        self.textureSpacer:Hide()
    elseif status == 'DISABLED' then
        self.__widget:Hide()
        self:SetDisabledFontObject('GameFontDisableSmall')
        self:Disable()
        self:GetLabelFontString():SetPoint('CENTER', 0, -2)
        
        self.textureLeft:Show()
        self.textureMiddle:Show()
        self.textureRight:Show()
        
        self.textureDisabledLeft:Hide()
        self.textureDisabledMiddle:Hide()
        self.textureDisabledRight:Hide()
        
        self.textureSpacer:Show()
    elseif status == 'NORMAL' then
        self.__widget:Hide()
        self:Enable()
        self:GetLabelFontString():SetPoint('CENTER', 0, -2)
        
        self.textureLeft:Show()
        self.textureMiddle:Show()
        self.textureRight:Show()
        
        self.textureDisabledLeft:Hide()
        self.textureDisabledMiddle:Hide()
        self.textureDisabledRight:Hide()
        
        self.textureSpacer:Show()
    else
        error('unknown tab button status.')
    end
    self.status = status
end

function TabButton:GetStatus()
    return self.status
end

function TabButton:IsSelected()
    return self.status == 'SELECTED'
end

function TabButton:IsDisabled()
    return self.status == 'DISABLED'
end

function TabButton:OnClick()
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
    self:GetParent():UpdateTabs(self)
end

function TabButton:OnShow()
    local textWidth = self:GetTextWidth()
    
    self.textureMiddle:SetWidth(textWidth)
    self.textureDisabledMiddle:SetWidth(textWidth)

    self:SetWidth(textWidth + 40)
end

function TabButton:OnMouseWheel(y)
    if y > 0 then
        self:GetParent().__prevButton:Click()
    else
        self:GetParent().__nextButton:Click()
    end
end

function TabButton:Update()
    self.__widget:Update()
end
