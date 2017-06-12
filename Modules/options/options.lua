local Options = HotLoot:NewModule('Options')
local module = Options -- Alias
local L = LibStub('AceLocale-3.0'):GetLocale('HotLoot')
local Util = HotLoot:GetModule('Util')

--
-- ─── LOCALS ─────────────────────────────────────────────────────────────────────
--

watchListTable = {}

local tableModifierKeys = {
    ['0'] = 'None',
    ['ctrl'] = 'Control',
    ['shift'] = 'Shift',
    ['alt'] = 'Alt'
}

local tableDirectionVertical = {
    [1] = L['Up'],
    [-1] = L['Down']
}

local tableDirectionHorizontal = {
    [0] = L['Right'],
    [1] = L['Left']
}

local tableThemeSize = {
    [0] = L['Small'],
    [1] = L['Large']
}

local tablePotionType = {
    ['both'] = L['Both'],
    ['healing'] = L['Healing'],
    ['mana'] = L['Mana'],
}

-- FIXME: Make sure these reflect ALL the filter types
local tableFilterTypes = {
    ['0None'] = L['None'],
    ['Quest'] = GetItemClassInfo(HL_ITEM_CLASS.QUEST),
    --['Junk'] = L['Junk'],
    ['Gem'] = GetItemClassInfo(HL_ITEM_CLASS.GEM),
    ['Metal & Stone'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.METAL_STONE),
    ['Cooking Ingredient'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.COOKING),
    ['Herb'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.HERB),
    ['Leather'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.LEATHER),
    ['Cloth'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.CLOTH),
    ['Elemental'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ELEMENTAL),
    ['Enchanting'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ENCHANTING),
    ['Potion'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.POTION),
    ['Flask'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.FLASK),
    ['Elixir'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.ELIXIR),
    ['z1Poor'] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r',
    ['z2Common'] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r',
    ['z3Uncommon'] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r',
    ['z4Rare'] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r',
    ['z5Epic'] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r',
    ['z6Legendary'] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r',
    ['z7Artifact'] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r',
    ['z8Heirloom'] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r',
    ['Include'] = L['headerIncludeList'],
}

-- TODO: fix so that it gets all window names
local tableChatWindows
local function GetChatWindows()
    local windows = {}
    for index, window in pairs(CHAT_FRAMES) do
       windows[window] = _G[window].name
    end

    return windows
end
tableChatWindows = GetChatWindows()

local function GetDefaultChatWindow()
    local first
    for window,name in pairs(GetChatWindows()) do
        if DEFAULT_CHAT_FRAME.name == name then
            return window
        elseif not first then
            first = window
        end
    end

    return first
end

--
-- ─── DEFAULTS ───────────────────────────────────────────────────────────────────
--

local defaults = {
    profile = {
        minimapIcon = {
            hide = false,
            radius = 80,
            minimapPos = 270
        },
        anchorPosition = {
            x = false,
            y = false
        },
        firstRun = false,
        toggleSystemEnable = true,
        toggleDisableInRaid = true,
        toggleDebugMode = false,
        toggleAnnounceEvents = true,
        selectAnnounceWindow = GetDefaultChatWindow(),
        toggleAnnounceBagsFullRaid = true,
        toggleCloseLootWindow = false,
        selectCloseLootWindowModifier = '0',
        toggleSkinningMode = false,
        selectSkinningModeModifier = '0',
        --
        -- ─── LOOT MONITOR ────────────────────────────────────────────────
        --

        toggleEnableLootMonitor = true,
        toggleShowLootMonitorAnchor = true,

        --== Appearance ==--
        --> General
        selectGrowthDirection = -1,
        selectThemeSize = 1,
        rangeTransparency = 1,
        rangeToastPadding = 8,
        inputMinWidth = '145',
        rangeToastScale = 0,

        --> Texture
        selectThemeBackground = 'HotLoot Custom',
        selectThemeBorder = 'HotLoot Custom',
        colorThemeBackground = {
            r = 0,
            g = 0,
            b = 0,
            a = 0.7
        },
        colorThemeBorder = {
            r = 1,
            g = 1,
            b = 1,
            a = 1
        },
        toggleColorByQuality = true,
        toggleThemeBackgroundTile = true,
        rangeThemeBackgroundTileSize = 16,
        rangeThemeBorderEdgeSize = 16,
        rangeThemeBorderInset = 2,

        --> Icon
        rangeIconSize = 16,

        --> Animation
        toggleShowAnimation = true,
        rangeDisplayTime = 4,
        rangeMultipleDelay = 0.5,
        rangeFadeSpeed = 5,

        --
        -- ─── TEXT ────────────────────────────────────────────────────────
        --
        --** UNUSED **--
        selectTextFont = 'Roboto Condensed Bold',
        rangeFontSize = 9,
        colorFontColor = {
            ['r'] = 1.0,
            ['g'] = 1.0,
            ['b'] = 1.0,
            ['a'] = 1.0
        },
        --** UNUSED **--

        --> General
        toggleFontColorByQual = false,
        selectTextSide = 0,

        --> Name Text
        selectNameTextFont   = 'Roboto Condensed Bold',
        rangeNameTextSize    = 12,
        rangeNameTextXOffset = 0,
        rangeNameTextYOffset = 0,

        --> Quantity
        toggleShowItemQuant = true,
        toggleShowTotalQuant = true,
        selectQuantTextFont   = 'Roboto Condensed Bold',
        rangeQuantTextSize    = 8,
        colorQuantTextFont = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 1.0
        },
        rangeQuantTextXOffset = 0,
        rangeQuantTextYOffset = 0,

        --> Line 1
        toggleShowItemType = false,
        selectLine1TextFont = 'Roboto Condensed Bold',
        rangeLine1TextSize  = 10,
        colorLine1TextFont = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 1.0
        },
        rangeLine1TextXOffset = 0,
        rangeLine1TextYOffset = 0,

        --> Line 2
        toggleShowSellPrice = true,
        selectLine2TextFont = 'Roboto Condensed Bold',
        rangeLine2TextSize  = 10,
        colorLine2TextFont = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 1.0
        },
        toggleShowTSMValue = false,
        toggleShowValuePrefix = false,
        inputValueTSMSource = 'DBMinBuyout',
        rangeLine2TextXOffset = 0,
        rangeLine2TextYOffset = 0,

        toggleGoldFilter             = true,
        toggleQuestFilter            = true,
        toggleCurrencyFilter         = true,
        toggleJunkFilter             = false,
        togglePickpocketFilter       = true,
        toggleClothFilter            = false,
        toggleMiningFilter           = false,
        toggleGemFilter              = false,
        toggleHerbFilter             = false,
        toggleLeatherFilter          = false,
        toggleFishingFilter          = false,
        toggleEnchantingFilter       = false,
        togglePigmentsFilter         = false,
        toggleCookingFilter          = false,
        toggleRecipeFilter           = false,
        togglePotionFilter           = false,
        selectPotionType             = 'both',
        toggleFlaskFilter            = false,
        toggleElixirFilter           = false,
        toggleElementalFilter        = false,
        togglePoorQualityFilter      = false,
        toggleSellPoorItems          = false,
        toggleCommonQualityFilter    = false,
        toggleUncommonQualityFilter  = true,
        toggleRareQualityFilter      = true,
        toggleEpicQualityFilter      = true,
        toggleLegendaryQualityFilter = true,
        toggleArtifactQualityFilter  = true,
        toggleHeirloomQualityFilter  = true,
        inputMinItemLevel = 0,

        -- Include List
        tableIncludeList = {},
        toggleShowIncludeButton = false,

        -- Exclude List
        tableExcludeList = {},
        toggleShowExcludeButton = false,

        selectThresholdType1 = '0None',
        inputThresholdValue1 = 0,
        selectThresholdType2 = '0None',
        inputThresholdValue2 = 0,
        selectThresholdType3 = '0None',
        inputThresholdValue3 = 0,
        toggleUseQuantValue = false,
    }
}

--
-- ─── OPTIONS ────────────────────────────────────────────────────────────────────
--

function Options:Get(info)
    if type(info) == 'table' then
        return self.db.profile[info[#info]]
    else
        return self.db.profile[tostring(info)]
    end
end

function Options:Set(info, value)
    if type(info) == 'table' then
        local old = self.db.profile[info[#info]]
        Util:DebugOption(info[#info], value, old)
        self.db.profile[info[#info]] = value
    else
        self.db.profile[tostring(info)] = value
    end
end

function Options:SetColor(info, r, g, b, a)
    self.db.profile[info[#info]] = {
        ['r'] = r,
        ['g'] = g,
        ['b'] = b,
        ['a'] = a
    }

    Util:DebugOption(
        tostring(info[#info]),
        tostring(r)..', '..
        tostring(g)..', '..
        tostring(b)..', '..
        tostring(a)
    )
end

function Options:GetColor(info)
    local color = self.db.profile[info[#info]]
    return color.r,
    color.g,
    color.b,
    color.a
end

function Options:SetMoney(info, value)
    if not value or value:trim() == '' then
        value = 0
    else
        value = Util:ToCopper(value)
    end
    self:Set(info, value)
end

function Options:GetMoney(info)
    local value = self:Get(info)
    if not tonumber(value) then
        value = 0
    end
    return Util:FormatMoney(value, 'SMART', true)
end

function Options:Advanced()
    return not self:Get('toggleAdvancedOptions')
end

-- function Options:GetThemeColorDisabled()
--     if self:Get('selectTheme'):find('custom') ~= nil then
--         return false
--     else
--         return true
--     end
-- end

function Options:ConfirmOption(info, value)
    if value then
        return true
    else
        return false
    end
end

function Options:RefreshConfig(db)
    HotLoot:RefreshAnchorPosition()
end

--
-- ─── EXTERNALIZED SET FUNCTIONS ─────────────────────────────────────────────────
--

function Options:SetShowLootMonitorAnchor(info, value)
    self:Set(info, value)
    HotLoot:ToggleAnchor(value)
end

--
-- ─── INCLUDE LIST ───────────────────────────────────────────────────────────────
--

-- TODO: Change to item id
function Options:AddToIncludeList(info, value)
    if type(value) == 'string' and value ~= nil then
        local itemName = GetItemInfo(value)
        if itemName then
            self.db.profile.tableIncludeList[itemName] = itemName
            Util:Announce(string.format(L['AnnounceListAdd'], Util:ColorText(itemName, 'info'), L['headerIncludeList']))
        else
            Util:Print(string.format(L['ErrorListItemNotFound'], Util:ColorText(value, 'info'), L['headerIncludeList']))
        end
    end
end

function Options:RemoveFromIncludeList()
    self.db.profile.tableIncludeList[self.db.profile.selectIncludeList] = nil
end

function Options:GetIncludeList()
    return self.db.profile.tableIncludeList
end

--
-- ─── EXCLUDE LIST ───────────────────────────────────────────────────────────────
--

function Options:AddToExcludeList(info, value)
    if type(value) == 'string' and value ~= nil then
        local itemName = GetItemInfo(value)
        if itemName then
            self.db.profile.tableExcludeList[itemName] = itemName
            Util:Announce(string.format(L['AnnounceListAdd'], Util:ColorText(itemName, 'info'), L['headerExcludeList']))
        else
            Util:Print(string.format(L['ErrorListItemNotFound'], tostring(value), L['headerExcludeList']))
        end
    end
end

function Options:RemoveFromExcludeList()
    self.db.profile.tableExcludeList[self.db.profile.selectExcludeList] = nil
end

function Options:GetExcludeList()
    return self.db.profile.tableExcludeList
end

--
-- ─── OPTIONS TABLE ──────────────────────────────────────────────────────────────
--

optionsTable = {
    name = 'HotLoot',
    handler = Options,
    type = 'group',
    childGroups = 'tree',
    set = 'Set',
    get = 'Get',
    args = {
        descHotLoot = {
            -- name = L['descHotLoot'],
            name = '',
            image = [[Interface\AddOns\HotLoot\media\textures\Logo]],
            imageCoords = {0.0390625, 0.96484375, 0.109375, 0.8125},
            imageWidth = 237,
            imageHeight = 90,
            type = 'description',
            order = 1
        },
        descHotLootNote = {
            name = Util:ColorText(L['descHotLootNote'], 'alert'),
            type = 'description',
            order = 2
        },
        groupSystem = {
            name = L['groupSystem'],
            type = 'group',
            order = 3,

            args = {
                toggleSystemEnable = {
                    name = L['genEnable'],
                    desc = L['toggleSystemEnableDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 1
                },
                toggleHideMinimapButton = {
                    name = L['toggleHideMinimapButtonName'],
                    desc = L['toggleHideMinimapButtonDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 2,
                    set = function(info, value)
                        Options.db.profile.minimapIcon.hide = value
                        Util:DebugOption('minimapIcon.hide', value)
                        if value then
                            HotLoot.minimapIcon:Hide('HotLoot')
                        else
                            HotLoot.minimapIcon:Show('HotLoot')
                        end
                    end,
                    get = function(info)
                        return Options.db.profile.minimapIcon.hide
                    end
                },
                toggleDisableInRaid = {
                    name = L['toggleDisableInRaidName'],
                    desc = L['toggleDisableInRaidDesc']..'\n\n'..Util:ColorText(L['toggleDisableInRaidDescNote'], 'info'),
                    type = 'toggle',
                    width = 'full',
                    order = 4
                },
                toggleAdvancedOptions = {
                    name = L['toggleAdvancedOptionsName'],
                    desc = L['toggleAdvancedOptionsDesc'],
                    type = 'toggle',
                    width = 'full',
                    hidden = true,
                    order = 5
                },
                toggleDebugMode = {
                    name = L['toggleDebugModegName'],
                    desc = L['toggleDebugModegDesc'],
                    type = 'toggle',
                    -- hidden = 'Advanced',
                    width = 'full',
                    order = 6
                },
                groupAnnounceEvents = {
                    name = L['groupAnnounceEvents'],
                    type = 'group',
                    order = 7,
                    inline = true,
                    args = {
                        toggleAnnounceEvents = {
                            name = L['genEnable'],
                            desc = L['toggleAnnounceEventsDesc'],
                            type = 'toggle',
                            order = 1
                        },
                        selectAnnounceWindow = {
                            name = L['selectAnnounceWindowName'],
                            desc = L['selectAnnounceWindowDesc'],
                            type = 'select',
                            values = tableChatWindows,
                            order = 2
                        },
                        toggleAnnounceBagsFullRaid = {
                            name = L['toggleAnnounceBagsFullRaidName'],
                            desc = L['toggleAnnounceBagsFullRaidDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 3
                        },
                    },
                },
                groupCloseLootWindow = {
                    name = L['groupCloseLootWindow'],
                    type = 'group',
                    order = 8,
                    inline = true,
                    args = {
                        toggleCloseLootWindow = {
                            name = L['genEnable'],
                            desc = L['toggleCloseLootWindowDesc'],
                            type = 'toggle',
                            order = 1
                        },
                        selectCloseLootWindowModifier = {
                            name = L['genModifierKey'],
                            desc = L['selectCloseLootWindowModifierDesc']:format(Util:ColorText(L['genEnabled']..':', 'success'), Util:ColorText(L['genDisabled']..':', 'alert')),
                            type = 'select',
                            values = tableModifierKeys,
                            order = 2
                        },
                    },
                },
                groupSkinningMode = {
                    name = L['groupSkinningMode'],
                    type = 'group',
                    order = 9,
                    inline = true,
                    args = {
                        toggleSkinningMode = {
                            name = L['genEnable'],
                            desc = L['toggleSkinningModeDesc']..'\n\n'..Util:ColorText(L['dialogConfirmSkinningModeWarn'], 'alert'),
                            type = 'toggle',
                            confirm = 'ConfirmOption',
                            confirmText = L['dialogConfirmSkinningMode']..'\n\n'..Util:ColorText(L['dialogConfirmSkinningModeWarn'], 'alert'),
                            order = 1
                        },
                        selectSkinningModeModifier = {
                            name = L['genModifierKey'],
                            desc = L['selectSkinningModeModifierDesc']:format(Util:ColorText(L['genEnabled']..':', 'success'), Util:ColorText(L['genDisabled']..':', 'alert')),
                            type = 'select',
                            values = tableModifierKeys,
                            order = 2
                        },
                    },
                },
            },
        },
        groupLootMonitor = {
            name = L['groupLootMonitor'],
            type = 'group',
            order = 4,
            childGroups = 'tab',
            args = {
                toggleEnableLootMonitor = {
                    name = L['toggleEnableLootMonitorName'],
                    desc = L['toggleEnableLootMonitorDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 2
                },
                buttonTestLootMonitor = {
                    name = L['buttonTestLootMonitor'],
                    type = 'execute',
                    -- width = 'double',
                    order = 3,
                    func = function()
                        HotLoot:TestLootMonitor()
                    end
                },
                buttonResetLootMonitor = {
                    name = L['buttonResetLootMonitorName'],
                    desc = L['buttonResetLootMonitorDesc'],
                    type = 'execute',
                    -- width = 'double',
                    order = 4,
                    func = function()
                        HotLoot.Anchor:ClearAllPoints()
                        HotLoot.Anchor:SetPoint('CENTER', 0, 0)
                        Options.db.profile.anchorPosition.x = anchor:GetLeft()
                        Options.db.profile.anchorPosition.y = anchor:GetBottom()
                        Util:Announce(L['AnchorReset'])
                    end
                },
                groupLootMonitorGeneral = {
                    name = L['genGeneral'],
                    type = 'group',
                    order = 4,
                    args = {
                        toggleShowLootMonitorAnchor = {
                            name = L['toggleShowLootMonitorAnchorName'],
                            desc = L['toggleShowLootMonitorAnchorDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 2,
                            set = 'SetShowLootMonitorAnchor'
                        },
                    }
                },
                groupLootMonitorAppearance = {
                    name = L['genAppearance'],
                    type = 'group',
                    order = 5,
                    args = {
                        -------
                        -- NEW
                        -------
                        --
                        -- GENERAL
                        --
                        headerLootMonitorAppearance = {
                            name = L['genGeneral'],
                            type = 'header',
                            order = 1
                        },
                        selectGrowthDirection = {
                            name = L['selectGrowthDirectionName'],
                            desc = L['selectGrowthDirectionDesc'],
                            type = 'select',
                            values = tableDirectionVertical,
                            order = 2
                        },
                        selectThemeSize = {
                            name = L['selectThemeSizeName'],
                            desc = L['selectThemeSizeDesc'],
                            type = 'select',
                            values = tableThemeSize,
                            order = 3
                        },
                        rangeTransparency = {
                            name = L['genTransparency'],
                            desc = L['rangeTransparencyDesc'],
                            type = 'range',
                            min = 0,
                            max = 1,
                            step = 0.1,
                            bigStep = 0.1,
                            order = 4
                        },
                        rangeToastPadding = {
                            name = L['rangeToastPaddingName'],
                            desc = L['rangeToastPaddingDesc'],
                            type = 'range',
                            min = 1,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            order = 5
                        },
                        inputMinWidth = {
                            name = L['inputMinWidthName'],
                            desc = L['inputMinWidthDesc'],
                            type = 'input',
                            order = 6
                        },
                        --
                        -- TEXTURES
                        --
                        headerLootMonitorTexture = {
                            name = L['genTexture'],
                            type = 'header',
                            order = 7
                        },
                        selectThemeBackground = {
                            name = L['genBackground'],
                            desc = L['selectThemeBackgroundDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Background',
                            values = AceGUIWidgetLSMlists.background,
                            width = 'double',
                            order = 8
                        },
                        selectThemeBorder = {
                            name = L['genBorder'],
                            desc = L['selectThemeBorderDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Border',
                            values = AceGUIWidgetLSMlists.border,
                            width = 'double',
                            order = 9
                        },
                        colorThemeBackground = {
                            name = L['colorThemeBGName'],
                            --desc = L['ThemeSelDesc'],
                            type = 'color',
                            hasAlpha = true,
                            order = 10,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        colorThemeBorder = {
                            name = L['colorThemeBorderName'],
                            --desc = L['ThemeSelDesc'],
                            type = 'color',
                            hasAlpha = true,
                            order = 11,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        toggleColorByQuality = {
                            name = L['toggleColorByQualityName'],
                            desc = L['toggleColorByQualityDesc'],
                            type = 'toggle',
                            order = 12
                        },
                        toggleThemeBackgroundTile = {
                            name = L['toggleThemeBackgroundTileName'],
                            desc = L['toggleThemeBackgroundTileDesc'],
                            type = 'toggle',
                            order = 13
                        },
                        rangeThemeBackgroundTileSize = {
                            name = L['rangeThemeBackgroundTileSizeName'],
                            desc = L['rangeThemeBackgroundTileSizeDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 14
                        },
                        rangeThemeBorderEdgeSize = {
                            name = L['rangeThemeBorderEdgeSizeName'],
                            desc = L['rangeThemeBorderEdgeSizeDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 15
                        },
                        rangeThemeBorderInset = {
                            name = L['rangeThemeBorderInsetName'],
                            desc = L['rangeThemeBorderInsetDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 16
                        },
                        --
                        -- ICON
                        --
                        headerLootMonitorIcon = {
                            name = L['genIcon'],
                            type = 'header',
                            order = 17
                        },
                        rangeIconSize = {
                            name = L['rangeIconSizeName'],
                            desc = L['rangeIconSizeDesc'],
                            type = 'range',
                            min = 16,
                            max = 32,
                            step = 4,
                            bigStep = 4,
                            disabled = function()
                                return Options.db.profile.selectThemeSize == 1
                            end,
                            order = 18
                        },
                        --
                        -- ANIMATION AND FADING
                        --
                        headerLootMonitorAnimation = {
                            name = L['genAnimation'],
                            type = 'header',
                            order = 19
                        },
                        -- NOTE: Changed from rangeInitialDelay
                        rangeDisplayTime = {
                            name = L['rangeDisplayTimeName'],
                            desc = L['rangeDisplayTimeDesc'],
                            type = 'range',
                            min = 1,
                            max = 10,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 20
                        },
                        -- NOTE: Changed from rangeSecondaryDelay
                        rangeMultipleDelay = {
                            name = L['rangeMultipleDelayName'],
                            desc = L['rangeMultipleDelayDesc'],
                            type = 'range',
                            min = 0.5,
                            max = 5,
                            step = 0.5,
                            bigStep = 0.5,
                            --width = 'half',
                            -- hidden = 'Advanced',
                            order = 21
                        },
                        rangeFadeSpeed = {
                            name = L['rangeFadeSpeedName'],
                            desc = L['rangeFadeSpeedDesc'],
                            type = 'range',
                            min = 5,
                            max = 15,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 22
                        },
                        toggleShowAnimation = {
                            name = L['toggleShowAnimationName'],
                            desc = L['toggleShowAnimationDesc'],
                            type = 'toggle',
                            order = 23
                        },
                        -- • • • • •
                        rangeToastScale = {
                            name = L['rangeToastScaleName'],
                            desc = L['rangeToastScaleDesc'],
                            type = 'range',
                            min = -1,
                            max = 1,
                            step = 0.1,
                            bigStep = 0.1,
                            hidden = true,
                            order = 60
                        },




                    }
                },
                --
                -- TEXT
                --
                groupLootMonitorText = {
                    name = L['genText'],
                    type = 'group',
                    order = 6,
                    args = {
                        --
                        -- GENERAL
                        --
                        toggleFontColorByQual = {
                            name = L['toggleFontColorByQualName'],
                            desc = L['toggleFontColorByQualDesc'],
                            type = 'toggle',
                            order = 1
                        },
                        selectTextSide = {
                            name = L['selectTextSideName'],
                            desc = L['selectTextSideDesc'],
                            type = 'select',
                            values = tableDirectionHorizontal,
                            order = 2
                        },
                        --
                        -- NAME
                        --
                        headerNameText = {
                            name = L['headerNameText'],
                            type = 'header',
                            order = 3
                        },
                        selectNameTextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 4
                        },
                        rangeNameTextSize = {
                            name = L['rangeFontSizeName'],
                            desc = L['rangeFontSizeDesc'],
                            type = 'range',
                            min = 6,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 5
                        },
                        --[[colorNameTextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 6,
                            set = 'SetColor',
                            get = 'GetColor'
                        },]]
                        --[[rangeNameTextXOffset = {
                            name = L['genXOffset'],
                            -- desc = L['genXOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 7
                        },
                        rangeNameTextYOffset = {
                            name = L['genYOffset'],
                            -- desc = L['genYOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 8
                        },]]
                        --
                        -- QUANTITY
                        --
                        headerQuantText = {
                            name = L['headerQuantText'],
                            type = 'header',
                            order = 9,
                        },
                        -- TODO: Consider changing the name for this and the other lines from 'Enable' to 'Show' (or 'Hide'?)
                        toggleShowItemQuant = {
                            name = L['genEnable'], -- Used to be toggleShowItemQuantName
                            desc = L['toggleShowItemQuantDesc'],
                            type = 'toggle',
                            -- width = 'double',
                            order = 10
                        },
                        toggleShowTotalQuant = {
                            name = L['toggleShowTotalQuantName'],
                            desc = L['toggleShowTotalQuantDesc'],
                            type = 'toggle',
                            -- width = 'double',
                            order = 11
                        },
                        selectQuantTextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 12
                        },
                        rangeQuantTextSize = {
                            name = L['rangeFontSizeName'],
                            desc = L['rangeFontSizeDesc'],
                            type = 'range',
                            min = 6,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 13
                        },
                        colorQuantTextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 14,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        --[[rangeQuantTextXOffset = {
                            name = L['genXOffset'],
                            -- desc = L['genXOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 15
                        },
                        rangeQuantTextYOffset = {
                            name = L['genYOffset'],
                            -- desc = L['genYOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 16
                        },]]
                        --
                        -- LINE 1
                        --
                        headerLine1Text = {
                            name = L['headerLine1Text'],
                            type = 'header',
                            order = 17,
                        },
                        toggleShowItemType = {
                            name = L['genEnable'], -- Used to be toggleShowItemTypeName
                            desc = L['toggleShowItemTypeDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 18
                        },
                        selectLine1TextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 19
                        },
                        rangeLine1TextSize = {
                            name = L['rangeFontSizeName'],
                            desc = L['rangeFontSizeDesc'],
                            type = 'range',
                            min = 6,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 20
                        },
                        colorLine1TextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 21,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        --[[rangeLine1TextXOffset = {
                            name = L['genXOffset'],
                            -- desc = L['genXOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 22
                        },
                        rangeLine1TextYOffset = {
                            name = L['genYOffset'],
                            -- desc = L['genYOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 23
                        },]]
                        --
                        -- LINE 2
                        --
                        headerLine2Text = {
                            name = L['headerLine2Text'],
                            type = 'header',
                            order = 24,
                        },
                        toggleShowSellPrice = {
                            name = L['genEnable'], -- Used to be toggleShowSellPriceName
                            desc = L['toggleShowSellPriceDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 25
                        },
                        selectLine2TextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 26
                        },
                        rangeLine2TextSize = {
                            name = L['rangeFontSizeName'],
                            desc = L['rangeFontSizeDesc'],
                            type = 'range',
                            min = 6,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            -- hidden = 'Advanced',
                            order = 27
                        },
                        colorLine2TextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 28,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        groupTSMValue = {
                            name = L['groupTSMValue'],
                            type = 'group',
                            order = 29,
                            inline = true,
                            args = {
                                toggleShowTSMValue = {
                                    name = L['toggleShowTSMValueName'],
                                    desc = L['toggleShowTSMValueDesc'],
                                    type = 'toggle',
                                    width = 'full',
                                    order = 1
                                },
                                toggleShowValuePrefix = {
                                    name = L['toggleShowValuePrefixName'],
                                    desc = L['toggleShowValuePrefixDesc'],
                                    type = 'toggle',
                                    order = 2
                                },
                                inputValueTSMSource = {
                                    name = L['inputValueTSMSourceName'],
                                    desc = L['inputValueTSMSourceDesc'],
                                    type = 'input',
                                    order = 3
                                },
                            }
                        },
                        --[[rangeLine2TextXOffset = {
                            name = L['genXOffset'],
                            -- desc = L['genXOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 29
                        },
                        rangeLine2TextYOffset = {
                            name = L['genYOffset'],
                            -- desc = L['genYOffset'],
                            type = 'range',
                            min = -30,
                            max = 30,
                            step = 1,
                            bigStep = 1,
                            hidden = true,
                            order = 30
                        },]]
                    }
                }
            }
        },
        groupLootFilters = {
            name = L['groupLootFilters'],
            type = 'group',
            order = 5,
            args = {
                groupGeneral = {
                    name = L['genGeneral'],
                    type = 'group',
                    order = 1,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersGeneral = {
                            name = L['buttonEnableAll'],
                            type = 'execute',
                            order = 1,
                            func = function()
                                Options:Set('toggleGoldFilter',       true)
                                Options:Set('toggleCurrencyFilter',   true)
                                Options:Set('toggleQuestFilter',      true)
                                Options:Set('toggleJunkFilter',       true)
                                Options:Set('togglePickpocketFilter', true)
                            end
                        },
                        buttonDisableAllFiltersGeneral = {
                            name = L['buttonDisableAll'],
                            type = 'execute',
                            order = 2,
                            func = function()
                                Options:Set('toggleGoldFilter',       false)
                                Options:Set('toggleCurrencyFilter',   false)
                                Options:Set('toggleQuestFilter',      false)
                                Options:Set('toggleJunkFilter',       false)
                                Options:Set('togglePickpocketFilter', false)
                            end
                        },
                        toggleGoldFilter = {
                            name = L['toggleGoldFilterName'],
                            desc = L['toggleGoldFilterDesc'],
                            type = 'toggle',
                            order = 3
                        },
                        toggleCurrencyFilter = {
                            name = L['toggleCurrencyFilterName'],
                            desc = L['toggleCurrencyFilterDesc'],
                            type = 'toggle',
                            order = 4
                        },
                        toggleQuestFilter = {
                            name = L['toggleQuestFilterName'],
                            desc = L['toggleQuestFilterDesc'],
                            type = 'toggle',
                            order = 5
                        },
                        togglePickpocketFilter = {
                            name = L['togglePickpocketFilterName'],
                            desc = L['togglePickpocketFilterName'],
                            type = 'toggle',
                            order = 7
                        }
                    }
                },
                groupProfessions = {
                    name = L['groupProfessions'],
                    type = 'group',
                    order = 2,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersProfessions = {
                            name = L['buttonEnableAll'],
                            type = 'execute',
                            order = 1,
                            func = function()
                                Options:Set('toggleClothFilter',      true)
                                Options:Set('toggleMiningFilter',     true)
                                Options:Set('toggleGemFilter',        true)
                                Options:Set('toggleHerbFilter',       true)
                                Options:Set('toggleLeatherFilter',    true)
                                Options:Set('toggleFishingFilter',    true)
                                Options:Set('toggleEnchantingFilter', true)
                                Options:Set('togglePigmentsFilter',   true)
                                Options:Set('toggleCookingFilter',    true)
                                Options:Set('toggleRecipeFilter',     true)
                            end
                        },
                        buttonDisableAllFiltersProfessions = {
                            name = L['buttonDisableAll'],
                            type = 'execute',
                            order = 2,
                            func = function()
                                Options:Set('toggleClothFilter',      false)
                                Options:Set('toggleMiningFilter',     false)
                                Options:Set('toggleGemFilter',        false)
                                Options:Set('toggleHerbFilter',       false)
                                Options:Set('toggleLeatherFilter',    false)
                                Options:Set('toggleFishingFilter',    false)
                                Options:Set('toggleEnchantingFilter', false)
                                Options:Set('togglePigmentsFilter',   false)
                                Options:Set('toggleCookingFilter',    false)
                                Options:Set('toggleRecipeFilter',     false)
                            end
                        },
                        toggleClothFilter = {
                            -- name = L['toggleClothFilterName'],
                            -- desc = L['toggleClothFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.CLOTH)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.CLOTH)),
                            type = 'toggle',
                            order = 3
                        },
                        toggleMiningFilter = {
                            -- name = L['toggleMiningFilterName'],
                            -- desc = L['toggleMiningFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.METAL_STONE)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.METAL_STONE)),
                            type = 'toggle',
                            order = 4
                        },
                        toggleGemFilter = {
                            -- name = L['toggleGemFilterName'],
                            -- desc = L['toggleGemFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.JEWELCRAFTING)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.JEWELCRAFTING)),
                            type = 'toggle',
                            order = 5
                        },
                        toggleHerbFilter = {
                            -- name = L['toggleHerbFilterName'],
                            -- desc = L['toggleHerbFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.HERB)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.HERB)),
                            type = 'toggle',
                            order = 6
                        },
                        toggleLeatherFilter = {
                            -- name = L['toggleLeatherFilterName'],
                            -- desc = L['toggleLeatherFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.LEATHER)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.LEATHER)),
                            type = 'toggle',
                            order = 7
                        },
                        toggleFishingFilter = {
                            -- name = L['toggleFishingFilterName'],
                            -- desc = L['toggleFishingFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.RECIPE, HL_ITEM_SUB_CLASS.RECIPE.FISHING)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.RECIPE, HL_ITEM_SUB_CLASS.RECIPE.FISHING)),
                            type = 'toggle',
                            order = 8
                        },
                        toggleEnchantingFilter = {
                            -- name = L['toggleEnchantingFilterName'],
                            -- desc = L['toggleEnchantingFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ENCHANTING)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ENCHANTING)),
                            type = 'toggle',
                            order = 9
                        },
                        togglePigmentsFilter = {
                            -- name = L['togglePigmentsFilterName']..Util:ColorText(' (experimental)', 'warning'),
                            -- desc = L['togglePigmentsFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.INSCRIPTION)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.INSCRIPTION)),
                            type = 'toggle',
                            order = 10
                        },
                        toggleCookingFilter = {
                            -- name = L['toggleCookingFilterName'],
                            -- desc = L['toggleCookingFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.COOKING)),
                            desc = L['FilterDescTemplate']:format(GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.COOKING)),
                            type = 'toggle',
                            width = 'full',
                            order = 11
                        },
                        toggleRecipeFilter = {
                            -- name = L['toggleRecipeFilterName'],
                            -- desc = L['toggleRecipeFilterDesc'],
                            name = L['FilterNameTemplate']:format(GetItemClassInfo(HL_ITEM_CLASS.RECIPE)),
                            desc = L['FilterDescTemplate']:format(GetItemClassInfo(HL_ITEM_CLASS.RECIPE)),
                            type = 'toggle',
                            order = 12
                        }
                    }
                },
                groupCommonDrops = {
                    name = L['groupCommonDrops'],
                    type = 'group',
                    order = 3,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersCommon = {
                            name = L['buttonEnableAll'],
                            type = 'execute',
                            order = 1,
                            func = function()
                                Options:Set('togglePotionFilter',    true)
                                Options:Set('toggleFlaskFilter',     true)
                                Options:Set('toggleElixirFilter',    true)
                                Options:Set('toggleElementalFilter', true)
                            end
                        },
                        buttonDisableAllFiltersCommon = {
                            name = L['buttonDisableAll'],
                            type = 'execute',
                            order = 2,
                            func = function()
                                Options:Set('togglePotionFilter',    false)
                                Options:Set('toggleFlaskFilter',     false)
                                Options:Set('toggleElixirFilter',    false)
                                Options:Set('toggleElementalFilter', false)
                            end
                        },
                        togglePotionFilter = {
                            name = L['togglePotionFilterName'],
                            desc = L['togglePotionFilterDesc'],
                            type = 'toggle',
                            order = 3
                        },
                        selectPotionType = {
                            name = L['selectPotionTypeName'],
                            desc = L['selectPotionTypeDesc'],
                            type = 'select',
                            values = tablePotionType,
                            order = 4
                        },
                        toggleFlaskFilter = {
                            name = L['toggleFlaskFilterName'],
                            desc = L['toggleFlaskFilterDesc'],
                            type = 'toggle',
                            order = 5
                        },
                        toggleElixirFilter = {
                            name = L['toggleElixirFilterName'],
                            desc = L['toggleElixirFilterDesc'],
                            type = 'toggle',
                            order = 6
                        },
                        toggleElementalFilter = {
                            name = L['toggleElementalFilterName'],
                            desc = L['toggleElementalFilterDesc'],
                            type = 'toggle',
                            order = 7
                        }
                    }
                },
                -- TODO: Localize these!
                groupLegion = {
                    name = 'Legion',
                    type = 'group',
                    order = 4,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersLegion = {
                            name = L['buttonEnableAll'],
                            type = 'execute',
                            order = 1,
                            func = function()
                                Options:Set('toggleAugmentRuneFilter', true)
                                Options:Set('toggleKnowledgeScrollFilter', true)
                                Options:Set('toggleSentinaxBeaconFilter', true)
                            end
                        },
                        buttonDisableAllFiltersLegion = {
                            name = L['buttonDisableAll'],
                            type = 'execute',
                            order = 2,
                            func = function()
                                Options:Set('toggleAugmentRuneFilter', false)
                                Options:Set('toggleKnowledgeScrollFilter', false)
                                Options:Set('toggleSentinaxBeaconFilter', false)
                            end
                        },
                        toggleAugmentRuneFilter = {
                            name = L['toggleAugmentRuneFilterName'],
                            desc = L['toggleAugmentRuneFilterDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 3
                        },
                        toggleKnowledgeScrollFilter = {
                            name = L['toggleKnowledgeScrollFilterName'],
                            desc = L['toggleKnowledgeScrollFilterDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 4
                        },
                        toggleSentinaxBeaconFilter = {
                            name = L['toggleSentinaxBeaconFilterName'],
                            desc = L['toggleSentinaxBeaconFilterDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 5
                        },
                    }
                },
            }
        },
        groupItemQualityFilters = {
            name = L['groupItemQualityFilters'],
            type = 'group',
            order = 6,
            args = {
                descItemQualityFilters = {
                    name = L['descItemQualityFilters']..'\n',
                    type = 'description',
                    order = 0,
                },
                buttonEnableAllFiltersQuality = {
                    name = L['buttonEnableAll'],
                    type = 'execute',
                    order = 1,
                    func = function()
                        Options:Set('togglePoorQualityFilter',      true)
                        Options:Set('toggleCommonQualityFilter',    true)
                        Options:Set('toggleUncommonQualityFilter',  true)
                        Options:Set('toggleRareQualityFilter',      true)
                        Options:Set('toggleEpicQualityFilter',      true)
                        Options:Set('toggleLegendaryQualityFilter', true)
                        Options:Set('toggleArtifactQualityFilter',  true)
                        Options:Set('toggleHeirloomQualityFilter',  true)
                    end
                },
                buttonDisableAllFiltersQuality = {
                    name = L['buttonDisableAll'],
                    type = 'execute',
                    order = 2,
                    func = function()
                        Options:Set('togglePoorQualityFilter',      false)
                        Options:Set('toggleCommonQualityFilter',    false)
                        Options:Set('toggleUncommonQualityFilter',  false)
                        Options:Set('toggleRareQualityFilter',      false)
                        Options:Set('toggleEpicQualityFilter',      false)
                        Options:Set('toggleLegendaryQualityFilter', false)
                        Options:Set('toggleArtifactQualityFilter',  false)
                        Options:Set('toggleHeirloomQualityFilter',  false)
                    end
                },
                togglePoorQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 3,
                },
                toggleSellPoorItems = {
                    name = L['toggleSellPoorItemsName'],
                    desc = L['toggleSellPoorItemsDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 4,
                },
                toggleCommonQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 6,
                },
                toggleUncommonQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r'),
                    type = 'toggle',
                    order = 8,
                    width = 'full',
                },
                toggleRareQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 10,
                },
                toggleEpicQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 12,
                },
                toggleLegendaryQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 14,
                },
                toggleArtifactQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 16,
                },
                toggleHeirloomQualityFilter = {
                    name = L['toggleItemQualityFilterName']:format(ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r'),
                    desc = L['toggleItemQualityFilterDesc']:format(ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r'),
                    type = 'toggle',
                    width = 'full',
                    order = 18,
                },
                inputMinItemLevel = {
                    name = L['inputMinItemLevelName'],
                    desc = L['inputMinItemLevelDesc'],
                    type = 'input',
                    -- pattern = '%d+',
                    order = 19,
                    set = function(info, value)
                        if value == '' or not tonumber(value) then
                            Options.db.profile.inputMinItemLevel = 0;
                            Util:Debug('inputMinItemLevel not set (defaulting to 0)');
                        else
                            Options.db.profile.inputMinItemLevel = value;
                            Util:DebugOption('inputMinItemLevel', value);
                        end
                    end
                },
            },
        },
        groupIncludeExclude = {
            name = L['groupIncludeExclude'],
            type = 'group',
            order = 7,
            args = {
                headerIncludeList = {
                    name = L['headerIncludeList'],
                    type = 'header',
                    order = 1,
                },
                selectIncludeList = {
                    name = L['selectIncludeListName'],
                    type = 'select',
                    values = 'GetIncludeList',
                    order = 2,
                },
                inputIncludeListAdd = {
                    name = L['inputIncludeListAddName'],
                    desc = L['inputIncludeListAddDesc'],
                    type = 'input',
                    order = 3,
                    set = 'AddToIncludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromIncludeList = {
                    name = L['buttonRemoveFromIncludeListName'],
                    type = 'execute',
                    order = 4,
                    func = 'RemoveFromIncludeList'
                },
                toggleShowIncludeButton = {
                    name = L['toggleShowIncludeButtonName'],
                    desc = L['toggleShowIncludeButtonDesc'],
                    type = 'toggle',
                    hidden = true,
                    order = 5,
                },
                headerExcludeList = {
                    name = L['headerExcludeList'],
                    type = 'header',
                    order = 6,
                },
                selectExcludeList = {
                    name = L['selectExcludeListName'],
                    type = 'select',
                    values = 'GetExcludeList',
                    order = 7,
                },
                inputExcludeListAdd = {
                    name = L['inputExcludeListAddName'],
                    desc = L['inputExcludeListAddDesc'],
                    --multiline = 10,
                    type = 'input',
                    --width = 'full',
                    order = 8,
                    set = 'AddToExcludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromExcludeList = {
                    name = L['buttonRemoveFromExcludeListName'],
                    type = 'execute',
                    order = 9,
                    func = 'RemoveFromExcludeList'
                },
                toggleShowExcludeButton = {
                    name = L['toggleShowExcludeButtonName'],
                    desc = L['toggleShowExcludeButtonDesc'],
                    type = 'toggle',
                    hidden = true,
                    order = 10,
                },
            },
        },
        groupValueThresholds = {
            name = L['groupValueThresholds'],
            type = 'group',
            order = 8,
            args = {
                descValueThresholds = {
                    name = Util:ColorText(L['descValueThresholds'], 'info')..'\n',
                    type = 'description',
                    order = 0
                },
                groupThreshold1 = {
                    name = L['groupThreshold1'],
                    type = 'group',
                    order = 1,
                    inline = true,
                    args = {
                        selectThresholdType1 = {
                            name = L['selectThresholdTypeName'],
                            desc = L['selectThresholdTypeDesc'],
                            type = 'select',
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue1 = {
                            name = L['inputThresholdValueName'],
                            type = 'input',
                            -- pattern = '(%d*)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?',
                            -- pattern = '^(?:%d+g[ ]*)?(?:[0-9]?[0-9]s[ ]*)?(?:[0-9]?[0-9]c)?$',
                            -- usage = L['inputThresholdValueDesc'],
                            set = 'SetMoney',
                            get = 'GetMoney',
                            order = 2
                        },
                    },
                },
                groupThreshold2 = {
                    name = L['groupThreshold2'],
                    type = 'group',
                    order = 2,
                    inline = true,
                    args = {
                        selectThresholdType2 = {
                            name = L['selectThresholdTypeName'],
                            desc = L['selectThresholdTypeDesc'],
                            type = 'select',
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue2 = {
                            name = L['inputThresholdValueName'],
                            type = 'input',
                            -- pattern = '(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]',
                            -- usage = L['inputThresholdValueDesc'],
                            set = 'SetMoney',
                            get = 'GetMoney',
                            order = 2
                        },
                    },
                },
                groupThreshold3 = {
                    name = L['groupThreshold3'],
                    type = 'group',
                    order = 3,
                    inline = true,
                    args = {
                        selectThresholdType3 = {
                            name = L['selectThresholdTypeName'],
                            desc = L['selectThresholdTypeDesc'],
                            type = 'select',
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue3 = {
                            name = L['inputThresholdValueName'],
                            type = 'input',
                            -- pattern = '(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]',
                            -- usage = L['inputThresholdValueDesc'],
                            set = 'SetMoney',
                            get = 'GetMoney',
                            order = 2
                        },
                    },
                },
                toggleUseQuantValue = {
                    name = L['toggleUseQuantValueName'],
                    desc = L['toggleUseQuantValueDesc'],
                    type = 'toggle',
                    -- hidden = 'Advanced',
                    order = 4
                },
            },
        },
        groupLootFrame = {
                            -- TODO: Localize
            name = 'Loot Frame',
            type = 'group',
            hidden = true,
            order = 9,
            args = {
                toggleLootFrameEnable = {
                            -- TODO: Localize
                    name = L['genEnable'],
                    desc = 'Enables the '..Util:ColorText('HotLoot', 'addon')..' Loot Frame.',
                    type = 'toggle',
                    order = 1
                },
            }
        },
    },
}

--
-- ─── TRANSFER SETTINGS ──────────────────────────────────────────────────────────
--

-- local function TransferOldSetting(oldKey, newKey)
--     if Options.db.profile[oldKey] ~= nil then
--         Options.db.profile[newKey] = Options.db.profile[oldKey];
--         Options.db.profile[oldKey] = nil;
--     end
-- end

-- local function TransferAllSettings()
--     Util:Announce('Settings have changed and need to be transferred.\n This should only happen once.');
--     Util:Announce('Transfering old settings now...');

--     Util:Announce('Settings transfer complete!');
-- end

function Options:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('HotLootDB', defaults)

    self.db:RegisterDefaults(defaults)
    HotLoot.options = self.db.profile

    -- Create Profiles section
    optionsTable.args.profile = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
    optionsTable.args.profile.order = 200

    -- Create About section
    optionsTable.args.about = LibStub('LibAboutPanel-2.0'):AboutOptionsTable('HotLoot')
    optionsTable.args.about.order = 201

    -- Create Options
    LibStub('AceConfig-3.0'):RegisterOptionsTable('HotLoot', optionsTable)
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

    LibStub('AceConfigDialog-3.0'):SetDefaultSize('HotLoot', 700, 650)

    -- Transfer
    -- if self.db.profile.bOldSettingsTransferred ~= true then
    --     TransferAllSettings()
    --     self.db.profile.bOldSettingsTransferred = true
    -- end

    tableChatWindows = GetChatWindows()
end
