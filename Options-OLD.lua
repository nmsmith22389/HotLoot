local L = LibStub("AceLocale-3.0"):GetLocale("HotLoot")
local HotLootFrame = HotLoot:GetModule("LootFrame")

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
    ["Include"] = L["Include List"],
}

local tableThemes = {
    ["customSmall"] = "Custom "..HotLoot:ColorText("info", "(Small)"),
    ["customLarge"] = "Custom "..HotLoot:ColorText("info", "(Large)"),
    ["tooltip"]     = "Tooltip "..HotLoot:ColorText("info", "(Large)"),
    ["paper"]       = "Paper "..HotLoot:ColorText("info", "(Large)"),
}
-- options
--
 hlOptions = {
    name = "HotLoot",
    handler = HotLoot,
    type = "group",
    childGroups = "tree",
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
                    set = "SetSystemEnable",
                    get = "GetSystemEnable",
                    order = 1
                },
                toggleHideMinimapButton = {
                    name = L["toggleHideMinimapButtonName"],
                    desc = L["toggleHideMinimapButtonDesc"],
                    type = "toggle",
                    set = "SetHideMinimapButton",
                    get = "GetHideMinimapButton",
                    order = 2
                },
                toggleAnnounceEvents = {
                    name = L["toggleAnnounceEventsName"],
                    desc = L["toggleAnnounceEventsDesc"],
                    type = "toggle",
                    set = "SetAnnounceEvents",
                    get = "GetAnnounceEvents",
                    order = 3
                },
                toggleAdvancedOptions = {
                    name = L["toggleAdvancedOptionsName"],
                    desc = L["toggleAdvancedOptionsDesc"],
                    type = "toggle",
                    set = "SetAdvancedOptions",
                    get = "GetAdvancedOptions",
                    order = 4
                },
                toggleDebugMode = {
                    name = L["toggleDebugModegName"],
                    desc = L["toggleDebugModegDesc"],
                    type = "toggle",
                    set = "SetDebugMode",
                    get = "GetDebugMode",
                    hidden = "GetAdvancedOptionsHidden",
                    order = 5
                },
                -- TODO: Add Enable/Disable select option to decide which one the mod key does.
                groupCloseLootWindow = {
                    name = L["groupCloseLootWindow"],
                    type = "group",
                    order = 6,
                    inline = true,
                    args = {
                        toggleCloseLootWindow = {
                            name = L["genEnable"],
                            desc = L["toggleCloseLootWindowDesc"],
                            type = "toggle",
                            set = "SetCloseLootWindow",
                            get = "GetCloseLootWindow",
                            order = 1
                        },
                        selectCloseLootWindowModifier = {
                            name = L["genModifierKey"],
                            desc = L["selectCloseLootWindowModifierDesc"],
                            type = "select",
                            values = tableModifierKeys,
                            set = "SetCloseLootWindowModifier",
                            get = "GetCloseLootWindowModifier",
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
                            set = "SetSkinningMode",
                            get = "GetSkinningMode",
                            order = 1
                        },
                        selectSkinningModeModifier = {
                            name = L["genModifierKey"],
                            desc = L["selectSkinningModeModifierDesc"],
                            type = "select",
                            values = tableModifierKeys,
                            set = "SetSkinningModeModifier",
                            get = "GetSkinningModeModifier",
                            order = 2
                        },
                    },
                },
            }, 
        },
        goupLootMonitor = {
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
                    func = "TestLootMonitor", 
                    order = 2
                },
                buttonResetLootMonitor = {
                    -- TODO: Maybe change text to say "Reset Loot Monitor Position"?
                    --          or just add a description if possible
                    name = L["buttonResetLootMonitorName"],
                    desc = L["buttonResetLootMonitorDesc"],
                    type = "execute",
                    func = "buttonResetLootMonitor", 
                    order = 3
                },
                goupLootMonitorGeneral = {
                    name = L["genGeneral"], 
                    type = "group", 
                    order = 4, 
                    args = {
                        toggleEnableLootMonitor = {
                            name = L["toggleEnableLootMonitorName"],
                            desc = L["toggleEnableLootMonitorDesc"],
                            type = "toggle",
                            set = "SetEnableLootMonitor",
                            get = "GetEnableLootMonitor",
                            width = "double",
                            order = 1
                        },
                        toggleShowLootMonitorAnchor = {
                            name = L["toggleShowLootMonitorAnchorName"],
                            desc = L["toggleShowLootMonitorAnchorDesc"],
                            type = "toggle",
                            set = "SetShowLootMonitorAnchor",
                            get = "GetShowLootMonitorAnchor",
                            width = "double",
                            order = 2
                        },
                        toggleShowItemNames = {
                            name = L["toggleShowItemNamesName"],
                            desc = L["toggleShowItemNamesDesc"],
                            type = "toggle",
                            set = "SetShowItemNames",
                            get = "GetShowItemNames",
                            -- hidden = "GetAdvancedOptionsHidden",
                            hidden = true,
                            width = "double",
                            order = 3
                        },
                        toggleShowItemQuant = {
                            name = L["toggleShowItemQuantName"],
                            desc = L["toggleShowItemQuantDesc"],
                            type = "toggle",
                            set = "SetShowItemQuant",
                            get = "GetShowItemQuant",
                            width = "double",
                            order = 4
                        },
                        -- TODO: Rename Locals and Funcs
                        inlineQuant = {
                            name = L["InlineQuantName"],
                            desc = L["InlineQuantDesc"],
                            type = "toggle",
                            set = "SetInlineQuant",
                            get = "GetInlineQuant",
                            hidden = true,
                            --hidden = "GetAdvancedOptionsHidden",
                            width = "double",
                            order = 5
                        },
                        toggleShowTotalQuant = {
                            name = L["toggleShowTotalQuantName"],
                            desc = L["toggleShowTotalQuantDesc"],
                            type = "toggle",
                            set = "SetShowTotalQuant",
                            get = "GetShowTotalQuant",
                            width = "double",
                            order = 6
                        },
                        toggleShowSellPrice = {
                            name = L["toggleShowSellPriceName"],
                            desc = L["toggleShowSellPriceDesc"],
                            type = "toggle",
                            set = "SetShowSellPrice",
                            get = "GetShowSellPrice",
                            width = "double",
                            order = 7
                        },
                        toggleShowItemType = {
                            name = L["toggleShowItemTypeName"],
                            desc = L["toggleShowItemTypeDesc"],
                            type = "toggle",
                            set = "SetShowItemType",
                            get = "GetShowItemType",
                            width = "double",
                            order = 8
                        },
                        -- TODO: Rename Locals and Funcs
                        -- NOTE: Remove?
                        groupGridMode = {
                            name = L["GridModeGroup"],
                            type = "group",
                            order = 9,
                            inline = true,
                            hidden = true,
                            --hidden = "GetAdvancedOptionsHidden",
                            disabled = "ToggleGridDisable",
                            args = {
                                lootGridMode = {
                                    name = L["GridEnableName"],
                                    desc = L["GridEnableDesc"],
                                    type = "toggle",
                                    set = "SetLootGridMode",
                                    get = "GetLootGridMode",
                                    order = 1
                                },
                                lootGridNumColumns = {
                                    name = L["GridColName"],
                                    type = "range",
                                    min = 1,
                                    max = 10,
                                    step = 1, 
                                    bigStep = 1,
                                    set = "SetLootGridNumColumns",
                                    get = "GetLootGridNumColumns",
                                    order = 2
                                }
                            }
                        }
                    }
                },
                goupLootMonitorAppearance = {
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
                            disabled = "GetIconSizeDisabled",
                            set = "SetIconSize",
                            get = "GetIconSize",
                            hidden = "GetAdvancedOptionsHidden",
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
                            set = "SetTransparency",
                            get = "GetTransparency",
                            order = 2
                        },
                        selectGrowthDirection = {
                            name = L["selectGrowthDirectionName"],
                            desc = L["selectGrowthDirectionDesc"],
                            type = "select",
                            values = tableDirectionVertical,
                            set = "SetGrowthDirection",
                            get = "GetGrowthDirection",
                            order = 3
                        },
                        selectTheme = {
                            name = L["selectThemeName"],
                            -- desc = L["selectThemeDesc"],
                            type = "select",
                            values = tableThemes,
                            set = "SetTheme",
                            get = "GetTheme",
                            order = 5
                        },
                        toggleColorByQuality = {
                            name = L["toggleColorByQualityName"],
                            desc = L["toggleColorByQualityDesc"],
                            type = "toggle",
                            set = "SetColorByQuality",
                            get = "GetColorByQuality",
                            hidden = "GetThemeColorDisabled",
                            --disabled = true,
                            order = 6
                        },
                        colorThemeBG = {
                            name = L["colorThemeBGName"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            set = "SetThemeBG",
                            get = "GetThemeBG",
                            hidden = "GetThemeColorDisabled",
                            hasAlpha = true,
                            order = 7
                        },
                        colorThemeBorder = {
                            name = L["colorThemeBorderName"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            set = "SetThemeBorderColor",
                            get = "GetThemeBorderColor",
                            hidden = "GetThemeColorDisabled",
                            hasAlpha = true,
                            order = 8
                        },
                        inputMinWidth = {
                            name = L["inputMinWidthName"],
                            desc = L["inputMinWidthDesc"],
                            type = "input",
                            set = "SetMinWidth",
                            get = "GetMinWidth",
                            hidden = "GetAdvancedOptionsHidden",
                            order = 9
                        },
                        rangeInitialDelay = {
                            name = L["rangeInitialDelayName"],
                            desc = L["rangeInitialDelayDesc"],
                            type = "range",
                            min = 1,
                            max = 10,
                            step = 1, 
                            bigStep = 1,
                            set = "SetInitialDelay",
                            get = "GetInitialDelay",
                            hidden = "GetAdvancedOptionsHidden",
                            order = 10
                        },
                        rangeSecondaryDelay = {
                            name = L["rangeSecondaryDelayName"],
                            desc = L["rangeSecondaryDelayDesc"],
                            type = "range",
                            min = 1,
                            max = 10,
                            step = 1, 
                            bigStep = 1,
                            --width = "half",
                            set = "SetSecondaryDelay",
                            get = "GetSecondaryDelay",
                            hidden = "GetAdvancedOptionsHidden",
                            order = 11
                        },
                        rangeFadeSpeed = {
                            name = L["rangeFadeSpeedName"],
                            desc = L["rangeFadeSpeedDesc"],
                            type = "range",
                            min = 5,
                            max = 15,
                            step = 1, 
                            bigStep = 1,
                            hidden = "GetAdvancedOptionsHidden",
                            set = "SetFadeSpeed",
                            get = "GetFadeSpeed",
                            order = 12
                        },
                        toggleShowAnimation = {
                            name = L["toggleShowAnimationName"],
                            desc = L["toggleShowAnimationDesc"], -- TODO: Needs to be updated for shines and etc.
                            type = "toggle",
                            set = "SetShowAnimation",
                            get = "GetShowAnimation",
                            order = 13
                        }
                    }
                },
                goupLootMonitorText = {
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
                            set = "SetTextFont",
                            get = "GetTextFont",
                            width = "double",
                            -- hidden = "GetAdvancedOptionsHidden",
                            order = 1
                        },
                        selectTextSide = {
                            name = L["selectTextSideName"],
                            desc = L["selectTextSideDesc"],
                            type = "select",
                            values = tableDirectionHorizontal,
                            set = "SetTextSide",
                            get = "GetTextSide",
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
                            set = "SetFontSize",
                            get = "GetFontSize",
                            hidden = "GetAdvancedOptionsHidden",
                            order = 3
                        },
                        colorFontColor = {
                            name = L["colorFontColorName"],
                            desc = L["colorFontColorDesc"],
                            type = "color",
                            set = "SetFontColor",
                            get = "GetFontColor",
                            hidden = "GetAdvancedOptionsHidden",
                            hasAlpha = true,
                            order = 4
                        },
                        toggleFontColorByQual = {
                            name = L["toggleFontColorByQualName"],
                            desc = L["toggleFontColorByQualDesc"],
                            type = "toggle",
                            set = "SetFontColorByQual",
                            get = "GetFontColorByQual",
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
                            type = "execute",
                            func = "buttonEnableAllFiltersGeneral", 
                            order = 1
                        },
                        buttonDisableAllFiltersGeneral = {
                            name = L["buttonDisableAll"],
                            type = "execute",
                            func = "buttonDisableAllFiltersGeneral", 
                            order = 2
                        },
                        toggleGoldFilter = {
                            name = L["toggleGoldFilterName"],
                            desc = L["toggleGoldFilterDesc"],
                            type = "toggle",
                            set = "SetGoldFilter",
                            get = "GetGoldFilter",
                            order = 3
                        },
                        toggleCurrencyFilter = {
                            name = L["toggleCurrencyFilterName"],
                            desc = L["toggleCurrencyFilterDesc"],
                            type = "toggle",
                            set = "SetCurrencyFilter",
                            get = "GetCurrencyFilter",
                            order = 4
                        },
                        toggleQuestFilter = {
                            name = L["toggleQuestFilterName"],
                            desc = L["toggleQuestFilterDesc"],
                            type = "toggle",
                            set = "SetQuestFilter",
                            get = "GetQuestFilter",
                            order = 5
                        },
                        toggleJunkFilter = {
                            name = L["toggleJunkFilterName"], 
                            desc = L["toggleJunkFilterDesc"],
                            type = "toggle",
                            set = "SetJunkFilter",
                            get = "GetJunkFilter",
                            order = 6,
                            hidden = true
                        },
                        
                        togglePickpocketFilter = {
                            name = L["togglePickpocketFilterName"], 
                            desc = L["togglePickpocketFilterName"],
                            type = "toggle",
                            set = "SetPickpocketFilter",
                            get = "GetPickpocketFilter",
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
                            type = "execute",
                            func = "buttonEnableAllFiltersProfessions", 
                            order = 1
                        },
                        buttonDisableAllFiltersProfessions = {
                            name = L["buttonDisableAll"],
                            type = "execute",
                            func = "buttonDisableAllFiltersProfessions", 
                            order = 2
                        },
                        toggleClothFilter = {
                            name = L["toggleClothFilterName"],
                            desc = L["toggleClothFilterDesc"],
                            type = "toggle",
                            set = "SetClothFilter",
                            get = "GetClothFilter",
                            order = 3
                        },
                        toggleMiningFilter = {
                            name = L["toggleMiningFilterName"],
                            desc = L["toggleMiningFilterDesc"],
                            type = "toggle",
                            set = "SetMiningFilter",
                            get = "GetMiningFilter",
                            order = 4
                        },
                        toggleGemFilter = {
                            name = L["toggleGemFilterName"],
                            desc = L["toggleGemFilterDesc"],
                            type = "toggle",
                            set = "SetGemFilter",
                            get = "GetGemFilter",
                            order = 5
                        },
                        toggleHerbFilter = {
                            name = L["toggleHerbFilterName"],
                            desc = L["toggleHerbFilterDesc"],
                            type = "toggle",
                            set = "SetHerbFilter",
                            get = "GetHerbFilter",
                            order = 6
                        },
                        toggleLeatherFilter = {
                            name = L["toggleLeatherFilterName"],
                            desc = L["toggleLeatherFilterDesc"],
                            type = "toggle",
                            set = "SetLeatherFilter",
                            get = "GetLeatherFilter",
                            order = 7
                        },
                        toggleFishingFilter = {
                            name = L["toggleFishingFilterName"],
                            desc = L["toggleFishingFilterDesc"],
                            type = "toggle",
                            set = "SetFishingFilter",
                            get = "GetFishingFilter",
                            order = 8
                        },
                        toggleEnchantingFilter = {
                            name = L["toggleEnchantingFilterName"],
                            desc = L["toggleEnchantingFilterDesc"],
                            type = "toggle",
                            set = "SetEnchantingFilter",
                            get = "GetEnchantingFilter",
                            order = 9
                        },
                        togglePigmentsFilter = {
                            name = L["togglePigmentsFilterName"],
                            desc = L["togglePigmentsFilterDesc"],
                            type = "toggle",
                            set = "SetPigmentsFilter",
                            get = "GetPigmentsFilter",
                            order = 10
                        },
                        toggleCookingFilter = {
                            name = L["toggleCookingFilterName"],
                            desc = L["toggleCookingFilterDesc"],
                            --\n\n|cff1eff00Note: Blizzard has cooking ingredients spread all over different categories but this should get most of them.|r
                            type = "toggle",
                            set = "SetCookingFilter",
                            get = "GetCookingFilter",
                            width = "full",
                            order = 11
                        },
                        toggleRecipeFilter = {
                            name = L["toggleRecipeFilterName"],
                            desc = L["toggleRecipeFilterDesc"],
                            type = "toggle",
                            set = "SetRecipeFilter",
                            get = "GetRecipeFilter",
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
                            type = "execute",
                            func = "buttonEnableAllFiltersCommon", 
                            order = 1
                        },
                        buttonDisableAllFiltersCommon = {
                            name = L["buttonDisableAll"],
                            type = "execute",
                            func = "buttonDisableAllFiltersCommon", 
                            order = 2
                        },
                        togglePotionFilter = {
                            name = L["togglePotionFilterName"],
                            desc = L["togglePotionFilterDesc"],
                            type = "toggle",
                            set = "SetPotionFilter",
                            get = "GetPotionFilter",
                            order = 3
                        },
                        selectPotionType = {
                            name = L["selectPotionTypeName"],
                            desc = L["selectPotionTypeDesc"],
                            type = "select",
                            set = "SetPotionType",
                            get = "GetPotionType",
                            values = tablePotionType,
                            order = 4
                        },
                        toggleFlaskFilter = {
                            name = L["toggleFlaskFilterName"],
                            desc = L["toggleFlaskFilterDesc"],
                            type = "toggle",
                            set = "SetFlaskFilter",
                            get = "GetFlaskFilter",
                            order = 5
                        },
                        toggleElixirFilter = {
                            name = L["toggleElixirFilterName"],
                            desc = L["toggleElixirFilterDesc"],
                            type = "toggle",
                            set = "SetElixirFilter",
                            get = "GetElixirFilter",
                            order = 6
                        },
                        toggleElementalFilter = {
                            name = L["toggleElementalFilterName"],
                            desc = L["toggleElementalFilterDesc"],
                            type = "toggle",
                            set = "SetElementalFilter",
                            get = "GetElementalFilter",
                            order = 7
                        }
                    }
                }
            }
        },
        -- groupTimeless = {
        --  name = L["TimelessIsleGroup"],
        --  type = "group",
        --  order = 9,
        --  args = {
        --      timelessDesc1 = {
        --          name = L["TimelessIsleDesc"],           
        --          type = "description",
        --          order = 0,
        --      },
        --      groupTBuffs = {
        --          name = L["BuffItemsGroup"],
        --          type = "group",
        --          order = 1,
        --          inline = true,
        --          args = {
        --              lootBotA = {
        --                  name = L["BoAFilterName"],
        --                  desc = L["BoAFilterDesc"],
        --                  type = "toggle",
        --                  set = "SetLootBotA",
        --                  get = "GetLootBotA",
        --                  width = "double",
        --                  order = 2,
        --              },
        --              lootDoEM = {
        --                  name = L["DoEMFilterName"],
        --                  desc = L["DoEMFilterDesc"],
        --                  type = "toggle",
        --                  set = "SetLootDoEM",
        --                  get = "GetLootDoEM",
        --                  width = "double",
        --                  order = 3,
        --              },
        --              lootSC = {
        --                  name = L["SCFilterName"],
        --                  desc = L["SCFilterDesc"],
        --                  type = "toggle",
        --                  set = "SetLootSC",
        --                  get = "GetLootSC",
        --                  width = "double",
        --                  order = 4,
        --              },
        --          },
        --      },
        --      groupTRep = {
        --          name = L["RepGroup"],
        --          type = "group",
        --          order = 2,
        --          inline = true,
        --          args = {
        --              lootRepMeat = {
        --                  name = L["RepMeatFilterName"],
        --                  desc = L["RepMeatFilterDesc"],
        --                  type = "toggle",
        --                  set = "SetLootRepMeat",
        --                  get = "GetLootRepMeat",
        --                  width = "double",
        --                  order = 1,
        --              },
        --          },
        --      },
        --  },
        -- },
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
                    type = "execute",
                    func = "buttonEnableAllFiltersQuality", 
                    order = 1
                },
                buttonDisableAllFiltersQuality = {
                    name = L["buttonDisableAll"],
                    type = "execute",
                    func = "buttonDisableAllFiltersQuality", 
                    order = 2
                },
                togglePoorQualityFilter = {
                    name = L["togglePoorQualityFilterName"],
                    desc = L["togglePoorQualityFilterDesc"],
                    type = "toggle",
                    set = "SetPoorQualityFilter",
                    get = "GetPoorQualityFilter",
                    width = "full",
                    order = 3,
                },
                toggleSellPoorItems = {
                    name = L["toggleSellPoorItemsName"],
                    desc = L["toggleSellPoorItemsDesc"],
                    type = "toggle",
                    set = "SetSellPoorItems",
                    get = "GetSellPoorItems",
                    width = "full",
                    order = 4,
                },
                toggleCommonQualityFilter = {
                    name = L["toggleCommonQualityFilterName"],
                    desc = L["toggleCommonQualityFilterDesc"],
                    type = "toggle",
                    set = "SetCommonQualityFilter",
                    get = "GetCommonQualityFilter",
                    width = "full",
                    order = 6,
                },
                toggleUncommonQualityFilter = {
                    name = L["toggleUncommonQualityFilterName"],
                    desc = L["toggleUncommonQualityFilterDesc"],
                    type = "toggle",
                    set = "SetUncommonQualityFilter",
                    get = "GetUncommonQualityFilter",
                    order = 8,
                    width = "full",
                },  
                toggleRareQualityFilter = {
                    name = L["toggleRareQualityFilterName"],
                    desc = L["toggleRareQualityFilterDesc"],
                    type = "toggle",
                    set = "SetRareQualityFilter",
                    get = "GetRareQualityFilter",
                    width = "full",
                    order = 10,
                },
                toggleEpicQualityFilter = {
                    name = L["toggleEpicQualityFilterName"],
                    desc = L["toggleEpicQualityFilterDesc"],
                    type = "toggle",
                    set = "SetEpicQualityFilter",
                    get = "GetEpicQualityFilter",
                    width = "full",
                    order = 12,
                },
                toggleLegendaryQualityFilter = {
                    name = L["toggleLegendaryQualityFilterName"],
                    desc = L["toggleLegendaryQualityFilterDesc"],
                    type = "toggle",
                    set = "SetLegendaryQualityFilter",
                    get = "GetLegendaryQualityFilter",
                    width = "full",
                    order = 14,
                },
                toggleArtifactQualityFilter = {
                    name = L["toggleArtifactQualityFilterName"],
                    desc = L["toggleArtifactQualityFilterDesc"],
                    type = "toggle",
                    set = "SetArtifactQualityFilter",
                    get = "GetArtifactQualityFilter",
                    width = "full",
                    order = 16,
                },
                toggleHeirloomQualityFilter = {
                    name = L["toggleHeirloomQualityFilterName"],
                    desc = L["toggleHeirloomQualityFilterDesc"],
                    type = "toggle",
                    set = "SetHeirloomQualityFilter",
                    get = "GetHeirloomQualityFilter",
                    width = "full",
                    order = 18,
                },
                inputMinItemLevel = {
                    name = L["inputMinItemLevelName"],
                    desc = L["inputMinItemLevelDesc"],           
                    type = "input",
                    -- pattern = "%d+",
                    set = "SetMinItemLevel",
                    get = "GetMinItemLevel",
                    order = 19,
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
                    set = "SetIncludeListSelect",
                    get = "GetIncludeListSelect",
                    values = "GetIncludeList",
                    order = 2,
                },
                inputIncludeListAdd = {
                    name = L["inputIncludeListAddName"],
                    desc = L["inputIncludeListAddDesc"],
                    type = "input",
                    set = "SetIncludeListAdd",
                    get = "GetIncludeListAdd",
                    order = 3
                },
                buttonRemoveFromIncludeList = {
                    name = L["buttonRemoveFromIncludeListName"],
                    type = "execute",
                    func = "RemoveFromIncludeList",
                    order = 4,
                },
                toggleShowIncludeButton = {
                    name = L["toggleShowIncludeButtonName"],
                    desc = L["toggleShowIncludeButtonDesc"],
                    type = "toggle",
                    set = "SetShowIncludeButton",
                    get = "GetShowIncludeButton",
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
                    set = "SetExcludeListSelect",
                    get = "GetExcludeListSelect",
                    values = "GetExcludeList",
                    order = 7,
                },
                inputExcludeListAdd = {
                    name = L["inputExcludeListAddName"],
                    desc = L["inputExcludeListAddDesc"],
                    --multiline = 10,
                    type = "input",
                    set = "SetExcludeListAdd",
                    get = "GetExcludeListAdd",
                    --width = "full",
                    order = 8
                },
                buttonRemoveFromExcludeList = {
                    name = L["buttonRemoveFromExcludeListName"],
                    type = "execute",
                    func = "RemoveFromExcludeList",
                    order = 9,
                },
                toggleShowExcludeButton = {
                    name = L["toggleShowExcludeButtonName"],
                    desc = L["toggleShowExcludeButtonDesc"],
                    type = "toggle",
                    set = "SetShowExcludeButton",
                    get = "GetShowExcludeButton",
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
                            set = "SetThresholdType1",
                            get = "GetThresholdType1",
                            order = 1
                        },
                        inputThresholdValue1 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            set = "SetThresholdValue1",
                            get = "GetThresholdValue1",
                            -- TODO: accept more than 2 digits each? (technically at least gold)
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
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
                            set = "SetThresholdType2",
                            get = "GetThresholdType2",
                            order = 1
                        },
                        inputThresholdValue2 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            set = "SetThresholdValue2",
                            get = "GetThresholdValue2",
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
                            set = "SetThresholdType3",
                            get = "GetThresholdType3",
                            order = 1
                        },
                        inputThresholdValue3 = {
                            name = L["inputThresholdValueName"],
                            type = "input",
                            set = "SetThresholdValue3",
                            get = "GetThresholdValue3",
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
                    set = "SetUseQuantValue",
                    get = "GetUseQuantValue",
                    hidden = "GetAdvancedOptionsHidden",
                    order = 4
                },
            },
        },
        groupAnnounce = {
            name = "Loot Frame",
            type = "group",
            order = 9,
            args = {
                toggleLootFrameEnable = {
                    name = 'Enable',
                    desc = 'Enables the |cffcd6600HotLoot|r Loot Frame.',
                    type = "toggle",
                    set = "SetLootFrameEnable",
                    get = "GetLootFrameEnable",
                    order = 1
                },
            --[[
                announceEnable = {
                    name = L["AnnounceEnableName"],
                    desc = L["AnnounceEnableDesc"],
                    type = "toggle",
                    set = "SetAnnounceEnable",
                    get = "GetAnnounceEnable",
                    order = 1
                },
                
                announce = {
                    name = L["AnnounceEnableName"],
                    desc = L["AnnounceEnableDesc"],
                    type = "",
                    set = "Set",
                    get = "Get",
                    order = 
                },
                announce = {
                    name = "",
                    desc = "",
                    type = "",
                    set = "Set",
                    get = "Get",
                    order = 
                },
                announce = {
                    name = "",
                    desc = "",
                    type = "",
                    set = "Set",
                    get = "Get",
                    order = 
                },
                announce = {
                    name = "",
                    desc = "",
                    type = "",
                    set = "Set",
                    get = "Get",
                    order = 
                },
                announce = {
                    name = "",
                    desc = "",
                    type = "",
                    set = "Set",
                    get = "Get",
                    order = 
                },]]
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
                            name = HotLoot:ColorText("hotkey", L["groupCloseLootWindow"]).."\n"..L["SysHelp1"]..HotLoot:ColorText("hotkey", L["groupSkinningMode"]).."\n"..L["SysHelp2"],            
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
                            name = HotLoot:ColorText("hotkey", L["Themes"]).."\n"..L["LMHelp1"],          
                            --..HotLoot:ColorText("hotkey", L["GridModeGroup"])..L["LMHelp2"]
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
                            name = L["IQHelp1"]..HotLoot:ColorText("hotkey", L["togglePoorQualityFilterName"]).."\n"..L["IQHelp2"],            
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
                            name = HotLoot:ColorText("hotkey", L["IEListHelpGroup"]).."\n"..L["IEListHelp1"],         
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
                            name = HotLoot:ColorText("hotkey", L["selectThresholdTypeName"]).."\n"..L["ThreshHelp1"]..HotLoot:ColorText("hotkey", L["inputThresholdValueName"]).."\n"..L["ThreshHelp2"]..HotLoot:ColorText("hotkey", L["toggleUseQuantValueName"]).."\n"..L["ThreshHelp3"],          
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
        groupExtras = {
            name = L["Extras"],
            type = "group",
            order = 14,
            hidden = true,
            args = {
                desc = {
                        name = L["ExtrasDesc"],         
                        type = "description",
                        order = 0,
                        },
            
            
        }},
        groupTracker = {
            name = L["LootTrackerGroup"],
            type = "group",
            order = 15,
            hidden = true,
            args = {
                trackerEnable = {
                    name = L["LootTrackerEnableName"],          
                    type = "toggle",
                    order = 2,
                    set = "SetTrackerEnable",
                    get = "GetTrackerEnable",
                },
                watchList = {
                    name = L["WatchListName"],          
                    type = "select",
                    order = 3,
                    values = watchListTable,
                    set = "SetWatchList",
                    get = "GetWatchList",
                    hidden = not "GetTrackerEnable"
                },
                trackerName = {
                    name = L["LootTrackerItemName"],            
                    type = "input",
                    order = 4,
                    set = "SetTrackerName",
                    get = "GetTrackerName",
                },
                trackerGoal = {
                    name = L["Goal"],           
                    type = "input",
                    order = 5,
                    set = "SetTrackerGoal",
                    get = "GetTrackerGoal",
                },
                trackerRemove = {
                    name = L["LootTrackerRemoveName"],          
                    type = "execute",
                    order = 6,
                    func = "TrackerRemove",

                },
                trackerAdd = {
                    name = L["LootTrackerAddName"],         
                    type = "execute",
                    order = 7,
                    func = "TrackerAdd",
                
                },
            },
        },
        groupAbout = {
            name = "About",
            type = "group",
            order = 17,
            args = {
                spacer2 = {
                    name = HotLoot:ColorText("hotkey", "HotLoot v"..GetAddOnMetadata("HotLoot", "Version").." ©2016\n\nAuthor:").." Neil Smith\n"..HotLoot:ColorText("hotkey","Co-author:").." Jessica Mitchell\n"..HotLoot:ColorText("hotkey","Testing:").."\ndsblack115\n"..HotLoot:ColorText("hotkey","Translations:").."\nphilipp5796 - German\nMad_Ti - French\n",         
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



-- Config Defaults
hlDefaults = {
    profile = {
        minimapIcon = {
            hide = false,
            radius = 80,
            minimapPos = 270,
        },
        toggleSystemEnable = true,
        toggleDebugMode = false,
        toggleAnnounceEvents = true,
        toggleAdvancedOptions = false,
        toggleCloseLootWindow = false,
        selectCloseLootWindowModifier = "0",
        toggleSkinningMode = false,
        selectSkinningModeModifier = "0", 
        toggleEnableLootMonitor = true,
        toggleShowLootMonitorAnchor = true,
        -- toggleShowItemNames = true, 
        toggleShowItemQuant = true, 
        toggleShowSellPrice = true,
        toggleShowItemType = true,
        rangeIconSize = 16, 
        rangeTransparency = 1,
        fThemeColorR = 0,
        fThemeColorG = 0,
        fThemeColorB = 0,
        fThemeColorA = 0.82,
        fThemeBorderColorR = 1,
        fThemeBorderColorG = 1,
        fThemeBorderColorB = 1,
        fThemeBorderColorA = 1,
        -- inlineQuant = true,
        toggleShowTotalQuant = true,
        selectTheme = "paper",
        selectGrowthDirection = -1, 
        inputMinWidth = "145",
        rangeInitialDelay = 5,
        rangeSecondaryDelay = 1,
        rangeFadeSpeed = 5,
        toggleColorByQuality = true,
        toggleShowAnimation = true,
        selectTextFont = "Friz Quadrata TT",
        selectTextSide = 0,
        rangeFontSize = 9,
        colorFontColor = {
            ["r"] = 1.0;
            ["g"] = 1.0;
            ["b"] = 1.0;
            ["a"] = 1.0;
        };
        toggleFontColorByQual = false,
        lootGridMode = false,
        lootGridNumColumns = 4,
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
        -- lootBotA = true,
        -- lootDoEM = true,
        -- lootSC = true,
        -- lootRepMeat = true,
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
        
        -- Loot History
        
        lootHistoryEnable = false,
        lootHistoryReset = "never",
        
        -- Loot Notification
        
        lootNotificationEnable = false,
        NotificationList = { },
        
        -- Fishing
        
        fishingModeEnable = false,
        fishingModeRaft = false,
        fishingModeLure = false,
        fishingModeLureSelect = 68049,
        
        -- Group
        
        groupNeedStringTable = { },
    }
}


--#############################
--      Set/Get Functions
--#############################


--inputThresholdValue1
function HotLoot:SetThresholdValue1(info, value)
    self.db.profile.inputThresholdValue1 = value or "0c";
    HotLoot:DebugOption("inputThresholdValue1 to copper", tonumber(HotLoot:ToCopper(self.db.profile.inputThresholdValue1)));
end

function HotLoot:GetThresholdValue1(info)
    if self.db.profile.inputThresholdValue1 == nil then
        return "0c";
    else
        return self.db.profile.inputThresholdValue1;
    end
end


--inputThresholdValue2
function HotLoot:SetThresholdValue2(info, value)
    self.db.profile.inputThresholdValue2 = value or "0c";
    HotLoot:DebugOption("inputThresholdValue2", value);
end
function HotLoot:GetThresholdValue2(info)
    if self.db.profile.inputThresholdValue2 == nil then
        return "0c";
    else
        return self.db.profile.inputThresholdValue2;
    end
end


--inputThresholdValue3
function HotLoot:SetThresholdValue3(info, value)
    self.db.profile.inputThresholdValue3 = value or "0c";
    HotLoot:DebugOption("inputThresholdValue3", value);
end
function HotLoot:GetThresholdValue3(info)
    if self.db.profile.inputThresholdValue3 == nil then
        return "0c";
    else
        return self.db.profile.inputThresholdValue3;
    end
end


--SetTrackerEnable
function HotLoot:SetTrackerEnable(info, value)
    self.db.profile.trackerEnable = value;
    HotLoot:DebugOption("trackerEnable", value);
    if value then
        HotLoot.lootTracker:Show()
    else
        HotLoot.lootTracker:Hide()
    end
end
function HotLoot:GetTrackerEnable(info)
    return self.db.profile.trackerEnable;
end

--SetTrackerAdd
function HotLoot:TrackerAdd()
    if HotLoot:GetTrackerEnable() then
    if GetItemInfo(HotLoot:GetTrackerName()) then
    self.db.profile.watchList[select(1, GetItemInfo(HotLoot:GetTrackerName()))] = HotLoot:AddWatchList(HotLoot:GetTrackerName(), HotLoot:GetTrackerGoal())
    HotLoot:SetTrackerGoal(self, "")
    HotLoot:SetTrackerName(self, "")
    for k,v in pairs(self.db.profile.watchList) do
    watchListTable[k] = k
    end
    else
        HotLoot:Announce(L["LootTrackerAnnounceInvalid"])
    end
    end
end


--SetTrackerRemove
function HotLoot:TrackerRemove()
-- /script HotLoot.db.profile.watchList["Shadow Pigment"]["fontString"]["name"]:Hide()
    HotLoot:RemoveWL()
    
end

function HotLoot:SetLootFrameEnable(info, value)
    HotLootFrame.options.toggleLootFrameEnable = value;
    HotLoot:DebugOption("lootFrameEnable", value);

    -- if value then
    --     if HotLootFrame and not HotLootFrame:IsEnabled() then
    --         HotLootFrame:Enable()
    --     end
    -- else
    --     if HotLootFrame and HotLootFrame:IsEnabled() then
    --         HotLootFrame:Disable()
    --     end
    -- end
end

function HotLoot:GetLootFrameEnable(info)
    return HotLootFrame.options.toggleLootFrameEnable;
end
