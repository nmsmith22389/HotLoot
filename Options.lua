local L = LibStub("AceLocale-3.0"):GetLocale("HotLoot")

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
    --["classic"] = "Classic",
    --["minimal"] = "Minimal",
    --["holo"] = "Holo",
    ["color"] = "Colored (Any)",
    ["paper"] = "Paper (Large)",
    ["toast"] = "Toast (Large)",
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
                    func = "buttonTestLootMonitor", 
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
                goupLootMonitorSettings = {
                    name = L["genSettings"], 
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
                            disabled = "GetShowItemNamesDisabled",
                            hidden = true, --"GetAdvancedOptions",
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
                            step = 8, 
                            bigStep = 8,
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
                        selectTextSide = {
                            name = L["selectTextSideName"],
                            desc = L["selectTextSideDesc"],
                            type = "select",
                            values = tableDirectionHorizontal,
                            set = "SetTextSide",
                            get = "GetTextSide",
                            order = 4
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
                            func = "buttonEnableAllFiltersGeneral", 
                            order = 1
                        },
                        buttonDisableAllFiltersGeneral = {
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersGeneralDesc"],
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
                            desc = L["buttonEnableAllFiltersProfessionsDesc"],
                            type = "execute",
                            func = "buttonEnableAllFiltersProfessions", 
                            order = 1
                        },
                        buttonDisableAllFiltersProfessions = {
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersProfessionsDesc"],
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
                            desc = L["buttonEnableAllFiltersCommonDesc"],
                            type = "execute",
                            func = "buttonEnableAllFiltersCommon", 
                            order = 1
                        },
                        buttonDisableAllFiltersCommon = {
                            name = L["buttonDisableAll"],
                            desc = L["buttonDisableAllFiltersCommonDesc"],
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
                    desc = L["buttonEnableAllFiltersQualityDesc"],
                    type = "execute",
                    func = "buttonEnableAllFiltersQuality", 
                    order = 1
                },
                buttonDisableAllFiltersQuality = {
                    name = L["buttonDisableAll"],
                    desc = L["buttonDisableAllFiltersQualityDesc"],
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
            name = "Unit Filter",
            type = "group",
            order = 14,
            disabled = false,
            hidden = true,
            args = {
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
                            name = HotLoot:MakeColor("ctrl", L["groupCloseLootWindow"]).."\n"..L["SysHelp1"]..HotLoot:MakeColor("ctrl", L["groupSkinningMode"]).."\n"..L["SysHelp2"],            
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
                            name = HotLoot:MakeColor("ctrl", L["Themes"]).."\n"..L["LMHelp1"],          
                            --..HotLoot:MakeColor("ctrl", L["GridModeGroup"])..L["LMHelp2"]
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
                            name = L["IQHelp1"]..HotLoot:MakeColor("ctrl", L["togglePoorQualityFilterName"]).."\n"..L["IQHelp2"],            
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
                            name = HotLoot:MakeColor("ctrl", L["IEListHelpGroup"]).."\n"..L["IEListHelp1"],         
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
                            name = HotLoot:MakeColor("ctrl", L["selectThresholdTypeName"]).."\n"..L["ThreshHelp1"]..HotLoot:MakeColor("ctrl", L["inputThresholdValueName"]).."\n"..L["ThreshHelp2"]..HotLoot:MakeColor("ctrl", L["toggleUseQuantValueName"]).."\n"..L["ThreshHelp3"],          
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
                    name = HotLoot:MakeColor("ctrl", "HotLoot v"..GetAddOnMetadata("HotLoot", "Version").." ©2016\n\nAuthor:").." Neil Smith\n"..HotLoot:MakeColor("ctrl","Co-author:").." Jessica Mitchell\n"..HotLoot:MakeColor("ctrl","Testing:").."\ndsblack115\n"..HotLoot:MakeColor("ctrl","Translations:").."\nphilipp5796 - German\nMad_Ti - French\n",         
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
        -- inlineQuant = true,
        toggleShowTotalQuant = true,
        selectGrowthDirection = -1, 
        selectTextSide = 0,
        inputMinWidth = "145",
        rangeInitialDelay = 5,
        rangeSecondaryDelay = 1,
        rangeFadeSpeed = 5,
        toggleColorByQuality = true,
        toggleShowAnimation = true,
        selectTheme = "toast",
        fThemeColorR = 0,
        fThemeColorG = 0,
        fThemeColorB = 0,
        fThemeColorA = 0.82,
        fThemeBorderColorR = 1,
        fThemeBorderColorG = 1,
        fThemeBorderColorB = 1,
        fThemeBorderColorA = 1,
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
-- toggleSystemEnable
function HotLoot:SetSystemEnable(info, value)
    self.db.profile.toggleSystemEnable = value;
    HotLoot:DebugOption("toggleSystemEnable", value);
end
function HotLoot:GetSystemEnable(info)
    return self.db.profile.toggleSystemEnable;
end

-- toggleEnableLootMonitor
function HotLoot:SetEnableLootMonitor(info, value)
    self.db.profile.toggleEnableLootMonitor = value;
    HotLoot:DebugOption("toggleEnableLootMonitor", value);
end
function HotLoot:GetEnableLootMonitor(info)
    return self.db.profile.toggleEnableLootMonitor;
end

-- toggleShowLootMonitorAnchor
function HotLoot:SetShowLootMonitorAnchor(info, value)
    self.db.profile.toggleShowLootMonitorAnchor = value;
    HotLoot:DebugOption("toggleShowLootMonitorAnchor", value);
    HotLoot:ToggleAnchor(value);
end
function HotLoot:GetShowLootMonitorAnchor(info)
    return self.db.profile.toggleShowLootMonitorAnchor;
end

-- toggleShowItemNames
function HotLoot:SetShowItemNames(info, value)
    self.db.profile.toggleShowItemNames = value;
    HotLoot:DebugOption("toggleShowItemNames", value);
end
function HotLoot:GetShowItemNames(info)
    return self.db.profile.toggleShowItemNames;
end

-- toggleShowItemQuant
function HotLoot:SetShowItemQuant(info, value)
    self.db.profile.toggleShowItemQuant = value;
    HotLoot:DebugOption("toggleShowItemQuant", value);
end
function HotLoot:GetShowItemQuant(info)
    return self.db.profile.toggleShowItemQuant;
end

--SetShowSellPrice
function HotLoot:SetShowSellPrice(info, value)
    self.db.profile.showSellPrice = value;
    HotLoot:DebugOption("showSellPrice", value);
end
function HotLoot:GetShowSellPrice(info)
    return self.db.profile.showSellPrice;
end

--SetShowItemType
function HotLoot:SetShowItemType(info, value)
    self.db.profile.toggleShowItemType = value;
    HotLoot:DebugOption("toggleShowItemType", value);
end
function HotLoot:GetShowItemType(info)
    return self.db.profile.toggleShowItemType;
end

-- HotLoot:GetShowTotalQuant()
function HotLoot:SetShowTotalQuant(info, value)
    self.db.profile.toggleShowTotalQuant = value
    HotLoot:DebugOption("toggleShowTotalQuant", value)
end
function HotLoot:GetShowTotalQuant(info)
    return self.db.profile.toggleShowTotalQuant
end

-- rangeIconSize
function HotLoot:SetIconSize(info, value)
    self.db.profile.rangeIconSize = value;
    HotLoot:DebugOption("rangeIconSize", value);
end
function HotLoot:GetIconSize(info)
    return self.db.profile.rangeIconSize;
end

-- SetTransparency
function HotLoot:SetTransparency(info, value)
    self.db.profile.rangeTransparency = value;
    HotLoot:DebugOption("rangeTransparency", value);
end
function HotLoot:GetTransparency(info)
    return self.db.profile.rangeTransparency;
end

-- selectGrowthDirection
function HotLoot:SetGrowthDirection(info, value)
    self.db.profile.selectGrowthDirection = value;
    HotLoot:DebugOption("selectGrowthDirection", value);
end
function HotLoot:GetGrowthDirection(info)
    return self.db.profile.selectGrowthDirection;
end

-- HotLoot:GetTextSide()
function HotLoot:SetTextSide(info, value)
    self.db.profile.selectTextSide = value;
    HotLoot:DebugOption("selectTextSide", value);
end
function HotLoot:GetTextSide(info)
    return self.db.profile.selectTextSide;
end

-- SetInlineQuant
function HotLoot:SetInlineQuant(info, value)
    self.db.profile.inlineQuant = value;
    HotLoot:DebugOption("inlineQuant", value);
end
function HotLoot:GetInlineQuant(info)
    return self.db.profile.inlineQuant;
end

-- HotLoot:GetTheme()
function HotLoot:SetTheme(info, value)
    self.db.profile.selectTheme = value;
    HotLoot:DebugOption("selectTheme", value);
    HotLoot:LoadTheme(value);
end
function HotLoot:GetTheme(info)
    return self.db.profile.selectTheme;
end

-- HotLoot:GetColorByQuality()
function HotLoot:SetColorByQuality(info, value)
    self.db.profile.toggleColorByQuality = value;
    HotLoot:DebugOption("toggleColorByQuality", value);
end
function HotLoot:GetColorByQuality(info)
    return self.db.profile.toggleColorByQuality;
end
-- LoadTheme(HotLoot:GetTheme());
-- SetThemeColor
function HotLoot:SetThemeBG(info, r, g, b, a)
    self.db.profile.fThemeColorR = r;
    self.db.profile.fThemeColorG = g;
    self.db.profile.fThemeColorB = b;
    self.db.profile.fThemeColorA = a;
    HotLoot:DebugOption("colorThemeBG", r..", "..g..", "..b..", "..a);
end
function HotLoot:GetThemeBG(info)
    return self.db.profile.fThemeColorR, self.db.profile.fThemeColorG, self.db.profile.fThemeColorB, self.db.profile.fThemeColorA;
end

function HotLoot:SetThemeBorderColor(info, r, g, b, a)
    self.db.profile.fThemeBorderColorR = r;
    self.db.profile.fThemeBorderColorG = g;
    self.db.profile.fThemeBorderColorB = b;
    self.db.profile.fThemeBorderColorA = a;
    HotLoot:DebugOption("colorThemeBorder", r..", "..g..", "..b..", "..a);
end
function HotLoot:GetThemeBorderColor(info)
    return self.db.profile.fThemeBorderColorR, self.db.profile.fThemeBorderColorG, self.db.profile.fThemeBorderColorB, self.db.profile.fThemeBorderColorA;
end

-- inputMinWidth
function HotLoot:SetMinWidth(info, value)
    self.db.profile.inputMinWidth = value;
    HotLoot:DebugOption("inputMinWidth", value);
end
function HotLoot:GetMinWidth(info)
    return self.db.profile.inputMinWidth;
end

-- iDelay
function HotLoot:SetInitialDelay(info, value)
    self.db.profile.rangeInitialDelay = value;
    HotLoot:DebugOption("rangeInitialDelay", value);
end
function HotLoot:GetInitialDelay(info)
    return self.db.profile.rangeInitialDelay;
end

-- SecondaryDelay
function HotLoot:SetSecondaryDelay(info, value)
    self.db.profile.rangeSecondaryDelay = value;
    HotLoot:DebugOption("rangeSecondaryDelay", value);
end
function HotLoot:GetSecondaryDelay(info)
    return self.db.profile.rangeSecondaryDelay;
end

-- fSpeed
function HotLoot:SetFadeSpeed(info, value)
    self.db.profile.rangeFadeSpeed = value;
    HotLoot:DebugOption("rangeFadeSpeed", value);
end
function HotLoot:GetFadeSpeed(info)
    return self.db.profile.rangeFadeSpeed;
end

-- fSpeed
function HotLoot:SetShowAnimation(info, value)
    self.db.profile.toggleShowAnimation = value;
    HotLoot:DebugOption("toggleShowAnimation", value);
end
function HotLoot:GetShowAnimation(info)
    return self.db.profile.toggleShowAnimation;
end

-- lootGridMode
function HotLoot:SetLootGridMode(info, value)
    self.db.profile.lootGridMode = value;
    HotLoot:DebugOption("lootGridMode", value);
end
function HotLoot:GetLootGridMode(info)
    return self.db.profile.lootGridMode;
end

function HotLoot:ToggleGridDisable()
    local namesChecked = HotLoot:GetShowItemNames();
    if namesChecked == true then
        --self.options.args.goupLootMonitor.lootGridMode:SetDisabled(true);
        HotLoot:SetLootGridMode(false);
        return true;
    else
        --self.options.args.goupLootMonitor.lootGridMode:SetDisabled(false);
        return false;
    end
end


-- lootGridNumColumns
function HotLoot:SetLootGridNumColumns(info, value)
    self.db.profile.lootGridNumColumns = value;
    HotLoot:DebugOption("lootGridNumColumns", value);
end
function HotLoot:GetLootGridNumColumns(info)
    return self.db.profile.lootGridNumColumns;
end



-- buttonResetLootMonitor
function HotLoot:buttonResetLootMonitor()
    HotLoot.mainFrame:ClearAllPoints();
    HotLoot.mainFrame:SetPoint("CENTER", 0, 0);
    --HotLoot:UpdateMonitor();
    HotLoot:Announce(L["AnchorReset"]);
end

--buttonEnableAllFiltersGeneral
function HotLoot:buttonEnableAllFiltersGeneral()
    HotLoot:SetGoldFilter(nil, true);
    HotLoot:SetCurrencyFilter(nil, true);
    HotLoot:SetQuestFilter(nil, true);
    HotLoot:SetJunkFilter(nil, true);
    HotLoot:SetPickpocketFilter(nil, true);
end

--buttonDisableAllFiltersGeneral
function HotLoot:buttonDisableAllFiltersGeneral()
    HotLoot:SetGoldFilter(nil, false);
    HotLoot:SetCurrencyFilter(nil, false);
    HotLoot:SetQuestFilter(nil, false);
    HotLoot:SetJunkFilter(nil, false);
    HotLoot:SetPickpocketFilter(nil, false);
end

-- toggleGoldFilter
function HotLoot:SetGoldFilter(info, value)
    self.db.profile.toggleGoldFilter = value;
    HotLoot:DebugOption("toggleGoldFilter", value);
end
function HotLoot:GetGoldFilter(info)
    return self.db.profile.toggleGoldFilter;
end

-- toggleQuestFilter
function HotLoot:SetQuestFilter(info, value)
    self.db.profile.toggleQuestFilter = value;
    HotLoot:DebugOption("toggleQuestFilter", value);
end
function HotLoot:GetQuestFilter(info)
    return self.db.profile.toggleQuestFilter;
end

-- toggleJunkFilter
function HotLoot:SetJunkFilter(info, value)
    self.db.profile.toggleJunkFilter = value;
    HotLoot:DebugOption("toggleJunkFilter", value);
end
function HotLoot:GetJunkFilter(info)
    return self.db.profile.toggleJunkFilter;
end

-- lootJunkDel
function HotLoot:SetPickpocketFilter(info, value)
    self.db.profile.togglePickpocketFilter = value;
    HotLoot:DebugOption("togglePickpocketFilter", value);
end
function HotLoot:GetPickpocketFilter(info)
    return self.db.profile.togglePickpocketFilter;
end

-- SetUnitEnable    SetTypeSelect   SetUnitKeyword  SetUnitLoot SetUnitClose

function HotLoot:SetUnitEnable(info, value)
    self.db.profile.unitEnable = value;
    HotLoot:DebugOption("GetUnitEnable", value);
end
function HotLoot:GetUnitEnable(info)
    return self.db.profile.unitEnable;
end

function HotLoot:SetTypeSelect(info, key, value)
    self.db.profile[key] = value;
    HotLoot:DebugOption(key, value);
end
function HotLoot:GetTypeSelect(info, key)
    return self.db.profile[key];
end

function HotLoot:SetUnitKeyword(info, value)
    self.db.profile.unitKeyword = value;
    HotLoot:DebugOption("UnitKeyword", value);
end
function HotLoot:GetUnitKeyword(info)
    return self.db.profile.unitKeyword;
end

function HotLoot:ToggleKeywordHide()
    local uk = HotLoot:GetTypeSelect(nil,"unitKeyword");
    if uk == true then
        --HotLoot:SetLootGridMode(false);
        return false;
    else
        return true;
    end
end

function HotLoot:SetUnitLoot(info, value)
    self.db.profile.unitLoot = value;
    HotLoot:DebugOption("UnitLoot", value);
end
function HotLoot:GetUnitLoot(info)
    return self.db.profile.unitLoot;
end

function HotLoot:SetUnitClose(info, value)
    self.db.profile.unitClose = value;
    HotLoot:DebugOption("UnitClose", value);
end
function HotLoot:GetUnitClose(info)
    return self.db.profile.unitClose;
end

-- toggleDebugMode
function HotLoot:SetDebugMode(info, value)
    self.db.profile.toggleDebugMode = value;
    HotLoot:DebugOption("toggleDebugMode", value);
end
function HotLoot:GetDebugMode(info)
    return self.db.profile.toggleDebugMode;
end

--toggleAnnounceEvents
function HotLoot:SetAnnounceEvents(info, value)
    self.db.profile.toggleAnnounceEvents = value;
    HotLoot:DebugOption("toggleAnnounceEvents", value);
end
function HotLoot:GetAnnounceEvents(info)
    return self.db.profile.toggleAnnounceEvents;
end

--Minimap
function HotLoot:SetHideMinimapButton(info, value)
    self.db.profile.minimapIcon.hide = value;
    HotLoot:DebugOption("minimapIcon.hide", value);
    if value then
        hIcon:Hide("HotLoot")
    else
        hIcon:Show("HotLoot")
    end
end
function HotLoot:GetHideMinimapButton(info)
    return self.db.profile.minimapIcon.hide;
end

--SettoggleAdvancedOptions
function HotLoot:SetAdvancedOptions(info, value)
    self.db.profile.toggleAdvancedOptions = value;
    HotLoot:DebugOption("toggleAdvancedOptions", value);
end
function HotLoot:GetAdvancedOptions(info)
    return self.db.profile.toggleAdvancedOptions;
end
function HotLoot:GetAdvancedOptionsHidden(info)
    return not self.db.profile.toggleAdvancedOptions;
end

-- toggleCloseLootWindow
function HotLoot:SetCloseLootWindow(info, value)
    self.db.profile.toggleCloseLootWindow = value;
    HotLoot:DebugOption("toggleCloseLootWindow", value);
end
function HotLoot:GetCloseLootWindow(info)
    return self.db.profile.toggleCloseLootWindow;
end

-- selectCloseLootWindowModifier
function HotLoot:SetCloseLootWindowModifier(info, value)
    self.db.profile.selectCloseLootWindowModifier = value;
    HotLoot:DebugOption("selectCloseLootWindowModifier", value);
end
function HotLoot:GetCloseLootWindowModifier(info)
    return self.db.profile.selectCloseLootWindowModifier;
end

-- selectSkinningModeModifier
function HotLoot:SetSkinningModeModifier(info, value)
    self.db.profile.selectSkinningModeModifier = value;
    HotLoot:DebugOption("selectSkinningModeModifier", value);
end
function HotLoot:GetSkinningModeModifier(info)
    return self.db.profile.selectSkinningModeModifier;
end

-- toggleSkinningMode
function HotLoot:SetSkinningMode(info, value)
    if value == true then
        GameTooltip:Hide();
        LibStub("AceConfigDialog-3.0"):Close("HotLoot");
        GameTooltip:Show();
        StaticPopup_Show("CONFIRM_SKINNING_MODE");
    elseif value == "confirmed" then
        self.db.profile.toggleSkinningMode = true;
        HotLoot:DebugOption("toggleSkinningMode", true);
    else
        self.db.profile.toggleSkinningMode = value;
        HotLoot:DebugOption("toggleSkinningMode", value);
    end
end
function HotLoot:GetSkinningMode(info)
    return self.db.profile.toggleSkinningMode;
end

--buttonEnableAllFiltersProfessions
function HotLoot:buttonEnableAllFiltersProfessions()
    HotLoot:SetClothFilter(nil, true);
    HotLoot:SetMiningFilter(nil, true);
    HotLoot:SetGemFilter(nil, true);
    HotLoot:SetHerbFilter(nil, true);
    HotLoot:SetLeatherFilter(nil, true);
    HotLoot:SetFishingFilter(nil, true);
    HotLoot:SetEnchantingFilter(nil, true);
    HotLoot:SetPigmentsFilter(nil, true);
    HotLoot:SetCookingFilter(nil, true);
    HotLoot:SetRecipeFilter(nil, true);
end

--buttonDisableAllFiltersProfessions
function HotLoot:buttonDisableAllFiltersProfessions()
    HotLoot:SetClothFilter(nil, false);
    HotLoot:SetMiningFilter(nil, false);
    HotLoot:SetGemFilter(nil, false);
    HotLoot:SetHerbFilter(nil, false);
    HotLoot:SetLeatherFilter(nil, false);
    HotLoot:SetFishingFilter(nil, false);
    HotLoot:SetEnchantingFilter(nil, false);
    HotLoot:SetPigmentsFilter(nil, false);
    HotLoot:SetCookingFilter(nil, false);
    HotLoot:SetRecipeFilter(nil, false);
end

--toggleClothFilter
function HotLoot:SetClothFilter(info, value)
    self.db.profile.toggleClothFilter = value;
    HotLoot:DebugOption("toggleClothFilter", value);
end
function HotLoot:GetClothFilter(info)
    return self.db.profile.toggleClothFilter;
end

--toggleMiningFilter
function HotLoot:SetMiningFilter(info, value)
    self.db.profile.toggleMiningFilter = value;
    HotLoot:DebugOption("toggleMiningFilter", value);
end
function HotLoot:GetMiningFilter(info)
    return self.db.profile.toggleMiningFilter;
end

--lootOre
--[[function HotLoot:SetLootOre(info, value)
    self.db.profile.lootOre = value;
    HotLoot:DebugOption("lootOre", value);
end
function HotLoot:GetLootOre(info)
    return self.db.profile.lootOre;
end

--lootStone
function HotLoot:SetLootStone(info, value)
    self.db.profile.lootStone = value;
    HotLoot:DebugOption("lootStone", value);
end
function HotLoot:GetLootStone(info)
    return self.db.profile.lootStone;
end
]]
--toggleGemFilter
function HotLoot:SetGemFilter(info, value)
    self.db.profile.toggleGemFilter = value;
    HotLoot:DebugOption("toggleGemFilter", value);
end
function HotLoot:GetGemFilter(info)
    return self.db.profile.toggleGemFilter;
end

--toggleHerbFilter
function HotLoot:SetHerbFilter(info, value)
    self.db.profile.toggleHerbFilter = value;
    HotLoot:DebugOption("toggleHerbFilter", value);
end
function HotLoot:GetHerbFilter(info)
    return self.db.profile.toggleHerbFilter;
end

--toggleLeatherFilter
function HotLoot:SetLeatherFilter(info, value)
    self.db.profile.toggleLeatherFilter = value;
    HotLoot:DebugOption("toggleLeatherFilter", value);
end
function HotLoot:GetLeatherFilter(info)
    return self.db.profile.toggleLeatherFilter;
end

-- toggleFishingFilter
function HotLoot:SetFishingFilter(info, value)
    self.db.profile.toggleFishingFilter = value;
    HotLoot:DebugOption("toggleFishingFilter", value);
end
function HotLoot:GetFishingFilter(info)
    return self.db.profile.toggleFishingFilter;
end

-- toggleEnchantingFilter
function HotLoot:SetEnchantingFilter(info, value)
    self.db.profile.toggleEnchantingFilter = value;
    HotLoot:DebugOption("toggleEnchantingFilter", value);
end
function HotLoot:GetEnchantingFilter(info)
    return self.db.profile.toggleEnchantingFilter;
end

-- toggleCookingFilter
function HotLoot:SetCookingFilter(info, value)
    self.db.profile.toggleCookingFilter = value;
    HotLoot:DebugOption("toggleCookingFilter", value);
end
function HotLoot:GetCookingFilter(info)
    return self.db.profile.toggleCookingFilter;
end

--SetRecipeFilter
function HotLoot:SetRecipeFilter(info, value)
    self.db.profile.toggleRecipeFilter = value;
    HotLoot:DebugOption("toggleRecipeFilter", value);
end
function HotLoot:GetRecipeFilter(info)
    return self.db.profile.toggleRecipeFilter;
end

--SetPigmentsFilter
function HotLoot:SetPigmentsFilter(info, value)
    self.db.profile.togglePigmentsFilter = value;
    HotLoot:DebugOption("togglePigmentsFilter", value);
end
function HotLoot:GetPigmentsFilter(info)
    return self.db.profile.togglePigmentsFilter;
end

--buttonEnableAllFiltersCommon
function HotLoot:buttonEnableAllFiltersCommon()
    HotLoot:SetPotionFilter(nil, true);
    HotLoot:SetFlaskFilter(nil, true);
    HotLoot:SetElixirFilter(nil, true);
    HotLoot:SetElementalFilter(nil, true);
end

--buttonDisableAllFiltersCommon
function HotLoot:buttonDisableAllFiltersCommon()
    HotLoot:SetPotionFilter(nil, false);
    HotLoot:SetFlaskFilter(nil, false);
    HotLoot:SetElixirFilter(nil, false);
    HotLoot:SetElementalFilter(nil, false);
end

-- togglePotionFilter
function HotLoot:SetPotionFilter(info, value)
    self.db.profile.togglePotionFilter = value;
    HotLoot:DebugOption("togglePotionFilter", value);
end
function HotLoot:GetPotionFilter(info)
    return self.db.profile.togglePotionFilter;
end

--SetPotionType
function HotLoot:SetPotionType(info, value)
    self.db.profile.selectPotionType = value;
    HotLoot:DebugOption("selectPotionType", value);
end
function HotLoot:GetPotionType(info)
    return self.db.profile.selectPotionType;
end

-- toggleFlaskFilter
function HotLoot:SetFlaskFilter(info, value)
    self.db.profile.toggleFlaskFilter = value;
    HotLoot:DebugOption("toggleFlaskFilter", value);
end
function HotLoot:GetFlaskFilter(info)
    return self.db.profile.toggleFlaskFilter;
end

-- toggleElixirFilter
function HotLoot:SetElixirFilter(info, value)
    self.db.profile.toggleElixirFilter = value;
    HotLoot:DebugOption("toggleElixirFilter", value);
end
function HotLoot:GetElixirFilter(info)
    return self.db.profile.toggleElixirFilter;
end

-- SetElementalFilter
function HotLoot:SetElementalFilter(info, value)
    self.db.profile.toggleElementalFilter = value;
    HotLoot:DebugOption("toggleElementalFilter", value);
end
function HotLoot:GetElementalFilter(info)
    return self.db.profile.toggleElementalFilter;
end

--SetLootBotA
-- function HotLoot:SetLootBotA(info, value)
--  self.db.profile.lootBotA = value;
--  HotLoot:DebugOption("lootBotA", value);
-- end
-- function HotLoot:GetLootBotA(info)
--  return self.db.profile.lootBotA;
-- end

--SetLootDoEM
-- function HotLoot:SetLootDoEM(info, value)
--  self.db.profile.lootDoEM = value;
--  HotLoot:DebugOption("lootDoEM", value);
-- end
-- function HotLoot:GetLootDoEM(info)
--  return self.db.profile.lootDoEM;
-- end

--SetLootSC
-- function HotLoot:SetLootSC(info, value)
--  self.db.profile.lootSC = value;
--  HotLoot:DebugOption("lootSC", value);
-- end
-- function HotLoot:GetLootSC(info)
--  return self.db.profile.lootSC;
-- end

--SetLootRepMeat
-- function HotLoot:SetLootRepMeat(info, value)
--  self.db.profile.lootRepMeat = value;
--  HotLoot:DebugOption("lootRepMeat", value);
-- end
-- function HotLoot:GetLootRepMeat(info)
--  return self.db.profile.lootRepMeat;
-- end

--buttonEnableAllFiltersQuality
function HotLoot:buttonEnableAllFiltersQuality()
    HotLoot:SetPoorQualityFilter(nil, true);
    HotLoot:SetCommonQualityFilter(nil, true);
    HotLoot:SetUncommonQualityFilter(nil, true);
    HotLoot:SetRareQualityFilter(nil, true);
    HotLoot:SetEpicQualityFilter(nil, true);
    HotLoot:SetLegendaryQualityFilter(nil, true);
    HotLoot:SetArtifactQualityFilter(nil, true);
    HotLoot:SetHeirloomQualityFilter(nil, true);
end

--buttonDisableAllFiltersQuality
function HotLoot:buttonDisableAllFiltersQuality()
    HotLoot:SetPoorQualityFilter(nil, false);
    HotLoot:SetCommonQualityFilter(nil, false);
    HotLoot:SetUncommonQualityFilter(nil, false);
    HotLoot:SetRareQualityFilter(nil, false);
    HotLoot:SetEpicQualityFilter(nil, false);
    HotLoot:SetLegendaryQualityFilter(nil, false);
    HotLoot:SetArtifactQualityFilter(nil, false);
    HotLoot:SetHeirloomQualityFilter(nil, false);
end

--togglePoorQualityFilter
function HotLoot:SetPoorQualityFilter(info, value)
    self.db.profile.togglePoorQualityFilter = value;
    HotLoot:DebugOption("togglePoorQualityFilter", value);
end
function HotLoot:GetPoorQualityFilter(info)
    return self.db.profile.togglePoorQualityFilter;
end

--SetSellPoorItems
function HotLoot:SetSellPoorItems(info, value)
    self.db.profile.toggleSellPoorItems = value;
    HotLoot:DebugOption("toggleSellPoorItems", value);
end
function HotLoot:GetSellPoorItems(info)
    return self.db.profile.toggleSellPoorItems;
end

--toggleCommonQualityFilter
function HotLoot:SetCommonQualityFilter(info, value)
    self.db.profile.toggleCommonQualityFilter = value;
    HotLoot:DebugOption("toggleCommonQualityFilter", value);
end
function HotLoot:GetCommonQualityFilter(info)
    return self.db.profile.toggleCommonQualityFilter;
end

--toggleUncommonQualityFilter
function HotLoot:SetUncommonQualityFilter(info, value)
    self.db.profile.toggleUncommonQualityFilter = value;
    HotLoot:DebugOption("toggleUncommonQualityFilter", value);
end
function HotLoot:GetUncommonQualityFilter(info)
    return self.db.profile.toggleUncommonQualityFilter;
end

--toggleRareQualityFilter
function HotLoot:SetRareQualityFilter(info, value)
    self.db.profile.toggleRareQualityFilter = value;
    HotLoot:DebugOption("toggleRareQualityFilter", value);
end
function HotLoot:GetRareQualityFilter(info)
    return self.db.profile.toggleRareQualityFilter;
end

--toggleEpicQualityFilter
function HotLoot:SetEpicQualityFilter(info, value)
    self.db.profile.toggleEpicQualityFilter = value;
    HotLoot:DebugOption("toggleEpicQualityFilter", value);
end
function HotLoot:GetEpicQualityFilter(info)
    return self.db.profile.toggleEpicQualityFilter;
end

--toggleLegendaryQualityFilter
function HotLoot:SetLegendaryQualityFilter(info, value)
    self.db.profile.toggleLegendaryQualityFilter = value;
    HotLoot:DebugOption("toggleLegendaryQualityFilter", value);
end
function HotLoot:GetLegendaryQualityFilter(info)
    return self.db.profile.toggleLegendaryQualityFilter;
end

--toggleArtifactQualityFilter
function HotLoot:SetArtifactQualityFilter(info, value)
    self.db.profile.toggleArtifactQualityFilter = value;
    HotLoot:DebugOption("toggleArtifactQualityFilter", value);
end
function HotLoot:GetArtifactQualityFilter(info)
    return self.db.profile.toggleArtifactQualityFilter;
end

--toggleHeirloomQualityFilter
function HotLoot:SetHeirloomQualityFilter(info, value)
    self.db.profile.toggleHeirloomQualityFilter = value;
    HotLoot:DebugOption("toggleHeirloomQualityFilter", value);
end
function HotLoot:GetHeirloomQualityFilter(info)
    return self.db.profile.toggleHeirloomQualityFilter;
end

--inputMinItemLevel
function HotLoot:SetMinItemLevel(info, value)
    if value == '' or not tonumber(value) then
        self.db.profile.inputMinItemLevel = 0;
        HotLoot:Debug("inputMinItemLevel not set (defaulting to 0)");
    else
        self.db.profile.inputMinItemLevel = value;
        HotLoot:DebugOption("inputMinItemLevel", value);
    end
end
function HotLoot:GetMinItemLevel(info)
    return self.db.profile.inputMinItemLevel;
end

--toggleCurrencyFilter
function HotLoot:SetCurrencyFilter(info, value)
    self.db.profile.toggleCurrencyFilter = value;
    HotLoot:DebugOption("toggleCurrencyFilter", value);
end
function HotLoot:GetCurrencyFilter(info)
    return self.db.profile.toggleCurrencyFilter;
end
function HotLoot:ToCopper(input)
    local gold = tonumber(string.match(input,"(%d+)%s?[gG]")) or 0;
    local silver = tonumber(string.match(input,"(%d+)%s?[sS]")) or 0;
    local copper = tonumber(string.match(input,"(%d+)%s?[cC]")) or 0;
    local total = (gold*10000)+(silver*100)+(copper);
    return total;
end

-- inputIncludeListAdd
function HotLoot:SetIncludeListAdd(info, value)
    --self.db.profile.inputIncludeListAdd = value
    HotLoot:DebugOption("inputIncludeListAdd", value)
    HotLoot:AddToIncludeList(value)
end
function HotLoot:GetIncludeListAdd(info)
    --return self.db.profile.inputIncludeListAdd;
end

function HotLoot:SetIncludeListSelect(info, value)
    self.db.profile.selectIncludeList = value
    HotLoot:DebugOption("selectIncludeList", value)
end
function HotLoot:GetIncludeListSelect(info)
    return self.db.profile.selectIncludeList;
end

function HotLoot:SetIncludeList(value)
    self.db.profile.tableIncludeList[value] = value
    HotLoot:DebugOption("tableIncludeList", value)
end
function HotLoot:GetIncludeList()
    return self.db.profile.tableIncludeList;
end
--toggleShowIncludeButton
function HotLoot:SetShowIncludeButton(info, value)
    self.db.profile.toggleShowIncludeButton = value
    HotLoot:DebugOption("toggleShowIncludeButton", value)
end
function HotLoot:GetShowIncludeButton()
    return self.db.profile.toggleShowIncludeButton;
end

-- inputExcludeListAdd
function HotLoot:SetExcludeListAdd(info, value)
    --self.db.profile.inputExcludeListAdd = value
    HotLoot:DebugOption("inputExcludeListAdd", value)
    HotLoot:AddToExcludeList(value)
end
function HotLoot:GetExcludeListAdd(info)
    --return self.db.profile.includeList;
end

function HotLoot:SetExcludeListSelect(info, value)
    self.db.profile.selectExcludeList = value
    HotLoot:DebugOption("selectExcludeList", value)
end
function HotLoot:GetExcludeListSelect(info)
    return self.db.profile.selectExcludeList;
end

function HotLoot:SetExcludeList(value)
    self.db.profile.tableExcludeList[value] = value
    HotLoot:DebugOption("tableExcludeList", value)
end
function HotLoot:GetExcludeList()
    return self.db.profile.tableExcludeList;
end

--excludeButton
function HotLoot:SetShowExcludeButton(info, value)
    self.db.profile.toggleShowExcludeButton = value
    HotLoot:DebugOption("toggleShowExcludeButton", value)
end
function HotLoot:GetShowExcludeButton()
    return self.db.profile.toggleShowExcludeButton;
end

--selectThresholdType1 
function HotLoot:SetThresholdType1(info, value)
    self.db.profile.selectThresholdType1 = value;
    HotLoot:DebugOption("selectThresholdType1", value);
end
function HotLoot:GetThresholdType1(info)
    return self.db.profile.selectThresholdType1;
end

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

--selectThresholdType2
function HotLoot:SetThresholdType2(info, value)
    self.db.profile.selectThresholdType2 = value;
    HotLoot:DebugOption("selectThresholdType2", value);
end
function HotLoot:GetThresholdType2(info)
    return self.db.profile.selectThresholdType2;
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

--selectThresholdType3
function HotLoot:SetThresholdType3(info, value)
    self.db.profile.selectThresholdType3 = value;
    HotLoot:DebugOption("selectThresholdType3", value);
end
function HotLoot:GetThresholdType3(info)
    return self.db.profile.selectThresholdType3;
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

-- toggleUseQuantValue
function HotLoot:SetUseQuantValue(info, value)
    self.db.profile.toggleUseQuantValue = value;
    HotLoot:DebugOption("toggleUseQuantValue", value);
end
function HotLoot:GetUseQuantValue(info)
    return self.db.profile.toggleUseQuantValue;
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

--SetWatchList
function HotLoot:SetWatchList(info, value)
    self.db.profile.watchListD = value;
    HotLoot:DebugOption("watchList", value);
end
function HotLoot:GetWatchList(info)
    return self.db.profile.watchListD;
end

function HotLoot:SetTrackerName(info, value)
    self.db.profile.trackerName = value;
    HotLoot:DebugOption("trackerName", value);
end
function HotLoot:GetTrackerName(info)
    return self.db.profile.trackerName;
end

function HotLoot:SetTrackerGoal(info, value)
    self.db.profile.trackerGoal = value;
    HotLoot:DebugOption("trackerGoal", value);
end
function HotLoot:GetTrackerGoal(info)
    return self.db.profile.trackerGoal;
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







