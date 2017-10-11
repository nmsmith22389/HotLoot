local Options = HotLoot:NewModule('Options')
local module = Options -- Alias
local L = LibStub('AceLocale-3.0'):GetLocale('HotLoot')
local Util = HotLoot:GetModule('Util')

-- TODO: Consider moving smart info and TSM options to Loot Monitor Appearance > General or even some place better
--       (The text options section should prob just be for actual text appearance.)

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
    ['Cloth'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.CLOTH),
    ['Metal & Stone'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.METAL_STONE),
    ['Gem'] = GetItemClassInfo(HL_ITEM_CLASS.GEM),
    ['Herb'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.HERB),
    ['Leather'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.LEATHER),
    ['Enchanting'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ENCHANTING),
    ['Inscription'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.INSCRIPTION),
    ['Cooking Ingredient'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.COOKING),
    ['Potion'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.POTION),
    ['Flask'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.FLASK),
    ['Elixir'] = GetItemSubClassInfo(HL_ITEM_CLASS.CONSUMABLE, HL_ITEM_SUB_CLASS.CONSUMABLE.ELIXIR),
    ['Elemental'] = GetItemSubClassInfo(HL_ITEM_CLASS.TRADESKILL, HL_ITEM_SUB_CLASS.TRADESKILL.ELEMENTAL),
    ['z1Poor'] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r',
    ['z2Common'] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r',
    ['z3Uncommon'] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r',
    ['z4Rare'] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r',
    ['z5Epic'] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r',
    ['z6Legendary'] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r',
    ['z7Artifact'] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r',
    ['z8Heirloom'] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r',
    ['z9Include'] = L['headerIncludeList'],
}

local tableItemQuality = {
    ['0'] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r',
    ['1'] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r',
    ['2'] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r',
    ['3'] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r',
    ['4'] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r',
    ['5'] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r',
    ['6'] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r',
    ['7'] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r',
}

local tableFontOutline = {
    ["NONE"] = NONE,
    ["OUTLINE"] = "OUTLINE",
    ["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
    ["THICKOUTLINE"] = "THICKOUTLINE"
}

-- TODO: Localize
local tableFarmingModeRate = {
    ['second'] = 'Per Second',
    ['hour']   = 'Per Hour',
    ['minute'] = 'Per Minute',
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
        --
        -- ─── INTERNAL ────────────────────────────────────────────────────
        --

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

        --
        -- ─── GENERAL ─────────────────────────────────────────────────────
        --

        toggleSystemEnable            = true,
        toggleDisableInRaid           = true,
        toggleDebugMode               = false,
        toggleAnnounceEvents          = true,
        selectAnnounceWindow          = GetDefaultChatWindow(),
        toggleAnnounceBagsFullRaid    = true,
        toggleCloseLootWindow         = false,
        selectCloseLootWindowModifier = '0',
        toggleSkinningMode            = false,
        selectSkinningModeModifier    = '0',
        --
        -- ─── LOOT MONITOR ────────────────────────────────────────────────
        --

        toggleEnableLootMonitor     = true,
        toggleShowLootMonitorAnchor = true,

        toggleFarmingMode = false,
        selectFarmingModeRate = 'hour',

        --== Appearance ==--
        --> General
        selectGrowthDirection = -1,
        selectThemeSize       = 1,
        rangeTransparency     = 1,
        rangeToastPadding     = 8,
        inputMinWidth         = '145',
        rangeToastScale       = 0,

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
        toggleColorByQuality         = true,
        toggleThemeBackgroundTile    = true,
        rangeThemeBackgroundTileSize = 16,
        rangeThemeBorderEdgeSize     = 16,
        rangeThemeBorderInset        = 2,

        --> Icon
        rangeIconSize = 16,

        --> Animation
        toggleShowAnimation = true,
        rangeDisplayTime    = 4,
        rangeMultipleDelay  = 0.5,
        rangeFadeSpeed      = 5,

        --
        -- ─── TEXT ────────────────────────────────────────────────────────
        --
        --** UNUSED **--
        selectTextFont = 'Roboto Condensed Bold',
        rangeFontSize  = 9,
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
        selectNameTextOutline = 'OUTLINE',
        rangeNameTextXOffset = 0,
        rangeNameTextYOffset = 0,

        --> Quantity
        toggleShowItemQuant  = true,
        toggleShowTotalQuant = true,
        selectQuantTextFont  = 'Roboto Condensed Bold',
        rangeQuantTextSize   = 8,
        selectQuantTextOutline = 'OUTLINE',
        colorQuantTextFont   = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 1.0
        },
        rangeQuantTextXOffset = 0,
        rangeQuantTextYOffset = 0,

        --> Line 1
        toggleShowItemType  = true,
        toggleShowItemTypeNoInfo = false,
        selectLine1TextFont = 'Roboto Condensed Bold',
        rangeLine1TextSize  = 10,
        selectLine1TextOutline = 'OUTLINE',
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
        selectLine2TextOutline = 'OUTLINE',
        colorLine2TextFont = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 1.0
        },
        toggleShowTSMValue    = false,
        toggleShowValuePrefix = false,
        inputValueTSMSource   = 'DBMinBuyout',
        rangeLine2TextXOffset = 0,
        rangeLine2TextYOffset = 0,

        --
        -- ─── FILTERS ─────────────────────────────────────────────────────
        --

        tableFilters = {},

        toggleGoldFilter       = true,
        toggleQuestFilter      = true,
        toggleCurrencyFilter   = true,
        toggleJunkFilter       = false,
        togglePickpocketFilter = true,
        toggleClothFilter      = false,
        toggleMiningFilter     = false,
        toggleGemFilter        = false,
        toggleHerbFilter       = false,
        toggleLeatherFilter    = false,
        toggleFishingFilter    = false,
        toggleEnchantingFilter = false,
        togglePigmentsFilter   = false,
        toggleCookingFilter    = false,
        toggleRecipeFilter     = false,
        togglePotionFilter     = false,
        selectPotionType       = 'both',
        toggleFlaskFilter      = false,
        toggleElixirFilter     = false,
        toggleElementalFilter  = false,

        --> Legion Filters
        toggleAPFilter              = true,
        toggleAugmentRuneFilter     = true,
        toggleKnowledgeScrollFilter = true,
        toggleSentinaxBeaconFilter  = true,

        --
        -- ─── QUALITY FILTERS ─────────────────────────────────────────────
        --

        toggleOnlyEquipQuality       = false,
        selectMinEquipQuality        = '2',
        togglePoorQualityFilter      = false,
        toggleSellPoorItems          = false,
        toggleCommonQualityFilter    = false,
        toggleUncommonQualityFilter  = true,
        toggleRareQualityFilter      = true,
        toggleEpicQualityFilter      = true,
        toggleLegendaryQualityFilter = true,
        toggleArtifactQualityFilter  = true,
        toggleHeirloomQualityFilter  = true,
        inputMinItemLevel            = 0,

        -- FIXME: Add defaults for equip only options!

        -- Include List
        tableIncludeList = {},
        toggleShowIncludeButton = false,

        -- Exclude List
        tableExcludeList = {},
        toggleShowExcludeButton = false,

        -- Farming List
        tableFarmingList = {},

        selectThresholdType1 = '0None',
        inputThresholdValue1 = 0,
        selectThresholdType2 = '0None',
        inputThresholdValue2 = 0,
        selectThresholdType3 = '0None',
        inputThresholdValue3 = 0,
        toggleUseQuantValue  = false,
    }
}

--
-- ─── FILTER GENERATOR ───────────────────────────────────────────────────────────
--

-- TODO: Get from dynamic func from HL FILTER TYPE
local tableFilterTypes = {
    [tostring(HL_FILTER_TYPE.TYPE)] = 'Type',
    [tostring(HL_FILTER_TYPE.VALUE)] = 'Value',
    [tostring(HL_FILTER_TYPE.QUALITY)] = 'Quality',
    [tostring(HL_FILTER_TYPE.NAME)] = 'Name',
    [tostring(HL_FILTER_TYPE.ILVL)] = 'Item Level'
}

local tableComparisons = {
    equalTo = 'Equal To',
    lessThan = 'Less Than',
    greaterThan = 'Greater Than'
}

local tableStringComparisons = {
    matches = 'Matches',
    contains = 'Contains'
}

local tableQualities = {
    ['0'] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r',
    ['1'] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r',
    ['2'] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r',
    ['3'] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r',
    ['4'] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r',
    ['5'] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r',
    ['6'] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r',
    ['7'] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r',
}

local function GetItemTypeTable()
    local t = {}
    for k,v in pairs(HL_ITEM_CLASS) do
        t[tostring(v)] = GetItemClassInfo(v)
    end
    return t
end

local function GetItemSubTypeTable(itemType)
    local t = {}
    local classString = nil

    for k,v in pairs(HL_ITEM_CLASS) do
        if tonumber(itemType) == v then
            classString = k
        end
    end

    if classString then
        for k,v in pairs(HL_ITEM_SUB_CLASS[classString]) do
            t[tostring(v)] = GetItemSubClassInfo(HL_ITEM_CLASS[classString], v)
        end
    end

    t.NONE = NONE
    return t
end

function Options:CreateFilter(info, name)
    if not self:Get('tableFilters')[name] then
        self.db.profile.tableFilters[name] = {
            conditions = {},
            enabled = true
        }
    end
end

function Options:GetFilterList()
    local list = {}
    for k,v in pairs(self:Get('tableFilters')) do
        list[k] = k
    end
    return list
end

function Options:AddCondition()
    local conditionTemplate = {
        type = tostring(HL_FILTER_TYPE.TYPE),
        value = tostring(HL_ITEM_CLASS.TRADESKILL),
        subvalue = 'NONE'
    }
    table.insert(self.db.profile.tableFilters[self:Get('selectFilter')].conditions, conditionTemplate)
    Options:ViewFilter(Options:Get('selectFilter'))
end

local function GetConditionArgs(num, condition)
    local args = {}
    local currentFilter = Options:Get('selectFilter')

    Util:Debug('------------------')
    Util:DebugOption('Current Filter', currentFilter)
    Util:DebugOption('num', num)
    Util:DebugOption('type', condition.type)
    Util:DebugOption('value', condition.value)
    Util:DebugOption('subvalue', condition.subvalue)

    args['selectConditionType'..num] = {
        name = 'Filter Type',
        type = 'select',
        values = tableFilterTypes,
        width = 'double',
        order = 1,
        set = function(info, value)
            condition.type = value
            if tonumber(value) == HL_FILTER_TYPE.TYPE then
                condition.value = tostring(HL_ITEM_CLASS.TRADESKILL)
                condition.subvalue = 'NONE'
            elseif tonumber(value) == HL_FILTER_TYPE.VALUE then
                condition.value = 'equalTo'
                condition.subvalue = 0
            elseif tonumber(value) == HL_FILTER_TYPE.QUALITY then
                condition.value = 'equalTo'
                condition.subvalue = '0'
            elseif tonumber(value) == HL_FILTER_TYPE.NAME then
                condition.value = 'matches'
                condition.subvalue = ''
            elseif tonumber(value) == HL_FILTER_TYPE.NAME then
                condition.value = 'equalTo'
                condition.subvalue = 0
            end
            Options:ViewFilter(Options:Get('selectFilter'))
        end,
        get = function(info)
            return condition.type
        end
    }

    args['buttonRemoveCondition'..num] = {
        name = 'Remove Condition',
        type = 'execute',
        order = 10,
        width = 'full',
        func = function()
            table.remove(Options.db.profile.tableFilters[Options:Get('selectFilter')].conditions, num)
            Options:ViewFilter(Options:Get('selectFilter'))
        end
    }

    if condition.type == tostring(HL_FILTER_TYPE.TYPE) then

        -- local containsEnum = false
        -- for enum,subClass in pairs(GetItemSubTypeTable(condition.value)) do
        --     if tonumber(enum) == tonumber(condition.subvalue) then
        --         containsEnum = true
        --     end
        -- end
        -- if not containsEnum then
        --     condition.subvalue = 'NONE'
        -- end

        args['selectConditionValue'..num] = {
            name = 'Item Type',
            type = 'select',
            values = GetItemTypeTable(),
            width = 'double',
            order = 2,
            set = function(info, value)
                condition.value = value
                condition.subvalue = 'NONE'
                Options:ViewFilter(Options:Get('selectFilter'))
        end,
            get = function(info)
                return condition.value
            end
        }
        args['selectConditionSubValue'..num] = {
            name = 'Item Sub Type',
            type = 'select',
            values = GetItemSubTypeTable(condition and condition.value or nil),
            width = 'double',
            order = 3,
            set = function(info, value)
                condition.subvalue = value
            end,
            get = function(info)
                return condition.subvalue
            end
        }
    elseif condition.type == tostring(HL_FILTER_TYPE.VALUE) then
        args['selectConditionValue'..num] = {
            name = 'Comparison',
            type = 'select',
            values = tableComparisons,
            width = 'double',
            order = 2,
            set = function(info, value)
                condition.value = value
            end,
            get = function(info)
                return condition.value
            end
        }
        args['selectConditionSubValue'..num] = {
            name = 'Value',
            type = 'input',
            order = 3,
            width = 'double',
            set = function(info, value)
                if not value or value:trim() == '' then
                    value = 0
                else
                    value = Util:ToCopper(value)
                end
                condition.subvalue = value
            end,
            get = function(info)
                local value = condition.subvalue
                if not tonumber(value) then
                    value = 0
                end
                return Util:FormatMoney(value, 'SMART', true)
            end
        }
    elseif condition.type == tostring(HL_FILTER_TYPE.QUALITY) then
        args['selectConditionValue'..num] = {
            name = 'Comparison',
            type = 'select',
            values = tableComparisons,
            width = 'double',
            order = 2,
            set = function(info, value)
                condition.value = value
            end,
            get = function(info)
                return condition.value
            end
        }
        args['selectConditionSubValue'..num] = {
            name = 'Item Quality',
            type = 'select',
            values = tableItemQuality,
            width = 'double',
            order = 3,
            set = function(info, value)
                condition.subvalue = value
            end,
            get = function(info)
                return condition.subvalue
            end
        }
    elseif condition.type == tostring(HL_FILTER_TYPE.NAME) then
        args['selectConditionValue'..num] = {
            name = 'Comparison',
            type = 'select',
            values = tableStringComparisons,
            width = 'double',
            order = 2,
            set = function(info, value)
                condition.value = value
            end,
            get = function(info)
                return condition.value
            end
        }
        args['selectConditionSubValue'..num] = {
            name = 'Text',
            type = 'input',
            order = 3,
            width = 'double',
            set = function(info, value)
                condition.subvalue = value
            end,
            get = function(info)
                return condition.subvalue
            end
        }
    elseif condition.type == tostring(HL_FILTER_TYPE.ILVL) then
        args['selectConditionValue'..num] = {
            name = 'Comparison',
            type = 'select',
            values = tableComparisons,
            width = 'double',
            order = 2,
            set = function(info, value)
                condition.value = value
            end,
            get = function(info)
                return condition.value
            end
        }
        args['selectConditionSubValue'..num] = {
            name = 'Item Level',
            type = 'input',
            order = 3,

            width = 'double',
            set = function(info, value)
                if not value or value == '' then
                    condition.subvalue = 0
                else
                    condition.subvalue = tonumber(value)
                end
            end,
            get = function(info)
                return tostring(condition.subvalue)
            end
        }
    end

    return args
end

function Options:ViewFilter(name)
    local opts = {}
    local filter = Options:Get('tableFilters')[name]

    opts.selectFilter = {
        name = 'Current Filter',
        type = 'select',
        values = 'GetFilterList',
        set = function(info, value)
            Options:ViewFilter(value)
            Options:Set(info, value)
        end,
        order = 2
    }
    opts.inputCreateFilter = {
        name = 'Create Filter',
        type = 'input',
        set = 'CreateFilter',
        get = function() return '' end,
        order = 4
    }
    opts.buttonDeleteFilter = {
        name = Util:ColorText('Delete Current Filter', 'alert'),
        type = 'execute',
        confirm = function()
            return ('Are you sure you want to delete \"%s\"?'):format(name);
        end,
        func = function()
            Options.db.profile.tableFilters[name] = nil
            local nextFilter = next(Options:GetFilterList())
            Options:Set('selectFilter', nextFilter)
            Options:ViewFilter(nextFilter)
        end,
        order = 5
    }
    opts.headerFilter = {
        name = name,
        type = 'header',
        order = 6
    }
    opts.buttonAddCondition = {
        name = 'Add Condition',
        type = 'execute',
        order = 1000,
        width = 'full',
        func = 'AddCondition'
    }

    for i,condition in ipairs(filter.conditions) do
        opts['groupCondition'..i] = {
            name = 'Condition '..i,
            type = 'group',
            inline = true,
            order = 10 +  i,
            args = GetConditionArgs(i, condition)
        }
    end

    optionsTable.args.groupLootFilters.args.groupCustomFilters.args = opts
end

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
-- ─── FARMING LIST ───────────────────────────────────────────────────────────────
--

function FormatFarmingType(text)
    text = text:gsub('(%a)', string.upper, 1)
    --[[
        ['z1Poor'] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC..'|r',
        ['z2Common'] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC..'|r',
        ['z3Uncommon'] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC..'|r',
        ['z4Rare'] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC..'|r',
        ['z5Epic'] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC..'|r',
        ['z6Legendary'] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC..'|r',
        ['z7Artifact'] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC..'|r',
        ['z8Heirloom'] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC..'|r',
        ['z9Include'] = L['headerIncludeList'],
    ]]
    if text == "Poor" then
        text = 'z1'..text
    elseif text == "Common" then
        text = 'z2'..text
    elseif text == "Uncommon" then
        text = 'z3'..text
    elseif text == "Rare" then
        text = 'z4'..text
    elseif text == "Epic" then
        text = 'z5'..text
    elseif text == "Legendary" then
        text = 'z6'..text
    elseif text == "Artifact" then
        text = 'z7'..text
    elseif text == "Heirloom" then
        text = 'z8'..text
    elseif text == "Include" then
        text = 'z9'..text
    end

    return text
end

function Options:AddToFarmingList(info, value)
    if type(value) == 'string' and value ~= '' then
        --[[ local reg = '%[(%w+)%:(%w+)%]'
        local cmd, cat = value:match(reg)
        if cmd and cat then
            cmd = cmd:lower()
            cat  = cat:lower()

            if cmd == 'type' then
                local formatted = FormatFarmingType(cat)
                if tableFilterTypes[formatted] and not self.db.profile.tableFarmingList[('type:%s'):format(cat)] then
                    self.db.profile.tableFarmingList[('type:%s'):format(cat)] = Util:ColorText('Type: ', 'success')..cat:gsub('(%a)', string.upper, 1)
                    Util:Announce(string.format(L['AnnounceListAdd'], Util:ColorText(Util:ColorText('Type: ', 'success')..cat:gsub('(%a)', string.upper, 1), 'info'), 'Farming List'))
                else
                    Util:Print(string.format(L['ErrorListItemNotFound'], Util:ColorText(value, 'info'), 'Farming List'))
                end
            end
        else ]]
            local itemName, itemLink = GetItemInfo(value)
            if itemName then
                self.db.profile.tableFarmingList[Util:GetItemID(itemLink)] = itemName
                Util:Announce(string.format(L['AnnounceListAdd'], Util:ColorText(itemName, 'info'), 'Farming List'))
            else
                Util:Print(string.format(L['ErrorListItemNotFound'], Util:ColorText(value, 'info'), 'Farming List'))
            end
        -- end
    end
end

function Options:RemoveFromFarmingList()
    self.db.profile.tableFarmingList[self.db.profile.selectFarmingList] = nil
end

function Options:GetFarmingList()
    return self.db.profile.tableFarmingList
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
            -- childGroups = 'tab',
            args = {
                toggleEnableLootMonitor = {
                    name = L['toggleEnableLootMonitorName'],
                    desc = L['toggleEnableLootMonitorDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 2
                },
                toggleShowLootMonitorAnchor = {
                    name = L['toggleShowLootMonitorAnchorName'],
                    desc = L['toggleShowLootMonitorAnchorDesc'],
                    type = 'toggle',
                    width = 'full',
                    order = 2,
                    set = 'SetShowLootMonitorAnchor'
                },
                spacer = {
                    name = '',
                    type = 'description',
                    width = 'full',
                    order = 4
                },
                groupFarmingMode = {
                    name = L['groupFarmingMode'],
                    type = 'group',
                    inline = true,
                    order = 12,
                    args = {
                        descFarmingMode = {
                            name = Util:ColorText(L['descFarmingMode'], 'info'),
                            type = 'description',
                            width = 'full',
                            order = 2
                        },
                        descListAddWarning = {
                            name = Util:ColorText(L['descListAddWarning'], 'warning'),
                            type = 'description',
                            width = 'full',
                            order = 6
                        },
                        toggleFarmingMode = {
                            name = L['genEnable'],
                            -- desc = L['toggleFarmingMode'],
                            type = 'toggle',
                            width = 'full',
                            order = 7
                        },
                        selectFarmingList = {
                            name = L['selectListName'],
                            type = 'select',
                            values = 'GetFarmingList',
                            order = 8,
                        },
                        inputFarmingListAdd = {
                            name = L['inputListAddName'],
                            desc = L['inputListAddDesc'],
                            type = 'input',
                            order = 10,
                            set = 'AddToFarmingList',
                            get = function(info)
                                return ''
                            end
                        },
                        buttonRemoveFromFarmingList = {
                            name = L['buttonRemoveFromListName'],
                            type = 'execute',
                            order = 12,
                            func = 'RemoveFromFarmingList'
                        },
                        selectFarmingModeRate = {
                            name = L['selectFarmingModeRateName'],
                            desc = L['selectFarmingModeRateDesc'],
                            type = 'select',
                            values = tableFarmingModeRate,
                            order = 14
                        }
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
                        buttonTestLootMonitor = {
                            name = L['buttonTestLootMonitor'],
                            type = 'execute',
                            -- width = 'double',
                            order = 2,
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
                        --
                        -- GENERAL
                        --
                        headerLootMonitorAppearance = {
                            name = L['genGeneral'],
                            type = 'header',
                            order = 6
                        },
                        selectGrowthDirection = {
                            name = L['selectGrowthDirectionName'],
                            desc = L['selectGrowthDirectionDesc'],
                            type = 'select',
                            values = tableDirectionVertical,
                            order = 8
                        },
                        selectThemeSize = {
                            name = L['selectThemeSizeName'],
                            desc = L['selectThemeSizeDesc'],
                            type = 'select',
                            values = tableThemeSize,
                            order = 10
                        },
                        rangeTransparency = {
                            name = L['genTransparency'],
                            desc = L['rangeTransparencyDesc'],
                            type = 'range',
                            min = 0,
                            max = 1,
                            step = 0.1,
                            bigStep = 0.1,
                            order = 12
                        },
                        rangeToastPadding = {
                            name = L['rangeToastPaddingName'],
                            desc = L['rangeToastPaddingDesc'],
                            type = 'range',
                            min = 1,
                            max = 16,
                            step = 1,
                            bigStep = 1,
                            order = 14
                        },
                        inputMinWidth = {
                            name = L['inputMinWidthName'],
                            desc = L['inputMinWidthDesc'],
                            type = 'input',
                            order = 16
                        },
                        --
                        -- TEXTURES
                        --
                        headerLootMonitorTexture = {
                            name = L['genTexture'],
                            type = 'header',
                            order = 18
                        },
                        selectThemeBackground = {
                            name = L['genBackground'],
                            desc = L['selectThemeBackgroundDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Background',
                            values = AceGUIWidgetLSMlists.background,
                            width = 'double',
                            order = 20
                        },
                        selectThemeBorder = {
                            name = L['genBorder'],
                            desc = L['selectThemeBorderDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Border',
                            values = AceGUIWidgetLSMlists.border,
                            width = 'double',
                            order = 22
                        },
                        colorThemeBackground = {
                            name = L['colorThemeBGName'],
                            --desc = L['ThemeSelDesc'],
                            type = 'color',
                            hasAlpha = true,
                            order = 24,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        colorThemeBorder = {
                            name = L['colorThemeBorderName'],
                            --desc = L['ThemeSelDesc'],
                            type = 'color',
                            hasAlpha = true,
                            order = 26,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        toggleColorByQuality = {
                            name = L['toggleColorByQualityName'],
                            desc = L['toggleColorByQualityDesc'],
                            type = 'toggle',
                            order = 28
                        },
                        toggleThemeBackgroundTile = {
                            name = L['toggleThemeBackgroundTileName'],
                            desc = L['toggleThemeBackgroundTileDesc'],
                            type = 'toggle',
                            order = 30
                        },
                        rangeThemeBackgroundTileSize = {
                            name = L['rangeThemeBackgroundTileSizeName'],
                            desc = L['rangeThemeBackgroundTileSizeDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 32
                        },
                        rangeThemeBorderEdgeSize = {
                            name = L['rangeThemeBorderEdgeSizeName'],
                            desc = L['rangeThemeBorderEdgeSizeDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 34
                        },
                        rangeThemeBorderInset = {
                            name = L['rangeThemeBorderInsetName'],
                            desc = L['rangeThemeBorderInsetDesc'],
                            type = 'range',
                            min = 1,
                            max = 32,
                            step = 1,
                            bigStep = 1,
                            order = 36
                        },
                        --
                        -- ICON
                        --
                        headerLootMonitorIcon = {
                            name = L['genIcon'],
                            type = 'header',
                            order = 38
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
                            order = 40
                        },
                        --
                        -- ANIMATION AND FADING
                        --
                        headerLootMonitorAnimation = {
                            name = L['genAnimation'],
                            type = 'header',
                            order = 42
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
                            order = 44
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
                            order = 46
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
                            order = 48
                        },
                        toggleShowAnimation = {
                            name = L['toggleShowAnimationName'],
                            desc = L['toggleShowAnimationDesc'],
                            type = 'toggle',
                            order = 50
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
                            order = 52
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
                        buttonTestLootMonitor = {
                            name = L['buttonTestLootMonitor'],
                            type = 'execute',
                            -- width = 'double',
                            order = 2,
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
                        --
                        -- GENERAL
                        --
                        toggleFontColorByQual = {
                            name = L['toggleFontColorByQualName'],
                            desc = L['toggleFontColorByQualDesc'],
                            type = 'toggle',
                            order = 6
                        },
                        selectTextSide = {
                            name = L['selectTextSideName'],
                            desc = L['selectTextSideDesc'],
                            type = 'select',
                            values = tableDirectionHorizontal,
                            order = 8
                        },
                        --
                        -- NAME
                        --
                        headerNameText = {
                            name = L['headerNameText'],
                            type = 'header',
                            order = 10
                        },
                        selectNameTextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 12
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
                            order = 14
                        },
                        selectNameTextOutline = {
                            name = L['genOutline'],
                            type = 'select',
                            values = tableFontOutline,
                            order = 16
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
                            order = 18,
                        },
                        -- TODO: Consider changing the name for this and the other lines from 'Enable' to 'Show' (or 'Hide'?)
                        toggleShowItemQuant = {
                            name = L['genEnable'], -- Used to be toggleShowItemQuantName
                            desc = L['toggleShowItemQuantDesc'],
                            type = 'toggle',
                            -- width = 'double',
                            order = 20
                        },
                        toggleShowTotalQuant = {
                            name = L['toggleShowTotalQuantName'],
                            desc = L['toggleShowTotalQuantDesc'],
                            type = 'toggle',
                            -- width = 'double',
                            order = 22
                        },
                        selectQuantTextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 24
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
                            order = 26
                        },
                        selectQuantTextOutline = {
                            name = L['genOutline'],
                            type = 'select',
                            values = tableFontOutline,
                            order = 28
                        },
                        colorQuantTextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 30,
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
                            order = 32,
                        },
                        descLine1Text = {
                            name = L['descSmartInfo'],
                            type = 'description',
                            order = 34,
                        },
                        -- TODO: Add toggle to show type when no smart info. (off by default)
                        -- TODO: Change to match Line 1
                        toggleShowItemType = {
                            name = L['genEnable'], -- Used to be toggleShowItemTypeName
                            -- desc = L['toggleShowItemTypeDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 36
                        },
                        toggleShowItemTypeNoInfo = {
                            name = L['toggleShowItemTypeNoInfoName'],
                            desc = L['toggleShowItemTypeNoInfoDesc'],
                            type = 'toggle',
                            -- width = 'double',
                            order = 38
                        },
                        selectLine1TextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 40
                        },
                        selectLine1TextOutline = {
                            name = L['genOutline'],
                            type = 'select',
                            values = tableFontOutline,
                            order = 42
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
                            order = 44
                        },
                        colorLine1TextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 46,
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
                            order = 48,
                        },
                        toggleShowSellPrice = {
                            name = L['genEnable'], -- Used to be toggleShowSellPriceName
                            desc = L['toggleShowSellPriceDesc'],
                            type = 'toggle',
                            width = 'double',
                            order = 50
                        },
                        selectLine2TextFont = {
                            name = L['genFont'],
                            desc = L['selectTextFontDesc'],
                            type = 'select',
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = 'double',
                            order = 52
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
                            order = 54
                        },
                        selectLine2TextOutline = {
                            name = L['genOutline'],
                            type = 'select',
                            values = tableFontOutline,
                            order = 56
                        },
                        colorLine2TextFont = {
                            name = L['colorFontColorName'],
                            desc = L['colorFontColorDesc'],
                            type = 'color',
                            -- hidden = 'Advanced',
                            hasAlpha = true,
                            order = 58,
                            set = 'SetColor',
                            get = 'GetColor'
                        },
                        groupTSMValue = {
                            name = L['groupTSMValue'],
                            type = 'group',
                            order = 60,
                            inline = true,
                            args = {
                                descTSMSource = {
                                    -- FIXME: make sure this slash code is right
                                    name = Util:ColorText(L['inputValueTSMSourceDescNote']:format(Util:ColorText('/tsm source', 'success')), 'info'),
                                    type = 'description',
                                    order = 2,
                                },
                                toggleShowTSMValue = {
                                    name = L['toggleShowTSMValueName'],
                                    desc = L['toggleShowTSMValueDesc'],
                                    type = 'toggle',
                                    width = 'full',
                                    order = 4
                                },
                                toggleShowValuePrefix = {
                                    name = L['toggleShowValuePrefixName'],
                                    desc = L['toggleShowValuePrefixDesc'],
                                    type = 'toggle',
                                    order = 6
                                },
                                inputValueTSMSource = {
                                    name = L['inputValueTSMSourceName'],
                                    desc = L['inputValueTSMSourceDesc'],
                                    type = 'input',
                                    order = 8
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
                groupGeneralFilters = {
                    name = 'General Filters',
                    type = 'group',
                    order = 1,
                    args = {
                        toggleGoldFilter = {
                            name = L['toggleGoldFilterName'],
                            desc = L['toggleGoldFilterDesc'],
                            type = 'toggle',
                            width = 'full',
                            order = 2
                        },
                        toggleCurrencyFilter = {
                            name = L['toggleCurrencyFilterName'],
                            desc = L['toggleCurrencyFilterDesc'],
                            type = 'toggle',
                            width = 'full',
                            order = 4
                        },
                        toggleAPFilter = {
                            name = L['FilterNameTemplate']:format(ARTIFACT_POWER),
                            desc = L['FilterDescTemplate']:format(ARTIFACT_POWER),
                            type = 'toggle',
                            width = 'full',
                            order = 6
                        },
                    }
                },
                groupCustomFilters = {
                    name = 'Custom Filters',
                    type = 'group',
                    order = 2,
                    args = {
                        selectFilter = {
                            name = 'Current Filter',
                            type = 'select',
                            values = 'GetFilterList',
                            set = function(info, value)
                                Options:ViewFilter(value)
                                Options:Set(info, value)
                            end,
                            order = 2
                        },
                        inputCreateFilter = {
                            name = 'Create Filter',
                            type = 'input',
                            set = 'CreateFilter',
                            get = function() return '' end,
                            order = 4
                        }
                    }
                }
            }
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
                descListAddWarning = {
                    name = Util:ColorText(L['descListAddWarning'], 'warning'),
                    type = 'description',
                    width = 'full',
                    order = 2
                },
                selectIncludeList = {
                    name = L['selectListName'],
                    type = 'select',
                    values = 'GetIncludeList',
                    order = 3,
                },
                inputIncludeListAdd = {
                    name = L['inputListAddName'],
                    desc = L['inputListAddDesc'],
                    type = 'input',
                    order = 4,
                    set = 'AddToIncludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromIncludeList = {
                    name = L['buttonRemoveFromListName'],
                    type = 'execute',
                    order = 5,
                    func = 'RemoveFromIncludeList'
                },
                toggleIncludeModifierClick = {
                    name = L['toggleIncludeModifierClickName'],
                    desc = L['toggleIncludeModifierClickDesc'],
                    type = 'toggle',
                    hidden = true,
                    order = 6,
                },
                headerExcludeList = {
                    name = L['headerExcludeList'],
                    type = 'header',
                    order = 7,
                },
                descListAddWarning2 = {
                    name = Util:ColorText(L['descListAddWarning'], 'warning'),
                    type = 'description',
                    width = 'full',
                    order = 8
                },
                selectExcludeList = {
                    name = L['selectListName'],
                    type = 'select',
                    values = 'GetExcludeList',
                    order = 9,
                },
                inputExcludeListAdd = {
                    name = L['inputListAddName'],
                    desc = L['inputListAddDesc'],
                    --multiline = 10,
                    type = 'input',
                    --width = 'full',
                    order = 10,
                    set = 'AddToExcludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromExcludeList = {
                    name = L['buttonRemoveFromListName'],
                    type = 'execute',
                    order = 11,
                    func = 'RemoveFromExcludeList'
                },
                toggleShowExcludeButton = {
                    name = L['toggleShowExcludeButtonName'],
                    desc = L['toggleShowExcludeButtonDesc'],
                    type = 'toggle',
                    hidden = true,
                    order = 12,
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
--         Options.db.profile[newKey] = Options.db.profile[oldKey]
--         Options.db.profile[oldKey] = nil
--     end
-- end

-- local function TransferAllSettings()
--     Util:Announce('Settings have changed and need to be transferred.\n This should only happen once.')
--     Util:Announce('Transfering old settings now...')

--     Util:Announce('Settings transfer complete!')
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

    -- Initialize Loot Filter View
    self:ViewFilter(self:Get('selectFilter'))

    tableChatWindows = GetChatWindows()

    setmetatable(self.db.profile.tableFarmingList, {
        __index = function(t, k)
            return rawget(t, tostring(k))
        end,
        __newindex = function(t, k, v)
            rawset(t, tostring(k), v)
        end
    })
end
