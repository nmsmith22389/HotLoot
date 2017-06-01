
-- BREAKING:
-- FIXME: ADD THE ANCHOR POSITION TO THE  SAVED VARS SO IT STOPS RESETTING
-- BREAKING:

local TipHooker = LibStub:GetLibrary("LibTipHooker-1.1")
local ScrollingTable = LibStub("ScrollingTable")


--
-- ─── VAR LIST ───────────────────────────────────────────────────────────────────
--
--==GENERAL==--
local icons, closeEL = {}, 0;
local strFilterCaught;

--==THEMES==--
-- Current
local nameCurrent,themeSize,heightCurrent,bgFileCurrent,edgeFileCurrent,tileCurrent,tileSizeCurrent,edgeSizeCurrent,insetsCurrent,disIconSizeCurrent

--==INCLUDE BUTTONS==--
local incButtons = {}





--
-- ─── PROCESS TOOLTIP ────────────────────────────────────────────────────────────
--

function HotLoot:ProcessTooltip(tooltip, name, link)
    --HotLoot:dBug("name", name)
    --HotLoot:dBug("link", link)
    local iName = select(1,GetItemInfo(name))
    if HotLoot:GetIncludeList()[iName] then
        GameTooltip:AddLine("|cFFCD6600HotLoot|r: "..L["Included"])
        
    elseif HotLoot:GetExcludeList()[iName] then
        GameTooltip:AddLine("|cFFCD6600HotLoot|r: "..L["Excluded"])
    end
    GameTooltip:Show()
end


--==========================
--  CREATE Loot Tracker
--==========================
--  UNUSED  <------------[

local function tableSize(tbl)
    local x = 0
    for k,v in pairs(tbl) do
        x = x + 1
    end
    return x
end



-- OnInitialize
function HotLoot:OnInitialize()
    -- Set Fonts
    HotLoot.media = {}
    HotLoot.media.fonts = {
        Macondo = LSM:Fetch('font', 'Macondo'),
        RobotoCondensedBold = LSM:Fetch('font', 'Roboto Condensed Bold')
    }
    
    self:RegisterChatCommand("hl", "ChatCommand")
    self:RegisterChatCommand("hotloot", "ChatCommand")
    --LootHistory:CreateLootHistory()
    -- Register Confirm Dialog for SkinMode
    
    --HotLoot:CreateFishingMacro()
end


-- OnEnable
function HotLoot:OnEnable()
    TipHooker:Hook(HotLoot.ProcessTooltip, "item")
    
    
    
    -- LoadThemeInit(HotLoot:GetTheme())
    
    
end

-- ChatCommand
function HotLoot:ChatCommand(input)
    if not input or input:trim() == "" then
        --InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        --InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        LibStub("AceConfigDialog-3.0"):Open("HotLoot")
    elseif input == "help" then
        print("|cFFCD6600HotLoot|r: Available Commands")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00enable:|r     Enables/disables |cFFCD6600HotLoot|r")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00debug:|r     Enables/disables debug mode")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00autoclose:|r Toggles the autoclose option")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00skinning:|r   Toggles skinning mode")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00monitor:|r    Toggles loot monitor")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00include <item>:|r    Adds the item to the Include List")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00exclude <item>:|r    Adds the item to the Exclude List")
        print("|cFFCD6600HotLoot|r: |cFFFFCC00history:|r    Opens the Loot History window")
    elseif string.match(input, "%a+") == "include" then
        local item = string.match(input, "%a+%s(.+)")
        HotLoot:SetIncludeList(nil, item)
         HotLoot:Announce(item..L["ChatCmdInclude"])
    elseif string.match(input, "%a+") == "exclude" then
        local item = string.match(input, "%a+%s(.+)")
        HotLoot:SetExcludeList(nil, item)
         HotLoot:Announce(item..L["ChatCmdExclude"])
    elseif string.match(input, "%a+") == "filter" then
        local id = string.match(input, "%a+%s(.+)")
        HotLoot:Announce("Running Filter...")
        HotLoot:CheckFilter(id)
    elseif string.match(input, "%a+") == "history" then
        HotLoot:ToggleLootHistory()
    else
        --print(input.." | trim: ".. input:trim())
        LibStub("AceConfigCmd-3.0"):HandleCommand("hl", "HotLoot", input)
    end
end



--==========================
--          Round
--==========================




--==========================
--          TT SCANNER
--==========================

local hlTipScan = CreateFrame('GameTooltip', 'hlTipScan', UIParent, 'GameTooltipTemplate')
local function ScanTip(slot, name)
    hlTipScan:SetOwner(UIParent, 'ANCHOR_NONE') 
    hlTipScan:SetLootItem(slot)
    local text = hlTipScanTextLeft2:GetText()
    text = hlTipScanTextLeft2:GetText()
    --HotLoot:dBug("scantip",text.." - "..name)
    if text and text == name then
        hlTipScan:Hide()
        return true
    else
        hlTipScan:Hide()
        return false
    end
end


--==========================
--      CreateRollFrame
--==========================
local rollFrames = {}
local function CreateRollFrame(id, length)
    local frame
end





--#############################
--          Tooltips
--#############################

local function EButtonClicked(name)
    HotLoot:AddToExcludeList(name)
    for i = 1, #icons do
        if icons[i].item == name then
            icons[i].e:Hide()
            break
        end
    end
     HotLoot:Announce(name..L["AnnounceExcludeAdd"])
    --self:Hide()
    --incButtons[slot]:Hide
    --LootSlot(slot)
end

--************TOOLTIP FOR BUTTON*****************

local function EBOnEnter(frame)
    GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
    GameTooltip:AddLine("HotLoot", 1, .6, 0, false)
    GameTooltip:AddLine(" ", 1, 1, 1, 1, false)
    GameTooltip:AddLine("Click to add item\nto the Exclude List", 1, 1, 0, true)
    GameTooltip:Show()
end

local function EBOnLeave()
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end


--#############################
--          Loot Buttons
--#############################


--==========================
--          EVENTS
--==========================



function HotLoot:LOOT_SLOT_CLEARED(...)
    local event, slot = ...

    if incButtons[slot] then
        incButtons[slot]:Hide()
    end
    

end





function HotLoot:PLAYER_REGEN_DISABLED()
    -- IN COMBAT
    --clear loot history (if enabled)
    if IsAddOnLoaded("HotLoot_LootHistory") and HotLoot:GetLootHistoryReset() == "combat" then
        HotLoot:ClearLootHistory()
    end
end

function HotLoot:PLAYER_REGEN_ENABLED()
    -- OUT OF COMBAT
    if IsAddOnLoaded("HotLoot_Fishing") and HotLoot.clearBindings then
        
        ClearOverrideBindings()
        HotLoot.clearBindings = false
    end
end

function HotLoot:START_LOOT_ROLL(...)
    local event, rollID, rollTime = ...
    if HotLoot:GetSystemEnable() and IsAddOnLoaded("HotLoot_Group") then
        HotLoot:StartRoll(rollID, rollTime)
    end
end
function HotLoot:CONFIRM_LOOT_ROLL(...)
    local event, rollID, rollType = ...
    if IsAddOnLoaded("HotLoot_Group") and HotLoot:GetGroupEnable() then
    local texture, name, count, quality = GetLootRollItemInfo(rollID)
    if quality == 2 and GetGroupRollUncommon() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    elseif quality == 3 and GetGroupRollRare() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    elseif quality == 4 and GetGroupRollEpic() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    end
    end
    --ConfirmLootRoll(rollID ,rollType)
end
function HotLoot:CONFIRM_DISENCHANT_ROLL(...)
    local event, rollID, rollType = ...
    if IsAddOnLoaded("HotLoot_Group") and HotLoot:GetGroupEnable() then
    local texture, name, count, quality = GetLootRollItemInfo(rollID)
    if quality == 2 and GetGroupRollUncommon() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    elseif quality == 3 and GetGroupRollRare() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    elseif quality == 4 and GetGroupRollEpic() ~= -1 then
        ConfirmLootRoll(rollID ,rollType)
    end
    end
end
function HotLoot:ADDON_LOADED(...)
    local event, arg1 = ...
    
end
