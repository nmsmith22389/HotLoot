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
-- TODO: Change the tt for Include List Add input to reflect how it really works or just change it to work the right way
-- TODO: Remove LibDialog
HotLoot = LibStub('AceAddon-3.0'):NewAddon('HotLoot', 'AceConsole-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('HotLoot')
local LSM = LibStub('LibSharedMedia-3.0')
HotLoot.minimapIcon = LibStub('LibDBIcon-1.0')
local Options, Util, HotLootFrame
local icons, closeEL = {}, 0
HotLoot.toasts = {}

-- NOTE: These are the returns for GetItemInfo()
-- local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemID)

-- WARNING: Make sure that locals are defined BEFORE they are used!


--
-- ─── VARS ───────────────────────────────────────────────────────────────────────
--

-- NOTE: Put vars (hoisted) here (i suppose if everything is done right then this should be empty)

--
-- ─── DIALOGS ────────────────────────────────────────────────────────────────────
--
local function GetFirstRunDialogText()
    local text = ''
    if Util and Util.ColorText then
        text = Util:ColorText('Thanks for using HotLoot!', 'success')..'\n\n'
        text = text..Util:ColorText('Please ensure all other looting addons and Blizzard\'s auto loot are turned off.','warning')
    else
        text = 'Thanks for using HotLoot!'..'\n\n'
        text = text..'Please ensure all other looting addons and Blizzard\'s auto loot are turned off.'
    end
    return text
end

local function OpenOptionsWindow()
    local Ace = LibStub('AceConfigDialog-3.0')
    Ace:Open('HotLoot')
end

--
-- ─── MINIMAP ICON ───────────────────────────────────────────────────────────────
--

local LDB = LibStub('LibDataBroker-1.1'):NewDataObject('HotLoot', {
    type = 'launcher',
    icon = 'Interface\\AddOns\\HotLoot\\icon',
    OnClick = function(clickedframe, button)
            if button == 'LeftButton' then
                OpenOptionsWindow()
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
-- ─── INIT ───────────────────────────────────────────────────────────────────────
--

function HotLoot:OnInitialize()
end

function HotLoot:OnEnable()

    -- Get Modules
    Options = self:GetModule('Options')
    Util = self:GetModule('Util')
    HotLootFrame = self:GetModule('LootFrame', true)

    -- Slash Commands
    self:RegisterChatCommand("hl", "ChatCommand")
    self:RegisterChatCommand("hotloot", "ChatCommand")

    -- Minimap Icon
    self.minimapIcon:Register('HotLoot', LDB, Options:Get('minimapIcon'))

    -- Create Main Anchor Frame
    self:CreateAnchorFrame()

    -- Hide anchor by default if set
    self:ToggleAnchor(Options:Get('toggleShowLootMonitorAnchor'))

    -- Register Events
    self:RegisterEvent("LOOT_OPENED")
    -- self:RegisterEvent("LOOT_CLOSED")
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("MERCHANT_SHOW")

    if not Options:Get('firstRun') then
        -- Print an option here
        self:ScheduleTimer(function()
            Util:Print(Util:ColorText('Thanks for using HotLoot!', 'success')..'\n'..Util:ColorText('Please ensure all other looting addons and Blizzard\'s auto loot are turned off.','warning'))
            Options:Set('firstRun', true)
        end, 2)
    end
end

--
-- ─── ANCHOR FRAME ───────────────────────────────────────────────────────────────
--

function HotLoot:RefreshAnchorPosition()
    local anchor = self.Anchor

    anchor:ClearAllPoints()
    if Options:Get('anchorPosition')['x'] and Options:Get('anchorPosition')['y'] then
        anchor:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', Options:Get('anchorPosition')['x'], Options:Get('anchorPosition')['y'])
    else
        anchor:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
    end
end

function HotLoot:CreateAnchorFrame()
    local anchor = CreateFrame("Frame", 'HotLoot_Anchor', UIParent)

    anchor:SetBackdrop({
        bgFile   = LSM:Fetch('background', 'HotLoot Custom'),
        edgeFile = LSM:Fetch('border', 'HotLoot Custom'),
        tile     = Options:Get('toggleThemeBackgroundTile'),
        tileSize = Options:Get('rangeThemeBackgroundTileSize'),
        edgeSize = Options:Get('rangeThemeBorderEdgeSize'),
        insets   = {
            left = Options:Get('rangeThemeBorderInset'),
            right = Options:Get('rangeThemeBorderInset'),
            top = Options:Get('rangeThemeBorderInset'),
            bottom = Options:Get('rangeThemeBorderInset')
        }
    })

    anchor:SetBackdropColor(0, 0, 0, 0.7)
    anchor:SetBackdropBorderColor(1, 1, 1, 1.0)

    local frameWidth  = 200
    local frameHeight = 50

    anchor:SetSize(frameWidth, frameHeight)

    anchor:SetClampedToScreen(true)

    anchor.text = anchor:CreateFontString('Text', "OVERLAY")
    anchor.text:SetPoint("CENTER", anchor, "CENTER", 0, 0)
    anchor.text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    anchor.text:SetText("HotLoot Anchor")
    anchor.text:SetTextColor(1, 0.24, 0, 1)


    anchor:RegisterForDrag("LeftButton")
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetScript("OnDragStart", function()
        anchor:StartMoving()
    end)
    anchor:SetScript("OnDragStop", function()
        anchor:StopMovingOrSizing()
        Options:Get('anchorPosition')['x'] = anchor:GetLeft()
        Options:Get('anchorPosition')['y'] = anchor:GetBottom()
    end)
    anchor:Show()

    self.Anchor = anchor

    self:RefreshAnchorPosition()
end

function HotLoot:ToggleAnchor(val)
    if val then
        self:ShowAnchor()
    else
        self:HideAnchor()
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

        if frame.size ~= Options:Get('selectThemeSize') or frame.textSide ~= Options:Get('selectTextSide') then
            self.toasts[nextIndex] = self:CreateLootToast()
            self.toasts[nextIndex]['pos'] = frame.pos
            frame = self.toasts[nextIndex]                
        end

        self:ShiftToastPosUp()
        frame:SetLoot(loot)
    end

    self:UpdateAnchors()

    frame.timer = self:ScheduleTimer(function()
        if frame.animation and Options:Get('toggleShowAnimation') then
            frame.animation:Play()
        else
            frame:Hide()
        end
    end, Options:Get('rangeDisplayTime'))

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
    if (Options:Get('toggleSkinningMode') or Util:IsSkinKeyDown()) and lootQuantity > 0 then
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
    local itemId = Util:GetItemID(itemLink)
    local items = {}
    if type == 'Leather' then
        items = {
            [124439] = true,
            [124438] = true,
        }
    elseif type == 'Defiled Augment Rune' then
        items = {
            [140587] = true,
        }
    elseif type == 'Artifact Research Notes' then
        items = {
            [139390] = true,
        }
    elseif type == 'Sentinax Beacons' then
        items = {
            [146909] = true, [146908] = true, [146907] = true,
            [146906] = true, [146905] = true, [146903] = true,
            [146915] = true, [146914] = true, [146913] = true,
            [146912] = true, [146911] = true, [146910] = true,
            [146921] = true, [146920] = true, [146919] = true,
            [146918] = true, [146917] = true, [146916] = true,
            [147355] = true, [146923] = true, [146922] = true,
            [147893] = true, [147889] = true, [147892] = true,
            [147891] = true, [147894] = true,
        }
    end

    if items[itemId] then
        Util:Debug('Untyped item in filter. [class: '..type..']')
        return true
    else
        return false
    end
end

local function CheckThreshold(itemType, sellAmount, itemQuantity)
    local value
    if Options:Get('toggleUseQuantValue') and itemQuantity ~= nil then
        value = itemQuantity * sellAmount
    else
        value = sellAmount
    end

    if Options:Get('selectThresholdType1') == itemType then
        if Options:Get('inputThresholdValue1') <= value then
            return true
        else
            return false
        end
    elseif Options:Get('selectThresholdType2') == itemType then
        if Options:Get('inputThresholdValue2') <= value then
            return true
        else
            return false
        end
    elseif Options:Get('selectThresholdType3') == itemType then
        if Options:Get('inputThresholdValue3') <= value then
            return true
        else
            return false
        end
    else
        return true
    end
end

local function CheckILvl(iLvl)
    if Options:Get('inputMinItemLevel') then
        if tonumber(iLvl) >= tonumber(Options:Get('inputMinItemLevel')) then
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
    if Options:Get('tableExcludeList')[loot.item] and loot.link and (not Options:Get('toggleDisableInRaid') or GetLootMethod() ~= 'master') then
        -- TODO: Consider moving this inside the item section
        -- Don't Loot
        Util:Announce(L["AnnounceItemExcluded"]:format(loot.link))
        return false, 'Exclude List'
    end

    if loot.slotType == HL_LOOT_SLOT_TYPE.COIN then
        -- Check Gold (Coin)
        if Options:Get('toggleGoldFilter') then
            return true, 'Gold Filter'
        end
    elseif loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
        -- Check Currency
        if Options:Get('toggleCurrencyFilter') then
            return true, 'Currency Filter'
        end
    elseif loot.slotType == HL_LOOT_SLOT_TYPE.ITEM and (not Options:Get('toggleDisableInRaid') or GetLootMethod() ~= 'master') then
        local _, _, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, _, itemSellPrice, itemClass, itemSubClass = GetItemInfo(loot.link)

        if (HasRoom(1) or CanStack(loot.item, itemStackCount, loot.quantity)) then

            -- TODO: Normalize these so that the check order is (pref, type, subtype, other) (there may be special cases)
            -- TODO: Make options for quality to loot only equipable items

            --> Debug
            if Options:Get('toggleDebugMode') then
                local strFilterDebug = "-------------\n"..
                    tostring(loot.link)..' x'..tostring(loot.quantity)..'\n'..
                    '    - '..tostring(itemType)..' > '..tostring(itemSubType)
                Util:Debug(strFilterDebug);
            end

            --> Include List
            if Options:Get('tableIncludeList')[loot.item] then
                return true, 'Include List'
            end

            --> Quest
            if
                Options:Get('toggleQuestFilter') and
                itemClass == HL_ITEM_CLASS.QUEST and
                CheckThreshold("Quest", itemSellPrice, loot.quantity)
            then
                return true, 'Quest Item Filter'
            end

            --> Pickpocket
            if IsStealthed() and Options:Get('togglePickpocketFilter') and loot.quality ~= 0 then
                return true, 'Pickpocket Filter'
            end

            --> Cloth
            if
                Options:Get('toggleClothFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.CLOTH) and
                CheckThreshold("Cloth", itemSellPrice, loot.quantity)
            then
                return true, 'Cloth Filter'
            end

            --> Mining
            if
                Options:Get('toggleMiningFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.METAL_STONE) and
                CheckThreshold("Metal & Stone", itemSellPrice, loot.quantity)
            then
                return true, 'Mining Filter'
            end

            --> Jewelcrafting
            if
                Options:Get('toggleGemFilter') and
                --[[(itemClass == HL_ITEM_CLASS.GEM or ]](itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.JEWELCRAFTING) and
                CheckThreshold("Gem", itemSellPrice, loot.quantity)
            then
                return true, 'Gem Filter'
            end

            --> Herbs
            if
                Options:Get('toggleHerbFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.HERB) and
                CheckThreshold("Herb", itemSellPrice, loot.quantity)
            then
                return true, 'Herb Filter'
            end

            --> Leather
            if
                Options:Get('toggleLeatherFilter') and
                ((itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.LEATHER) or
                CheckUntyped('Leather', loot.link)) and
                CheckThreshold("Leather", itemSellPrice, loot.quantity)
            then
                return true, 'Leather Filter'
            end

            --> Fishing (-junk)
            if
                IsFishingLoot() and
                Options:Get('toggleFishingFilter') and
                not (itemClass == HL_ITEM_CLASS.MISCELLANEOUS and itemSubClass == HL_ITEM_SUB_CLASS.MISCELLANEOUS.JUNK)
            then
                return true, 'Fishing Filter'
            end

            --> Enchanting
            if
                Options:Get('toggleEnchantingFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.ENCHANTING) and
                CheckThreshold("Enchanting", itemSellPrice, loot.quantity)
            then
                return true, 'Enchanting Filter'
            end

            --> Inscription
            if
                Options:Get('togglePigmentsFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.INSCRIPTION) and
                CheckThreshold("Inscription", itemSellPrice, loot.quantity)
            then
                return true, 'Pigment Filter'
            end

            --> Cooking
            if
                Options:Get('toggleCookingFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.COOKING) and
                CheckThreshold("Cooking Ingredient", itemSellPrice, loot.quantity)
            then
                return true, 'Cooking Filter'
            end

            --> Recipe
            if Options:Get('toggleRecipeFilter') and itemClass == HL_ITEM_CLASS.RECIPE then
                return true, 'Recipe Filter'
            end

            --> Pots
            if
                Options:Get('togglePotionFilter') and
                (itemClass == HL_ITEM_CLASS.CONSUMABLE and itemSubClass == HL_ITEM_SUB_CLASS.CONSUMABLE.POTION) and
                CheckThreshold("Potion", itemSellPrice, loot.quantity)
            then
                if Options:Get('selectPotionType') == "both" then
                    return true, 'Potion Filter'
                -- FIXME: Either make these experiemental or fix these so they work in any language
                elseif Options:Get('selectPotionType') == "healing" and string.find(loot.item, L["Healing"])  then
                    return true, 'Health Potion Filter'
                elseif Options:Get('selectPotionType') == "mana" and string.find(loot.item, L["Mana"])  then
                    return true, 'Mana Potion Filter'
                else
                    return false, 'Unsupported Potion'
                end
            end

            --> Flasks
            if
                Options:Get('toggleFlaskFilter') and
                (itemClass == HL_ITEM_CLASS.CONSUMABLE and itemSubClass == HL_ITEM_SUB_CLASS.CONSUMABLE.FLASK) and
                CheckThreshold("Flask", itemSellPrice, loot.quantity)
            then
                return true, 'Flask Filter'
            end

            --> Elixirs
            if
                Options:Get('toggleElixirFilter') and
                (itemClass == HL_ITEM_CLASS.CONSUMABLE and itemSubClass == HL_ITEM_SUB_CLASS.CONSUMABLE.ELIXIR) and
                CheckThreshold("Elixir", itemSellPrice, loot.quantity)
            then
                return true, 'Elixir Filter'
            end

            --> Motes
            if
                Options:Get('toggleElementalFilter') and
                (itemClass == HL_ITEM_CLASS.TRADESKILL and itemSubClass == HL_ITEM_SUB_CLASS.TRADESKILL.ELEMENTAL) and
                CheckThreshold("Elemental", itemSellPrice, loot.quantity)
            then
                return true, 'Elemental Filter'
            end

            -- LEGION

            --> Defiled Augment Rune
            if Options:Get('toggleAugmentRuneFilter') and CheckUntyped('Defiled Augment Rune', loot.link) then
                return true, 'Defiled Augment Rune Filter'
            end

            --> Artifact Research Notes
            if Options:Get('toggleKnowledgeScrollFilter') and CheckUntyped('Artifact Research Notes', loot.link) then
                return true, 'Artifact Research Notes Filter'
            end

            --> Sentinax Beacons
            if Options:Get('toggleSentinaxBeaconFilter') and CheckUntyped('Sentinax Beacons', loot.link) then
                return true, 'Sentinax Beacons Filter'
            end

            -- QUALITY

            --> Poor
            if
                Options:Get('togglePoorQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_POOR and
                CheckThreshold("z1Poor", itemSellPrice, loot.quantity)
            then
                return true, 'Poor Quality Filter'
            end

            --> Common
            if
                Options:Get('toggleCommonQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_COMMON and
                CheckThreshold("z2Common", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Common Quality Filter'
            end

            --> Uncommon
            if
                Options:Get('toggleUncommonQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_UNCOMMON and
                CheckThreshold("z3Uncommon", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Uncommon Quality Filter'
            end

            --> Rare
            if
                Options:Get('toggleRareQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_RARE and
                CheckThreshold("z4Rare", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Rare Quality Filter'
            end

            --> Epic
            if
                Options:Get('toggleEpicQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_EPIC and
                CheckThreshold("z5Epic", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Epic Quality Filter'
            end

            --> Legendary
            if
                Options:Get('toggleLegendaryQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_LEGENDARY and
                CheckThreshold("z6Legendary", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Legendary Quality Filter'
            end

            --> Artifact
            if
                Options:Get('toggleArtifactQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_ARTIFACT and
                CheckThreshold("z7Artifact", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Artifact Quality Filter'
            end

            --> Heirloom
            if
                Options:Get('toggleHeirloomQualityFilter') and
                loot.quality == LE_ITEM_QUALITY_HEIRLOOM and
                CheckThreshold("z8Heirloom", itemSellPrice, loot.quantity) and CheckILvl(itemLevel)
            then
                return true, 'Heirloom Quality Filter'
            end

            return false, 'Not Found'
        else
            Util:Announce(L["BagsFull"])
            Util:Debug(ERR_INV_FULL);
            if Options:Get('toggleAnnounceBagsFullRaid') then
                -- TODO: RECOLOR?
                RaidNotice_AddMessage(RaidWarningFrame, L['BagsFull'], ChatTypeInfo["RAID_WARNING"])
            end
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
                    Util:Debug(string.format(L["GreyItemSold"], itemLink, itemCount, Util:FormatMoney(sellPrice * itemCount, 'SMART', true)))
                    UseContainerItem(bag,slot)
                    totalPrice = totalPrice + sellPrice * itemCount
                    totalCount = totalCount + itemCount
                end
            end
        end
    end
    if totalPrice > 0 then
        Util:Announce(string.format(L["AllGreysSold"], totalCount, Util:FormatMoney(totalPrice, 'SMART', true)))
    end
end

--
-- ─── NEW LOOT ICON FUNCTIONS ────────────────────────────────────────────────────
--

local function GetItemValueText(itemLink, useTSM)
    local itemValue
    local prefixText = ''

    -- FIXME: Replace dummy opts and add input for source
    if useTSM and IsAddOnLoaded('TradeSkillMaster') and TSMAPI then
        local tsmSources = TSMAPI:GetPriceSources()
        local priceSource = (tsmSources[Options:Get('inputValueTSMSource')]) and Options:Get('inputValueTSMSource') or 'DBMarket'
        prefixText = tsmSources[priceSource]

        if prefixText:len() > 20 then
           prefixText = prefixText:match('^%a+%s%-%s([%w%s]+)') or priceSource
        end

        itemValue = TSMAPI:GetItemValue(_G.TSMAPI.Item:ToItemString(itemLink), priceSource)
        if not itemValue then
            return GetItemValueText(itemLink, false)
        end
    else
        itemValue = select(11, GetItemInfo(itemLink))
        -- TODO: Localize
        prefixText = 'Vendor'
    end

    prefixText = (prefixText ~= '' and Options:Get('toggleShowValuePrefix')) and prefixText..': ' or ''
    return prefixText..Util:FormatMoney(itemValue, 'SMART', true)
end

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
        bgFile   = LSM:Fetch('background', Options:Get('selectThemeBackground')),
        edgeFile = LSM:Fetch('border', Options:Get('selectThemeBorder')),
        tile     = Options:Get('toggleThemeBackgroundTile'),
        tileSize = Options:Get('rangeThemeBackgroundTileSize'),
        edgeSize = Options:Get('rangeThemeBorderEdgeSize'),
        insets   = {
            left   = Options:Get('rangeThemeBorderInset'),
            right  = Options:Get('rangeThemeBorderInset'),
            top    = Options:Get('rangeThemeBorderInset'),
            bottom = Options:Get('rangeThemeBorderInset') 
        }
    })

    --> Coin Type
    if loot.slotType == HL_LOOT_SLOT_TYPE.COIN then
        loot.item = Util:FormatMoney(Util:ToCopper(loot.item), 'SMART', true)
    end

    --> Set Theme Color
    local colorThemeBG = Options:Get('colorThemeBackground')

    frame:SetBackdropColor(colorThemeBG.r, colorThemeBG.g, colorThemeBG.b, colorThemeBG.a)

    local borderRed   = Options:Get('colorThemeBorder')['r']
    local borderGreen = Options:Get('colorThemeBorder')['g']
    local borderBlue  = Options:Get('colorThemeBorder')['b']
    local borderAlpha = Options:Get('colorThemeBorder')['a']

    if Options:Get('toggleColorByQuality') and loot.quantity > 0 and loot.quality then
        borderRed, borderGreen, borderBlue = GetItemQualityColor(loot.quality)
        borderAlpha = 1
    end

    frame:SetBackdropBorderColor(borderRed, borderGreen, borderBlue, borderAlpha)

    --> Set Opacity
    frame:SetAlpha(Options:Get('rangeTransparency'))

    --> Set Icon
    frame.icon:SetTexture(loot.texture)
    -- frame.icon:ClearAllPoints()
    -- frame.icon:SetPoint('TOPLEFT', frame, 'TOPLEFT', theme.icon.left, theme.icon.top)
    if frame.size == HL_THEME_SIZE.SMALL then
        frame.icon:SetSize(Options:Get('rangeIconSize'), Options:Get('rangeIconSize'))
    else
        frame.icon:SetSize(32, 32)
    end

    --> Font Color
    local colorFont = {
        red   = Options:Get('colorFontColor')['r'],
        green = Options:Get('colorFontColor')['g'],
        blue  = Options:Get('colorFontColor')['b'],
        alpha = Options:Get('colorFontColor')['a']
    }

    if Options:Get('toggleFontColorByQual') and loot.quality then
        colorFont.red, colorFont.green, colorFont.blue = GetItemQualityColor(loot.quality)
        colorFont.alpha = 1.0
    end

    -- TODO: ADD OPTIONS FOR OUTLINE ETC
    --> Set Name
    local nameText = loot.link or loot.item
    frame.name:SetFont(AceGUIWidgetLSMlists.font[Options:Get('selectNameTextFont')], Options:Get('rangeNameTextSize'), "OUTLINE")
    frame.name:SetText(nameText)
    -- frame.name:ClearAllPoints()
    -- frame.name:SetPoint('TOPLEFT', frame, 'TOPLEFT', theme.text.name.left, theme.text.name.top)

    --> Set Count
    if frame.count then
        frame.count:SetFont(AceGUIWidgetLSMlists.font[Options:Get('selectQuantTextFont')], Options:Get('rangeQuantTextSize'), "OUTLINE")
        frame.count:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowItemQuant') and loot.quantity > 0 then
            local countText = loot.quantity

            if Options:Get('toggleShowTotalQuant') and loot.slotType ~= nil then
                if loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
                    local _, currencyCurrentAmount, _, _, _, currencyMax, _ = GetCurrencyInfo(loot.link)
                    local currencyTotalText = (currencyCurrentAmount + loot.quantity < currencyMax) and (currencyCurrentAmount + loot.quantity) or currencyMax
                    countText = loot.quantity..' ['..tostring(currencyTotalText)..']'
                else
                    countText = loot.quantity..' ['..tostring(GetItemCount(loot.item) + loot.quantity)..']'
                end
            end

            frame.count:SetText(countText)

            frame.count:Show()
        else
            frame.count:Hide()
        end
    end

    --> Set Value
    if frame.value then
        frame.value:SetFont(AceGUIWidgetLSMlists.font[Options:Get('selectLine2TextFont')], Options:Get('rangeLine2TextSize'), "OUTLINE")
        frame.value:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowSellPrice') and loot.quantity > 0 and loot.slotType == HL_LOOT_SLOT_TYPE.ITEM then

            frame.value:SetText(GetItemValueText(loot.link, Options:Get('toggleShowTSMValue')))

            -- frame.value:ClearAllPoints()
            --[[if theme.text.value.top then
                frame.value:SetPoint('TOPLEFT', frame, 'TOPLEFT', theme.text.value.left, theme.text.value.top)
            else
                frame.value:SetPoint('BOTTOMLEFT', frame, 'BOTTOMLEFT', theme.text.value.left, theme.text.value.bottom)
            end]]

            frame.value:Show()
        else
            frame.value:Hide()
        end
    end

    --> Set Type
    if frame.type then
        frame.type:SetFont(AceGUIWidgetLSMlists.font[Options:Get('selectLine1TextFont')], Options:Get('rangeLine1TextSize'), "OUTLINE")
        frame.type:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowItemType') then
            local typeText, subtypeText, typeTextDivider = '', '', ''

            if loot.slotType == HL_LOOT_SLOT_TYPE.ITEM then
                typeText        = select(6, GetItemInfo(loot.link)) or 'N/A'
                subtypeText     = select(7, GetItemInfo(loot.link)) or 'N/A'
                typeTextDivider = ': '
            elseif loot.slotType == HL_LOOT_SLOT_TYPE.CURRENCY then
                typeText = CURRENCY
            end

            frame.type:SetText(typeText..typeTextDivider..subtypeText)
            -- frame.type:ClearAllPoints()
            -- frame.type:SetPoint('TOPLEFT', frame, 'TOPLEFT', theme.text.type.left, theme.text.type.top)

            frame.type:Show()
        else
            frame.type:Hide()
        end
    end

    --> Set Size
    --> ==> Width
    local iconWidth   = frame.icon:GetWidth()
    local nameWidth   = frame.name:GetStringWidth()
    local typeWidth   = (frame.type and Options:Get('toggleShowItemType')) and frame.type:GetStringWidth() or 0
    local valueWidth  = (frame.count and Options:Get('toggleShowSellPrice')) and frame.value:GetStringWidth() or 0
    local spacerWidth = 16
    local minWidth    = tonumber(Options:Get('inputMinWidth'))

    local frameWidth = max(
        iconWidth + nameWidth  + spacerWidth,
        iconWidth + typeWidth  + spacerWidth,
        iconWidth + valueWidth + spacerWidth,
        minWidth
    )

    --> ==> Height
    local frameHeight = (frame.size == HL_THEME_SIZE.SMALL) and (Options:Get('rangeIconSize') + 4) or 50

    frame:SetSize(frameWidth, frameHeight)

    --> Set Scale
    local defaultScale = 1
    frame:SetScale(defaultScale + Options:Get('rangeToastScale'))

    --> Fade Animation
    if Options:Get('toggleShowAnimation') then
        local animationGroup = frame:CreateAnimationGroup()
        animationGroup:SetScript('OnFinished', function(self)
            frame:Hide()
        end)

        local animationTrans = animationGroup:CreateAnimation("Translation")
        local transOffset = (Options:Get('selectGrowthDirection') == 1) and 100 or -100
        animationTrans:SetOffset(0, transOffset)
        animationTrans:SetDuration(1.0)
        animationTrans:SetSmoothing("IN")

        local animationFade = animationGroup:CreateAnimation("Alpha")
        animationFade:SetFromAlpha(Options:Get('rangeTransparency'))
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
    local templateSize = (Options:Get('selectThemeSize') == HL_THEME_SIZE.SMALL) and "Small" or "Large"
    local templateIsFlipped = (Options:Get('selectTextSide') == HL_TEXT_SIDE.RIGHT) and "" or "Flipped"

    local frame = CreateFrame("Frame", "HotLoot_Toast", nil, "HotLoot_Toast"..templateSize..templateIsFlipped.."Template")

    frame.size = Options:Get('selectThemeSize')
    frame.textSide = Options:Get('selectTextSide')
    -- frame.pos = 0

    frame.SetLoot = SetLoot

    frame:Hide()

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
    local pos = frame.pos
    local padding = Options:Get('rangeToastPadding')
    local offset = (frame.size == HL_THEME_SIZE.LARGE)
        and ((pos - 1) * (frame:GetHeight() + padding) * Options:Get('selectGrowthDirection'))
        or  ((pos - 1) * (tonumber(Options:Get('rangeIconSize') + 4 + padding) * Options:Get('selectGrowthDirection')))

    local vertAnchor = (Options:Get('selectGrowthDirection') == 1) and 'BOTTOM' or 'TOP'
    local horzAnchor = (Options:Get('selectTextSide')        == 0) and 'LEFT'   or 'RIGHT'
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
-- ─── CHAT COMMANDS ──────────────────────────────────────────────────────────────
--

function HotLoot:ChatCommand(input)
    if not input or input:trim() == "" then
        --InterfaceOptionsFrame_OpenToCategory(Options:Get('rame'))
        OpenOptionsWindow()
    elseif input == "help" then
        Util:Print('--- Available Commands ---')
        Util:Print('UNDER CONSTRUCTION')
        Util:Print('- '..Util:ColorText('enable', 'info')..': Enables/disables the addon')
        -- Util:Print('- '..Util:ColorText('debug', 'info')..': Enables/disables debug mode')
        -- Util:Print('- '..Util:ColorText('autoclose', 'info')..': Toggles the autoclose option')
        -- Util:Print('- '..Util:ColorText('skinning', 'info')..': Toggles skinning mode')
        -- Util:Print('- '..Util:ColorText('monitor', 'info')..': Toggles loot monitor')
        Util:Print('- '..Util:ColorText('include', 'info')..' <item>: Adds the item to the Include List')
        Util:Print('- '..Util:ColorText('exclude', 'info')..' <item>: Adds the item to the Exclude List')
        Util:Print('- '..Util:ColorText('filter', 'info')..' <item>: Test to see if an item will be looted')
    elseif string.find(input, '^enable') then
        if Options:Get('toggleSystemEnable') then
            Options:Set('toggleSystemEnable', false)
            Util:Print('Auto looting DISABLED.')            
        else
            Options:Set('toggleSystemEnable', true)
            Util:Print('Auto looting ENABLED.')            
        end
    elseif string.find(input, '^include%s') then
        local item = string.gsub(input, '^include%s', '', 1)
        Options:AddToIncludeList(nil, item)
    elseif string.find(input, '^exclude%s') then
        local item = string.gsub(input, '^exclude%s', '', 1)
        Options:AddToExcludeList(nil, item)
    elseif string.find(input, '^filter%s') then
        local itemInput = string.gsub(input, '^filter%s', '', 1)

        local itemName, itemLink, itemQuality, _, _, _, _, _, _, iconFileDataID, _, _, _, _, _, _, isCraftingReagent = GetItemInfo(itemInput)

        if not itemName then
            -- TODO: Do this proper and localize it
            Util:Print(string.format(L['ErrorListItemNotFound'], Util:ColorText(itemInput, 'info'), 'filter test')..'\n'..'The item may just need to be cached, if you are sure its right just try again.')
            return false
        end

        local loot = {
            texture     = iconFileDataID,
            item        = itemName,
            quantity    = 1,
            quality     = itemQuality,
            locked      = false,
            isQuestItem = false,
            -- questId     = questId,
            -- isActive    = isActive,
            link        = itemLink,
            slotType    = HL_LOOT_SLOT_TYPE.ITEM
        }

        Util:Print("Running Filter...")
        
        local result, reason = FilterSlot(loot)

        local printStr = ''
        if result then
            printStr = '%s was caught in the %s.'
            Util:Print(printStr:format(loot.link, reason))
        else
            printStr = '%s was not caught. Reason: %s'
            Util:Print(printStr:format(loot.link, reason))
        end
    else
        OpenOptionsWindow()
        -- print(input.." | trim: ".. input:trim())
        -- LibStub("AceConfigCmd-3.0"):HandleCommand("hl", "HotLoot", input)
    end
end

--
-- ─── EVENTS ─────────────────────────────────────────────────────────────────────
--

function HotLoot:LOOT_OPENED()
    if Options:Get('toggleSystemEnable') then
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
                Util:Debug("Item Looted in " .. Util:ColorText(reason, 'info') .. ".")

                if Options:Get('toggleEnableLootMonitor') then
                    local frame
                    local nextIndex = self:GetNextToastIndex()

                    -- TODO: This can be simplified
                    if not nextIndex then
                        frame = self:CreateLootToast()
                        self:ShiftToastPosUp()
                        frame:SetLoot(lootInfo[slot])
                        table.insert(self.toasts, frame)
                    else
                        frame = self.toasts[nextIndex]

                        -- TODO: It might be possible to make 2 seperate pools (4 since sides also) and use those instead
                        if frame.size ~= Options:Get('selectThemeSize') or frame.textSide ~= Options:Get('selectTextSide') then
                            self.toasts[nextIndex] = self:CreateLootToast()
                            self.toasts[nextIndex]['pos'] = frame.pos
                            frame = self.toasts[nextIndex]
                        end

                        self:ShiftToastPosUp()
                        frame:SetLoot(lootInfo[slot])
                    end

                    self:UpdateAnchors()

                    -- frame:SetScript('OnShow', function(self)
                        frame.timer = HotLoot:ScheduleTimer(function()
                            if frame.animation and Options:Get('toggleShowAnimation') then
                                frame.animation:Play()
                            else
                                frame:Hide()
                            end
                        end, Options:Get('rangeDisplayTime') + Options:Get('rangeMultipleDelay') * staggerCount)
                    -- end)

                    -- Increase Stagger Count
                    staggerCount = staggerCount + 1

                    frame:Show()
                end

                LootSlot(slot)
            else
                Util:Debug('Item NOT looted. '..Util:ColorText('('..tostring(reason)..')', 'alert'))
                ToSkin(slot)
            end
        end

        if Options:Get('toggleLootFrameEnable') and HotLootFrame then
            if not Options:Get('toggleCloseLootWindow') or Util:IsCloseKeyDown() then
                HotLootFrame:Update()
                HotLootFrame:Show()
            else
                CloseLoot()
            end
            -- TODO: Turn into elseif
        else
            -- TODO: Add back RealUI and ElvUI support
            if Options:Get('toggleCloseLootWindow') and not Util:IsCloseKeyDown()--[[ and (string.find(mFocus, "WorldFrame") or Util:IsRealUILootOn())]] then
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
    if Options:Get('toggleSystemEnable') and Options:Get('toggleSellPoorItems') then
        Util:Debug("Merchant Window Opened")
        SellPoorItems()
    end
end

function HotLoot:BAG_UPDATE(...)
    DeleteLeftovers();
end
