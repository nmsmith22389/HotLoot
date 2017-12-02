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
local TooltipScan = LibStub('LibTTScan-1.0')
HotLoot.minimapIcon = LibStub('LibDBIcon-1.0')
local Options, Util, HotLootFrame
local icons, closeEL = {}, 0
HotLoot.toasts = {}

-- NOTE: These are the returns for GetItemInfo()
-- local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemID)

--
-- ─── VARS ───────────────────────────────────────────────────────────────────────
--

local private = {}

local function GetFont(key)
    if not LSM:IsValid('font', Options:Get(key)) then
        Options:Set(key, Options.db.defaults.profile[key])
    end

    return LSM:Fetch('font', Options:Get(key))
end

--
-- ─── DIALOGS ────────────────────────────────────────────────────────────────────
--
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
    private.CreateAnchorFrame()

    -- Hide anchor by default if set
    self:ToggleAnchor(Options:Get('toggleShowLootMonitorAnchor'))

    -- Register Events
    self:RegisterEvent("LOOT_OPENED")
    self:RegisterEvent("LOOT_CLOSED")
    -- self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("MERCHANT_SHOW")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")

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
    self.Anchor:ClearAllPoints()
    if Options:Get('anchorPosition')['x'] and Options:Get('anchorPosition')['y'] then
        self.Anchor:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', Options:Get('anchorPosition')['x'], Options:Get('anchorPosition')['y'])
    else
        self.Anchor:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
    end
end

function private.CreateAnchorFrame()
    local anchorFrame = CreateFrame("Frame", 'HotLoot_Anchor', UIParent)

    anchorFrame:SetBackdrop({
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

    anchorFrame:SetBackdropColor(0, 0, 0, 0.7)
    anchorFrame:SetBackdropBorderColor(1, 1, 1, 1.0)

    local frameWidth  = 200
    local frameHeight = 50

    anchorFrame:SetSize(frameWidth, frameHeight)

    anchorFrame:SetClampedToScreen(true)

    anchorFrame.text = anchorFrame:CreateFontString('Text', "OVERLAY")
    anchorFrame.text:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
    anchorFrame.text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    anchorFrame.text:SetText("HotLoot Anchor")
    anchorFrame.text:SetTextColor(1, 0.24, 0, 1)


    anchorFrame:RegisterForDrag("LeftButton")
    anchorFrame:SetMovable(true)
    anchorFrame:EnableMouse(true)
    anchorFrame:SetScript("OnDragStart", function()
        anchorFrame:StartMoving()
    end)
    anchorFrame:SetScript("OnDragStop", function()
        anchorFrame:StopMovingOrSizing()
        Options:Get('anchorPosition')['x'] = anchorFrame:GetLeft()
        Options:Get('anchorPosition')['y'] = anchorFrame:GetBottom()
    end)
    anchorFrame:Show()

    HotLoot.Anchor = anchorFrame

    HotLoot:RefreshAnchorPosition()
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

    local loot = HotLoot.LootItem:NewDummy(itemLink)

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
-- TODO: Use SplitContainerItem to only delete the right quant
function private.AddToDeleteList(item)
    if not item.GetClass or item:GetClass() ~= 'LootItem' then error('Wrong class for argument.') end
    if (Options:Get('toggleSkinningMode') or Util:IsSkinKeyDown()) and item:Quantity() > 0 then
        private.deleteList = private.deleteList or {}

        local itemID = item:ID()
        if not itemID then return false end

        private.deleteList[itemID] = item:Name()
        item:Loot()
        Util:Debug(Util:ColorText(item:Link()..' is set to be deleted!', 'alert'))
    end
end

function private.RunDeleteList()
    if not Util:IsEmpty(private.deleteList) then
        -- TODO: Rename
        Util:Announce(L["SkinAnnounce1"])
        Util:ScanBags(function(bag, slot, itemLink)
            if itemLink then
                local itemID = GetItemInfoInstant(itemID)
                if itemID and private.deleteList[itemID] then
                    ClearCursor()
                    PickupContainerItem(bag, slot)
                    if CursorHasItem() then
                        DeleteCursorItem()
                        -- TODO: Rename
                        Util:Announce(itemLink .. L["SkinAnnounce2"])
                    end
                end
            end
        end)
        private.deleteList = {}
    end
end

--
-- ─── LOOT FILTER ────────────────────────────────────────────────────────────────
--

-- Helper Functions
function private.HasRoom(room)
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

function private.CanStack(item)
    local stackRoom = 0
    Util:ScanBags(
       function(bag, slot, itemLink)
           if itemLink == GetContainerItemLink(bag, slot) then
                local bagQuant = select(2, GetContainerItemInfo(bag, slot))
                stackRoom = stackRoom + (item:StackCount() - bagQuant)
           end
       end
    )
    if item:Quantity() <= stackRoom then
        return true
    else
        return false
    end
end

-- TODO: Figure out how to add leather to new filters?
-- TODO: This is left over from old filter so either incorporate it or get rid of it
--[[ local untypedItems = {
    ['Leather'] = {
        [124439] = true,
        [124438] = true,
    },
    ['Defiled Augment Rune'] = {
        [140587] = true,
    },
    ['Artifact Research Notes'] = {
        [139390] = true,
    },
    ['Sentinax Beacons'] = {
        [146909] = true, [146908] = true, [146907] = true,
        [146906] = true, [146905] = true, [146903] = true,
        [146915] = true, [146914] = true, [146913] = true,
        [146912] = true, [146911] = true, [146910] = true,
        [146921] = true, [146920] = true, [146919] = true,
        [146918] = true, [146917] = true, [146916] = true,
        [147355] = true, [146923] = true, [146922] = true,
        [147893] = true, [147889] = true, [147892] = true,
        [147891] = true, [147894] = true,
    },
}

function private.CheckUntyped(type, itemLink)
    local itemId = Util:GetItemID(itemLink)

    if not untypedItems[type] then
        Util:Debug('Invalid type for CheckUntyped()')
        return false
    end

    if untypedItems[type][tonumber(itemId)] then
        Util:Debug('Untyped item in filter. [class: '..type..']')
        return true
    else
        return false
    end
end ]]

function private.GetItemPrice(item, opts)
    -- NOTE: The item table must contain value, link, and quant
    --[[
        NOTE: Example
        opts = {
            useTSM   => 'toggleFilterTSMValue',
            source   => 'inputFilterTSMSource',
            useQuant => 'toggleUseQuantValue'
        }
    ]]
    if not item or not item:Value() or not item:Link() or not item:Quantity() then return 0 end
    if not opts or type(opts) ~= 'table' then
        opts = {
            useTSM = false,
            source = nil,
            useQuant = false
        }
    else
        opts.useTSM = opts.useTSM or false
        opts.useQuant = opts.useQuant or false
    end
    local value = item:Value()
    local defaultSource = 'DBMarket'

    if opts.useTSM and Options:IsTSMLoaded() then
        local tsmSources = TSMAPI:GetPriceSources()
        local priceSource = tsmSources[opts.source] and opts.source or defaultSource
        local tsmPrice = TSMAPI:GetItemValue(TSMAPI.Item:ToItemString(item:Link()), priceSource)
        value = tsmPrice or value
    end

    if opts.useQuant and item:Quantity() ~= nil then
        value = item:Quantity() * value
    end
    return value
end

function private.RunConditions(opts)
    if not opts.item.GetClass or opts.item:GetClass() ~= 'Item' then error('Wrong class for argument.') end
    --[[
        opts = {
            filters   => filters table,
            item      => Item class,
            tsmToggle => TSM on/off,
            tsmSource => TSM source string,
            useQuant  => toggleUseQuantValue
        }
     ]]
    if not opts or not opts.filters or type(opts.filters) ~= 'table' or not opts.item then
        return false
    end

    opts.tsmToggle = type(opts.tsmToggle) == 'boolean' and opts.tsmToggle or false
    opts.tsmSource = type(opts.tsmSource) == 'string'  and opts.tsmSource or 'DBMarket'
    opts.useQuant  = type(opts.useQuant)  == 'boolean' and opts.useQuant  or false

    local function debug_c(str)
        local debug = HotLoot.DEBUG_CONDITIONS
        if debug then
            Util:Print(str)
        end
    end

    for filterName, filter in pairs(opts.filters) do
        if filter.enabled then
            local conditionsMet = 0
            for num, condition in ipairs(filter.conditions) do
                if tonumber(condition.type) == HL_FILTER_TYPE.TYPE and opts.item:Class() then
                    --> Item Type
                    debug_c('Item Type:     '..opts.item:Class())
                    debug_c('Condition Val: '..condition.value)
                    debug_c('Item SubType:     '..opts.item:SubClass())
                    debug_c('Condition SubVal: '..condition.subvalue)
                    if opts.item:Class() == tonumber(condition.value) then
                        if tonumber(condition.subvalue) == opts.item:SubClass() or condition.subvalue == 'NONE' then
                            conditionsMet = conditionsMet + 1
                        end
                    end
                elseif tonumber(condition.type) == HL_FILTER_TYPE.VALUE and opts.item:Value() then
                    --> Item Value
                    local itemValue = private.GetItemPrice(opts.item, opts.tsmToggle, opts.tsmSource, opts.useQuant)
                    debug_c('Item Value:    '..Util:FormatMoney(itemValue, 'SMART', true))
                    debug_c('Condition Val: '..Util:FormatMoney(condition.subvalue, 'SMART', true))

                    if condition.value == 'equalTo' then
                        if condition.subvalue == itemValue then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'greaterThan' then
                        if itemValue > condition.subvalue then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'lessThan' then
                        if itemValue < condition.subvalue then
                            conditionsMet = conditionsMet + 1
                        end
                    end
                elseif tonumber(condition.type) == HL_FILTER_TYPE.QUALITY and opts.item:Quality() then
                    --> Item Quality
                    if condition.value == 'equalTo' then
                        if tonumber(condition.subvalue) == opts.item:Quality() then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'greaterThan' then
                        if opts.item:Quality() > tonumber(condition.subvalue) then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'lessThan' then
                        if opts.item:Quality() < tonumber(condition.subvalue) then
                            conditionsMet = conditionsMet + 1
                        end
                    end
                elseif tonumber(condition.type) == HL_FILTER_TYPE.NAME and opts.item:Name() then
                    --> Item Name
                    if condition.value == 'contains' then
                        if opts.item:Name():match(condition.subvalue) then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'matches' then
                        if opts.item:Name():match(condition.subvalue) == opts.item:Name() then
                            conditionsMet = conditionsMet + 1
                        end
                    end
                elseif tonumber(condition.type) == HL_FILTER_TYPE.ILVL and opts.item:iLvl() and opts.item:IsEquippable() then
                    --> Item Level
                    if condition.value == 'equalTo' then
                        if tonumber(condition.subvalue) == opts.item:iLvl() then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'greaterThan' then
                        if opts.item:iLvl() > tonumber(condition.subvalue) then
                            conditionsMet = conditionsMet + 1
                        end
                    elseif condition.value == 'lessThan' then
                        if opts.item:iLvl() < tonumber(condition.subvalue) then
                            conditionsMet = conditionsMet + 1
                        end
                    end
                elseif tonumber(condition.type) == HL_FILTER_TYPE.BIND then
                    --> Bind Type
                    local bindType = Util:GetBindType(opts.item:Link())

                    if bindType then
                        if condition.value == 'is' then
                            if tonumber(condition.subvalue) == bindType then
                                conditionsMet = conditionsMet + 1
                            end
                        elseif condition.value == 'isNot' then
                            if tonumber(condition.subvalue) ~= bindType then
                                conditionsMet = conditionsMet + 1
                            end
                        end
                    end
                end
            end

            if (filter.trigger == 'any' and conditionsMet >= 1) or
                (filter.trigger == 'all' and conditionsMet == #filter.conditions) then
                return true, filterName
            end
        end
    end

    return false
end

-- NOTE: Returns 2 vars...
--      1: result [boolean]
--      2: filter caught in / reason not caught [string]
function private.FilterSlot(item)
    if not item.GetClass or item:GetClass() ~= 'LootItem' then error('Wrong class for argument.') end
    -- FIXME: is this check for in raid part really needed?
    if Options:Get('tableExcludeList')[item:Name()] and item:Link() and (not Options:Get('toggleDisableInRaid') or GetLootMethod() ~= 'master') then
        -- Don't Loot
        Util:Announce(L["AnnounceItemExcluded"]:format(item:Link()))
        return false, HL_LOOT_REASON.EXCLUDE
    end

    if item:IsGold() then
        -- Check Gold (Coin)
        if Options:Get('toggleGoldFilter') then
            return true, HL_LOOT_REASON.GOLD
        end
    elseif item:IsCurrency() then
        -- Check Currency
        if Options:Get('toggleCurrencyFilter') then
            return true, HL_LOOT_REASON.CURRENCY
        end
    elseif item:IsItem() and (not Options:Get('toggleDisableInRaid') or GetLootMethod() ~= 'master') then
        -- local _, _, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, _, itemSellPrice, itemClass, itemSubClass = GetItemInfo(loot.link)
        -- loot.value = itemSellPrice

--[[         local item = {
            item = loot.item,
            link = loot.link,
            slotType = item:SlotType(),
            value = loot.value,
            quantity = loot.quantity,
            quality = loot.quality,
            texture = loot.texture,
            ilvl = itemLevel,
            class = itemClass,
            subClass = itemSubClass
        } ]]

        item = item:ToItem()

        if (private.HasRoom(1) or private.CanStack(item)) then

            -- TODO: Normalize these so that the check order is (pref, type, subtype, other) (there may be special cases)

            --> Debug
            if Options:Get('toggleDebugMode') then
                local strFilterDebug = "-------------\n"..
                    tostring(item:Link())..' x'..tostring(item:Quantity())..'\n'..
                    '    - '..item:LocalClass()..' > '..item:LocalSubClass()
                Util:Debug(strFilterDebug)
            end

            --> Include List
            if Options:Get('tableIncludeList')[item:Name()] then
                return true, HL_LOOT_REASON.INCLUDE
            end

            --> Artifact Power
            if Options:Get('toggleAPFilter') and TooltipScan.GetItemArtifactPower(item:ID(), true) then
                return true, HL_LOOT_REASON.ARTIFACT_POWER
            end

            --> Custom Filters
            local filterTriggered, filterName = private.RunConditions{
                filters   = Options:Get('tableFilters'),
                item      = item,
                tsmToggle = Options:Get('toggleFilterTSMValue'),
                tsmSource = Options:Get('inputFilterTSMSource'),
                useQuant  = Options:Get('toggleUseQuantValue')
            }

            return filterTriggered, filterTriggered and filterName or HL_LOOT_REASON.NOT_FOUND
        else
            Util:Announce(L["BagsFull"])
            Util:Debug(ERR_INV_FULL)
            if Options:Get('toggleAnnounceBagsFullRaid') then
                -- TODO: RECOLOR?
                RaidNotice_AddMessage(RaidWarningFrame, L['BagsFull'], ChatTypeInfo["RAID_WARNING"])
            end
            return false, HL_LOOT_REASON.BAGS_FULL
        end
    else
        return false, HL_LOOT_REASON.NOT_FOUND
    end
end

--
-- ─── SELL POOR ITEMS ────────────────────────────────────────────────────────────
--

local function SellFilters()
    local totalPrice = 0
    local totalCount = 0
    local sellFunc = function(bag, slot, itemLink)
        if not itemLink then return false end
        -- local item = {}
        -- item.link = itemLink
        -- item.item, _, item.quality, item.ilvl, item.minLvl, _, _, _, _, _, item.value, item.class, item.subClass = GetItemInfo(item.link)
        local item = HotLoot.Item:New(itemLink, true)

        if not item then return end

        local filterTriggered, filterName = private.RunConditions{
            filters   = Options:Get('tableSellFilters'),
            item      = item,
            tsmToggle = Options:Get('toggleSellFilterTSMValue'),
            tsmSource = Options:Get('inputSellFilterTSMSource')
        }
        local _, itemCount, locked, _, _, lootable, _, _ = GetContainerItemInfo(bag, slot)

        if filterTriggered and not locked and not lootable then
            UseContainerItem(bag, slot)
            totalPrice = totalPrice + item:Value() * itemCount
            totalCount = totalCount + itemCount
            if Options:Get('toggleSellFiltersPrintEachItem') then
                Util:Announce(L['ItemSold']:format(item:Link(), Util:FormatMoney(item:Value(), 'SMART', true)))
            end
        end
    end
    Util:ScanBags(sellFunc)

    -- TODO: Calc price of sold items (sperate by filter? say which sold what?)
    if totalPrice > 0 and Options:Get('toggleSellFiltersPrintTotal') then
        Util:Announce(L["TotalItemsSold"]:format(totalCount, Util:FormatMoney(totalPrice, 'SMART', true)))
    end
end

--
-- ─── NEW LOOT ICON FUNCTIONS ────────────────────────────────────────────────────
--

-- FIXME: Figure out why sometimes as of 7.2.5 it gets nil as the value
local function GetItemValueText(item)
    -- item.value = item.value or select(11, GetItemInfo(item.link))
    if not item.GetClass or item:GetClass() ~= 'Item' then error('Wrong class for argument.') end
    local prefixText = ''
    local itemValue = private.GetItemPrice(item, {
        useTSM = Options:Get('toggleTextTSMValue'),
        source = Options:Get('inputTextTSMSource')
    })

    if Options:IsTSMLoaded() and Options:Get('toggleTextTSMValue') then
        local tsmSources = TSMAPI:GetPriceSources()
        prefixText = tsmSources[Options:Get('inputTextTSMSource')] or tsmSources['DBMarket']

        if prefixText:len() > 20 then
            prefixText = prefixText:match('^%a+%s%-%s([%w%s]+)')
         end
    else
        -- TODO: Localize
        prefixText = 'Vendor'
    end

    if not itemValue then
        return Util:FormatMoney(item:Value(), 'SMART', true)
    else
        prefixText = (prefixText ~= '' and Options:Get('toggleShowValuePrefix')) and prefixText..': ' or ''
        return prefixText..Util:FormatMoney(itemValue, 'SMART', true)
    end
end

local function GetSmartInfoText(loot)
    if not loot.GetClass or loot:GetClass() ~= 'LootItem' then error('Wrong class for argument.') end
-- ────────────────────────────────────────────────────────────────────────────────
-- TODO: Localize ALL these
-- ────────────────────────────────────────────────────────────────────────────────
    if loot:IsGold() then
        --> If loot is gold
        -- ... show total player gold.
        -- TODO: LOCALIZE
        local template = 'Player Gold: %s'
        local goldValue = GetMoney()
        return template:format(Util:FormatMoney(goldValue, 'SMART', true))
    elseif loot:IsCurrency() then
        --> If loot is currency
        -- ... Weekly max? Total max?
        return CURRENCY
    else
        --> If loot is an item
        local reason = loot:GetInfo('reason')
        local itemID = loot:ID()

        --> If the item is...
        if loot:GetInfo('reason') == HL_LOOT_REASON.ARTIFACT_POWER then
            -- Artifact Power
            -- TODO: LOCALIZE
            return string.format('Gives %s AP', Util:ShortNumber(TooltipScan.GetItemArtifactPower(itemID), 1))
        elseif Options:Get('toggleFarmingMode') and HotLoot.farmingStats and HotLoot.farmingStats[itemID] then
            -- TODO: Clean up farming mode
            local stat = HotLoot:GetFarmingStats(itemID)
            local statFormatted = function()
                if stat < 1 then
                    return string.format('%.2f', stat)
                elseif stat < 100 then
                    return string.format('%.1f', stat)
                elseif stat < 1000 then
                    return string.format('%.0f', stat)
                else
                    return Util:ShortNumber(stat, 1)
                end
            end
            local perOption = Options:Get('selectFarmingModeRate')
            -- TODO: Localize these below (ie 'Second', 'Minute', 'Hour')
            local perFormatted = (perOption == 'second' and 'Second') or (perOption == 'minute' and 'Minute') or (perOption == 'hour' and 'Hour')

            return string.format('Farmed: %s/%s', statFormatted(), perFormatted)
        else
            local typeText        = select(2, GetItemInfoInstant(itemID)) or 'N/A'
            local subtypeText     = select(3, GetItemInfoInstant(itemID)) or 'N/A'
            local typeTextDivider = ': '

            return Options:Get('toggleShowItemTypeNoInfo') and typeText..typeTextDivider..subtypeText or ''
        end
    end
end

-- TODO: Add option to change text outline (ie outline, thickoutline, mono, none)
local function SetLoot(frame, loot)
    if not loot.GetClass or loot:GetClass() ~= 'LootItem' then error('Wrong class for argument.') end
    --> Set ToolTip
    if loot:Link() then
        -- NOTE: loot.link and loot.slotType need to be set before calling this func
        frame.item = loot:Link()
        frame.ShowTooltip = function(self)
            if self.item then
                GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
                GameTooltip:SetHyperlink(self.item)
                GameTooltip:AddLine(Util:ColorText('Shift + Right Click', 'warning')..Util:ColorText(' to add this item to the exclude list.', 'info'))
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
        frame:SetScript('OnMouseUp', function(self, button)
            if IsShiftKeyDown() and button == 'RightButton' then
                Options:AddToList('tableExcludeList', self.item, 'Exclude List')
            end
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
    if loot:IsGold() then
        loot.__data.name = Util:FormatMoney(Util:ToCopper(loot:Name()), 'SMART', true)
    end

    --> Set Theme Color
    local colorThemeBG = Options:Get('colorThemeBackground')

    frame:SetBackdropColor(colorThemeBG.r, colorThemeBG.g, colorThemeBG.b, colorThemeBG.a)

    local borderRed   = Options:Get('colorThemeBorder')['r']
    local borderGreen = Options:Get('colorThemeBorder')['g']
    local borderBlue  = Options:Get('colorThemeBorder')['b']
    local borderAlpha = Options:Get('colorThemeBorder')['a']

    if Options:Get('toggleColorByQuality') and loot:Quantity() > 0 and loot:Quality() then
        borderRed, borderGreen, borderBlue = GetItemQualityColor(loot:Quality())
        borderAlpha = 1
    end

    frame:SetBackdropBorderColor(borderRed, borderGreen, borderBlue, borderAlpha)

    --> Set Opacity
    frame:SetAlpha(Options:Get('rangeTransparency'))

    --> Set Icon
    frame.icon:SetTexture(loot:Texture())
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

    if Options:Get('toggleFontColorByQual') and loot:Quality() then
        colorFont.red, colorFont.green, colorFont.blue = GetItemQualityColor(loot:Quality())
        colorFont.alpha = 1.0
    end

    --> Set Name
    local nameText = loot:Link() or loot:Name()
    local nameFont = GetFont('selectNameTextFont')

    frame.name:SetFont(nameFont, Options:Get('rangeNameTextSize'), Options:Get('selectNameTextOutline'))
    frame.name:SetText(nameText)
    -- frame.name:ClearAllPoints()
    -- frame.name:SetPoint('TOPLEFT', frame, 'TOPLEFT', theme.text.name.left, theme.text.name.top)

    --> Set Count
    if frame.count then
        local countFont = GetFont('selectQuantTextFont')

        frame.count:SetFont(countFont, Options:Get('rangeQuantTextSize'), Options:Get('selectQuantTextOutline'))
        frame.count:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowItemQuant') and loot:Quantity() > 0 then
            local countText = loot:Quantity()

            if Options:Get('toggleShowTotalQuant') and loot:SlotType() ~= nil then
                if loot:IsCurrency() then
                    local _, currencyCurrentAmount, _, _, _, currencyMax, _ = GetCurrencyInfo(loot:Link())
                    local currencyTotalText = (currencyCurrentAmount + loot:Quantity() < currencyMax or currencyMax == 0) and (currencyCurrentAmount + loot:Quantity()) or currencyMax
                    countText = loot:Quantity()..' ['..tostring(currencyTotalText)..']'
                else
                    countText = loot:Quantity()..' ['..tostring(GetItemCount(loot:Link()) + loot:Quantity())..']'
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
        local valueFont = GetFont('selectLine2TextFont')

        frame.value:SetFont(valueFont, Options:Get('rangeLine2TextSize'), Options:Get('selectLine2TextOutline'))
        frame.value:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowSellPrice') and loot:Quantity() > 0 and loot:IsItem() then

            frame.value:SetText(GetItemValueText(loot:ToItem()))

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
        frame.type:SetFont(GetFont('selectLine1TextFont'), Options:Get('rangeLine1TextSize'), Options:Get('selectLine1TextOutline'))
        frame.type:SetTextColor(colorFont.red, colorFont.green, colorFont.blue, colorFont.alpha)

        if Options:Get('toggleShowItemType') then
            frame.type:SetText(GetSmartInfoText(loot))
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
    local valueWidth  = (frame.value and Options:Get('toggleShowSellPrice')) and frame.value:GetStringWidth() or 0
    local countWidth  = (frame.count and Options:Get('toggleShowItemQuant')) and frame.count:GetStringWidth() or 0
    local spacerWidth = 16
    local minWidth    = tonumber(Options:Get('inputMinWidth')) or 0

    local frameWidth = max(
        iconWidth + nameWidth  + spacerWidth,
        iconWidth + nameWidth  + spacerWidth + countWidth,
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
-- ─── FARMING MODE ───────────────────────────────────────────────────────────────
--

function UpdateFarmingList(itemID, quant)
    local list = Options:Get('tableFarmingList')
    if not HotLoot.farmingStats then
        HotLoot.farmingStats = {}
        local mt = {
            __index = function(t, k)
                return rawget(t, tostring(k))
            end,
            __newindex = function(t, k, v)
                rawset(t, tostring(k), v)
            end
        }
        setmetatable(HotLoot.farmingStats, mt)
    end

    if list[itemID] then
        HotLoot.farmingStats[itemID] = HotLoot.farmingStats[itemID] or {}

        local stat = {
            ['quant'] = quant,
            ['time']  = time()
        }

        table.insert(HotLoot.farmingStats[itemID], stat)

        if #HotLoot.farmingStats[itemID] > 10 then
            table.remove(HotLoot.farmingStats[itemID], 1)
        end
    end
end

function HotLoot:GetFarmingStats(itemID)
    if not HotLoot.farmingStats[itemID] then
        return false
    end

    local totalQuant = 0
    local duration   = 0
    local minTime    = 0
    local maxTime    = 0

    for _, v in ipairs(HotLoot.farmingStats[itemID]) do
        totalQuant = totalQuant + v.quant
        if minTime == 0 or v.time < minTime then
            minTime = v.time
        end
        if maxTime == 0 or v.time > maxTime then
            maxTime = v.time
        end
    end

    duration = (maxTime - minTime < 1 and 1) or (maxTime - minTime)

    local perSec  = totalQuant/duration
    local perMin  = perSec * 60
    local perHour = perMin * 60
    local option  = Options:Get('selectFarmingModeRate')

    return (option == 'second' and perSec) or (option == 'minute' and perMin) or (option == 'hour' and perHour)
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
    local attachFrame = Util:IsRealUILootOn() and _G['RealUI_Loot'] or _G['LootFrame']
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
        -- TODO: Localize
        Util:Print('--- Available Commands ---')
        Util:Print('UNDER CONSTRUCTION')
        Util:Print('- '..Util:ColorText('enable',       'info')..': Enables/disables the addon')
        -- Util:Print('- '..Util:ColorText('debug',     'info')..': Enables/disables debug mode')
        -- Util:Print('- '..Util:ColorText('autoclose', 'info')..': Toggles the autoclose option')
        -- Util:Print('- '..Util:ColorText('skinning',  'info')..': Toggles skinning mode')
        -- Util:Print('- '..Util:ColorText('monitor',   'info')..': Toggles loot monitor')
        Util:Print('- '..Util:ColorText('include',      'info')..' <item>: Adds the item to the Include List')
        Util:Print('- '..Util:ColorText('exclude',      'info')..' <item>: Adds the item to the Exclude List')
        Util:Print('- '..Util:ColorText('filter',       'info')..' <item>: Test to see if an item will be looted')
        Util:Print('- '..Util:ColorText('sellFilter',   'info')..' <item>: Test to see if an item will be looted')
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
        Options:AddToList('tableIncludeList', item, 'Include List')
    elseif string.find(input, '^exclude%s') then
        local item = string.gsub(input, '^exclude%s', '', 1)
        Options:AddToList('tableExcludeList', item, 'Exclude List')
    -- TODO: Add farming filter
    elseif string.find(input, '^filter%s') then
        local itemInput = string.gsub(input, '^filter%s', '', 1)

        local itemID = GetItemInfoInstant(itemInput)

        if not itemID then
            -- TODO: Do this proper and localize it
            Util:Print(string.format(L['ErrorListItemNotFound'], Util:ColorText(itemInput, 'info'), 'filter test')..'\n'..'The item may just need to be cached, if you are sure its right just try again.')
            return false
        end

        Util:Print("Running Filter...")

        Util:GetItemInfoDelayed(itemID,
           function(itemLink, ...)
                local lootItem = HotLoot.LootItem:NewDummy(itemLink)

                local result, reason = private.FilterSlot(lootItem)

                local printStr = ''
                if result then
                    printStr = '%s was caught in the %s.'
                    Util:Print(printStr:format(lootItem:Link(), reason))
                else
                    printStr = '%s was not caught. Reason: %s'
                    Util:Print(printStr:format(lootItem:Link(), reason))
                end
           end
        )
    elseif string.find(input, '^sellFilter%s') then
    elseif string.find(input, '^debugc') then
        self.DEBUG_CONDITIONS = not self.DEBUG_CONDITIONS
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

        -- TODO: CLEAN UP!
        local lootInfo = GetLootInfo()
        self.lootInfo = lootInfo
        -- For staggering the fades
        local staggerCount = 0

        for slot, lootItem in pairs(lootInfo) do
            local item = HotLoot.LootItem:New(lootItem, slot)

            local filtered, reason = private.FilterSlot(item)

            if filtered and not item:Locked() then
                Util:Debug("Item Looted in " .. Util:ColorText(reason, 'info') .. ".")

                -- NOTE: Setting the reason into the loot var so it can be read by SetLoot()
                item:SetLootReason(reason)

                if Options:Get('toggleEnableLootMonitor') then
                    local frame
                    local nextIndex = self:GetNextToastIndex()

                    -- Farming Mode
                    if Options:Get('toggleFarmingMode') and item:Link() then
                        UpdateFarmingList(item:ID(), item:Quantity())
                    end

                    -- TODO: This can be simplified
                    if not nextIndex then
                        frame = self:CreateLootToast()
                        self:ShiftToastPosUp()
                        frame:SetLoot(item)
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
                        frame:SetLoot(item)
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
            elseif not filtered then
                Util:Debug('Item NOT looted. '..Util:ColorText('('..tostring(reason)..')', 'alert'))
                -- Send items that aren't looted to the skinning mode functions.
                private.AddToDeleteList(item)
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
                closeEL = 1
                CloseLoot()
            end
        end
    end
end

function HotLoot:LOOT_CLOSED()
    -- Delete leftover items
    private.RunDeleteList()
    -- Clear stored loot info
    self.lootInfo = nil
end

function HotLoot:LOOT_SLOT_CLEARED(slot)
    -- TODO: Finish... Replace with option... Localize
    local modifier = IsAltKeyDown()
    if modifier and Options:Get('toggleIncludeModifierClick') and self.lootInfo and self.lootInfo[slot] then
        local loot = self.lootInfo[slot]
        Options:AddToList('tableIncludeList', loot.item, 'Include List')
    end
end

function HotLoot:MERCHANT_SHOW(...)
    Util:Debug("Merchant Window Opened")
    SellFilters()
end
