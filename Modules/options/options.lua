local Options = HotLoot:NewModule('Options')
local module = Options -- Alias
local L = LibStub('AceLocale-3.0'):GetLocale('HotLoot')
local Util = HotLoot:GetModule('Util')

--
-- ─── LOCALS ─────────────────────────────────────────────────────────────────────
--

watchListTable = {}

local tableModifierKeys = {
    ["0"] = "None",
    ["ctrl"] = "Control",
    ["shift"] = "Shift",
    ["alt"] = "Alt"
}

local tableDirectionVertical = {
    [1] = L["Up"],
    [-1] = L["Down"]
}

local tableDirectionHorizontal = {
    [0] = L["Right"],
    [1] = L["Left"]
}

local tablePotionType = {
    ["both"] = L["Both"],
    ["healing"] = L["Healing"],
    ["mana"] = L["Mana"],
}

local tableFilterTypes = {
    ["0None"] = L["None"],
    ["Quest"] = L["Quest Items"],
    --["Junk"] = L["Junk"],
    ["Gem"] = L["Gems"],
    ["Metal & Stone"] = L["Metal & Stone"],
    ["Cooking Ingredient"] = L["Cooking Ingredients"],
    ["Herb"] = L["Herbs"],
    ["Leather"] = L["Leather"],
    ["Cloth"] = L["Cloth"],
    ["Elemental"] = L["Elementals"],
    ["Enchanting"] = L["Enchanting"],
    ["Potion"] = L["Potions"],
    ["Flask"] = L["Flasks"],
    ["Elixir"] = L["Elixirs"],
    ["z1Poor"] = ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC.."|r",
    ["z2Common"] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC.."|r",
    ["z3Uncommon"] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC.."|r",
    ["z4Rare"] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC.."|r",
    ["z5Epic"] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC.."|r",
    ["z6Legendary"] = ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC.."|r",
    ["z7Artifact"] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC.."|r",
    ["z8Heirloom"] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC.."|r",
    ["Include"] = L["headerIncludeList"],
}

local tableThemes = {
    -- ['customSmall'] = 'Custom '..Util:ColorText('(Small)', 'info'),
    -- ['customLarge'] = 'Custom '..Util:ColorText('(Large)', 'info'),
    -- ['tooltip']     = 'Tooltip '..Util:ColorText('(Large)', 'info'),
    -- ['paper']       = 'Paper '..Util:ColorText('(Large)', 'info'),
    ['10plain']      = 'Plain',
    ['11metalLarge'] = 'Metal (large)',
    ['12metalSmall'] = 'Metal (small)',
    ['13goldLarge']  = 'Gold (large)',
    ['14goldSmall']  = 'Gold (small)',
    ['15legendary']  = 'Legendary',
    ['16chest']      = 'Chest',
    ['17explorer']   = 'Explorer',
    ['18horde']      = 'Horde',
    ['19alliance']   = 'Alliance',
}

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
        toggleSystemEnable = true,
        toggleDebugMode = false,
        toggleAnnounceEvents = true,
        toggleDisableInRaid = false,
        toggleAdvancedOptions = false,
        toggleCloseLootWindow = false,
        selectCloseLootWindowModifier = "0",
        toggleSkinningMode = false,
        selectSkinningModeModifier = "0", 
        toggleEnableLootMonitor = true,
        toggleShowLootMonitorAnchor = true,
        toggleShowItemQuant = true, 
        toggleShowSellPrice = true,
        toggleShowItemType = true,
        rangeIconSize = 16, 
        rangeTransparency = 1,
        rangeToastScale = 0,
        rangeToastPadding = 8,
        fThemeColorR = 0,
        fThemeColorG = 0,
        fThemeColorB = 0,
        fThemeColorA = 0.82,
        fThemeBorderColorR = 1,
        fThemeBorderColorG = 1,
        fThemeBorderColorB = 1,
        fThemeBorderColorA = 1,
        toggleShowTotalQuant = true,
        selectTheme = "paper",
        selectGrowthDirection = -1, 
        inputMinWidth = "145",
        rangeDisplayTime = 4,
        rangeMultipleDelay = 0.5,
        rangeFadeSpeed = 5,
        toggleColorByQuality = true,
        toggleShowAnimation = true,
        selectTextFont = "Friz Quadrata TT",
        selectTextSide = 0,
        rangeFontSize = 9,
        colorFontColor = {
            ["r"] = 1.0,
            ["g"] = 1.0,
            ["b"] = 1.0,
            ["a"] = 1.0
        },
        toggleFontColorByQual = false,
        toggleGoldFilter = true,
        toggleQuestFilter = true,
        toggleCurrencyFilter = true,
        toggleJunkFilter = false,
        togglePickpocketFilter = true,
        toggleClothFilter = false,
        toggleMiningFilter = false,
        toggleGemFilter = false,
        toggleHerbFilter = false,
        toggleLeatherFilter = false,
        toggleFishingFilter = false,
        toggleEnchantingFilter = false,
        togglePigmentsFilter = false,
        toggleCookingFilter = false,
        toggleRecipeFilter = false,
        togglePotionFilter = false,
        selectPotionType = "both",
        toggleFlaskFilter = false,
        toggleElixirFilter = false,
        toggleElementalFilter = false,
        togglePoorQualityFilter = false,
        toggleSellPoorItems = false,
        toggleCommonQualityFilter = false,
        toggleUncommonQualityFilter = true,
        toggleRareQualityFilter = true,
        toggleEpicQualityFilter = true,
        toggleLegendaryQualityFilter = true,
        toggleArtifactQualityFilter = true,
        toggleHeirloomQualityFilter = true,
        inputMinItemLevel = 0,

        -- Include List
        tableIncludeList = { },
        toggleShowIncludeButton = false,

        -- Exclude List
        tableExcludeList = { },
        toggleShowExcludeButton = false,
        
        selectThresholdType1 = "0None",
        selectThresholdType2 = "0None",
        selectThresholdType3 = "0None",
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

function Options:Advanced()
    return not self:Get('toggleAdvancedOptions')
end

function Options:GetThemeColorDisabled()
    if self:Get('selectTheme'):find("custom") ~= nil then
        return false
    else
        return true
    end
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
    name = "HotLoot",
    handler = Options,
    type = "group",
    childGroups = "tree",
    set = "Set",
    get = "Get",
    args = {
        descHotLoot = {
            name = L["descHotLoot"],           
            type = "description",
            order = 1
        },
        descHotLootNote = {
            name = L["descHotLootNote"],  
            type = "description",
            order = 2
        },
        groupSystem = {
            name = L["groupSystem"],
            type = "group",
            order = 3,
            
            args = {
                toggleSystemEnable = {
                    name = L["genEnable"],
                    desc = L["toggleSystemEnableDesc"],
                    type = "toggle",
                    order = 1
                },
                toggleHideMinimapButton = {
                    name = L["toggleHideMinimapButtonName"],
                    desc = L["toggleHideMinimapButtonDesc"],
                    type = "toggle",
                    order = 2,
                    set = function(info, value)
                        Options.db.profile.minimapIcon.hide = value
                        Util:DebugOption("minimapIcon.hide", value)
                        if value then
                            HotLoot.minimapIcon:Hide("HotLoot")
                        else
                            HotLoot.minimapIcon:Show("HotLoot")
                        end
                    end,
                    get = function(info)
                        return Options.db.profile.minimapIcon.hide
                    end
                },
                toggleAnnounceEvents = {
                    name = L["toggleAnnounceEventsName"],
                    desc = L["toggleAnnounceEventsDesc"],
                    type = "toggle",
                    order = 3
                },
                toggleDisableInRaid = {
                    name = L["toggleDisableInRaidName"],
                    desc = L["toggleDisableInRaidDesc"]..'\n'..Util:ColorText(L["toggleDisableInRaidDescNote"], 'info'),
                    type = "toggle",
                    order = 4
                },
                toggleAdvancedOptions = {
                    name = L["toggleAdvancedOptionsName"],
                    desc = L["toggleAdvancedOptionsDesc"],
                    type = "toggle",
                    order = 5
                },
                toggleDebugMode = {
                    name = L["toggleDebugModegName"],
                    desc = L["toggleDebugModegDesc"],
                    type = "toggle",
                    hidden = 'Advanced',
                    order = 6
                },
                -- TODO: Add Enable/Disable select option to decide which one the mod key does.
                groupCloseLootWindow = {
                    name = L["groupCloseLootWindow"],
                    type = "group",
                    order = 7,
                    inline = true,
                    args = {
                        toggleCloseLootWindow = {
                            name = L["genEnable"],
                            desc = L["toggleCloseLootWindowDesc"],
                            type = "toggle",
                            order = 1
                        },
                        selectCloseLootWindowModifier = {
                            name = L["genModifierKey"],
                            desc = L["selectCloseLootWindowModifierDesc"],
                            type = "select",
                            values = tableModifierKeys,
                            order = 2
                        },
                    },
                },
                -- TODO: Add Enable/Disable select option to decide which one the mod key does.
                groupSkinningMode = {
                    name = L["groupSkinningMode"],
                    type = "group",
                    order = 7,
                    inline = true,
                    args = {
                        toggleSkinningMode = {
                            name = L["genEnable"],
                            desc = L["toggleSkinningModeDesc"],
                            type = "toggle",
                            order = 1,
                            set = function(info, value)
                                if value == true then
                                    GameTooltip:Hide()
                                    LibStub("AceConfigDialog-3.0"):Close("HotLoot")
                                    GameTooltip:Show()
                                    StaticPopup_Show("CONFIRM_SKINNING_MODE")
                                elseif value == "confirmed" then
                                    Options.db.profile.toggleSkinningMode = true
                                    Util:DebugOption("toggleSkinningMode", true)
                                else
                                    Options.db.profile.toggleSkinningMode = value
                                    Util:DebugOption("toggleSkinningMode", value)
                                end
                            end
                        },
                        selectSkinningModeModifier = {
                            name = L["genModifierKey"],
                            desc = L["selectSkinningModeModifierDesc"],
                            type = "select",
                            values = tableModifierKeys,
                            order = 2
                        },
                    },
                },
            }, 
        },
        groupLootMonitor = {
            name = L["groupLootMonitor"], 
            type = "group", 
            order = 4, 
            childGroups = "tab",
            args = {
                descLootMonitorNote = {
                    name = L["descLootMonitorNote"],
                    type = "description",
                    hidden = true,
                    order = 1,
                },
                buttonTestLootMonitor = {
                    name = L["buttonTestLootMonitor"],
                    type = "execute",
                    order = 2,
                    func = function()
                        HotLoot:TestLootMonitor()
                    end
                },
                buttonResetLootMonitor = {
                    -- TODO: Maybe change text to say "Reset Loot Monitor Position"?
                    --          or just add a description if possible
                    name = L["buttonResetLootMonitorName"],
                    desc = L["buttonResetLootMonitorDesc"],
                    type = "execute",
                    order = 3,
                    func = function()
                        HotLoot.Anchor:ClearAllPoints()
                        HotLoot.Anchor:SetPoint("CENTER", 0, 0)
                        Options.db.profile.anchorPosition.x = anchor:GetLeft()
                        Options.db.profile.anchorPosition.y = anchor:GetBottom()
                        Util:Announce(L["AnchorReset"])
                    end
                },
                groupLootMonitorGeneral = {
                    name = L["genGeneral"], 
                    type = "group", 
                    order = 4, 
                    args = {
                        toggleEnableLootMonitor = {
                            name = L["toggleEnableLootMonitorName"],
                            desc = L["toggleEnableLootMonitorDesc"],
                            type = "toggle",
                            width = "double",
                            order = 1
                        },
                        toggleShowLootMonitorAnchor = {
                            name = L["toggleShowLootMonitorAnchorName"],
                            desc = L["toggleShowLootMonitorAnchorDesc"],
                            type = "toggle",
                            width = "double",
                            order = 2,
                            set = 'SetShowLootMonitorAnchor'
                        },
                        toggleShowItemQuant = {
                            name = L["toggleShowItemQuantName"],
                            desc = L["toggleShowItemQuantDesc"],
                            type = "toggle",
                            width = "double",
                            order = 3
                        },
                        toggleShowTotalQuant = {
                            name = L["toggleShowTotalQuantName"],
                            desc = L["toggleShowTotalQuantDesc"],
                            type = "toggle",
                            width = "double",
                            order = 4
                        },
                        toggleShowSellPrice = {
                            name = L["toggleShowSellPriceName"],
                            desc = L["toggleShowSellPriceDesc"],
                            type = "toggle",
                            width = "double",
                            order = 5
                        },
                        toggleShowItemType = {
                            name = L["toggleShowItemTypeName"],
                            desc = L["toggleShowItemTypeDesc"],
                            type = "toggle",
                            width = "double",
                            order = 6
                        },
                    }
                },
                groupLootMonitorAppearance = {
                    name = L["genAppearance"], 
                    type = "group", 
                    order = 5, 
                    args = {
                        rangeIconSize = {
                            name = L["rangeIconSizeName"],
                            desc = L["rangeIconSizeDesc"],
                            type = "range",
                            min = 16,
                            max = 32,
                            step = 4, 
                            bigStep = 4,
                            -- disabled = function()
                            --     return not HotLoot:GetThemeSetting('iconSizable')
                            -- end,
                            hidden = "Advanced",
                            order = 1
                        },
                        rangeTransparency = {
                            name = L["genTransparency"],
                            desc = L["rangeTransparencyDesc"],
                            type = "range",
                            min = 0,
                            max = 1,
                            step = 0.1, 
                            bigStep = 0.1,
                            order = 2
                        },
                        selectGrowthDirection = {
                            name = L["selectGrowthDirectionName"],
                            desc = L["selectGrowthDirectionDesc"],
                            type = "select",
                            values = tableDirectionVertical,
                            order = 3
                        },
                        rangeToastScale = {
                            -- TODO: FIXME: Localize these!
                            name = 'Scale Offset',
                            -- name = L["rangeToastScaleName"],
                            desc = 'Adjusts the overall scale of each loot toast.',
                            -- desc = L["rangeToastScaleDesc"],
                            type = "range",
                            min = -1,
                            max = 1,
                            step = 0.1, 
                            bigStep = 0.1,
                            hidden = "Advanced",
                            order = 4
                        },
                        rangeToastPadding = {
                            name = L["rangeToastPaddingName"],
                            desc = L["rangeToastPaddingDesc"],
                            type = "range",
                            min = 1,
                            max = 16,
                            step = 1, 
                            bigStep = 1,
                            -- TODO: Figure out if this should be Advanced or not.
                            -- hidden = "Advanced",
                            order = 5
                        },
                        selectTheme = {
                            name = L["selectThemeName"],
                            -- desc = L["selectThemeDesc"],
                            type = "select",
                            values = tableThemes,
                            order = 6
                        },
                        toggleColorByQuality = {
                            name = L["toggleColorByQualityName"],
                            desc = L["toggleColorByQualityDesc"],
                            type = "toggle",
                            hidden = "GetThemeColorDisabled",
                            order = 7
                        },
                        colorThemeBG = {
                            name = L["colorThemeBGName"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            hidden = "GetThemeColorDisabled",
                            hasAlpha = true,
                            order = 8,
                            set = function(info, r, g, b, a)
                                Options.db.profile.fThemeColorR = r
                                Options.db.profile.fThemeColorG = g
                                Options.db.profile.fThemeColorB = b
                                Options.db.profile.fThemeColorA = a

                                Util:DebugOption('colorThemeBG', r..', '..g..', '..b..', '..a)
                            end,
                            get = function(info)
                                return Options.db.profile.fThemeColorR, Options.db.profile.fThemeColorG, Options.db.profile.fThemeColorB, Options.db.profile.fThemeColorA
                            end
                        },
                        colorThemeBorder = {
                            name = L["colorThemeBorderName"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            hidden = "GetThemeColorDisabled",
                            hasAlpha = true,
                            order = 9,
                            set = function(info, r, g, b, a)
                                Options.db.profile.fThemeBorderColorR = r
                                Options.db.profile.fThemeBorderColorG = g
                                Options.db.profile.fThemeBorderColorB = b
                                Options.db.profile.fThemeBorderColorA = a

                                Util:DebugOption('colorThemeBorder', r..', '..g..', '..b..', '..a)
                            end,
                            get = function(info)
                                return Options.db.profile.fThemeBorderColorR, Options.db.profile.fThemeBorderColorG, Options.db.profile.fThemeBorderColorB, Options.db.profile.fThemeBorderColorA
                            end
                        },
                        inputMinWidth = {
                            name = L["inputMinWidthName"],
                            desc = L["inputMinWidthDesc"],
                            type = "input",
                            hidden = "Advanced",
                            order = 10
                        },
                        -- NOTE: Changed from rangeInitialDelay
                        rangeDisplayTime = {
                            name = L["rangeDisplayTimeName"],
                            desc = L["rangeDisplayTimeDesc"],
                            type = "range",
                            min = 1,
                            max = 10,
                            step = 1, 
                            bigStep = 1,
                            hidden = "Advanced",
                            order = 11
                        },
                        -- NOTE: Changed from rangeSecondaryDelay
                        rangeMultipleDelay = {
                            name = L["rangeMultipleDelayName"],
                            desc = L["rangeMultipleDelayDesc"],
                            type = "range",
                            min = 0.5,
                            max = 5,
                            step = 0.5, 
                            bigStep = 0.5,
                            --width = "half",
                            hidden = "Advanced",
                            order = 12
                        },
                        rangeFadeSpeed = {
                            name = L["rangeFadeSpeedName"],
                            desc = L["rangeFadeSpeedDesc"],
                            type = "range",
                            min = 5,
                            max = 15,
                            step = 1, 
                            bigStep = 1,
                            hidden = "Advanced",
                            order = 13
                        },
                        toggleShowAnimation = {
                            name = L["toggleShowAnimationName"],
                            desc = L["toggleShowAnimationDesc"], -- TODO: Needs to be updated for shines and etc.
                            type = "toggle",
                            order = 14
                        }
                    }
                },
                groupLootMonitorText = {
                    name = L["genText"], 
                    type = "group", 
                    order = 6, 
                    args = {
                        selectTextFont = {
                            name = L["genFont"],
                            desc = L["selectTextFontDesc"],
                            type = "select",
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                            width = "double",
                            order = 1
                        },
                        selectTextSide = {
                            name = L["selectTextSideName"],
                            desc = L["selectTextSideDesc"],
                            type = "select",
                            values = tableDirectionHorizontal,
                            order = 2
                        },
                        rangeFontSize = {
                            name = L["rangeFontSizeName"],
                            desc = L["rangeFontSizeDesc"],
                            type = "range",
                            min = 6,
                            max = 16,
                            step = 1, 
                            bigStep = 1,
                            hidden = "Advanced",
                            order = 3
                        },
                        colorFontColor = {
                            name = L["colorFontColorName"],
                            desc = L["colorFontColorDesc"],
                            type = "color",
                            hidden = "Advanced",
                            hasAlpha = true,
                            order = 4,
                            set = function(info, r, g, b, a)
                                Options.db.profile.colorFontColor = {
                                    ["r"] = r,
                                    ["g"] = g,
                                    ["b"] = b,
                                    ["a"] = a
                                }

                                Util:DebugOption(
                                    "colorFontColor{}",
                                    tostring(r)..", "..
                                    tostring(g)..", "..
                                    tostring(b)..", "..
                                    tostring(a)
                                )
                            end,
                            get = function(info)
                                local fontColor = Options:Get('colorFontColor')
                                return fontColor.r,
                                fontColor.g,
                                fontColor.b,
                                fontColor.a
                            end
                        },
                        toggleFontColorByQual = {
                            name = L["toggleFontColorByQualName"],
                            desc = L["toggleFontColorByQualDesc"],
                            type = "toggle",
                            order = 5
                        },
                    }
                }
            }
        },
        groupLootFilters = {
            name = L["groupLootFilters"],
            type = "group",
            order = 5,
            args = {
                groupGeneral = {
                    name = L["groupGeneral"],
                    type = "group",
                    order = 1,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersGeneral = {
                            name = L["buttonEnableAll"],
                            desc = L["buttonEnableAllFiltersGeneralDesc"],
                            type = "execute",
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
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersGeneralDesc"],
                            type = "execute",
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
                            name = L["toggleGoldFilterName"],
                            desc = L["toggleGoldFilterDesc"],
                            type = "toggle",
                            order = 3
                        },
                        toggleCurrencyFilter = {
                            name = L["toggleCurrencyFilterName"],
                            desc = L["toggleCurrencyFilterDesc"],
                            type = "toggle",
                            order = 4
                        },
                        toggleQuestFilter = {
                            name = L["toggleQuestFilterName"],
                            desc = L["toggleQuestFilterDesc"],
                            type = "toggle",
                            order = 5
                        },
                        togglePickpocketFilter = {
                            name = L["togglePickpocketFilterName"], 
                            desc = L["togglePickpocketFilterName"],
                            type = "toggle",
                            order = 7
                        }
                    }
                },
                groupProfessions = {
                    name = L["groupProfessions"],
                    type = "group",
                    order = 2,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersProfessions = {
                            name = L["buttonEnableAll"],
                            desc = L["buttonEnableAllFiltersProfessionsDesc"],
                            type = "execute",
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
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersProfessionsDesc"],
                            type = "execute",
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
                            name = L["toggleClothFilterName"],
                            desc = L["toggleClothFilterDesc"],
                            type = "toggle",
                            order = 3
                        },
                        toggleMiningFilter = {
                            name = L["toggleMiningFilterName"],
                            desc = L["toggleMiningFilterDesc"],
                            type = "toggle",
                            order = 4
                        },
                        toggleGemFilter = {
                            name = L["toggleGemFilterName"],
                            desc = L["toggleGemFilterDesc"],
                            type = "toggle",
                            order = 5
                        },
                        toggleHerbFilter = {
                            name = L["toggleHerbFilterName"],
                            desc = L["toggleHerbFilterDesc"],
                            type = "toggle",
                            order = 6
                        },
                        toggleLeatherFilter = {
                            name = L["toggleLeatherFilterName"],
                            desc = L["toggleLeatherFilterDesc"],
                            type = "toggle",
                            order = 7
                        },
                        toggleFishingFilter = {
                            name = L["toggleFishingFilterName"],
                            desc = L["toggleFishingFilterDesc"],
                            type = "toggle",
                            order = 8
                        },
                        toggleEnchantingFilter = {
                            name = L["toggleEnchantingFilterName"],
                            desc = L["toggleEnchantingFilterDesc"],
                            type = "toggle",
                            order = 9
                        },
                        togglePigmentsFilter = {
                            name = L["togglePigmentsFilterName"]..Util:ColorText(' (experimental)', 'warning'),
                            desc = L["togglePigmentsFilterDesc"],
                            type = "toggle",
                            order = 10
                        },
                        toggleCookingFilter = {
                            name = L["toggleCookingFilterName"],
                            desc = L["toggleCookingFilterDesc"],
                            --\n\n|cff1eff00Note: Blizzard has cooking ingredients spread all over different categories but this should get most of them.|r
                            type = "toggle",
                            width = "full",
                            order = 11
                        },
                        toggleRecipeFilter = {
                            name = L["toggleRecipeFilterName"],
                            desc = L["toggleRecipeFilterDesc"],
                            type = "toggle",
                            order = 12
                        }
                    }
                },
                groupCommonDrops = {
                    name = L["groupCommonDrops"],
                    type = "group",
                    order = 3,
                    inline = true,
                    args = {
                        buttonEnableAllFiltersCommon = {
                            name = L["buttonEnableAll"],
                            desc = L["buttonEnableAllFiltersCommonDesc"],
                            type = "execute",
                            order = 1,
                            func = function()
                                Options:Set('togglePotionFilter',    true)
                                Options:Set('toggleFlaskFilter',     true)
                                Options:Set('toggleElixirFilter',    true)
                                Options:Set('toggleElementalFilter', true)
                            end
                        },
                        buttonDisableAllFiltersCommon = {
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersCommonDesc"],
                            type = "execute",
                            order = 2,
                            func = function()
                                Options:Set('togglePotionFilter',    false)
                                Options:Set('toggleFlaskFilter',     false)
                                Options:Set('toggleElixirFilter',    false)
                                Options:Set('toggleElementalFilter', false)
                            end
                        },
                        togglePotionFilter = {
                            name = L["togglePotionFilterName"],
                            desc = L["togglePotionFilterDesc"],
                            type = "toggle",
                            order = 3
                        },
                        selectPotionType = {
                            name = L["selectPotionTypeName"],
                            desc = L["selectPotionTypeDesc"],
                            type = "select",
                            values = tablePotionType,
                            order = 4
                        },
                        toggleFlaskFilter = {
                            name = L["toggleFlaskFilterName"],
                            desc = L["toggleFlaskFilterDesc"],
                            type = "toggle",
                            order = 5
                        },
                        toggleElixirFilter = {
                            name = L["toggleElixirFilterName"],
                            desc = L["toggleElixirFilterDesc"],
                            type = "toggle",
                            order = 6
                        },
                        toggleElementalFilter = {
                            name = L["toggleElementalFilterName"],
                            desc = L["toggleElementalFilterDesc"],
                            type = "toggle",
                            order = 7
                        }
                    }
                }
            }
        },
        groupItemQualityFilters = {
            name = L["groupItemQualityFilters"],
            type = "group",
            order = 6,
            args = {
                descItemQualityFilters = {
                    name = L["descItemQualityFilters"].."\n",
                    type = "description",
                    order = 0,
                },
                buttonEnableAllFiltersQuality = {
                    name = L["buttonEnableAll"],
                    desc = L["buttonEnableAllFiltersQualityDesc"],
                    type = "execute",
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
                    name = L["buttonDisableAll"],
                    desc = L["buttonDisableAllFiltersQualityDesc"],
                    type = "execute",
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
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC.."|r"),
                    desc = L["toggleItemQualityFilterDesc"]:format(ITEM_QUALITY_COLORS[0].hex..ITEM_QUALITY0_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 3,
                },
                toggleSellPoorItems = {
                    name = L["toggleSellPoorItemsName"],
                    desc = L["toggleSellPoorItemsDesc"],
                    type = "toggle",
                    width = "full",
                    order = 4,
                },
                toggleCommonQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 6,
                },
                toggleUncommonQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC.."|r"),
                    type = "toggle",
                    order = 8,
                    width = "full",
                },  
                toggleRareQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 10,
                },
                toggleEpicQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 12,
                },
                toggleLegendaryQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[5].hex..ITEM_QUALITY5_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 14,
                },
                toggleArtifactQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 16,
                },
                toggleHeirloomQualityFilter = {
                    name = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC.."|r"),
                    desc = L["toggleItemQualityFilterName"]:format(ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC.."|r"),
                    type = "toggle",
                    width = "full",
                    order = 18,
                },
                inputMinItemLevel = {
                    name = L["inputMinItemLevelName"],
                    desc = L["inputMinItemLevelDesc"],           
                    type = "input",
                    -- pattern = "%d+",
                    order = 19,
                    set = function(info, value)
                        if value == '' or not tonumber(value) then
                            Options.db.profile.inputMinItemLevel = 0;
                            Util:Debug("inputMinItemLevel not set (defaulting to 0)");
                        else
                            Options.db.profile.inputMinItemLevel = value;
                            Util:DebugOption("inputMinItemLevel", value);
                        end
                    end
                },
            },
        },
        groupIncludeExclude = {
            name = L["groupIncludeExclude"],
            type = "group",
            order = 7,
            args = {
                headerIncludeList = {
                    name = L["headerIncludeList"],
                    type = "header",
                    order = 1,
                },
                selectIncludeList = {
                    name = L["selectIncludeListName"],
                    type = "select",
                    values = "GetIncludeList",
                    order = 2,
                },
                inputIncludeListAdd = {
                    name = L["inputIncludeListAddName"],
                    desc = L["inputIncludeListAddDesc"],
                    type = "input",
                    order = 3,
                    set = 'AddToIncludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromIncludeList = {
                    name = L["buttonRemoveFromIncludeListName"],
                    type = "execute",
                    order = 4,
                    func = 'RemoveFromIncludeList'
                },
                toggleShowIncludeButton = {
                    name = L["toggleShowIncludeButtonName"],
                    desc = L["toggleShowIncludeButtonDesc"],
                    type = "toggle",
                    order = 5,
                },
                headerExcludeList = {
                    name = L["headerExcludeList"],
                    type = "header",
                    order = 6,
                },
                selectExcludeList = {
                    name = L["selectExcludeListName"],
                    type = "select",
                    values = "GetExcludeList",
                    order = 7,
                },
                inputExcludeListAdd = {
                    name = L["inputExcludeListAddName"],
                    desc = L["inputExcludeListAddDesc"],
                    --multiline = 10,
                    type = "input",
                    --width = "full",
                    order = 8,
                    set = 'AddToExcludeList',
                    get = function(info)
                        return ''
                    end
                },
                buttonRemoveFromExcludeList = {
                    name = L["buttonRemoveFromExcludeListName"],
                    type = "execute",
                    order = 9,
                    func = 'RemoveFromExcludeList'
                },
                toggleShowExcludeButton = {
                    name = L["toggleShowExcludeButtonName"],
                    desc = L["toggleShowExcludeButtonDesc"],
                    type = "toggle",
                    order = 10,
                },
            },
        },
        groupValueThresholds = {
            name = L["groupValueThresholds"],
            type = "group",
            order = 8,
            args = {
                descValueThresholds = {
                    name = L["descValueThresholds"].."\n",
                    type = "description",
                    order = 0
                },
                groupThreshold1 = {
                    name = L["groupThreshold1"],
                    type = "group",
                    order = 1,
                    inline = true,
                    args = {
                        selectThresholdType1 = {
                            name = L["selectThresholdTypeName"],
                            desc = L["selectThresholdTypeDesc"],
                            type = "select",
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue1 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            -- pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            -- BREAKING: This newer patter wouldn't work so either fix or just figure out a better way to do it
                            pattern = "((%d+g)|((%d+g)%s*(%d?%d[sc]))|((%d+g)%s*(%d?%ds)%s*(%d?%dc))|((%d+s)%s*(%d?%dc))|((%d?%d[sc])))$",
                            usage = L["inputThresholdValueDesc"],
                            order = 2
                        },
                    },
                },
                groupThreshold2 = {
                    name = L["groupThreshold2"],
                    type = "group",
                    order = 2,
                    inline = true,
                    args = {
                        selectThresholdType2 = {
                            name = L["selectThresholdTypeName"],
                            desc = L["selectThresholdTypeDesc"],
                            type = "select",
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue2 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            usage = L["inputThresholdValueDesc"],
                            order = 2
                        },
                    },
                },
                groupThreshold3 = {
                    name = L["groupThreshold3"],
                    type = "group",
                    order = 3,
                    inline = true,
                    args = {
                        selectThresholdType3 = {
                            name = L["selectThresholdTypeName"],
                            desc = L["selectThresholdTypeDesc"],
                            type = "select",
                            values = tableFilterTypes,
                            order = 1
                        },
                        inputThresholdValue3 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            usage = L["inputThresholdValueDesc"],
                            order = 2
                        },
                    },
                },
                toggleUseQuantValue = {
                    name = L["toggleUseQuantValueName"],
                    desc = L["toggleUseQuantValueDesc"],
                    type = "toggle",
                    hidden = "Advanced",
                    order = 4
                },
            },
        },
        groupAnnounce = {
            name = "Loot Frame",
            type = "group",
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
        groupHelp = {
            name = L["HelpGroup"],
            type = "group",
            childGroups = "select",
            order = 16,
            args = {
                desc = {
                    name = L["HelpDesc"],
                    type = "description",
                    order = 0,
                },
                groupSys = {
                    name = L["SysHelpGroup"],
                    type = "group",
                    order = 1,
                    args = {
                        desc = {
                            -- FIXME: CHANGE ALL THESE
                            name = Util:ColorText(L["groupCloseLootWindow"], 'warning').."\n"..L["SysHelp1"]..Util:ColorText(L["groupSkinningMode"], 'warning').."\n"..L["SysHelp2"],            
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupLM = {
                    name = L["groupLootMonitor"],
                    type = "group",
                    order = 2,
                    args = {
                        desc = {
                            name = Util:ColorText(L["Themes"], 'warning').."\n"..L["LMHelp1"],          
                            --..Util:ColorText(L["GridModeGroup"], 'warning')..L["LMHelp2"]
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupIQ = {
                    name = L["groupItemQualityFilters"],
                    type = "group",
                    order = 3,
                    args = {
                        desc = {
                            name = L["IQHelp1"]..Util:ColorText(L["togglePoorQualityFilterName"], 'warning').."\n"..L["IQHelp2"],            
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupIE = {
                    name = L["IEListHelpGroup"],
                    type = "group",
                    order = 4,
                    hidden = false,
                    args = {
                        desc = {
                            name = Util:ColorText(L["IEListHelpGroup"], 'warning').."\n"..L["IEListHelp1"],         
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupThresh = {
                    name = L["groupValueThresholds"],
                    type = "group",
                    order = 5,
                    args = {
                        desc = {
                            -- FIXME: Fix this to be with current doings
                            name = Util:ColorText(L["selectThresholdTypeName"], 'warning').."\n"..L["ThreshHelp1"]..
                                Util:ColorText(L["inputThresholdValueName"], 'warning').."\n"..L["ThreshHelp2"]..
                                Util:ColorText(L["toggleUseQuantValueName"], 'warning').."\n"..L["ThreshHelp3"],          
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupSC = {
                    name = L["SCHelpGroup"],
                    type = "group",
                    order = 6,
                    args = {
                        
                    },
                },
            },
        },
        groupAbout = {
            name = "About",
            type = "group",
            order = 17,
            args = {
                spacer2 = {
                    name = Util:ColorText("HotLoot v"..GetAddOnMetadata("HotLoot", "Version").." ©2016\n\nAuthor:", 'warning').." Neil Smith\n"..Util:ColorText("Co-author:", 'warning').." Jessica Mitchell\n"..Util:ColorText("Testing:", 'warning').."\ndsblack115\n"..Util:ColorText("Translations:", 'warning').."\nphilipp5796 - German\nMad_Ti - French\n",         
                    type = "description",
                    order = 1,
                },
                desc = {
                    name = "Curse Page",
                    type = "input",
                    width = "double",
                    get = function() return "http://www.curse.com/addons/wow/hotloot" end,
                    order = 2,
                },
            },
        },
    },
}

--
-- ─── TRANSFER SETTINGS ──────────────────────────────────────────────────────────
--

local function TransferOldSetting(oldKey, newKey)
    if Options.db.profile[oldKey] ~= nil then
        Options.db.profile[newKey] = Options.db.profile[oldKey];
        Options.db.profile[oldKey] = nil;
    end
end

local function TransferAllSettings()
    Util:Announce("Settings have changed and need to be transferred.\n This should only happen once.");
    Util:Announce("Transfering old settings now...");

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
    -- TransferOldSetting("initialDelay",        "rangeInitialDelay");
    -- TransferOldSetting("secondaryDelay",      "rangeSecondaryDelay");
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

    Util:Announce("Settings transfer complete!");
end

function Options:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('HotLootDB', defaults)
    
    self.db:RegisterDefaults(defaults)
    HotLoot.options = self.db.profile

    -- Create Options
    LibStub("AceConfig-3.0"):RegisterOptionsTable("HotLoot", optionsTable)

    -- Create Profiles section
    optionsTable.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    -- Create About section
    optionsTable.args.about = LibStub('LibAboutPanel-2.0'):AboutOptionsTable('HotLoot')
    optionsTable.args.about.order = 201

    -- Transfer 
    if self.db.profile.bOldSettingsTransferred ~= true then
        TransferAllSettings()
        self.db.profile.bOldSettingsTransferred = true
    end
end
