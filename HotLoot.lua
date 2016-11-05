-- =================== --
--        TODO         --
-------------------------
-- * Add Enable/Disable select option to decide which one the mod key does.
-- * Make Include & Exclude button look better (texture)
-- * Export and update localizations (for artifact and heirloom qualities and other stuff maybe)
-- * Optimize Code
-- =================== --


HotLoot = LibStub("AceAddon-3.0"):NewAddon("HotLoot", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HotLoot")
local TipHooker = LibStub:GetLibrary("LibTipHooker-1.1")
local ScrollingTable = LibStub("ScrollingTable")
--local ScrollingTable = LibStub:GetLibrary("ScrollingTable")
hIcon = LibStub("LibDBIcon-1.0")

--==========================
--         VAR LIST
--==========================
--==GENERAL==--
local icons, closeEL = {}, 0;
local strFilterCaught;

--==THEMES==--
--Current
local nameCurrent,themeSize,heightCurrent,bgFileCurrent,edgeFileCurrent,tileCurrent,tileSizeCurrent,edgeSizeCurrent,insetsCurrent,disIconSizeCurrent

--==INCLUDE BUTTONS==--
local incButtons = {}

--==FADE ITEMS==--
local isFirst = 0
--**************************


--==========================
--      Process Tooltip
--==========================
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
--      MINIMAP ICON
--==========================
local hLDB = LibStub("LibDataBroker-1.1"):NewDataObject("HotLoot", {
    type = "launcher",
    icon = "Interface\\AddOns\\HotLoot\\icon",
    OnClick = function(clickedframe, button)
            -- HotLoot:dBug(button)
            if button == "LeftButton" then
                LibStub("AceConfigDialog-3.0"):Open("HotLoot")
            -- elseif button == "RightButton" and IsAddOnLoaded("HotLoot_LootHistory") then
            --     HotLoot:ToggleLootHistory()
            elseif button == "MiddleButton" then
                HotLoot:MMToggleAnchor()
            end
    end,
    OnTooltipShow = function(Tip)
        if not Tip or not Tip.AddLine then 
            return
        end
        Tip:AddLine("HotLoot", 1, 0.4, 0)
        Tip:AddLine(L["MMIconTT"], 1, 1, 1)
        Tip:AddLine(L["MMIconTT2"], 1, 1, 1)
        Tip:AddLine(L["MMIconTT3"], 1, 1, 1)
    end,
})
--==========================
--  CREATE MONITOR ANCHOR
--==========================
function HotLoot:CreateMainFrame()
    HotLoot.mainFrame = CreateFrame("Frame", "mainFrame", UIParent, "ThinGoldEdgeTemplate")
    HotLoot.mainFrame:SetHeight(16)
    HotLoot.mainFrame:SetPoint("CENTER", 0, 0)
    HotLoot.fade = CreateFrame("Frame", nil, UIParent)
    HotLoot.fade:SetScript("OnUpdate", hlFadeItems)

    -- HotLoot.mainFrame.mainBG = HotLoot.mainFrame:CreateTexture("mainBG", "BACKGROUND")
    -- HotLoot.mainFrame.mainBG:SetAllPoints(HotLoot.mainFrame)
    -- HotLoot.mainFrame.mainBG:SetColorTexture(0, 0.7, 0, 0.7)
    
    HotLoot.mainFrame.anchorText = HotLoot.mainFrame:CreateFontString(nil, "OVERLAY")
    HotLoot.mainFrame.anchorText:SetPoint("CENTER", HotLoot.mainFrame, "CENTER", 0, 0)
    HotLoot.mainFrame.anchorText:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    --name:SetJustifyH("LEFT")
    HotLoot.mainFrame.anchorText:SetText("HotLoot Anchor")
    HotLoot.mainFrame:SetWidth(145)
    
    HotLoot.mainFrame:RegisterForDrag("LeftButton")
    HotLoot.mainFrame:SetMovable(true)
    HotLoot.mainFrame:EnableMouse(true)
    HotLoot.mainFrame:SetScript("OnDragStart", HotLoot.mainFrame.StartMoving)
    HotLoot.mainFrame:SetScript("OnDragStop", HotLoot.mainFrame.StopMovingOrSizing)
    HotLoot.mainFrame:Show()
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

string.ucfirst = function(str)
    return (str:gsub("^%l", string.upper))
end




--==========================
--      Total in Bags
--==========================
local function InBags(iName, lquant)
    local q, inBags, n, scount
    inBags = lquant
    for b = 0, 4 do 
        for s = 1, GetContainerNumSlots(b) do 
            if GetContainerItemID(b, s) then
            n = select(1, GetItemInfo(GetContainerItemID(b, s)))
            if n == iName then
                q = select(2, GetContainerItemInfo(b, s))
                inBags = inBags + q
            end
            end
        end
    end
    return inBags
end


--******************ANNOUNCE FUNCTION********************

function HotLoot:Announce(input)
    if HotLoot:GetAnnounceEvents() then
        print("|cFFCD6600HotLoot|r: " .. tostring(input))
    end
end

--==================================
--      Themes Table and FUNCS
--==================================
local tableThemeSettings = {
    ["customSmall"] ={
        ["name"] = "Custom",
        ["disIconSize"] = false,
        ["themeSize"] = "small",
        ["height"] = 20,
        ["bgFile"] = [[Interface\AddOns\HotLoot\media\textures\statusbars\colorbg]],
        ["edgeFile"] = [[Interface\AddOns\HotLoot\media\textures\borders\colorborder]],
        ["tile"] = true, ["tileSize"] = 16, ["edgeSize"] = 16,
        ["insets"] = { left = 2, right = 2, top = 2, bottom = 2 }
    },
    ["customLarge"] ={
        ["name"] = "Custom",
        ["disIconSize"] = false,
        ["themeSize"] = "large",
        ["height"] = 50,
        ["bgFile"] = [[Interface\AddOns\HotLoot\media\textures\statusbars\colorbg]],
        ["edgeFile"] = [[Interface\AddOns\HotLoot\media\textures\borders\colorborder]],
        ["tile"] = true, ["tileSize"] = 16, ["edgeSize"] = 16,
        ["insets"] = { left = 2, right = 2, top = 2, bottom = 2 }
    },
    ["paper"] ={
        ["name"] = "Paper",
        ["disIconSize"] = true,
        ["themeSize"] = "large",
        ["height"] = 50,
        ["bgFile"] = [[Interface\ACHIEVEMENTFRAME\UI-ACHIEVEMENT-ACHIEVEMENTBACKGROUND]],
        ["edgeFile"] = [[Interface\FriendsFrame\UI-Toast-Border]],
        ["tile"] = true, ["tileSize"] = 256, ["edgeSize"] = 8,
        ["insets"] = { left = 3, right = 3, top = 3, bottom = 3 }
    },
    ["toast"] ={
        ["name"] = "Toast",
        ["themeSize"] = "large",
        ["disIconSize"] = true,
        ["height"] = 50,
        ["bgFile"] = [[Interface\CHATFRAME\CHATFRAMEBACKGROUND]], 
        ["edgeFile"] = [[Interface\FriendsFrame\UI-Toast-Border]], 
        ["tile"] = true, ["tileSize"] = 12, ["edgeSize"] = 12, 
        ["insets"] = { left = 5, right = 5, top = 5, bottom = 5 }
    },
}

function HotLoot:GetThemeSetting( setting )
    return tableThemeSettings[HotLoot:GetTheme()][setting];
end

-- disIconSizeCurrent
function HotLoot:GetIconSizeDisabled()
    return disIconSizeCurrent
end

function HotLoot:GetThemeColorDisabled()
    if HotLoot:GetTheme():find("custom") ~= nil then
        return false
    else
        return true
    end
end

function HotLoot:ColorText(colorName, text)
    local prefix = "|c";
    local suffix = "|r";
    local color;

    if      colorName == "success"  then color = "ff5cb85c"
    elseif  colorName == "info"     then color = "ff5bc0de"
    elseif  colorName == "warning"  then color = "fff0ad4e"
    elseif  colorName == "alert"    then color = "ffd9534f"
    elseif  colorName == "hotkey"   then color = "ffffcc00"
    else                                 color = "ff000000"
    end

    return prefix..color..text..suffix;
end

--=========================
--       Get Color
--=========================
-- NOTE: Don't need???
function HotLoot:GetColor(color)
    if      color == "success"  then return "ff5cb85c"
    elseif  color == "info"     then return "ff5bc0de"
    elseif  color == "warning"  then return "fff0ad4e"
    elseif  color == "alert"    then return "ffd9534f"
    else                             return "ff000000"
    end
end

--=========================
--   Transfer Settings
--=========================
local function TransferOldSetting(oldKey, newKey)
    if HotLoot.db.profile[oldKey] ~= nil then
        HotLoot.db.profile[newKey] = HotLoot.db.profile[oldKey];
        HotLoot.db.profile[oldKey] = nil;
    end
end
function HotLoot:TransferAllSettings()
    HotLoot:Announce("Settings have changed and need to be transferred.\n This should only happen once.");
    HotLoot:Announce("Transfering old settings now...");

    TransferOldSetting("lootEnabled",         "toggleSystemEnable");
    TransferOldSetting("lootDebug",           "toggleDebugMode");
    TransferOldSetting("lootAnnounce",        "toggleAnnounceEvents");
    TransferOldSetting("lootAdvanced",        "toggleAdvancedOptions");
    TransferOldSetting("lootClose",           "toggleCloseLootWindow");
    TransferOldSetting("lootCloseKey",        "selectCloseLootWindowModifier");
    TransferOldSetting("lootSkinMode",        "toggleSkinningMode");
    TransferOldSetting("lootSkinKey",         "selectSkinningModeModifier");
    TransferOldSetting("lootEnableMonitor",   "toggleEnableLootMonitor");
    TransferOldSetting("lootShowAnchor",      "toggleShowLootMonitorAnchor");
    TransferOldSetting("lootShowQuantities",  "toggleShowItemQuant");
    TransferOldSetting("showSellPrice",       "toggleShowSellPrice");
    TransferOldSetting("showItemType",        "toggleShowItemType");
    TransferOldSetting("lootIconSize",        "rangeIconSize");
    TransferOldSetting("lootTrans",           "rangeTransparency");
    TransferOldSetting("lootShowTotal",       "toggleShowTotalQuant");
    TransferOldSetting("lootGrowthDirection", "selectGrowthDirection");
    TransferOldSetting("textSide",            "selectTextSide");
    TransferOldSetting("minWidth",            "inputMinWidth");
    TransferOldSetting("initialDelay",        "rangeInitialDelay");
    TransferOldSetting("secondaryDelay",      "rangeSecondaryDelay");
    TransferOldSetting("fadeSpeed",           "rangeFadeSpeed");
    TransferOldSetting("colorQual",           "toggleColorByQuality");
    TransferOldSetting("showAnimation",       "toggleShowAnimation");
    TransferOldSetting("themeSelect",         "selectTheme");
    TransferOldSetting("themeColorR",         "fThemeColorR");
    TransferOldSetting("themeColorG",         "fThemeColorG");
    TransferOldSetting("themeColorB",         "fThemeColorB");
    TransferOldSetting("themeColorA",         "fThemeColorA");
    TransferOldSetting("themeColorBorderR",   "fThemeBorderColorR");
    TransferOldSetting("themeColorBorderG",   "fThemeBorderColorG");
    TransferOldSetting("themeColorBorderB",   "fThemeBorderColorB");
    TransferOldSetting("themeColorBorderA",   "fThemeBorderColorA");
    TransferOldSetting("lootGold",            "toggleGoldFilter");
    TransferOldSetting("lootQuest",           "toggleQuestFilter");
    TransferOldSetting("lootCurrency",        "toggleCurrencyFilter");
    TransferOldSetting("lootJunk",            "toggleJunkFilter");
    TransferOldSetting("lootPick",            "togglePickpocketFilter");
    TransferOldSetting("lootCloth",           "toggleClothFilter");
    TransferOldSetting("lootMining",          "toggleMiningFilter");
    TransferOldSetting("lootGems",            "toggleGemFilter");
    TransferOldSetting("lootHerbs",           "toggleHerbFilter");
    TransferOldSetting("lootSkinning",        "toggleLeatherFilter");
    TransferOldSetting("lootFishing",         "toggleFishingFilter");
    TransferOldSetting("lootEnchanting",      "toggleEnchantingFilter");
    TransferOldSetting("lootPigments",        "togglePigmentsFilter");
    TransferOldSetting("lootCooking",         "toggleCookingFilter");
    TransferOldSetting("lootRecipes",         "toggleRecipeFilter");
    TransferOldSetting("lootPots",            "togglePotionFilter");
    TransferOldSetting("potionType",          "selectPotionType");
    TransferOldSetting("lootFlasks",          "toggleFlaskFilter");
    TransferOldSetting("lootElixirs",         "toggleElixirFilter");
    TransferOldSetting("lootElemental",       "toggleElementalFilter");
    TransferOldSetting("lootPoor",            "togglePoorQualityFilter");
    TransferOldSetting("sellGreys",           "toggleSellPoorItems");
    TransferOldSetting("lootCommon",          "toggleCommonQualityFilter");
    TransferOldSetting("lootUncommon",        "toggleUncommonQualityFilter");
    TransferOldSetting("lootRare",            "toggleRareQualityFilter");
    TransferOldSetting("lootEpic",            "toggleEpicQualityFilter");
    TransferOldSetting("lootLegendary",       "toggleLegendaryQualityFilter");
    TransferOldSetting("minILvl",             "inputMinItemLevel");
    TransferOldSetting("eList",               "tableExcludeList");
    TransferOldSetting("iList",               "tableIncludeList");
    TransferOldSetting("type1",               "selectThresholdType1");
    TransferOldSetting("type2",               "selectThresholdType2");
    TransferOldSetting("type3",               "selectThresholdType3");
    TransferOldSetting("useQuant",            "toggleUseQuantValue");

    HotLoot:Announce("Settings transfer complete!");
end

-- OnInitialize
function HotLoot:OnInitialize()
    
    self.db = LibStub("AceDB-3.0"):New("HotLootDB", hlDefaults)
    hIcon:Register("HotLoot", hLDB, self.db.profile.minimapIcon)
    --s
    LibStub("AceConfig-3.0"):RegisterOptionsTable("HotLoot", hlOptions)
    hlOptions.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    --self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HotLoot", "HotLoot")
    
    -- Transfer Settings
    if self.db.profile.bOldSettingsTransferred ~= true then
        HotLoot:TransferAllSettings();
        self.db.profile.bOldSettingsTransferred = true;
    end

    if not self.db.profile.watchList then
        self.db.profile.watchList = {}
    end
    self:RegisterChatCommand("hl", "ChatCommand")
    self:RegisterChatCommand("hotloot", "ChatCommand")
    HotLoot:CreateMainFrame()
    --LootHistory:CreateLootHistory()
    -- Register Confirm Dialog for SkinMode
    StaticPopupDialogs["CONFIRM_SKINNING_MODE"] = {
        text = L["dialogConfirmSkinningMode"],
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            HotLoot:SetSkinningMode(nil, "confirmed");
            LibStub("AceConfigDialog-3.0"):Open("HotLoot");
        end,
        OnCancel = function ()
            HotLoot:SetSkinningMode(nil, false);
            LibStub("AceConfigDialog-3.0"):Open("HotLoot");
        end,
        timeout = 25,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }
    --HotLoot:CreateFishingMacro()
end


-- OnEnable
function HotLoot:OnEnable()
    TipHooker:Hook(HotLoot.ProcessTooltip, "item")
    
    --[[if not HotLoot:GetTheme() then
        HotLoot:SetThemeSelect(self,"classic")
    end]]
    
    tStart = 0
    HotLoot:ToggleAnchor(HotLoot:GetShowLootMonitorAnchor())
    -- LoadThemeInit(HotLoot:GetTheme())
    HotLoot:RegisterEvent("LOOT_OPENED")
    HotLoot:RegisterEvent("LOOT_CLOSED")
    HotLoot:RegisterEvent("LOOT_SLOT_CLEARED")
    HotLoot:RegisterEvent("BAG_UPDATE")
    HotLoot:RegisterEvent("ADDON_LOADED")
    HotLoot:RegisterEvent("MERCHANT_SHOW")
    HotLoot:RegisterEvent("PLAYER_REGEN_ENABLED")
    HotLoot:RegisterEvent("PLAYER_REGEN_DISABLED")
    HotLoot:RegisterEvent("START_LOOT_ROLL")
    HotLoot:RegisterEvent("CONFIRM_LOOT_ROLL")
    HotLoot:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
    
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
--      Debug Mode
--==========================
function HotLoot:Debug(string)
    if (HotLoot:GetDebugMode() == true) then
        print("<|c"..HotLoot:GetColor("alert").."HotLoot Debug|r> " .. tostring(string));
        -- Old HL color was --> |cFFCD6600HotLoot|r
    end
end
function HotLoot:DebugOption(name, value)
    if (HotLoot:GetDebugMode() == true) then
        local toPrint
        if value then
            toPrint = tostring(name) .. " = " .. tostring(value)
        else
            toPrint = tostring(name)
        end
        print("<|c"..HotLoot:GetColor("alert").."HotLoot Debug|r> " .. toPrint)
    end
end
--==========================
--      Restart Timer
--==========================
local function ResetTimer()
    tStart = GetTime()
end
--==========================
--      Test Monitor
--==========================
function HotLoot:buttonTestLootMonitor()
    local itemName, itemLink, _, itemLevel, _, itemType, itemSubType, _, _, itemTexture, itemSellPrice = GetItemInfo(6948)
    local itoadd = HotLoot:addLootIcon(itemTexture, itemName, itemLink, 5)
    table.insert(icons, 1, itoadd)
    ResetTimer()
    itoadd = nil
    itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = nil          
    HotLoot:UpdateMonitor()
end
--==========================
--          GET ID
--==========================
local function GetItemID(itemLink)
    -- local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

    -- This should return only the item ID
    local itemID = select(5, string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"));
    return tonumber(Id);
end
--==========================
--      IS KEY DOWN
--==========================
local function CloseKeyDown()
    local keyDown
    local modKey = HotLoot:GetCloseLootWindowModifier()
    if     (modKey == "ctrl")  then keyDown = IsControlKeyDown()
    elseif (modKey == "shift") then keyDown = IsShiftKeyDown()
    elseif (modKey == "alt")   then keyDown = IsAltKeyDown()
    end
    return keyDown
end
local function SkinKeyDown()
    local keyDown
    local modKey = HotLoot:GetSkinningModeModifier()
    if     (modKey == "ctrl")  then keyDown = IsControlKeyDown()
    elseif (modKey == "shift") then keyDown = IsShiftKeyDown()
    elseif (modKey == "alt")   then keyDown = IsAltKeyDown()
    end
    return keyDown
end
--==========================
--      Add to I List
--==========================
function HotLoot:AddToIncludeList(value)
    if GetItemInfo(value) then
        local iName = select(1,GetItemInfo(value))
        HotLoot:SetIncludeList(iName)
    else
        HotLoot:SetIncludeList(value)
    end
end
function HotLoot:RemoveFromIncludeList()
    HotLoot:GetIncludeList()[HotLoot:GetIncludeListSelect()] = nil
end

--==========================
--      Add to E List
--==========================
function HotLoot:AddToExcludeList(value)
    if GetItemInfo(tostring(value)) then
        local iName = select(1,GetItemInfo(value))
        HotLoot:SetExcludeList(iName)
    else
        HotLoot:SetExcludeList(value)
    end
end
function HotLoot:RemoveFromExcludeList()
    HotLoot:GetExcludeList()[HotLoot:GetExcludeListSelect()] = nil
end


--==========================
--      To Skin Mode
--==========================
-- TODO: Find out what happens if gold isnt set to pick up and you use skinning mode on it.
local tItemsToDelete = {};
local function ToSkin(slot)
    local _, lootName, lootQuantity, _, _ = GetLootSlotInfo(slot);
    local itemLink = GetLootSlotLink(slot);
    if (HotLoot:GetSkinningMode() or SkinKeyDown()) and (lootQuantity > 0) then
        tItemsToDelete[lootName] = true;
        LootSlot(slot);
        HotLoot:Debug("|c" .. HotLoot:GetColor("alert") .. lootName .. " is set to be deleted!|r");
    end
end
--#############################
--      Skinning Mode
--#############################
local function DeleteLeftovers()
    if tableSize(tItemsToDelete) > 0 then
        -- TODO: Rename
        HotLoot:Announce(L["SkinAnnounce1"]);
        for bag = 0, NUM_BAG_SLOTS do 
            for slot = 1, GetContainerNumSlots(bag) do 
                local itemLink = GetContainerItemLink(bag, slot);
                local itemName
                if itemLink then
                    itemName = select(1, GetItemInfo(itemLink));
                    if itemName and tItemsToDelete[itemName] then
                        PickupContainerItem(bag, slot);
                        if CursorHasItem() then
                            DeleteCursorItem();
                            -- TODO: Rename
                            HotLoot:Announce(itemLink .. L["SkinAnnounce2"]);
                        end
                    end
                end
            end
        end
        tItemsToDelete = {}
    end
end
--==========================
--  Is it Gold or Currency?
--==========================
local function IsGold(slot)
    if GetLootSlotType(slot) == 2 and HotLoot:GetGoldFilter() then 
        return true
    end
end
local function IsCurrency(slot)
    if GetLootSlotType(slot) == 3 and HotLoot:GetCurrencyFilter() then 
        return true
    end
end

--==========================
--      CHECK FOR ROOM
--==========================
local function HasRoom(room)
    local numFSlots = 0
    for b = 0, 4 do 
        numFSlots = numFSlots + select(1, GetContainerNumFreeSlots(b))
    end
    if  numFSlots >= room then
        return true
    else
        return false
    end
end
--==========================
--      CHECK STACKABLE
--==========================
local function CanStack(iname, scount, lquant)
    --if scount then
    local q, stackRoom, n
    stackRoom = 0
    for b = 0, 4 do 
        for s = 1, GetContainerNumSlots(b) do 
            n = select(1, GetItemInfo(GetContainerItemID(b, s)))
            if n == iname then
                q = select(2, GetContainerItemInfo(b, s))
                stackRoom = (stackRoom) + (scount - q)
            end
        end
    end
    if lquant <= stackRoom then
        return true 
    else
        return false
    end
    --else
    --  return true
    --end
end
--==========================
--      Threshold Check
--==========================
local function CheckThreshold(iType, sellAmount, lootQuant)
    local value, quant
    quant = lootQuant
    if HotLoot:GetUseQuantValue() then
        value = quant * sellAmount
    else
        value = sellAmount
    end
    
    if HotLoot:GetThresholdType1() == iType then
        if tonumber(HotLoot:ToCopper(HotLoot:GetThresholdValue1())) <= value then
            return true
        else
            return false
        end
    elseif HotLoot:GetThresholdType2() == iType then
        if tonumber(HotLoot:ToCopper(HotLoot:GetThresholdValue2())) <= value then
            return true
        else
            return false
        end
    elseif HotLoot:GetThresholdType3() == iType then
        if tonumber(HotLoot:ToCopper(HotLoot:GetThresholdValue3())) <= value then
            return true
        else
            return false
        end
    else
        return true
    end
end
--==========================
--      iLvl Check
--==========================
local function CheckILvl(iLvl)
    if HotLoot:GetMinItemLevel() then
        if tonumber(iLvl) >= tonumber(HotLoot:GetMinItemLevel()) then
            return true
        else
            return false
        end
    else
        return true
    end
end

--==========================
--          Round
--==========================
local function round(num, idp)
    local mult = 10^(idp or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

--==========================
--          Round
--==========================
function HotLoot:SellPoorItems()
    local bag, slot
    local totalPrice=0
    for bag=0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemID(bag,slot)
            if item then
                local itemName, itemLink, itemQuality = GetItemInfo(item)
                local sellPrice = select(11,GetItemInfo(item))
                if itemQuality == 0 and sellPrice > 0 then
                    local itemCount = select(2,GetContainerItemInfo(bag,slot))
                    HotLoot:Announce(string.format(L["GreyItemSold"], itemLink, itemCount, GetCoinTextureString(sellPrice * itemCount)))
                    UseContainerItem(bag,slot)
                    totalPrice = totalPrice + sellPrice * itemCount
                end
            end
        end
    end
    if totalPrice > 0 then
        HotLoot:Announce(string.format(L["AllGreysSold"], GetCoinTextureString(totalPrice)))
    end
end
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

function HotLoot:CheckFilter(itemID)
    local wasLooted = false;
    local whereLooted = "???"
    local itemName, itemLink, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, _, itemSellPrice = GetItemInfo(itemID)
    if
        -- Quest
        HotLoot:GetQuestFilter() and (itemType == L["Quest"]) --[[or ScanTip(slot, L["Quest Item"]))]] and CheckThreshold("Quest", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Quest"
    -- Commented out to remove "junk" option
    --elseif
        -- Junk
    --  (itemSubType == L["Junk"]) and HotLoot:GetJunkFilter() and CheckThreshold("Junk", itemSellPrice, lootQuantity) then 
    --      wasLooted = true
    elseif
        -- HotLoot:GetPickpocketFilter(
        (IsStealthed()) and (lootQuality ~= 0) and HotLoot:GetPickpocketFilter() then 
            wasLooted = true
            whereLooted = "PickPocket"
    elseif
        -- Cloth
        -- TODO: Change ALL Trade Goods to Tradeskill
        (itemSubType == L["Cloth"]) and (itemType == L["Tradeskill"]) and HotLoot:GetClothFilter() and CheckThreshold("Cloth", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Cloth"
    elseif
        -- Mining
        (itemSubType == L["Metal & Stone"]) and HotLoot:GetMiningFilter() and CheckThreshold("Metal & Stone", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Mining"
    elseif
        -- Gems
        (itemType == L["Gem"]) and HotLoot:GetGemFilter() and CheckThreshold("Gem", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Gems"
    elseif
        -- Herbs
        (itemSubType == L["Herb"]) and HotLoot:GetHerbFilter() and CheckThreshold("Herb", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Herbs"
    elseif
        -- Leather
        (itemSubType == L["Leather"]) and (itemType == L["Tradeskill"]) and HotLoot:GetLeatherFilter() and CheckThreshold("Leather", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Leather"
    elseif
        -- Fishing (-junk)
        IsFishingLoot() and HotLoot:GetFishingFilter() and (itemSubType ~= L["Junk"]) then 
            wasLooted = true
            whereLooted = "Fishing"
    elseif
        -- enchanting
        HotLoot:GetEnchantingFilter() and (itemSubType == L["Enchanting"]) and CheckThreshold("Enchanting", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Enchanting"
    
    elseif
        -- GetCookingFilter
        HotLoot:GetCookingFilter() and (itemSubType == L["Cooking"]) and CheckThreshold("Cooking Ingredient", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Cooking"
    elseif
        -- GetRecipeFilter
        HotLoot:GetRecipeFilter() and (itemType == L["Recipe"]) then 
            wasLooted = true
            whereLooted = "Recipes"
    elseif
        --HotLoot:GetPigmentsFilter()
        HotLoot:GetPigmentsFilter() and (string.find(lootName, "Pigment")) then 
            wasLooted = true
            whereLooted = "Pigments"
    elseif
        -- Pots
        (itemSubType == L["Potion"]) and HotLoot:GetPotionFilter() and CheckThreshold("Potion", itemSellPrice, lootQuantity) then 
            if HotLoot:GetPotionType() == "both" then
                wasLooted = true
                whereLooted = "Potion"
            elseif HotLoot:GetPotionType() == "healing" and string.find(lootName, L["Healing"])  then
                wasLooted = true
                whereLooted = "Health Potion"
            elseif HotLoot:GetPotionType() == "mana" and string.find(lootName, L["Mana"])  then
                wasLooted = true
                whereLooted = "Mana Potion"
            else
                wasLooted = false
            end
    elseif
        -- Flasks
        (itemSubType == L["Flask"]) and HotLoot:GetFlaskFilter() and CheckThreshold("Flask", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Flask"
    elseif
        -- Elixirs
        (itemSubType == L["Elixir"]) and HotLoot:GetElixirFilter() and CheckThreshold("Elixir", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Elixer"
    elseif
        -- Motes
        (itemSubType == L["Elemental"]) and HotLoot:GetElementalFilter() and CheckThreshold("Elemental", itemSellPrice, lootQuantity) then 
            wasLooted = true
            whereLooted = "Elemental"
    elseif
        -- MoH
        (itemID == 89112) and (HotLoot:GetLootMoH() == true) then 
            wasLooted = true 
    elseif
        --lootBotA
        (itemID == 103642) and (HotLoot:GetLootBotA() == true) then 
            wasLooted = true 
    elseif
        --lootDoEM
        (itemID == 103643) and (HotLoot:GetLootDoEM() == true) then 
            wasLooted = true 
    elseif
        --lootSC
        (itemID == 103641) and (HotLoot:GetLootSC() == true) then 
            wasLooted = true
    elseif
        --lootRepMeat
        (itemID == 104265) and (HotLoot:GetLootRepMeat() == true) then 
            wasLooted = true
    elseif
        --lootRepMeat
        (itemID == 104266) and (HotLoot:GetLootRepMeat() == true) then 
            wasLooted = true
    elseif
        --lootRepMeat
        (itemID == 104264) and (HotLoot:GetLootRepMeat() == true) then 
            wasLooted = true
    elseif
        --lootRepMeat
        (itemID == 104257) and (HotLoot:GetLootRepMeat() == true) then 
            wasLooted = true
    elseif
        --lootRepMeat
        (itemID == 104267) and (HotLoot:GetLootRepMeat() == true) then 
            wasLooted = true
    elseif
        -- Include List
        HotLoot:GetIncludeList()[lootName] then 
            wasLooted = true
            whereLooted = "INCLUDE"
    elseif
        -- Poor
        (HotLoot:GetPoorQualityFilter() == true) and (lootQuality == 0) and (CheckThreshold("z1Poor", itemSellPrice, lootQuantity)) --[[and (CheckILvl(itemLevel))]] then 
            wasLooted = true
            whereLooted = "Poor"
    elseif
        -- Common
        (HotLoot:GetCommonQualityFilter() == true) and (lootQuality == 1) and (CheckThreshold("z2Common", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Common"
    elseif
        -- Uncommon
        --[[(IsInGroup() == false) and ]](HotLoot:GetUncommonQualityFilter() == true) and (lootQuality == 2) and (CheckThreshold("z3Uncommon", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Uncommon"
    elseif
        -- Rare
        --[[(IsInGroup() == false) and ]](HotLoot:GetRareQualityFilter() == true) and (lootQuality == 3) and (CheckThreshold("z4Rare", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Rare"
    elseif
        -- Epic
        --[[(IsInGroup() == false) and ]](HotLoot:GetEpicQualityFilter() == true) and (lootQuality == 4) and (CheckThreshold("z5Epic", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Epic"
    elseif
        -- Legendary
        --[[(IsInGroup() == false) and ]](HotLoot:GetLegendaryQualityFilter() == true) and (lootQuality == 5) and (CheckThreshold("z6Legendary", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Legendary"
    elseif
        -- Artifact
        --[[(IsInGroup() == false) and ]](HotLoot:GetArtifactQualityFilter() == true) and (lootQuality == 6) and (CheckThreshold("z7Artifact", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Artifact"
    elseif
        -- Heirloom
        --[[(IsInGroup() == false) and ]](HotLoot:GetHeirloomQualityFilter() == true) and (lootQuality == 7) and (CheckThreshold("z8Heirloom", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
            wasLooted = true
            whereLooted = "Heirloom"
    end
    if wasLooted == true then
        print(itemName.." looted in section "..whereLooted..".")
    else
        print(itemName.." NOT \'looted\'!")
    end
end


--==========================
--          Filter
--==========================
-- ToFilters() is called in HotLoot:LOOT_OPENED() and returns TRUE if certain loot criteria are met i.e.
--          
--          if isKindOfLoot(you, want) then
--              return true -- Loots item
--          end
--
local function ToFilters(slot)
    local lootIcon, lootName, lootQuantity, lootQuality, locked = GetLootSlotInfo(slot)
    local lootLink = GetLootSlotLink(slot)
    
    if HotLoot:GetExcludeList()[lootName] then
        -- Don't Loot
         HotLoot:Announce(lootLink .. L["ExcludeAnnounce1"])
        return false
    end
    if IsGold(slot) then
        strFilterCaught = "Gold";
        return true
    elseif IsCurrency(slot) then
        strFilterCaught = "Currency";
        return true
    end
    -- NOTE: Commented out because it appears to not be needed.
    -- if IsGold(slot) and not HotLoot:GetGoldFilter() then
    --     return false
    -- elseif IsCurrency(slot) and not HotLoot:GetCurrencyFilter() then
    --     return false
    -- end
    if lootLink then
    local _, itemLink, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, _, itemSellPrice = GetItemInfo(lootLink)
    -- local itemID = GetItemID(itemLink)
    if (HasRoom(1) or CanStack(lootName, itemStackCount, lootQuantity))--[[ and locked == 0 ]]then
            
            local strFilterDebug =  "---------------------\n"..
                                    itemLink .. " - Loot Slot: " .. slot .. "\n" ..
                                    "Type: [" .. itemType .. "]  Sub-Type: [" .. itemSubType .. "]\n";
            HotLoot:Debug(strFilterDebug);
            if
                -- Quest
                HotLoot:GetQuestFilter() and (itemType == L["Quest"] or ScanTip(slot, L["Quest Item"])) and CheckThreshold("Quest", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Quest Item";
                    return true
            -- Commented out to remove "junk" option
            --elseif
                -- Junk
            --  (itemSubType == L["Junk"]) and HotLoot:GetJunkFilter() and CheckThreshold("Junk", itemSellPrice, lootQuantity) then 
            --      return true
            elseif
                -- HotLoot:GetPickpocketFilter(
                (IsStealthed()) and (lootQuality ~= 0) and HotLoot:GetPickpocketFilter() then 
                    strFilterCaught = "PickPocket";
                    return true
            elseif
                -- Cloth
                -- TODO: Change ALL Trade Goods to Tradeskill
                (itemSubType == L["Cloth"]) and (itemType == L["Tradeskill"] or itemType == "Item Enhancement!") and HotLoot:GetClothFilter() and CheckThreshold("Cloth", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Cloth";
                    return true
            elseif
                -- Mining
                (itemSubType == L["Metal & Stone"]) and HotLoot:GetMiningFilter() and CheckThreshold("Metal & Stone", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Metal & Stone";
                    return true
            elseif
                -- Gems
                ((itemType == L["Gem"]) or (itemType == "Item Enhancement!" and itemSubType == "Jewelcrafting")) and HotLoot:GetGemFilter() and CheckThreshold("Gem", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Gem";
                    return true
            elseif
                -- Herbs
                (itemSubType == L["Herb"]) and HotLoot:GetHerbFilter() and CheckThreshold("Herb", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Herb";
                    return true
            elseif
                -- Leather
                (itemSubType == L["Leather"]) and (itemType == L["Tradeskill"] or itemType == "Item Enhancement!") and HotLoot:GetLeatherFilter() and CheckThreshold("Leather", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Leather";
                    return true
            elseif
                -- Fishing (-junk)
                IsFishingLoot() and HotLoot:GetFishingFilter() and (itemSubType ~= L["Junk"]) then 
                    strFilterCaught = "Fishing";
                    return true
            elseif
                -- enchanting
                HotLoot:GetEnchantingFilter() and (itemSubType == L["Enchanting"]) and CheckThreshold("Enchanting", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Enchanting";
                    return true
            
            elseif
                -- GetCookingFilter
                HotLoot:GetCookingFilter() and (itemSubType == L["Cooking"]) and CheckThreshold("Cooking Ingredient", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Cooking";
                    return true
            elseif
                -- GetRecipeFilter
                HotLoot:GetRecipeFilter() and (itemType == L["Recipe"]) then 
                    strFilterCaught = "Recipe";
                    return true
            elseif
                --HotLoot:GetPigmentsFilter(info)
                HotLoot:GetPigmentsFilter() and (string.find(lootName, "Pigment")) then 
                    strFilterCaught = "Pigment";
                    return true
            elseif
                -- Pots
                (itemSubType == L["Potion"]) and HotLoot:GetPotionFilter() and CheckThreshold("Potion", itemSellPrice, lootQuantity) then 
                    if HotLoot:GetPotionType() == "both" then
                        strFilterCaught = "Potion";
                        return true
                    elseif HotLoot:GetPotionType() == "healing" and string.find(lootName, L["Healing"])  then
                        strFilterCaught = "Health Potion";
                        return true
                    elseif HotLoot:GetPotionType() == "mana" and string.find(lootName, L["Mana"])  then
                        strFilterCaught = "Mana Potion";
                        return true
                    else
                        return false
                    end
            elseif
                -- Flasks
                (itemSubType == L["Flask"]) and HotLoot:GetFlaskFilter() and CheckThreshold("Flask", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Flask";
                    return true
            elseif
                -- Elixirs
                (itemSubType == L["Elixir"]) and HotLoot:GetElixirFilter() and CheckThreshold("Elixir", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Elixir";
                    return true
            elseif
                -- Motes
                (itemSubType == L["Elemental"]) and HotLoot:GetElementalFilter() and CheckThreshold("Elemental", itemSellPrice, lootQuantity) then 
                    strFilterCaught = "Elemental";
                    return true
            --[[elseif
                -- MoH
                (itemID == 89112) and (HotLoot:GetLootMoH() == true) then 
                    return true 
            elseif
                --lootBotA
                (itemID == 103642) and (HotLoot:GetLootBotA() == true) then 
                    return true 
            elseif
                --lootDoEM
                (itemID == 103643) and (HotLoot:GetLootDoEM() == true) then 
                    return true 
            elseif
                --lootSC
                (itemID == 103641) and (HotLoot:GetLootSC() == true) then 
                    return true
            elseif
                --lootRepMeat
                (itemID == 104265) and (HotLoot:GetLootRepMeat() == true) then 
                    return true
            elseif
                --lootRepMeat
                (itemID == 104266) and (HotLoot:GetLootRepMeat() == true) then 
                    return true
            elseif
                --lootRepMeat
                (itemID == 104264) and (HotLoot:GetLootRepMeat() == true) then 
                    return true
            elseif
                --lootRepMeat
                (itemID == 104257) and (HotLoot:GetLootRepMeat() == true) then 
                    return true
            elseif
                --lootRepMeat
                (itemID == 104267) and (HotLoot:GetLootRepMeat() == true) then 
                    return true]]
            elseif
                -- Include List
                HotLoot:GetIncludeList()[lootName] then 
                    strFilterCaught = "Include List";
                    return true
            elseif
                -- Poor
                (HotLoot:GetPoorQualityFilter() == true) and (lootQuality == 0) and (CheckThreshold("z1Poor", itemSellPrice, lootQuantity)) --[[and (CheckILvl(itemLevel))]] then 
                    strFilterCaught = "Poor Quality";
                    return true
            elseif
                -- Common
                (HotLoot:GetCommonQualityFilter() == true) and (lootQuality == 1) and (CheckThreshold("z2Common", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Common Quality";
                    return true
            elseif
                -- Uncommon
                --[[(IsInGroup() == false) and ]](HotLoot:GetUncommonQualityFilter() == true) and (lootQuality == 2) and (CheckThreshold("z3Uncommon", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Uncommon Quality";
                    return true
            elseif
                -- Rare
                --[[(IsInGroup() == false) and ]](HotLoot:GetRareQualityFilter() == true) and (lootQuality == 3) and (CheckThreshold("z4Rare", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Rare Quality";
                    return true
            elseif
                -- Epic
                --[[(IsInGroup() == false) and ]](HotLoot:GetEpicQualityFilter() == true) and (lootQuality == 4) and (CheckThreshold("z5Epic", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Epic Quality";
                    return true
            elseif
                -- Legendary
                --[[(IsInGroup() == false) and ]](HotLoot:GetLegendaryQualityFilter() == true) and (lootQuality == 5) and (CheckThreshold("z6Legendary", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Legendary Quality";
                    return true
            elseif
                -- Artifact
                --[[(IsInGroup() == false) and ]](HotLoot:GetArtifactQualityFilter() == true) and (lootQuality == 6) and (CheckThreshold("z7Artifact", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Artifact Quality";
                    return true
            elseif
                -- Heirloom
                --[[(IsInGroup() == false) and ]](HotLoot:GetHeirloomQualityFilter() == true) and (lootQuality == 7) and (CheckThreshold("z8Heirloom", itemSellPrice, lootQuantity)) and (CheckILvl(itemLevel)) then 
                    strFilterCaught = "Heirloom Quality";
                    return true
            end
            
            
    else
        HotLoot:Announce(L["BagsFull"])
        HotLoot:Debug(ERR_INV_FULL);
        return false
    end
    else
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
--          Anchor
--#############################
function HotLoot:ToggleAnchor(val)
    if val then
        HotLoot:ShowAnchor()
    else
        HotLoot:HideAnchor()
    end
end

function HotLoot:MMToggleAnchor()
    if HotLoot.mainFrame:IsVisible() then
        HotLoot:SetShowLootMonitorAnchor(self, false)
    else
        HotLoot:SetShowLootMonitorAnchor(self, true)
    end
end

function HotLoot:ShowAnchor()
    --HotLoot.mainFrame:SetAlpha(1)
    HotLoot.mainFrame:Show()
end

function HotLoot:HideAnchor()
    --HotLoot.mainFrame:SetAlpha(0)
    HotLoot.mainFrame:Hide()
end

--#############################
--      Monitor Refresh
--#############################
function HotLoot:UpdateMonitor()
    local i = 1
    local yOffset
    local xOffset
    local row, column = 0, 0
    if (HotLoot:GetLootGridMode() == true) and (HotLoot:GetShowItemNames() == false) then
        while i <= #icons do
            
            xOffset = column * HotLoot:GetIconSize() --0, 32, 64, 96
            yOffset = ((row + 1) * (HotLoot:GetIconSize() * HotLoot:GetGrowthDirection())) --0, 0, 0, 0, 
            icons[i]:SetPoint("CENTER", HotLoot.mainFrame, "CENTER", xOffset, yOffset+5)
            i = i + 1
            if column < (HotLoot:GetLootGridNumColumns() - 1) then
                column = column + 1
            else 
                row = row + 1
                column = 0
            end
        end
    else
        while i <= #icons do
            if HotLoot:GetThemeSetting("themeSize") == "large" then
                yOffset = (i * ((32 + 18) * HotLoot:GetGrowthDirection()))
            else
                yOffset = (i * ((HotLoot:GetIconSize() + 3) * HotLoot:GetGrowthDirection()))
            end
            if HotLoot:GetTextSide() == 0 then
                icons[i]:SetPoint("LEFT", HotLoot.mainFrame, "LEFT", 0, yOffset)
            else
                icons[i]:SetPoint("RIGHT", HotLoot.mainFrame, "RIGHT", 0, yOffset)
            end
            i = i + 1
        end
    end 
end


--#############################
--          Tooltips
--#############################



local function ClearTooltips()
    GameTooltip:Hide()
    --HotLoot:UpdateMonitor()
end

local function ShowTooltip(self)
    if self.item then
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:SetHyperlink(self.item)
        GameTooltip:Show()
    end
end

local function OnEnter(self)
    self:ShowTooltip()
end

local function OnLeave(self)
    ClearTooltips()
    ResetCursor()
end
local function EButtonClicked(name)
    HotLoot:AddEList(name)
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
--      Loot Monitor Icon
--#############################
function HotLoot:addLootIcon(iPath, iName, iLink, iCount)
    local icon = self.createLootIcon(iPath, iName, iLink, iCount)
    icon:Show()
    return icon
end
    
function HotLoot.createLootIcon(iPath, iName, iLink, iCount)
    local strThemeSize = HotLoot:GetThemeSetting("themeSize"):ucfirst();
    local strFlipped = (HotLoot:GetTextSide() == 0) and "" or "Flipped";
    local toast = CreateFrame("frame", "HotLoot_ToastFrame", nil, "HotLoot_Toast"..strThemeSize..strFlipped.."Template");
    -- local e = CreateFrame("button", "ExButtonFrame", toast)
    toast.item = iLink;
    toast.ShowTooltip = ShowTooltip;

    -- Set Backdrop
    toast:SetBackdrop({
        bgFile   = HotLoot:GetThemeSetting("bgFile"),
        edgeFile = HotLoot:GetThemeSetting("edgeFile"),
        tile     = HotLoot:GetThemeSetting("tile"),
        tileSize = HotLoot:GetThemeSetting("tileSize"),
        edgeSize = HotLoot:GetThemeSetting("edgeSize"),
        insets   = HotLoot:GetThemeSetting("insets")
    });
        
    -- Set Opacity
    toast:SetAlpha(HotLoot:GetTransparency());
    
    -- Set Icon
    toast.icon:SetTexture(iPath);
    if not HotLoot:GetIconSizeDisabled() then
        --then
    end
        
    -- Set Name
    toast.name:SetFont(AceGUIWidgetLSMlists.font[HotLoot:GetTextFont()], HotLoot:GetFontSize(), "OUTLINE") ;
    if iCount == 0 then
        toast.name:SetText(iName);
    else
        toast.name:SetText(iLink);
    end

    -- Set Count
    if toast.count and iCount > 0 then
        toast.count:SetFont(AceGUIWidgetLSMlists.font[HotLoot:GetTextFont()], HotLoot:GetFontSize(), "OUTLINE");
        if HotLoot:GetShowItemQuant() then
            if HotLoot:GetShowTotalQuant() then
                local inBags = InBags(iName, iCount);
                toast.count:SetText("x"..iCount.." ["..inBags.."]");
            else
                toast.count:SetText("x"..iCount);
            end
            toast.count:Show();
        else
            toast.count:Hide();
        end
    end

    -- Set Value
    if toast.value and iCount > 0 then
        toast.value:SetFont(AceGUIWidgetLSMlists.font[HotLoot:GetTextFont()], HotLoot:GetFontSize(), "OUTLINE");
        if HotLoot:GetShowSellPrice() then
            local strItemValue = select(11, GetItemInfo(iLink));
            if strItemValue then
                toast.value:SetText(GetCoinTextureString(strItemValue));
                toast.value:Show();
            end
        else
            toast.value:Hide();
        end
    end
    
    -- Set Type
    if toast.type and iCount > 0 then
        toast.type:SetFont(AceGUIWidgetLSMlists.font[HotLoot:GetTextFont()], HotLoot:GetFontSize(), "OUTLINE");
        if HotLoot:GetShowItemType() then
            local strItemType = select(6, GetItemInfo(iLink));
            local strItemSubType = select(7, GetItemInfo(iLink));
            if strItemType and strItemSubType then
                toast.type:SetText(strItemType .. ": " .. strItemSubType);
                toast.type:Show();
            end
        else
            toast.type:Hide();
        end
    end

    -- Width
    local intWidth = toast.name:GetStringWidth() + toast.count:GetStringWidth() + toast.icon:GetWidth() + 16;
    if toast.type and HotLoot:GetShowItemType() then
        local intTypeWidth = toast.type:GetStringWidth() + toast.count:GetStringWidth() + toast.icon:GetWidth() + 16;
        intWidth = max(intWidth, intTypeWidth, tonumber(HotLoot:GetMinWidth()));
    else
        intWidth = max(intWidth, tonumber(HotLoot:GetMinWidth()));
    end
    local intHeight = HotLoot:GetThemeSetting("height");
    toast:SetSize(intWidth, intHeight);

    -- Tooltip
    toast:SetScript("OnEnter", OnEnter);
    toast:SetScript("OnLeave", OnLeave);

    -- Fade Animation
    if HotLoot:GetShowAnimation() then
        local aniGroupFade = toast:CreateAnimationGroup();
        local aniFade = aniGroupFade:CreateAnimation("Translation");
        toast.ani = aniGroupFade;

        aniFade:SetDuration(1.5);
        aniFade:SetSmoothing("IN");
        -- NOTE: Small said 200 so idk try experimenting
        if HotLoot:GetGrowthDirection() == 1 then
            aniFade:SetOffset(0, 100*HotLoot:GetFadeSpeed());
        else
            aniFade:SetOffset(0, -100*HotLoot:GetFadeSpeed());
        end
    end
        
        --[[if HotLoot:GetShowAnimation() then
            local AnimationGroup = toast:CreateAnimationGroup()
            local animation1 = AnimationGroup:CreateAnimation("Translation")
            local GlowAnimationGroup = toast.glow:CreateAnimationGroup()
            local ShineAnimationGroup = toast.shine:CreateAnimationGroup()
            local glowAnimIn = GlowAnimationGroup:CreateAnimation("Alpha")
            local glowAnimOut = GlowAnimationGroup:CreateAnimation("Alpha")
            local shineAnimIn = ShineAnimationGroup:CreateAnimation("Alpha")
            local shineAnimT = ShineAnimationGroup:CreateAnimation("Translation")
            local shineAnimOut = ShineAnimationGroup:CreateAnimation("Alpha")
            glowAnimIn:SetDuration(0.2)
            glowAnimOut:SetDuration(0.5)
            
            -- Depreciated - Use From/To
            -- glowAnimIn:SetChange(0.7)
            -- glowAnimOut:SetChange(-1)
            glowAnimIn:SetFromAlpha(0)
            glowAnimIn:SetToAlpha(0.6)
            glowAnimOut:SetFromAlpha(0.6)
            glowAnimOut:SetToAlpha(0)
            
            glowAnimIn:SetOrder(1)
            glowAnimOut:SetOrder(2)
            
            shineAnimIn:SetOrder(1)
            shineAnimT:SetOrder(2)
            shineAnimOut:SetOrder(2)
            
            -- shineAnimIn:SetChange(1)
            -- shineAnimOut:SetChange(-1)
            shineAnimIn:SetFromAlpha(0)
            shineAnimIn:SetToAlpha(0.6)
            shineAnimOut:SetFromAlpha(0.6)
            shineAnimOut:SetToAlpha(0)

            shineAnimT:SetOffset(200,0)
            
            shineAnimOut:SetStartDelay(0)
            
            shineAnimT:SetDuration(0.5)
            shineAnimIn:SetDuration(0.2)
            shineAnimOut:SetDuration(0.3)
            
            animation1:SetDuration(1.5)
            animation1:SetSmoothing("IN")
            if HotLoot:GetGrowthDirection() == 1 then
                animation1:SetOffset(0, 100*HotLoot:GetFadeSpeed())
            else
                animation1:SetOffset(0, -100*HotLoot:GetFadeSpeed())
            end
            toast.a = AnimationGroup
            toast.glow.a = GlowAnimationGroup
            toast.shine.a = ShineAnimationGroup
            toast.shine.a:Play()
            toast.glow.a:Play()
        end
    ]]
    --[[if iCount > 0  and HotLoot:GetShowExcludeButton() then
        if HotLoot:GetTextSide() == 0 then
            e:SetPoint("RIGHT", toast, "LEFT", -1, 0)
        else
            e:SetPoint("LEFT", toast, "RIGHT", 1, 0)
        end
        e:SetWidth(5)
        
        e.texture = e:CreateTexture("eTexture", "BACKGROUND")
        e.texture:SetColorTexture(1, 0, 0, 0.7)
        e.texture:SetAllPoints(e)
        e:EnableMouse(true)
        e:RegisterForClicks("LeftButtonUp")
        e:SetScript("OnEnter", function(self) EBOnEnter(toast) end)
        e:SetScript("OnLeave", function(self) EBOnLeave() end)
        e:SetScript("OnClick", function(self) EButtonClicked(iLink) end)
        toast.e = e
    end]]
    return toast
end

--#############################
--          Loot Buttons
--#############################

local function IButtonClicked(slot)
    incButtons[slot]:Hide()
    local iLink = GetLootSlotLink(slot)
    HotLoot:AddToIncludeList(iLink)
    LootSlot(slot)
end

--************TOOLTIP FOR BUTTON*****************

local function IBOnEnter(slot)
    GameTooltip:SetOwner(_G["IncButton"..slot], "ANCHOR_CURSOR")
    GameTooltip:AddLine("HotLoot", 1, .6, 0, false)
    GameTooltip:AddLine(" ", 1, 1, 1, 1, false)
    GameTooltip:AddLine("Click to add item\nto the Include List", 1, 1, 0, true)
    GameTooltip:Show()
end

local function IBOnLeave()
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end

function HotLoot:CreateILootButton(slot)
    local i = CreateFrame("button", "IncButton"..slot, _G["LootFrame"])
    i:SetWidth(8)
    i:SetHeight(30)
    --[[
    if (IsAddOnLoaded("XLoot Frame")) then
        
        i:SetPoint("RIGHT", _G["XLootFrameButton"..slot], "LEFT", -10, 0)
        i:SetPoint("RIGHT", _G["XLootFrameButton"..slot], "LEFT", -10, 0)
    elseif (IsAddOnLoaded("ElvUI")) then
        i:SetPoint("RIGHT", _G["ElvLootSlot"..slot], "LEFT", -10, 0)
        i:SetPoint("RIGHT", _G["ElvLootSlot"..slot], "LEFT", -10, 0)
    else
    ]]
        i:SetPoint("RIGHT", _G["LootButton"..slot], "LEFT", -10, 0)
    --end
    
    i.texture = i:CreateTexture("iTexture"..slot )
    i.texture:SetColorTexture(0, 1, 0, 0.7)
    i.texture:SetAllPoints(i)
    i:EnableMouse(true)
    i:RegisterForClicks("LeftButtonUp")
    i:SetScript("OnEnter", function(self) IBOnEnter(slot) end)
    i:SetScript("OnLeave", function(self) IBOnLeave() end)
    i:SetScript("OnClick", function(self) IButtonClicked(slot) end)
    
    return i
end

--#############################
--          Fade Items
--#############################

function hlFadeItems()
    --====================
    --     ElvUI Fix
    --====================
    if closeEL == 1 and _G["ElvLootFrame"] then
        _G["ElvLootFrame"]:Hide()
        closeEL = 0
    end
    --====================
    -- Main Fade Section
    --====================
    local iframe, alpha, fDelay, iDelay, sDelay, fSpeed
    iDelay = HotLoot:GetInitialDelay()
    sDelay = HotLoot:GetSecondaryDelay()
    fSpeed = HotLoot:GetFadeSpeed() * 0.01
    if (isFirst == 0) then
        --isFirst = 0
        fDelay = iDelay -- 5
    else
        fDelay = sDelay -- 1
    end
    if (icons[#icons] == nil) then
        isFirst = 0
    end
    if (icons[#icons] ~= nil) and (tStart < (GetTime() - fDelay)) then
        iframe = icons[#icons]
        alpha = iframe:GetAlpha()
        if (alpha == 1) then
            
        end
        if (alpha > 0) then 
            if HotLoot:GetShowAnimation() and iframe.ani then
                iframe.ani:Play()
            end
            iframe:SetAlpha(alpha - fSpeed) -- fSpeed = 0.05
        elseif (alpha <= 0) then 
            iframe:Hide()
            table.remove(icons)
            --HotLoot:dBug("#icons", #icons)
            ResetTimer()
            isFirst = isFirst + 1
            --HotLoot:dBug("isFirst", isFirst)
            --HotLoot:dBug("fDelay", fDelay)
        end
    end
end
--==========================
--          EVENTS
--==========================

function HotLoot:LOOT_OPENED()
    if HotLoot:GetSystemEnable() then
    
    mFocus = GetMouseFocus():GetName()
    skinModeTrigger = 0
        for i=1, GetNumLootItems() do
            local _, lootName = GetLootSlotInfo(i)
            --table.insert(lootSlots, HotLoot:CreatLootSlot(i))
            if HotLoot:GetShowIncludeButton() and not HotLoot:GetIncludeList()[lootName] then
                incButtons[i] = HotLoot:CreateILootButton(i)
                --HotLoot:dBug(incButtons[i])
            end
            if ToFilters(i) then
                HotLoot:Debug("Item Looted in " .. strFilterCaught .. " filter.") -- TODO: Localize
                --local lootIcon, lootName, lootQuantity, lootQuality, locked = GetLootSlotInfo(i)
                --Toast:Spawn("Loot",lootName, lootIcon )
                    local lootIcon, lootName, lootQuantity, lootQuality, locked = GetLootSlotInfo(i)
                    local itemLink = GetLootSlotLink(i)
                --HotLoot:AddToCount(lootName, lootQuantity)
                if (HotLoot:GetEnableLootMonitor() == true) then
                    if IsGold(i) then
                        lootName = GetCoinTextureString(HotLoot:ToCopper(lootName))
                    end
                    local itoadd = HotLoot:addLootIcon(lootIcon, lootName, itemLink, lootQuantity)
                    table.insert(icons, 1, itoadd)
                    ResetTimer()
                    itoadd = nil
            
                    HotLoot:UpdateMonitor()
                end
                if IsAddOnLoaded("HotLoot_LootHistory") then
                    HotLoot:AddToLootHistory(i, lootName, lootQuantity)
                end
                if IsAddOnLoaded("HotLoot_LootNotification") then
                    HotLoot:CheckForLootNotification(lootName, itemLink)
                end
                
                LootSlot(i)
            else
                HotLoot:Debug("Item NOT Looted")
                ToSkin(i)
                
            end
        
        end
        if mFocus == nil then
            mFocus = "nil"
        end
        --HotLoot:dBug("mFocus", mFocus)
        if HotLoot:GetCloseLootWindow() and not CloseKeyDown() and string.find(mFocus, "WorldFrame") then     
            closeEL = 1
            CloseLoot()
        end
    end
end

function HotLoot:LOOT_CLOSED()

    if incButtons then
        for i = 1, #incButtons do
            incButtons[i]:Hide()
        end
    end
    --          lootSlots+
    
end

function HotLoot:LOOT_SLOT_CLEARED(...)
    local event, slot = ...

    if incButtons[slot] then
        incButtons[slot]:Hide()
    end
    

end

function HotLoot:BAG_UPDATE(...)
    DeleteLeftovers();
end

function HotLoot:MERCHANT_SHOW(...)
    if HotLoot:GetSystemEnable() and HotLoot:GetSellPoorItems() then
    HotLoot:Debug("Merchant Window Opened")
        HotLoot:SellPoorItems()
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
