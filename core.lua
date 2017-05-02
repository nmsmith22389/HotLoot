-- ────────────────────────────────────────────────────────────────────────────────
--[[
                            )            (                     
                         ( /(          ) )\ )               )  
                         )\())      ( /((()/(            ( /(  
                        ((_)\   (   )\())/(_))  (    (   )\()) 
                         _((_)  )\ (_))/(_))    )\   )\ (_))/  
                        | || | ((_)| |_ | |    ((_) ((_)| |_   
                        | __ |/ _ \|  _|| |__ / _ \/ _ \|  _|  
                        |_||_|\___/ \__||____|\___/\___/ \__|  
                                       
By Neil Smith
https://github.com/nmsmith22389/HotLoot

MIT License
--]]
-- ────────────────────────────────────────────────────────────────────────────────
-- TODO: Remove uneeded libs
HotLoot = LibStub('AceAddon-3.0'):NewAddon('HotLoot', 'AceConsole-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('HotLoot')
HotLoot.minimapIcon = LibStub('LibDBIcon-1.0')
local Options, Util, HotLootFrame
local icons, closeEL = {}, 0;
HotLoot.toasts = {}

-- WARNING: Make sure that locals are defined BEFORE they are used!


--
-- ─── VARS ───────────────────────────────────────────────────────────────────────
--

-- NOTE: Put vars (hoisted) here (i suppose if everything is done right then this should be empty)

--
-- ─── MINIMAP ICON ───────────────────────────────────────────────────────────────
--

local LDB = LibStub('LibDataBroker-1.1'):NewDataObject('HotLoot', {
    type = 'launcher',
    icon = 'Interface\\AddOns\\HotLoot\\icon',
    OnClick = function(clickedframe, button)
            if button == 'LeftButton' then
                LibStub('AceConfigDialog-3.0'):Open('HotLoot')
            elseif button == 'RightButton' or button == 'RightButton' then
                if HotLoot.Anchor:IsVisible() then
                    Options:SetShowLootMonitorAnchor('toggleShowLootMonitorAnchor', false)
                else
                    Options:SetShowLootMonitorAnchor('toggleShowLootMonitorAnchor', true)
                end
            end
    end,
    OnTooltipShow = function(Tip)
        if not Tip or not Tip.AddLine then
            return
        end

        Tip:AddLine('HotLoot', 1, 0.4, 0)
        Tip:AddLine(string.format(L['MinimapTTOptions'], Util:ColorText('Left Click', 'warning')), 1, 1, 1)
        Tip:AddLine(string.format(L['MinimapTTAnchor'], Util:ColorText('Right Click', 'warning')), 1, 1, 1)
    end,
})

--
-- ─── THEME ──────────────────────────────────────────────────────────────────────
--

local themes = {
    ["customSmall"] = {
        ["name"] = "Custom",
        ["iconSizable"] = true,
        ["themeSize"] = "small",
        ["height"] = 20,
        ["bgFile"] = [[Interface\AddOns\HotLoot\media\textures\statusbars\colorbg]],
        ["edgeFile"] = [[Interface\AddOns\HotLoot\media\textures\borders\colorborder]],
        ["tile"] = true, ["tileSize"] = 16, ["edgeSize"] = 16,
        ["insets"] = { left = 2, right = 2, top = 2, bottom = 2 }
    },
    ["customLarge"] = {
        ["name"] = "Custom",
        ["iconSizable"] = true,
        ["themeSize"] = "large",
        ["height"] = 50,
        ["bgFile"] = [[Interface\AddOns\HotLoot\media\textures\statusbars\colorbg]],
        ["edgeFile"] = [[Interface\AddOns\HotLoot\media\textures\borders\colorborder]],
        ["tile"] = true, ["tileSize"] = 16, ["edgeSize"] = 16,
        ["insets"] = { left = 2, right = 2, top = 2, bottom = 2 }
    },
    ["paper"] = {
        ["name"] = "Paper",
        ["iconSizable"] = false,
        ["themeSize"] = "large",
        ["height"] = 50,
        ["bgFile"] = [[Interface\ACHIEVEMENTFRAME\UI-ACHIEVEMENT-ACHIEVEMENTBACKGROUND]],
        ["edgeFile"] = [[Interface\FriendsFrame\UI-Toast-Border]],
        ["tile"] = true, ["tileSize"] = 256, ["edgeSize"] = 8,
        ["insets"] = { left = 3, right = 3, top = 3, bottom = 3 }
    },
    ["tooltip"] = {
        ["name"] = "Tooltip",
        ["themeSize"] = "large",
        ["iconSizable"] = false,
        ["height"] = 50,
        ["bgFile"] = [[Interface\Tooltips\CHATBUBBLE-BACKGROUND]],
        ["edgeFile"] = [[Interface\Tooltips\UI-Tooltip-Border]],
        ["tile"] = true, ["tileSize"] = 32, ["edgeSize"] = 12,
        ["insets"] = { left = 3, right = 3, top = 3, bottom = 3 }
    },
}

function HotLoot:GetThemeSetting(setting)
    return themes[self.options.selectTheme][setting];
end

--
-- ─── INIT ───────────────────────────────────────────────────────────────────────
--

function HotLoot:OnInitialize()
end

function HotLoot:OnEnable()

    -- Get Modules
    Options = self:GetModule('Options')
    Util = self:GetModule('Util')
    HotLootFrame = self:GetModule('LootFrame')

    -- Minimap Icon
    self.minimapIcon:Register('HotLoot', LDB, self.options.minimapIcon)

    -- TODO: Find a better way to do this!
    StaticPopupDialogs["CONFIRM_SKINNING_MODE"] = {
        text = L["dialogConfirmSkinningMode"],
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            Options:Set('toggleSkinningMode', 'confirmed')
            LibStub("AceConfigDialog-3.0"):Open("HotLoot")
        end,
        OnCancel = function()
            Options:Set('toggleSkinningMode', false);
            LibStub("AceConfigDialog-3.0"):Open("HotLoot");
        end,
        timeout = 25,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }

    -- If an old (nonexistant) theme is set then switch it
    if self.options.selectTheme == nil or themes[self.options.selectTheme] == nil then
        Options:Set('selectTheme', 'paper')
    end

    -- Create Main Anchor Frame
    self:CreateAnchorFrame()

    -- For toast fading
    -- TODO: find a better way
    tStart = 0

    -- Hide anchor by default if set
    self:ToggleAnchor(self.options.toggleShowLootMonitorAnchor)

    -- Register Events
    self:RegisterEvent("LOOT_OPENED")
    self:RegisterEvent("LOOT_CLOSED")
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("MERCHANT_SHOW")
end

--
-- ─── ANCHOR FRAME ───────────────────────────────────────────────────────────────
--

function HotLoot:CreateAnchorFrame()
    local anchor = CreateFrame("Frame", 'HotLoot_Anchor', UIParent)

    anchor:ClearAllPoints()
    if self.options.anchorPosition.x and self.options.anchorPosition.y then
        anchor:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', self.options.anchorPosition.x, self.options.anchorPosition.y)
    else
        anchor:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
    end

    anchor:SetBackdrop({
        bgFile   = self:GetThemeSetting("bgFile"),
        edgeFile = self:GetThemeSetting("edgeFile"),
        tile     = self:GetThemeSetting("tile"),
        tileSize = self:GetThemeSetting("tileSize"),
        edgeSize = self:GetThemeSetting("edgeSize"),
        insets   = self:GetThemeSetting("insets")
    })

    anchor:SetBackdropColor(0, 0, 0, 0.7)
    anchor:SetBackdropBorderColor(1, 1, 1, 1.0)

    local frameWidth    = tonumber(self.options.inputMinWidth)
    local frameHeight = (self:GetThemeSetting('themeSize') == 'small') and (self.options.rangeIconSize + 4) or self:GetThemeSetting('height')

    anchor:SetSize(frameWidth, frameHeight)

    anchor:SetClampedToScreen(true)

    anchor.text = anchor:CreateFontString('Text', "OVERLAY")
    anchor.text:SetPoint("CENTER", anchor, "CENTER", 0, 0)
    anchor.text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    anchor.text:SetText("HotLoot Anchor")
    anchor.text:SetTextColor(1, 0.24, 0, 0)


    anchor:RegisterForDrag("LeftButton")
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetScript("OnDragStart", function()
        anchor:StartMoving()
    end)
    anchor:SetScript("OnDragStop", function()
        anchor:StopMovingOrSizing()
        HotLoot.options.anchorPosition.x = anchor:GetLeft()
        HotLoot.options.anchorPosition.y = anchor:GetBottom()
    end)
    anchor:Show()

    HotLoot.Anchor = anchor
end

function HotLoot:ToggleAnchor(val)
    if val then
        HotLoot:ShowAnchor()
    else
        HotLoot:HideAnchor()
    end
end

function HotLoot:ShowAnchor()
    HotLoot.Anchor:Show()
end

function HotLoot:HideAnchor()
    HotLoot.Anchor:Hide()
end

--
-- ─── TEST LOOT MONITOR ──────────────────────────────────────────────────────────
--

function HotLoot:TestLootMonitor()
    -- Get an Item in bags.
    local rndBag = math.random( 0, NUM_BAG_SLOTS - 1 )
    local rndSlot = math.random( 1, GetContainerNumSlots(rndBag) )
    local itemLink = GetContainerItemLink(rndBag, rndSlot)

    if not itemLink then
        local timeoutCounter = 0
        while not itemLink do
            rndBag = math.random( 0, NUM_BAG_SLOTS - 1 )
            rndSlot = math.random( 1, GetContainerNumSlots(rndBag) )
            itemLink = GetContainerItemLink(rndBag, rndSlot)

            timeoutCounter = timeoutCounter + 1
            if timeoutCounter >= 49 then
                -- TODO: Create an error to be printed when it times out
                return false
            end
        end
    end

    local itemTexture, _, isLocked, itemQuality = GetContainerItemInfo(rndBag, rndSlot)
    local isQuestItem, questId, isActive = GetContainerItemQuestInfo(rndBag, rndSlot)
    local itemName = GetItemInfo(itemLink)
    local loot = {
        texture     = itemTexture,
        item        = itemName,
        quantity    = 1,
        quality     = itemQuality,
        locked      = isLocked,
        isQuestItem = isQuestItem,
        questId     = questId,
        isActive    = isActive,
        link        = itemLink,
        slotType    = HL_LOOT_SLOT_TYPE.ITEM
    }

    -- Create Toast
    -- TODO: Consider making this a func since its also used in the LOOT_OPENED event
    -- NOTE: (UPDATE) I did notice this is slightly different than the loot one so a func for all might not work
    local frame
    local nextIndex = self:GetNextToastIndex()

    if not nextIndex then
        frame = self:CreateLootToast()
        self:ShiftToastPosUp()
        frame:SetLoot(loot)
        table.insert(self.toasts, frame)
    else
        frame = self.toasts[nextIndex]
        self:ShiftToastPosUp()
        frame:SetLoot(loot)
    end

    self:UpdateAnchors()

    frame.timer = self:ScheduleTimer(function()
        if frame.animation and HotLoot.options.toggleShowAnimation then
            frame.animation:Play()
        else
            frame:Hide()
        end
    end, self.options.rangeDisplayTime)

    frame:Show()
end

--
-- ─── SKINNING MODE ──────────────────────────────────────────────────────────────
--

-- TODO: Find out what happens if gold isnt set to pick up and you use skinning mode on it.
local tItemsToDelete = {};
local function ToSkin(slot)
    local _, lootName, lootQuantity, _, _ = GetLootSlotInfo(slot);
    -- local itemLink = GetLootSlotLink(slot);
    if (HotLoot.options.toggleSkinningMode or Util:IsSkinKeyDown()) and lootQuantity > 0 then
        tItemsToDelete[lootName] = true;
        LootSlot(slot);
        Util:Debug(Util:ColorText(lootName..' is set to be deleted!', 'alert'));
    end
end

local function DeleteLeftovers()
    if not Util:IsEmpty(tItemsToDelete) then
        -- TODO: Rename
        Util:Announce(L["SkinAnnounce1"]);
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
                            Util:Announce(itemLink .. L["SkinAnnounce2"]);
                        end
                    end
                end
            end
        end
        tItemsToDelete = {}
    end
end

--
-- ─── LOOT FILTER ────────────────────────────────────────────────────────────────
--

-- Helper Functions
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

-- TODO: Clean Up
local function CheckUntyped(type, itemLink)
    -- local itemName, _, _, itemLevel, _, itemType, itemSubType, _, _, _, _ = GetItemInfo(itemLink)
    local itemId = Util:GetItemID(itemLink)
    local items = {}
    if (type == 'leather') then
        items = {
            [124439] = true,
            [124438] = true,
        }
    end

    if items[itemId] then
        Util:Debug(--[[itemLink..' ('..itemId..') is an '..]]'untyped item in the '..type..' filter.')
        return true
    else
        return false
    end
end

local function CheckThreshold(itemType, sellAmount, itemQuantity)
    local value
    if HotLoot.options.toggleUseQuantValue and itemQuantity ~= nil then
        value = itemQuantity * sellAmount
    else
        value = sellAmount
    end

    if HotLoot.options.selectThresholdType1 == itemType then
        if Util:ToCopper(HotLoot.options.inputThresholdValue1) <= value then
            return true
        else
            return false
        end
    elseif HotLoot.options.selectThresholdType2 == itemType then
        if Util:ToCopper(HotLoot.options.inputThresholdValue2) <= value then
            return true
        else
            return false
        end
    elseif HotLoot.options.selectThresholdType3 == itemType then
        if Util:ToCopper(HotLoot.options.inputThresholdValue3) <= value then
            return true
        else
            return false
        end
    else
        return true
    end
end

local function CheckILvl(iLvl)
    if HotLoot.options.inputMinItemLevel then
        if tonumber(iLvl) >= tonumber(HotLoot.options.inputMinItemLevel) then
            return true
        else
            return false
        end
    else
        return true
    end
end

-- NOTE: Returns 2 vars...
--      1: result [boolean]
--      2: filter caught in / reason not caught [string]
local function FilterSlot(loot)
    if HotLoot.options.tableExcludeList[loot.item] and loot.link and not HotLoot.options.toggleDisableInRaid then
        -- TODO: Consider moving this inside the item section
        -- Don't Loot
        Util:Announce(L["AnnounceItemExcluded"]:format(loot.link))
        return false, 'Exclude List'
    end

    if loot.slotType == HL_LOOT_SLOT_TYPE.COIN then
        -- Check Gold (Coin)
        if HotLoot.options.toggleGoldFilter then
            return true, 'Gold Filter'
        end
    elseif loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
        -- Check Currency
        if HotLoot.options.toggleCurrencyFilter then
            return true, 'Currency Filter'
        end
    elseif loot.slotType == HL_LOOT_SLOT_TYPE.ITEM and not HotLoot.options.toggleDisableInRaid then
        local _, _, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, _, itemSellPrice = GetItemInfo(loot.link)

        if (HasRoom(1) or CanStack(loot.item, itemStackCount, loot.quantity)) then

            -- TODO: Normalize these so that the check order is (pref, type, subtype, other) (there may be special cases)

            -- Debug
            if HotLoot.options.toggleDebugMode then
                local strFilterDebug = "-------------\n"..
                    tostring(loot.link)..' x'..tostring(loot.quantity)..'\n'..
                    '    - '..tostring(itemType)..' > '..tostring(itemSubType)
                Util:Debug(strFilterDebug);
            end

            -- Include List
            if HotLoot.options.tableIncludeList[loot.item] then
                return true, 'Include List'
            end

            -- Quest
            if HotLoot.options.toggleQuestFilter and itemType == L["Quest"]and CheckThreshold("Quest", itemSellPrice, loot.quantity) then
                return true, 'Quest Item Filter'
            end

            -- Pickpocket
            if IsStealthed() and loot.quality ~= 0 and HotLoot.options.togglePickpocketFilter then
                return true, 'Pickpocket Filter'

            end

            -- Cloth
            if ((itemSubType == L["Cloth"] and itemType == L["Tradeskill"]) or itemType == "Item Enhancement!") and HotLoot.options.toggleClothFilter and CheckThreshold("Cloth", itemSellPrice, loot.quantity) then
                    return true, 'Cloth Filter'

            end

            -- Mining
            if itemSubType == L["Metal & Stone"] and HotLoot.options.toggleMiningFilter and CheckThreshold("Metal & Stone", itemSellPrice, loot.quantity) then
                return true, 'Mining Filter'

            end

            -- Gems
            if (itemType == L["Gem"] or (itemType == "Item Enhancement!" and itemSubType == "Jewelcrafting")) and HotLoot.options.toggleGemFilter and CheckThreshold("Gem", itemSellPrice, loot.quantity) then
                return true, 'Gem Filter'

            end

            -- Herbs
            if itemSubType == L["Herb"] and HotLoot.options.toggleHerbFilter and CheckThreshold("Herb", itemSellPrice, loot.quantity) then
                return true, 'Herb Filter'

            end

            -- Leather
            if HotLoot.options.toggleLeatherFilter and (((itemType == L["Tradeskill"] or itemType == "Item Enhancement!") and itemSubType == L["Leather"]) or CheckUntyped('leather', loot.link)) and CheckThreshold("Leather", itemSellPrice, loot.quantity) then
                return true, 'Leather Filter'

            end

            -- Fishing (-junk)
            if IsFishingLoot() and HotLoot.options.toggleFishingFilter and itemSubType ~= L["Junk"] then
                return true, 'Fishing Filter'
            end

            -- Enchanting
            if HotLoot.options.toggleEnchantingFilter and itemSubType == L["Enchanting"] and CheckThreshold("Enchanting", itemSellPrice, loot.quantity) then
                return true, 'Enchanting Filter'
            end

            -- Pigments
            -- TODO: Need to localize "Pigment"?
            if HotLoot.options.togglePigmentsFilter and string.find(loot.item, "Pigment") then
                return true, 'Pigment Filter'
            end

            -- Cooking
            if HotLoot.options.toggleCookingFilter and itemSubType == L["Cooking"] and CheckThreshold("Cooking Ingredient", itemSellPrice, loot.quantity) then
                return true, 'Cooking Filter'
            end

            -- Recipe
            if HotLoot.options.toggleRecipeFilter and itemType == L["Recipe"] then
                return true, 'Recipe Filter'
            end

            -- Pots
            if itemSubType == L["Potion"] and HotLoot.options.togglePotionFilter and CheckThreshold("Potion", itemSellPrice, loot.quantity) then
                if HotLoot.options.selectPotionType == "both" then
                    return true, 'Potion Filter'
                elseif HotLoot.options.selectPotionType == "healing" and string.find(loot.item, L["Healing"])  then
                    return true, 'Health Potion Filter'
                elseif HotLoot.options.selectPotionType == "mana" and string.find(loot.item, L["Mana"])  then
                    return true, 'Mana Potion Filter'
                else
                    return false, 'Unsupported Potion'
                end
            end

            -- Flasks
            if itemSubType == L["Flask"] and HotLoot.options.toggleFlaskFilter and CheckThreshold("Flask", itemSellPrice, loot.quantity) then
                return true, 'Flask Filter'
            end

            -- Elixirs
            if itemSubType == L["Elixir"] and HotLoot.options.toggleElixirFilter and CheckThreshold("Elixir", itemSellPrice, loot.quantity) then
                return true, 'Elixir Filter'
            end

            -- Motes
            if itemSubType == L["Elemental"] and HotLoot.options.toggleElementalFilter and CheckThreshold("Elemental", itemSellPrice, loot.quantity) then
                return true, 'Elemental Filter'
            end

            -- QUALITY

            -- Poor
            if HotLoot.options.togglePoorQualityFilter and loot.quality == 0 and CheckThreshold("z1Poor", itemSellPrice, loot.quantity) then
                return true, 'Poort Quality Filter'
            end

            -- Common
            if HotLoot.options.toggleCommonQualityFilter and loot.quality == 1 and CheckThreshold("z2Common", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Common Quality Filter'
            end

            -- Uncommon
            if HotLoot.options.toggleUncommonQualityFilter and loot.quality == 2 and CheckThreshold("z3Uncommon", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Uncommon Quality Filter'
            end

            -- Rare
            if HotLoot.options.toggleRareQualityFilter and loot.quality == 3 and CheckThreshold("z4Rare", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Rare Quality Filter'
            end

            -- Epic
            if HotLoot.options.toggleEpicQualityFilter and loot.quality == 4 and CheckThreshold("z5Epic", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Epic Quality Filter'
            end

            -- Legendary
            if HotLoot.options.toggleLegendaryQualityFilter and loot.quality == 5 and CheckThreshold("z6Legendary", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Legendary Quality Filter'
            end

            -- Artifact
            if HotLoot.options.toggleArtifactQualityFilter and loot.quality == 6 and CheckThreshold("z7Artifact", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Artifact Quality Filter'
            end

            -- Heirloom
            if HotLoot.options.toggleHeirloomQualityFilter and loot.quality == 7 and CheckThreshold("z8Heirloom", itemSellPrice, loot.quantity) and CheckILvl(itemLevel) then
                return true, 'Heirloom Quality Filter'
            end

            return false, 'Not Found'
        else
            HotLoot:Announce(L["BagsFull"])
            Util:Debug(ERR_INV_FULL);
            return false, 'Bags Full'
        end
    else
        return false, 'Not Found'
    end
end

--
-- ─── SELL POOR ITEMS ────────────────────────────────────────────────────────────
--

local function SellPoorItems()
    local bag, slot
    local totalPrice = 0
    local totalCount = 0
    for bag=0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemID(bag,slot)
            if item then
                local itemName, itemLink, itemQuality = GetItemInfo(item)
                local sellPrice = select(11,GetItemInfo(item))
                if itemQuality == 0 and sellPrice > 0 then
                    local itemCount = select(2,GetContainerItemInfo(bag,slot))
                    Util:Debug(string.format(L["GreyItemSold"], itemLink, itemCount, GetCoinTextureString(sellPrice * itemCount)))
                    UseContainerItem(bag,slot)
                    totalPrice = totalPrice + sellPrice * itemCount
                    totalCount = totalCount + itemCount
                end
            end
        end
    end
    if totalPrice > 0 then
        Util:Announce(string.format(L["AllGreysSold"], totalCount, GetCoinTextureString(totalPrice)))
    end
end

--
-- ─── LOOT TOAST ─────────────────────────────────────────────────────────────────
--

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

--
-- ─── NEW LOOT ICON FUNCTIONS ────────────────────────────────────────────────────
--

-- TODO: Add option to change text outline (ie outline, thickoutline, mono, none)
local function SetLoot(frame, loot)
    --> Set ToolTip
    if loot.link then
        -- NOTE: loot.link and loot.slotType need to be set before calling this func
        frame.item = loot.link
        frame.ShowTooltip = function(self)
            if self.item then
                GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
                GameTooltip:SetHyperlink(self.item)
                GameTooltip:Show()
            end
        end

        frame:SetScript('OnEnter', function(self)
            self:ShowTooltip()
        end)
        frame:SetScript('OnLeave', function(self)
            GameTooltip:Hide()
            ResetCursor()
        end)
    else
        frame.item = nil
        frame.ShowTooltip = nil
        frame:SetScript('OnEnter', nil)
        frame:SetScript('OnLeave', nil)
    end

    --> Set Theme
    frame:SetBackdrop({
        bgFile   = HotLoot:GetThemeSetting("bgFile"),
        edgeFile = HotLoot:GetThemeSetting("edgeFile"),
        tile     = HotLoot:GetThemeSetting("tile"),
        tileSize = HotLoot:GetThemeSetting("tileSize"),
        edgeSize = HotLoot:GetThemeSetting("edgeSize"),
        insets   = HotLoot:GetThemeSetting("insets")
    })

    --> Coin Type
    if loot.slotType == HL_LOOT_SLOT_TYPE.COIN then
        loot.name = GetCoinTextureString(Util:ToCopper(loot.name))
    end

    --> Set Theme Color
    if not Options:GetThemeColorDisabled() then
        -- TODO: Have the actual options return an object
        local bgRed   = HotLoot.options.fThemeColorR
        local bgGreen = HotLoot.options.fThemeColorG
        local bgBlue  = HotLoot.options.fThemeColorB
        local bgAlpha = HotLoot.options.fThemeColorA

        frame:SetBackdropColor(bgRed, bgGreen, bgBlue, bgAlpha)

        local borderRed   = HotLoot.options.fThemeBorderColorR
        local borderGreen = HotLoot.options.fThemeBorderColorG
        local borderBlue  = HotLoot.options.fThemeBorderColorB
        local borderAlpha = HotLoot.options.fThemeBorderColorA

        if HotLoot.options.toggleColorByQuality and loot.quantity > 0 and loot.quality then
            borderRed, borderGreen, borderBlue = GetItemQualityColor(loot.quality)
            borderAlpha = 1
        end

        frame:SetBackdropBorderColor(borderRed, borderGreen, borderBlue, borderAlpha)
    end

    --> Set Opacity
    frame:SetAlpha(HotLoot.options.rangeTransparency)

    --> Set Icon
    frame.icon:SetTexture(loot.texture)
    if HotLoot:GetThemeSetting("themeSize") == "small" then
        frame.icon:SetSize(HotLoot.options.rangeIconSize, HotLoot.options.rangeIconSize)
    end

    --> Font Color
    local colorFont = {
        red   = HotLoot.options.colorFontColor.r,
        green = HotLoot.options.colorFontColor.g,
        blue  = HotLoot.options.colorFontColor.b,
        alpha = HotLoot.options.colorFontColor.a
    }

    if HotLoot.options.toggleFontColorByQual and loot.quality then
        colorFont.red, colorFont.green, colorFont.blue = GetItemQualityColor(loot.quality)
        colorFont.alpha = 1.0
    end

    --> Set Name
    local nameText = loot.link or loot.name
    frame.name:SetFont(AceGUIWidgetLSMlists.font[HotLoot.options.selectTextFont], HotLoot.options.rangeFontSize, "OUTLINE")
    frame.name:SetText(nameText)

    --> Set Count
    if frame.count then
        frame.count:SetFont(AceGUIWidgetLSMlists.font[HotLoot.options.selectTextFont], HotLoot.options.rangeFontSize, "OUTLINE")
        frame.count:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if HotLoot.options.toggleShowItemQuant and loot.quantity > 0 then
            local countText = loot.quantity

            if HotLoot.options.toggleShowTotalQuant and loot.slotType ~= nil then
                if loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
                    local _, currencyCurrentAmount, _, _, _, currencyMax, _ = GetCurrencyInfo(index)
                    local currencyTotalText = (currencyCurrentAmount + loot.quantity < currencyMax) and (currencyCurrentAmount + loot.quantity) or currencyMax
                    countText = loot.quantity..' ['..tostring(currencyTotalText)..']'
                else
                    countText = loot.quantity..' ['..tostring(InBags(loot.name, loot.quantity))..']'
                end
            end

            frame.count:SetText("x"..countText)

            frame.count:Show()
        else
            frame.count:Hide()
        end
    end

    --> Set Value
    if frame.value then
        frame.value:SetFont(AceGUIWidgetLSMlists.font[HotLoot.options.selectTextFont], HotLoot.options.rangeFontSize, "OUTLINE")
        frame.value:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if HotLoot.options.toggleShowSellPrice and loot.quantity > 0 and loot.slotType == HL_LOOT_SLOT_TYPE.ITEM then
            local itemValue = select(11, GetItemInfo(loot.link)) or 0

            frame.value:SetText(GetCoinTextureString(itemValue))

            frame.value:Show()
        else
            frame.value:Hide()
        end
    end

    --> Set Type
    if frame.type then
        frame.type:SetFont(AceGUIWidgetLSMlists.font[HotLoot.options.selectTextFont], HotLoot.options.rangeFontSize, "OUTLINE")
        frame.type:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if HotLoot.options.toggleShowItemType then
            local typeText, subtypeText, typeTextDivider = '', '', ''

            if loot.slotType == HL_LOOT_SLOT_TYPE.ITEM then
                typeText        = select(6, GetItemInfo(loot.link)) or 'N/A'
                subtypeText     = select(7, GetItemInfo(loot.link)) or 'N/A'
                typeTextDivider = ': '
            elseif loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
                typeText = L['Currency']
            end

            frame.type:SetText(typeText..typeTextDivider..subtypeText)
            frame.type:Show()
        else
            frame.type:Hide()
        end
    end

    --> Set Size
    --> ==> Width
    local iconWidth   = frame.icon:GetWidth()
    local nameWidth   = frame.name:GetStringWidth()
    local typeWidth   = (frame.type and HotLoot.options.toggleShowItemType) and frame.type:GetStringWidth() or 0
    local countWidth  = (frame.count and HotLoot.options.toggleShowItemQuant) and frame.count:GetStringWidth() or 0
    local spacerWidth = 16
    local minWidth    = tonumber(HotLoot.options.inputMinWidth)

    local frameWidth = max(
        iconWidth + nameWidth  + spacerWidth,
        iconWidth + typeWidth  + spacerWidth,
        iconWidth + countWidth + spacerWidth,
        minWidth
    )

    --> ==> Height
    local frameHeight = (HotLoot:GetThemeSetting('themeSize') == 'small') and (HotLoot.options.rangeIconSize + 4) or HotLoot:GetThemeSetting('height')

    frame:SetSize(frameWidth, frameHeight)

    --> Fade Animation
    if HotLoot.options.toggleShowAnimation then
        local animationGroup = frame:CreateAnimationGroup()
        animationGroup:SetScript('OnFinished', function(self)
            frame:Hide()
        end)

        local animationTrans = animationGroup:CreateAnimation("Translation")
        local transOffset = (HotLoot.options.selectGrowthDirection == 1) and 100 or -100
        animationTrans:SetOffset(0, transOffset)
        animationTrans:SetDuration(1.0)
        animationTrans:SetSmoothing("IN")

        local animationFade = animationGroup:CreateAnimation("Alpha")
        animationFade:SetFromAlpha(HotLoot.options.rangeTransparency)
        animationFade:SetToAlpha(0)
        animationFade:SetDuration(1.0)
        animationFade:SetSmoothing("IN")

        frame.animation = animationGroup
    end

    -- NOTE: Removed Shine and Glow for now because it's not absolutely necessary but will add in later.

    --> Exclude Button
    -- TODO: Implement later and do it better (maybe no button and just shift+rightclick or something?)

    frame.pos = 1
end

function HotLoot:CreateLootToast()
    local templateSize = Util:UCFirst(self:GetThemeSetting("themeSize"))
    local templateIsFlipped = (self.options.selectTextSide == 0) and "" or "Flipped"

    local frame = CreateFrame("Frame", "HotLoot_Toast", nil, "HotLoot_Toast"..templateSize..templateIsFlipped.."Template")

    -- frame.index = index

    frame.SetLoot = SetLoot

    frame:Hide()

    -- self:SetToastAnchor(index)

    -- self.toasts[index] = frame

    return frame
end

-- function HotLoot:GetLootToast()
--     local nextIndex = self:GetNextToastIndex()
--     if not nextIndex then
--         self:CreateLootToast(index)
--     end

--     return self.toasts[index]
-- end

function HotLoot:UpdateAnchors()
    for i, frame in ipairs(self.toasts) do
        self:SetToastAnchor(frame)
    end
end

function HotLoot:SetToastAnchor(frame)
    -- TODO: Make padding an option
    local pos = frame.pos
    local padding = self.options.rangeToastPadding
    local offset = (self:GetThemeSetting("themeSize") == "large")
        and ((pos - 1) * (tonumber(self:GetThemeSetting("height") + padding) * self.options.selectGrowthDirection))
        or  ((pos - 1) * (tonumber(self.options.rangeIconSize + 3 + padding) * self.options.selectGrowthDirection))

    local vertAnchor = (self.options.selectGrowthDirection == 1) and 'BOTTOM' or 'TOP'
    local horzAnchor = (self.options.selectTextSide        == 0) and 'LEFT'   or 'RIGHT'
    local anchor     = vertAnchor..horzAnchor

    frame:ClearAllPoints()
    frame:SetPoint(anchor, HotLoot.Anchor, anchor, 0, offset)
end

-- Returns the next inactive index
function HotLoot:GetNextToastIndex()
    for i, frame in ipairs(self.toasts) do
        if not frame:IsVisible() then
            return i
        end
    end

    return false
end

function HotLoot:ShiftToastPosUp()
    for i, frame in ipairs(self.toasts) do
        frame.pos = frame.pos + 1
    end
end

--
-- ─── INCLUDE BUTTON ─────────────────────────────────────────────────────────────
--

-- FIXME: Redo all of this stuff and make it BETTER! (also make for hl loot frame)

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
    local attachFrame = Util:IsRealUILootOn() and _G['RealUI_Loot'] or _G['LootFrame'];
    local i = CreateFrame("button", "IncButton"..slot, attachFrame)
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
    --end

    if Util:IsRealUILootOn() then
        i:SetPoint("RIGHT", _G["ButsuSlot"..slot], "LEFT", -35, 0)
    --[[elseif IsAddOnLoaded("ElvUI") then
        i:SetPoint("RIGHT", _G["ElvLootSlot"..slot], "LEFT", -10, 0)
        i:SetPoint("RIGHT", _G["ElvLootSlot"..slot], "LEFT", -10, 0)]]
    else
        i:SetPoint("RIGHT", _G["LootButton"..slot], "LEFT", -10, 0)
    end

    i.texture = i:CreateTexture("iTexture"..slot )
    i.texture:SetColorTexture(0, 1, 0, 0.7)
    i.texture:SetAllPoints(i)

    -- Plus text on button
    i.text = i:CreateFontString(nil, "OVERLAY")
    i.text:SetPoint("CENTER", i, "CENTER", 1, 0)
    i.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    --name:SetJustifyH("LEFT")
    i.text:SetText("+")

    i:EnableMouse(true)
    i:RegisterForClicks("LeftButtonUp")
    i:SetScript("OnEnter", function(self) IBOnEnter(slot) end)
    i:SetScript("OnLeave", function(self) IBOnLeave() end)
    i:SetScript("OnClick", function(self) IButtonClicked(slot) end)

    return i
end

--
-- ─── EVENTS ─────────────────────────────────────────────────────────────────────
--

function HotLoot:LOOT_OPENED()
    if self.options.toggleSystemEnable then
        -- TODO: Revaluate why mouse focus is needed
        -- mFocus = GetMouseFocus()
        -- mFocus = (mFocus) and mFocus:GetName() or 'nil'

        skinModeTrigger = 0

        local lootInfo = GetLootInfo()
        -- For staggering the fades
        local staggerCount = 0

        for slot, lootItem in pairs(lootInfo) do
            lootInfo[slot].link = GetLootSlotLink(slot)
            lootInfo[slot].slotType = (Util:SlotIsGold(slot)     and HL_LOOT_SLOT_TYPE.COIN) or
                                      (Util:SlotIsCurrency(slot) and HL_LOOT_SLOT_TYPE.CURRENCY) or
                                      HL_LOOT_SLOT_TYPE.ITEM

            local filtered, reason = FilterSlot(lootInfo[slot])

            if filtered then
                if self.options.toggleDebugMode then
                    print("Item Looted in " .. Util:ColorText(reason, 'info') .. ".")
                end

                if self.options.toggleEnableLootMonitor then
                    local frame
                    local nextIndex = self:GetNextToastIndex()
                    staggerCount = staggerCount + 1
                    if not nextIndex then
                        frame = self:CreateLootToast()
                        self:ShiftToastPosUp()
                        frame:SetLoot(lootInfo[slot])
                        table.insert(self.toasts, frame)
                    else
                        frame = self.toasts[nextIndex]
                        self:ShiftToastPosUp()
                        frame:SetLoot(lootInfo[slot])
                    end

                    self:UpdateAnchors()

                    -- frame:SetScript('OnShow', function(self)
                        frame.timer = HotLoot:ScheduleTimer(function()
                            if frame.animation and HotLoot.options.toggleShowAnimation then
                                frame.animation:Play()
                            else
                                frame:Hide()
                            end
                        end, HotLoot.options.rangeDisplayTime + HotLoot.options.rangeMultipleDelay * 1)
                    -- end)

                    frame:Show()
                end

                LootSlot(slot)
            else
                Util:Debug('Item NOT looted. '..Util:ColorText('('..reason..')', 'alert'))
                ToSkin(slot)
            end
        end

        if self.options.toggleLootFrameEnable then
            if not self.options.toggleCloseLootWindow or Util:IsCloseKeyDown() then
                HotLootFrame:Update()
                HotLootFrame:Show()
            else
                CloseLoot()
            end
            -- TODO: Turn into elseif
        else
            -- TODO: Add back RealUI and ElvUI support
            if HotLoot.options.toggleCloseLootWindow and not Util:IsCloseKeyDown()--[[ and (string.find(mFocus, "WorldFrame") or Util:IsRealUILootOn())]] then
                -- TODO: Figure out if this is needed
                closeEL = 1;
                CloseLoot();
            end
        end
    end
end

function HotLoot:LOOT_CLOSED()
    -- TODO: Change to support only HL LootFrame
    -- if incButtons then
    --     for i = 1, #incButtons do
    --         incButtons[i]:Hide()
    --     end
    -- end
end

function HotLoot:MERCHANT_SHOW(...)
    if self.options.toggleSystemEnable and self.options.toggleSellPoorItems then
    Util:Debug("Merchant Window Opened")
        SellPoorItems()
    end
end

function HotLoot:BAG_UPDATE(...)
    DeleteLeftovers();
end
