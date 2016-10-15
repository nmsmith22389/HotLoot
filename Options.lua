local L = LibStub("AceLocale-3.0"):GetLocale("HotLoot")

watchListTable = {}
local unitTable = {
    ["rare"] = "Rare",
    ["boss"] = "Boss",
    ["chest"] = "Chest",
    ["unitKeyword"] = "Unit Keyword"
}

local closeKeyTable = {
    ["0"] = "None",
    ["ctrl"] = "Control",
    ["shift"] = "Shift",
    ["alt"] = "Alt"
}

local growthDirectionTable = {
    [1] = L["Up"],
    [-1] = L["Down"]
}

-- SetTextSide
local textSideTable = {
    [0] = L["Right"],
    [1] = L["Left"]
}

--potionTypeTable
local potionTypeTable = {
    ["both"] = L["Both"],
    ["healing"] = L["Healing"],
    ["mana"] = L["Mana"],
}

local itemTypeTable = {
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
    ["z1Poor"] = "|cff9d9d9d"..L["Poor"].."|r",
    ["z2Common"] = "|cffffffff"..L["Common"].."|r",
    ["z3Uncommon"] = "|cff1eff00"..L["Uncommon"].."|r",
    ["z4Rare"] = "|cff0070dd"..L["Rare"].."|r",
    ["z5Epic"] = "|cffa335ee"..L["Epic"].."|r",
    ["z6Legendary"] = "|cffff8000"..L["Legendary"].."|r",
    ["z7Artifact"] = ITEM_QUALITY_COLORS[6].hex..ITEM_QUALITY6_DESC.."|r",
    ["z8Heirloom"] = ITEM_QUALITY_COLORS[7].hex..ITEM_QUALITY7_DESC.."|r",
    ["Include"] = L["Include List"],
}

local themeTable = {
    --["classic"] = "Classic",
    --["minimal"] = "Minimal",
    --["holo"] = "Holo",
    ["paper"] = "Paper (Large)",
    ["color"] = "Colored (Any)",
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
        lootDesc = {
            name = L["lootDesc"],           
            type = "description",
            order = 0
        },
        lootDesc3 = {
            name = L["lootDesc3"],  
            type = "description",
            order = 2
        },
        enable = {
            name = L["EnableName"],
            desc = L["EnableDesc"],
            type = "toggle",
            set = "SetLootEnabled",
            get = "GetLootEnabled",
            hidden = true
        },
        debug = {
            name = L["DebugName"],
            desc = L["DebugDesc"],
            type = "toggle",
            set = "SetLootDebug",
            get = "GetLootDebug",
            hidden = true
        },
        autoclose = {
            name = L["ACEnableName"],
            desc = L["ACEnableDesc"],
            type = "toggle",
            set = "SetLootClose",
            get = "GetLootClose",
            hidden = true
        },
        skinmode = {
            name = "Enable",
            desc = "Skinning mode will pick up and delete any items left over after autolooting.\n|cFFFF0000(WARNING: use with caution this deletes items. HL is not responsible for lost items.)",
            type = "toggle",
            set = "SetLootSkinMode",
            get = "GetLootSkinMode",
            confirm = true,
            hidden = true
        },
        monitor = {
            name = "Enable Loot Monitor",
            type = "toggle",
            set = "SetLootEnableMonitor",
            get = "GetLootEnableMonitor",
            hidden = true
        },
        groupSystem = {
            name = "System",
            type = "group",
            order = 4,
            
            args = {
                lootEnabled = {
                    name = L["EnableName"],
                    desc = L["EnableDesc"],
                    type = "toggle",
                    set = "SetLootEnabled",
                    get = "GetLootEnabled",
                    order = 1
                },
                lootDebug = {
                    name = L["DebugName"],
                    desc = L["DebugDesc"],
                    type = "toggle",
                    set = "SetLootDebug",
                    get = "GetLootDebug",
                    hidden = "Advanced",
                    order = 5
                },
                lootAnnounce = {
                    name = L["AnnounceName"],
                    desc = L["AnnounceDesc"],
                    type = "toggle",
                    set = "SetLootAnnounce",
                    get = "GetLootAnnounce",
                    order = 3
                },
                lootMinimap = {
                    name = L["HideMMName"],
                    desc = L["HideMMDesc"],
                    type = "toggle",
                    set = "SetMinimap",
                    get = "GetMinimap",
                    order = 2
                },
                lootAdvanced = {
                    name = L["AdvancedName"],
                    desc = L["AdvancedDesc"],
                    type = "toggle",
                    set = "SetLootAdvanced",
                    get = "GetLootAdvanced",
                    order = 4
                },
                groupLWindow = {
                    name = L["ACGroup"],
                    type = "group",
                    order = 50,
                    inline = true,
                    args = {
                        lootClose = {
                            name = L["ACEnableName"],
                            desc = L["ACEnableDesc"],
                            type = "toggle",
                            set = "SetLootClose",
                            get = "GetLootClose",
                            order = 1
                        },
                        lootCloseKey = {
                            name = L["ACKeyName"],
                            desc = L["ACKeyDesc"],
                            type = "select",
                            values = closeKeyTable,
                            set = "SetLootCloseKey",
                            get = "GetLootCloseKey",
                            order = 2
                        },
                    },
                },
                groupSkinning = {
                    name = L["SkinningGroup"],
                    type = "group",
                    order = 100,
                    inline = true,
                    --hidden = "Advanced",
                    args = {
                        lootSkinKey = {
                            name = L["SkinningKeyName"],
                            desc = L["SkinningKeyDesc"],
                            type = "select",
                            values = closeKeyTable,
                            set = "SetLootSkinKey",
                            get = "GetLootSkinKey",
                            order = 2
                        },
                        skinmode = {
                            name = L["SkinningEnableName"],
                            desc = L["SkinningEnableDesc"],
                            type = "toggle",
                            set = "SetLootSkinMode",
                            get = "GetLootSkinMode",
                            confirm = true,
                            order = 1
                        },
                    },
                },
            }, 
        },
        goupLootMonitor = {
            name = L["LootMonGroup"], 
            type = "group", 
            order = 5, 
            childGroups = "tab",
            args = {
                goupLootMonitor1 = {
                    name = L["GeneralGroup"], 
                    type = "group", 
                    order = 5, 
                    args = {
                        lootEnableMonitor = {
                            name = L["LootMonName"],
                            desc = L["LootMonDesc"],
                            type = "toggle",
                            set = "SetLootEnableMonitor",
                            get = "GetLootEnableMonitor",
                            width = "double",
                            order = 1
                        },
                        lootShowAnchor = {
                            name = L["ShowAnchName"],
                            desc = L["ShowAnchDesc"],
                            type = "toggle",
                            set = "SetLootShowAnchor",
                            get = "GetLootShowAnchor",
                            width = "double",
                            order = 2
                        },
                        lootShowNames = {
                            name = L["ShowNamesName"],
                            desc = L["ShowNamesDesc"],
                            type = "toggle",
                            set = "SetLootShowNames",
                            get = "GetLootShowNames",
                            disabled = "ToggleNamesDisable",
                            hidden = true, --"Advanced",
                            width = "double",
                            order = 3
                        },
                        lootShowQuantities = {
                            name = L["ShowQuantName"],
                            desc = L["ShowQuantDesc"],
                            type = "toggle",
                            set = "SetLootShowQuantities",
                            get = "GetLootShowQuantities",
                            width = "double",
                            order = 4
                        },
                        inlineQuant = {
                            name = L["InlineQuantName"],
                            desc = L["InlineQuantDesc"],
                            type = "toggle",
                            set = "SetInlineQuant",
                            get = "GetInlineQuant",
                            hidden = true,
                            --hidden = "Advanced",
                            width = "double",
                            order = 5
                        },
                        lootShowTotal = {
                            name = L["ShowTotName"],
                            desc = L["ShowTotDesc"],
                            type = "toggle",
                            set = "SetShowTotal",
                            get = "GetShowTotal",
                            width = "double",
                            order = 6
                        },
                        lootShowSellPrice = {
                            name = L["ShowSellName"],
                            desc = L["ShowSellDesc"],
                            type = "toggle",
                            set = "SetShowSellPrice",
                            get = "GetShowSellPrice",
                            width = "double",
                            order = 7
                        },
                        lootShowItemType = {
                            name = L["ShowTypeName"],
                            desc = L["ShowTypeDesc"],
                            type = "toggle",
                            set = "SetShowItemType",
                            get = "GetShowItemType",
                            width = "double",
                            order = 8
                        },
                        groupGridMode = {
                            name = L["GridModeGroup"],
                            type = "group",
                            order = 15,
                            inline = true,
                            hidden = true,
                            --hidden = "Advanced",
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
                goupLootMonitor2 = {
                    name = L["Appearance"], 
                    type = "group", 
                    order = 6, 
                    args = {
                        lootIconSize = {
                            name = L["IconSizeName"],
                            desc = L["IconSizeDesc"],
                            type = "range",
                            min = 16,
                            max = 32,
                            step = 8, 
                            bigStep = 8,
                            disabled = "ToggleSizeDisable",
                            set = "SetLootIconSize",
                            get = "GetLootIconSize",
                            hidden = "Advanced",
                            order = 7
                        },
                        lootTransparency = {
                            name = L["TransName"],
                            desc = L["TransDesc"],
                            type = "range",
                            min = 0,
                            max = 1,
                            step = 0.1, 
                            bigStep = 0.1,
                            set = "SetLootTrans",
                            get = "GetLootTrans",
                            --hidden = "Advanced",
                            order = 8
                        },
                        lootGrowthDirection = {
                            name = L["GrowthDircName"],
                            desc = L["GrowthDircDesc"],
                            type = "select",
                            values = growthDirectionTable,
                            set = "SetLootGrowthDirection",
                            get = "GetLootGrowthDirection",
                            order = 9
                        },
                        textSide = {
                            name = L["TxtSideName"],
                            desc = L["TxtSideDesc"],
                            type = "select",
                            values = textSideTable,
                            set = "SetTextSide",
                            get = "GetTextSide",
                            order = 10
                        },
                        
                        themeSelect = {
                            name = L["ThemeSelName"],
                            desc = L["ThemeSelDesc"],
                            type = "select",
                            values = themeTable,
                            set = "SetThemeSelect",
                            get = "GetThemeSelect",
                            --disabled = true,
                            order = 11
                        },
                        colorQual = {
                            name = L["ColorQualName"],
                            desc = L["ColorQualDesc"],
                            type = "toggle",
                            set = "SetColorQual",
                            get = "GetColorQual",
                            hidden = "ColorHide",
                            --disabled = true,
                            order = 12
                        },
                        themeColorSelect = {
                            name = L["ThemeColorSelect"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            set = "SetThemeColorSelect",
                            get = "GetThemeColorSelect",
                            hidden = "ColorHide",
                            hasAlpha = true,
                            --disabled = true,
                            order = 13
                        },
                        themeColorBorderSelect = {
                            name = L["ThemeColorBorderSelect"],
                            --desc = L["ThemeSelDesc"],
                            type = "color",
                            set = "SetThemeColorBorderSelect",
                            get = "GetThemeColorBorderSelect",
                            hidden = "ColorHide",
                            hasAlpha = true,
                            --disabled = true,
                            order = 14
                        },
                        minWidth = {
                            name = L["MinWidthName"],
                            desc = L["MinWidthDesc"],
                            type = "input",
                            --width = "half",
                            set = "SetMinWidth",
                            get = "GetMinWidth",
                            hidden = "Advanced",
                            order = 15
                        },
                        initialDelay = {
                            name = L["InitDelayName"],
                            desc = L["InitDelayDesc"],
                            type = "range",
                            min = 1,
                            max = 10,
                            step = 1, 
                            bigStep = 1,
                            --width = "half",
                            set = "SetIDelay",
                            get = "GetIDelay",
                            hidden = "Advanced",
                            order = 16
                        },
                        secondaryDelay = {
                            name = L["SecDelayName"],
                            desc = L["SecDelayDesc"],
                            type = "range",
                            min = 1,
                            max = 10,
                            step = 1, 
                            bigStep = 1,
                            --width = "half",
                            set = "SetSDelay",
                            get = "GetSDelay",
                            hidden = "Advanced",
                            order = 17
                        },
                        fadeSpeed = {
                            name = L["FadeDelayName"],
                            desc = L["FadeDelayDesc"],
                            type = "range",
                            min = 5,
                            max = 15,
                            step = 1, 
                            bigStep = 1,
                            hidden = "Advanced",
                            set = "SetFSpeed",
                            get = "GetFSpeed",
                            order = 18
                        },
                        showAnim = {
                            name = L["ShowAnimationName"],
                            desc = L["ShowAnimationDesc"],
                            type = "toggle",
                            set = "SetShowAnimation",
                            get = "GetShowAnimation",
                            --hidden = "ColorHide",
                            --disabled = true,
                            order = 19
                        }
                    }
                },
                lootTestMonitor = {
                    name = L["TestMonName"],
                    --desc = " ",
                    type = "execute",
                    func = "TestMonitor", 
                    order = 30
                },
                lootResetMonitor = {
                    name = L["ResetMonName"],
                    --desc = " ",
                    type = "execute",
                    func = "ResetMonitor", 
                    order = 31
                },
                lootDesc = {
                    name = L["MonDescName"],
                    type = "description",
                    hidden = true,
                    order = 65,
                }
            }
        },
        groupFilters = {
            name = L["FilterGroup"],
            type = "group",
            order = 6,
            args = {
                groupGeneral = {
                    name = L["GeneralGroup"],
                    type = "group",
                    order = 1,
                    inline = true,
                    args = {
                lootGold = {
                    name = L["GoldFilterName"],
                    desc = L["GoldFilterDesc"],
                    type = "toggle",
                    set = "SetLootGold",
                    get = "GetLootGold",
                    order = 1
                },
                lootCurrency = {
                    name = L["CurrFilterName"],
                    desc = L["CurrFilterDesc"],
                    type = "toggle",
                    set = "SetLootCurrency",
                    get = "GetLootCurrency",
                    order = 2
                },
                lootQuest = {
                    name = L["QuestFilterName"],
                    desc = L["QuestFilterDesc"],
                    type = "toggle",
                    set = "SetLootQuest",
                    get = "GetLootQuest",
                    order = 3
                },
                lootJunk = {
                    name = L["JunkFilterName"], 
                    desc = L["JunkFilterDesc"],
                    type = "toggle",
                    set = "SetLootJunk",
                    get = "GetLootJunk",
                    order = 4,
                    hidden = true
                },
                
                lootPick = {
                    name = L["PickFilterName"], 
                    desc = L["PickFilterName"],
                    type = "toggle",
                    set = "SetLootPick",
                    get = "GetLootPick",
                    order = 5
                },
            },
        },
        groupProfessions = {
            name = L["ProfessionsGroup"],
            type = "group",
            order = 2,
            inline = true,
            args = {
                lootCloth = {
                    name = L["ClothFilterName"],
                    desc = L["ClothFilterDesc"],
                    type = "toggle",
                    set = "SetLootCloth",
                    get = "GetLootCloth",
                    order = 0
                },
                lootMining = {
                    name = L["OreFilterName"],
                    desc = L["OreFilterDesc"],
                    type = "toggle",
                    set = "SetLootMining",
                    get = "GetLootMining",
                    order = 1
                },
                lootGems = {
                    name = L["GemFilterName"],
                    desc = L["GemFilterDesc"],
                    type = "toggle",
                    set = "SetLootGems",
                    get = "GetLootGems",
                    order = 2
                },
                lootHerbs = {
                    name = L["HerbFilterName"],
                    desc = L["HerbFilterDesc"],
                    type = "toggle",
                    set = "SetLootHerbs",
                    get = "GetLootHerbs",
                    order = 3
                },
                lootSkinning = {
                    name = L["LeatherFilterName"],
                    desc = L["LeatherFilterDesc"],
                    type = "toggle",
                    set = "SetLootSkinning",
                    get = "GetLootSkinning",
                    order = 4
                },
                lootFishing = {
                    name = L["FishingFilterName"],
                    desc = L["FishingFilterDesc"],
                    type = "toggle",
                    set = "SetLootFishing",
                    get = "GetLootFishing",
                    order = 5
                },
                lootEnchanting = {
                    name = L["EnchantingFilterName"],
                    desc = L["EnchantingFilterDesc"],
                    type = "toggle",
                    set = "SetLootEnchanting",
                    get = "GetLootEnchanting",
                    order = 6
                },
                lootPigments = {
                    name = L["PigmentsFilterName"],
                    desc = L["PigmentsFilterDesc"],
                    type = "toggle",
                    set = "SetLootPigments",
                    get = "GetLootPigments",
                    order = 7
                },
                lootCooking = {
                    name = L["CookingFilterName"],
                    desc = L["CookingFilterDesc"],
                    --\n\n|cff1eff00Note: Blizzard has cooking ingredients spread all over different categories but this should get most of them.|r
                    type = "toggle",
                    set = "SetLootCooking",
                    get = "GetLootCooking",
                    width = "full",
                    order = 9
                },
                lootRecipes = {
                    name = L["RecipeFilterName"],
                    desc = L["RecipeFilterDesc"],
                    type = "toggle",
                    set = "SetLootRecipes",
                    get = "GetLootRecipes",
                    order = 10
                },
                
            }
        },
        groupDrops = {
            name = L["DropsGroup"],
            type = "group",
            order = 3,
            inline = true,
            args = {
                lootPots = {
                    name = L["PotionFilterName"],
                    desc = L["PotionFilterDesc"],
                    type = "toggle",
                    set = "SetLootPots",
                    get = "GetLootPots",
                    order = 2
                },
                potionType = {
                    name = L["PotionType"],
                    type = "select",
                    set = "SetPotionType",
                    get = "GetPotionType",
                    values = potionTypeTable,
                    order = 3,
                },
                lootFlasks = {
                    name = L["FlaskFilterName"],
                    desc = L["FlaskFilterDesc"],
                    type = "toggle",
                    set = "SetLootFlasks",
                    get = "GetLootFlasks",
                    order = 4
                },
                lootElixirs = {
                    name = L["ElixirFilterName"],
                    desc = L["ElixirFilterDesc"],
                    type = "toggle",
                    set = "SetLootElixirs",
                    get = "GetLootElixirs",
                    order = 5
                },
                lootMoH = {
                    name = L["MoHFilterName"],
                    desc = L["MoHFilterDesc"],
                    type = "toggle",
                    set = "SetLootMoH",
                    get = "GetLootMoH",
                    width = "double",
                    order = 7
                },
                lootElemental = {
                    name = L["EleFilterName"],
                    desc = L["EleFilterDesc"],
                    type = "toggle",
                    set = "SetLootElemental",
                    get = "GetLootElemental",
                    order = 6
                },  
            },
        },
        },
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
        groupQuality = {
            name = L["ItemQualityGroup"],
            type = "group",
            order = 10,
            args = {
                magicDesc1 = {
                    name = L["ItemQualityDesc"],
                    type = "description",
                    order = 0,
                },
                lootPoor = {
                    name = L["PoorFilterName"],
                    desc = L["PoorFilterDesc"],
                    type = "toggle",
                    set = "SetLootPoor",
                    get = "GetLootPoor",
                    width = "full",
                    order = 1,
                },
                sellPoor = {
                    name = L["PoorSellName"],
                    desc = L["PoorSellDesc"],
                    type = "toggle",
                    set = "SetSellGreys",
                    get = "GetSellGreys",
                    width = "full",
                    order = 2,
                },
                spacerQ1 = {
                    name = "",          
                    type = "description",
                    order = 3,
                },
                lootCommon = {
                    name = L["CommonFilterName"],
                    desc = L["CommonFilterDesc"],
                    type = "toggle",
                    set = "SetLootCommon",
                    get = "GetLootCommon",
                    width = "full",
                    order = 4,
                },
                spacerQ2 = {
                    name = "",          
                    type = "description",
                    order = 5,
                },
                lootUncommon = {
                    name = L["UncommonFilterName"],
                    desc = L["UncommonFilterDesc"],
                    type = "toggle",
                    set = "SetLootUncommon",
                    get = "GetLootUncommon",
                    order = 6,
                    width = "full",
                },  
                spacerQ3 = {
                    name = "",          
                    type = "description",
                    order = 7,
                },
                lootRare = {
                    name = L["RareFilterName"],
                    desc = L["RareFilterDesc"],
                    type = "toggle",
                    set = "SetLootRare",
                    get = "GetLootRare",
                    width = "full",
                    order = 8,
                },
                spacerQ4 = {
                    name = "",          
                    type = "description",
                    order = 9,
                },
                lootEpic = {
                    name = L["EpicFilterName"],
                    desc = L["EpicFilterDesc"],
                    type = "toggle",
                    set = "SetLootEpic",
                    get = "GetLootEpic",
                    width = "full",
                    order = 10,
                },
                spacerQ5 = {
                    name = "",          
                    type = "description",
                    order = 11,
                },
                lootLegendary = {
                    name = L["LegendaryFilterName"],
                    desc = L["LegendaryFilterDesc"],
                    type = "toggle",
                    set = "SetLootLegendary",
                    get = "GetLootLegendary",
                    width = "full",
                    order = 12,
                },
                spacerQ6 = {
                    name = "",          
                    type = "description",
                    order = 13,
                },
                lootArtifact = {
                    name = L["ArtifactFilterName"],
                    desc = L["ArtifactFilterDesc"],
                    type = "toggle",
                    set = "SetLootArtifact",
                    get = "GetLootArtifact",
                    width = "full",
                    order = 14,
                },
                spacerQ7 = {
                    name = "",          
                    type = "description",
                    order = 15,
                },
                lootHeirloom = {
                    name = L["HeirloomFilterName"],
                    desc = L["HeirloomFilterDesc"],
                    type = "toggle",
                    set = "SetLootHeirloom",
                    get = "GetLootHeirloom",
                    width = "full",
                    order = 16,
                },
                minILvl = {
                    name = L["MinimumItemLevelName"],
                    desc = L["MinimumItemLevelDesc"],           
                    type = "input",
                    -- pattern = "%d+",
                    set = "SetMinILvl",
                    get = "GetMinILvl",
                    order = 17,
                },
            },
        },
        groupInclude = {
            name = L["InExGroup"],
            type = "group",
            order = 11,
            args = {
                includeHeader = {
                    name = L["IncludeHeader"],
                    type = "header",
                    order = 0,
                },
                includeDrop = {
                    name = L["IncludeListName"],
                    type = "select",
                    set = "SetIncludeDrop",
                    get = "GetIncludeDrop",
                    values = "GetIncludeTable",
                    order = 1,
                },
                includeList = {
                    name = L["IncludeInputName"],
                    --multiline = 10,
                    type = "input",
                    set = "SetIncludeList",
                    get = "GetIncludeList",
                    --width = "full",
                    order = 2
                },
                includeRemove = {
                    name = L["IncludeRemoveName"],
                    type = "execute",
                    func = "RemoveIList",
                    order = 3,
                },
                includeButton = {
                    name = L["IncludeButtonName"],
                    desc = L["IncludeButtonDesc"],
                    type = "toggle",
                    set = "SetIncludeButton",
                    get = "GetIncludeButton",
                    order = 4,
                    --hidden = true
                },
                excludeHeader = {
                    name = L["ExcludeHeader"],
                    type = "header",
                    order = 5,
                },
                excludeDrop = {
                    name = L["ExcludeListName"],
                    type = "select",
                    set = "SetExcludeDrop",
                    get = "GetExcludeDrop",
                    values = "GetExcludeTable",
                    order = 6,
                },
                excludeList = {
                    name = L["ExcludeInputName"],
                    --multiline = 10,
                    type = "input",
                    set = "SetExcludeList",
                    get = "GetExcludeList",
                    --width = "full",
                    order = 7
                },
                excludeRemove = {
                    name = L["ExcludeRemoveName"],
                    type = "execute",
                    func = "RemoveEList",
                    order = 8,
                },
                excludeButton = {
                    name = L["ExcludeButtonName"],
                    desc = L["ExcludeButtonDesc"],
                    type = "toggle",
                    set = "SetExcludeButton",
                    get = "GetExcludeButton",
                    order = 9,
                },
            },
        },
        groupThresholds = {
            name = L["ThreshGroup"],
            type = "group",
            order = 13,
            args = {
                lootDesc = {
                    name = "See the help section for details.".."\n",
                    type = "description",
                    order = 0
                },
                groupT1 = {
                    name = L["Thresh1Group"],
                    type = "group",
                    order = 1,
                    inline = true,
                    args = {
                        type1 = {
                            name = L["Thresh1TypeName"],
                            desc = L["Thresh1TypeDesc"],
                            type = "select",
                            values = itemTypeTable,
                            set = "SetType1",
                            get = "GetType1",
                            order = 2
                        },
                        value1 = {
                            name = L["Thresh1ValueName"],
                            type = "input",
                            set = "SetValue1",
                            get = "GetValue1",
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            usage = L["Thresh1ValueDesc"],
                            --usage = "Value is entered in gold.",
                            order = 3
                        },
                    },
                },
                groupT2 = {
                    name = L["Thresh2Group"],
                    type = "group",
                    order = 2,
                    inline = true,
                    args = {
                        type2 = {
                            name = L["Thresh2TypeName"],
                            desc = L["Thresh2TypeDesc"],
                            type = "select",
                            values = itemTypeTable,
                            set = "SetType2",
                            get = "GetType2",
                            order = 5
                        },
                        value2 = {
                            name = L["Thresh2ValueName"],
                            type = "input",
                            set = "SetValue2",
                            get = "GetValue2",
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            usage = L["Thresh2ValueDesc"],
                            --usage = "Value is entered in gold.",
                            order = 6
                        },
                    },
                },
                groupT3 = {
                    name = L["Thresh3Group"],
                    type = "group",
                    order = 3,
                    inline = true,
                    args = {
                        type3 = {
                            name = L["Thresh3TypeName"],
                            desc = L["Thresh3TypeDesc"],
                            type = "select",
                            values = itemTypeTable,
                            set = "SetType3",
                            get = "GetType3",
                            order = 8
                        },
                        value3 = {
                            name = L["Thresh3ValueName"],
                            type = "input",
                            set = "SetValue3",
                            get = "GetValue3",
                            pattern = "(%d?%d?)[gsc]?%s*(%d?%d?)[gsc]?%s*(%d?%d)[gsc]",
                            usage = L["Thresh3ValueDesc"],
                            --usage = "Value is entered in gold.",
                            order = 9
                        },
                    },
                },
                useQuant = {
                    name = L["UseQuantValName"],
                    desc = L["UseQuantValDesc"],
                    type = "toggle",
                    set = "SetUseQuant",
                    get = "GetUseQuant",
                    hidden = "Advanced",
                    order = 10
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
        groupUnit = {
            name = "Unit Filter",
            type = "group",
            order = 14,
            disabled = false,
            hidden = true,
            args = {
                unitEnable = {
                    name = "Enable",
                    desc = "Skinning mode will pick up and delete any items left over after autolooting.\n|cFFFF0000(WARNING: use with caution this deletes items. HL is not responsible for lost items.)",
                    type = "toggle",
                    set = "SetUnitEnable",
                    get = "GetUnitEnable",
                    order = 0
                },
                typeSelect = {
                    name = "Unit Select",
                    desc = "Here you can choose the modifier key to temporarily disable auto closing the loot window if it is enabled.",
                    type = "multiselect",
                    values = unitTable,
                    set = "SetTypeSelect",
                    get = "GetTypeSelect",
                    order = 1
                },
                unitKeyword = {
                    name = "Unit Keyword",
                    desc = "Here you can choose the modifier key to temporarily enable Skinning Mode.",
                    type = "input",
                    set = "SetUnitKeyword",
                    get = "GetUnitKeyword",
                    hidden = "ToggleKeywordHide",
                    order = 2
                },
                spacer2 = {
                    name = "",          
                    type = "description",
                    order = 3,
                },
                unitLoot = {
                    name = "Autoloot",
                    desc = "Skinning mode will pick up and delete any items left over after autolooting.\n|cFFFF0000(WARNING: use with caution this deletes items. HL is not responsible for lost items.)",
                    type = "toggle",
                    set = "SetUnitLoot",
                    get = "GetUnitLoot",
                    order = 4
                },
                unitClose = {
                    name = "Autoclose",
                    desc = "Skinning mode will pick up and delete any items left over after autolooting.\n|cFFFF0000(WARNING: use with caution this deletes items. HL is not responsible for lost items.)",
                    type = "toggle",
                    set = "SetUnitClose",
                    get = "GetUnitClose",
                    order = 5
                },
            },
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
                            name = HotLoot:MakeColor("ctrl", L["ACGroup"]).."\n"..L["SysHelp1"]..HotLoot:MakeColor("ctrl", L["SkinningGroup"]).."\n"..L["SysHelp2"],            
                            type = "description",
                            order = 1,
                        },
                    },
                },
                groupLM = {
                    name = L["LootMonGroup"],
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
                    name = L["ItemQualityGroup"],
                    type = "group",
                    order = 3,
                    args = {
                        desc = {
                            name = L["IQHelp1"]..HotLoot:MakeColor("ctrl", L["PoorFilterName"]).."\n"..L["IQHelp2"],            
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
                    name = L["ThreshGroup"],
                    type = "group",
                    order = 5,
                    args = {
                        desc = {
                            name = HotLoot:MakeColor("ctrl", L["Thresh1TypeName"]).."\n"..L["ThreshHelp1"]..HotLoot:MakeColor("ctrl", L["Thresh1ValueName"]).."\n"..L["ThreshHelp2"]..HotLoot:MakeColor("ctrl", L["UseQuantValName"]).."\n"..L["ThreshHelp3"],          
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
        lootEnabled = true,
        lootDebug = false,
        lootAnnounce = true,
        lootAdvanced = false,
        lootClose = false,
        lootCloseKey = "0",
        lootSkinMode = false,
        lootSkinKey = "0", 
        lootEnableMonitor = true,
        lootShowAnchor = true,
        lootShowNames = true, 
        lootShowQuantities = true, 
        showSellPrice = true,
        showItemType = true,
        lootIconSize = 16, 
        lootTrans = 1,
        inlineQuant = true,
        lootShowTotal = true,
        lootGrowthDirection = -1, 
        textSide = 0,
        minWidth = "145",
        initialDelay = 5,
        secondaryDelay = 1,
        fadeSpeed = 5,
        colorQual = true,
        showAnimation = true,
        themeSelect = "toast",
        themeColorR = 0,
        themeColorG = 0,
        themeColorB = 0,
        themeColorA = 0.82,
        themeColorBorderR = 1,
        themeColorBorderG = 1,
        themeColorBorderB = 1,
        themeColorBorderA = 1,
        lootGridMode = false,
        lootGridNumColumns = 4,
        lootGold = true,
        lootQuest = true,
        lootCurrency = true,
        lootJunk = false,
        lootPick = true,
        lootCloth = false,
        lootMining = false,
        lootGems = false,
        lootHerbs = false,
        lootSkinning = false,
        lootFishing = false,
        lootEnchanting = false,
        lootCooking = false,
        lootRecipes = false,
        lootPots = false,
        potionType = "both",
        lootFlasks = false,
        lootElixirs = false,
        lootMoH = false,
        lootElemental = false,
        -- lootBotA = true,
        -- lootDoEM = true,
        -- lootSC = true,
        -- lootRepMeat = true,
        lootPoor = false,
        sellGreys = false,
        lootCommon = false,
        lootUncommon = true,
        lootRare = true,
        lootEpic = true,
        lootLegendary = true,
        lootArtifact = true,
        lootHeirloom = true,
        minILvl = 0,
        eList = { },
        iList = { },
        
        type1 = "0None",
        type2 = "0None",
        type3 = "0None",
        useQuant = false,
        
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
-- lootEnabled
function HotLoot:SetLootEnabled(info, value)
    self.db.profile.lootEnabled = value;
    HotLoot:dBug("lootEnabled", value);
end
function HotLoot:GetLootEnabled(info)
    return self.db.profile.lootEnabled;
end

-- lootEnableMonitor
function HotLoot:SetLootEnableMonitor(info, value)
    self.db.profile.lootEnableMonitor = value;
    HotLoot:dBug("lootEnableMonitor", value);
end
function HotLoot:GetLootEnableMonitor(info)
    return self.db.profile.lootEnableMonitor;
end

-- lootShowAnchor
function HotLoot:SetLootShowAnchor(info, value)
    self.db.profile.lootShowAnchor = value;
    HotLoot:dBug("lootShowAnchor", value);
    HotLoot:ToggleAnchor(value);
end
function HotLoot:GetLootShowAnchor(info)
    return self.db.profile.lootShowAnchor;
end

-- lootShowNames
function HotLoot:SetLootShowNames(info, value)
    self.db.profile.lootShowNames = value;
    HotLoot:dBug("lootShowNames", value);
end
function HotLoot:GetLootShowNames(info)
    return self.db.profile.lootShowNames;
end

-- lootShowQuantities
function HotLoot:SetLootShowQuantities(info, value)
    self.db.profile.lootShowQuantities = value;
    HotLoot:dBug("lootShowQuantities", value);
end
function HotLoot:GetLootShowQuantities(info)
    return self.db.profile.lootShowQuantities;
end

--SetShowSellPrice
function HotLoot:SetShowSellPrice(info, value)
    self.db.profile.showSellPrice = value;
    HotLoot:dBug("showSellPrice", value);
end
function HotLoot:GetShowSellPrice(info)
    return self.db.profile.showSellPrice;
end

--SetShowItemType
function HotLoot:SetShowItemType(info, value)
    self.db.profile.showItemType = value;
    HotLoot:dBug("showItemType", value);
end
function HotLoot:GetShowItemType(info)
    return self.db.profile.showItemType;
end

-- HotLoot:GetShowTotal()
function HotLoot:SetShowTotal(info, value)
    self.db.profile.lootShowTotal = value
    HotLoot:dBug("lootShowTotal", value)
end
function HotLoot:GetShowTotal(info)
    return self.db.profile.lootShowTotal
end

-- lootIconSize
function HotLoot:SetLootIconSize(info, value)
    self.db.profile.lootIconSize = value;
    HotLoot:dBug("lootIconSize", value);
end
function HotLoot:GetLootIconSize(info)
    return self.db.profile.lootIconSize;
end

-- SetLootTrans
function HotLoot:SetLootTrans(info, value)
    self.db.profile.lootTrans = value;
    HotLoot:dBug("lootTrans", value);
end
function HotLoot:GetLootTrans(info)
    return self.db.profile.lootTrans;
end

-- lootGrowthDirection
function HotLoot:SetLootGrowthDirection(info, value)
    self.db.profile.lootGrowthDirection = value;
    HotLoot:dBug("lootGrowthDirection", value);
end
function HotLoot:GetLootGrowthDirection(info)
    return self.db.profile.lootGrowthDirection;
end

-- HotLoot:GetTextSide()
function HotLoot:SetTextSide(info, value)
    self.db.profile.textSide = value;
    HotLoot:dBug("textSide", value);
end
function HotLoot:GetTextSide(info)
    return self.db.profile.textSide;
end

-- SetInlineQuant
function HotLoot:SetInlineQuant(info, value)
    self.db.profile.inlineQuant = value;
    HotLoot:dBug("inlineQuant", value);
end
function HotLoot:GetInlineQuant(info)
    return self.db.profile.inlineQuant;
end

-- HotLoot:GetThemeSelect()
function HotLoot:SetThemeSelect(info, value)
    self.db.profile.themeSelect = value;
    HotLoot:dBug("themeSelect", value);
    HotLoot:LoadTheme(value);
end
function HotLoot:GetThemeSelect(info)
    return self.db.profile.themeSelect;
end

-- HotLoot:GetColorQual()
function HotLoot:SetColorQual(info, value)
    self.db.profile.colorQual = value;
    HotLoot:dBug("GetColorQual", value);
end
function HotLoot:GetColorQual(info)
    return self.db.profile.colorQual;
end
-- LoadTheme(HotLoot:GetThemeSelect());
-- SetThemeColor
function HotLoot:SetThemeColorSelect(info, r, g, b, a)
    self.db.profile.themeColorR = r;
    self.db.profile.themeColorG = g;
    self.db.profile.themeColorB = b;
    self.db.profile.themeColorA = a;
    HotLoot:dBug("themeColor", r..", "..g..", "..b..", "..a);
end
function HotLoot:GetThemeColorSelect(info)
    return self.db.profile.themeColorR, self.db.profile.themeColorG, self.db.profile.themeColorB, self.db.profile.themeColorA;
end

function HotLoot:SetThemeColorBorderSelect(info, r, g, b, a)
    self.db.profile.themeColorBorderR = r;
    self.db.profile.themeColorBorderG = g;
    self.db.profile.themeColorBorderB = b;
    self.db.profile.themeColorBorderA = a;
    HotLoot:dBug("themeColor", r..", "..g..", "..b..", "..a);
end
function HotLoot:GetThemeColorBorderSelect(info)
    return self.db.profile.themeColorBorderR, self.db.profile.themeColorBorderG, self.db.profile.themeColorBorderB, self.db.profile.themeColorBorderA;
end

function HotLoot:ToggleThemeColorHide()
    local tc = HotLoot:GetThemeSelect();
    if tc == 2 or tc == 3 then
        --HotLoot:SetLootGridMode(false);
        return false;
    else
        return true;
    end
end

-- minWidth
function HotLoot:SetMinWidth(info, value)
    self.db.profile.minWidth = value;
    HotLoot:dBug("minWidth", value);
end
function HotLoot:GetMinWidth(info)
    return self.db.profile.minWidth;
end

-- iDelay
function HotLoot:SetIDelay(info, value)
    self.db.profile.initialDelay = value;
    HotLoot:dBug("initialDelay", value);
end
function HotLoot:GetIDelay(info)
    return self.db.profile.initialDelay;
end

-- sDelay
function HotLoot:SetSDelay(info, value)
    self.db.profile.secondaryDelay = value;
    HotLoot:dBug("secondaryDelay", value);
end
function HotLoot:GetSDelay(info)
    return self.db.profile.secondaryDelay;
end

-- fSpeed
function HotLoot:SetFSpeed(info, value)
    self.db.profile.fadeSpeed = value;
    HotLoot:dBug("fadeSpeed", value);
end
function HotLoot:GetFSpeed(info)
    return self.db.profile.fadeSpeed;
end

-- fSpeed
function HotLoot:SetShowAnimation(info, value)
    self.db.profile.showAnimation = value;
    HotLoot:dBug("showAnimation", value);
end
function HotLoot:GetShowAnimation(info)
    return self.db.profile.showAnimation;
end

-- lootGridMode
function HotLoot:SetLootGridMode(info, value)
    self.db.profile.lootGridMode = value;
    HotLoot:dBug("lootGridMode", value);
end
function HotLoot:GetLootGridMode(info)
    return self.db.profile.lootGridMode;
end

function HotLoot:ToggleGridDisable()
    local namesChecked = HotLoot:GetLootShowNames();
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
    HotLoot:dBug("lootGridNumColumns", value);
end
function HotLoot:GetLootGridNumColumns(info)
    return self.db.profile.lootGridNumColumns;
end



-- ResetMonitor
function HotLoot:ResetMonitor()
    HotLoot.mainFrame:ClearAllPoints();
    HotLoot.mainFrame:SetPoint("CENTER", 0, 0);
    --HotLoot:UpdateMonitor();
    HotLoot:Announce(L["AnchorReset"]);
end

-- lootGold
function HotLoot:SetLootGold(info, value)
    self.db.profile.lootGold = value;
    HotLoot:dBug("lootGold", value);
end
function HotLoot:GetLootGold(info)
    return self.db.profile.lootGold;
end

-- lootQuest
function HotLoot:SetLootQuest(info, value)
    self.db.profile.lootQuest = value;
    HotLoot:dBug("lootQuest", value);
end
function HotLoot:GetLootQuest(info)
    return self.db.profile.lootQuest;
end

-- lootJunk
function HotLoot:SetLootJunk(info, value)
    self.db.profile.lootJunk = value;
    HotLoot:dBug("lootJunk", value);
end
function HotLoot:GetLootJunk(info)
    return self.db.profile.lootJunk;
end

-- lootJunkDel
function HotLoot:SetLootPick(info, value)
    self.db.profile.lootPick = value;
    HotLoot:dBug("lootPick", value);
end
function HotLoot:GetLootPick(info)
    return self.db.profile.lootPick;
end

-- SetUnitEnable    SetTypeSelect   SetUnitKeyword  SetUnitLoot SetUnitClose

function HotLoot:SetUnitEnable(info, value)
    self.db.profile.unitEnable = value;
    HotLoot:dBug("GetUnitEnable", value);
end
function HotLoot:GetUnitEnable(info)
    return self.db.profile.unitEnable;
end

function HotLoot:SetTypeSelect(info, key, value)
    self.db.profile[key] = value;
    HotLoot:dBug(key, value);
end
function HotLoot:GetTypeSelect(info, key)
    return self.db.profile[key];
end

function HotLoot:SetUnitKeyword(info, value)
    self.db.profile.unitKeyword = value;
    HotLoot:dBug("UnitKeyword", value);
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
    HotLoot:dBug("UnitLoot", value);
end
function HotLoot:GetUnitLoot(info)
    return self.db.profile.unitLoot;
end

function HotLoot:SetUnitClose(info, value)
    self.db.profile.unitClose = value;
    HotLoot:dBug("UnitClose", value);
end
function HotLoot:GetUnitClose(info)
    return self.db.profile.unitClose;
end

-- lootDebug
function HotLoot:SetLootDebug(info, value)
    self.db.profile.lootDebug = value;
    HotLoot:dBug("lootDebug", value);
end
function HotLoot:GetLootDebug(info)
    return self.db.profile.lootDebug;
end

--lootAnnounce
function HotLoot:SetLootAnnounce(info, value)
    self.db.profile.lootAnnounce = value;
    HotLoot:dBug("lootAnnounce", value);
end
function HotLoot:GetLootAnnounce(info)
    return self.db.profile.lootAnnounce;
end

--Minimap
function HotLoot:SetMinimap(info, value)
    self.db.profile.minimapIcon.hide = value;
    HotLoot:dBug("minimapIcon.hide", value);
    if value then
        hIcon:Hide("HotLoot")
    elseif not value then
        hIcon:Show("HotLoot")
    end
end
function HotLoot:GetMinimap(info)
    return self.db.profile.minimapIcon.hide;
end

--SetLootAdvanced
function HotLoot:SetLootAdvanced(info, value)
    self.db.profile.lootAdvanced = value;
    HotLoot:dBug("lootAdvanced", value);
end
function HotLoot:GetLootAdvanced(info)
    return self.db.profile.lootAdvanced;
end

function HotLoot:Advanced()
    if HotLoot:GetLootAdvanced() then
        return false;
    else
        return true;
    end
end

-- lootClose
function HotLoot:SetLootClose(info, value)
    self.db.profile.lootClose = value;
    HotLoot:dBug("lootClose", value);
end
function HotLoot:GetLootClose(info)
    return self.db.profile.lootClose;
end

-- lootCloseKey
function HotLoot:SetLootCloseKey(info, value)
    self.db.profile.lootCloseKey = value;
    HotLoot:dBug("lootCloseKey", value);
end
function HotLoot:GetLootCloseKey(info)
    return self.db.profile.lootCloseKey;
end

-- lootSkinKey
function HotLoot:SetLootSkinKey(info, value)
    self.db.profile.lootSkinKey = value;
    HotLoot:dBug("lootSkinKey", value);
end
function HotLoot:GetLootSkinKey(info)
    return self.db.profile.lootSkinKey;
end

-- lootSkinMode
function HotLoot:SetLootSkinMode(info, value)
    self.db.profile.lootSkinMode = value;
    HotLoot:dBug("lootSkinMode", value);
end
function HotLoot:GetLootSkinMode(info)
    return self.db.profile.lootSkinMode;
end

--lootCloth
function HotLoot:SetLootCloth(info, value)
    self.db.profile.lootCloth = value;
    HotLoot:dBug("lootCloth", value);
end
function HotLoot:GetLootCloth(info)
    return self.db.profile.lootCloth;
end

--lootMining
function HotLoot:SetLootMining(info, value)
    self.db.profile.lootMining = value;
    HotLoot:dBug("lootMining", value);
end
function HotLoot:GetLootMining(info)
    return self.db.profile.lootMining;
end

--lootOre
--[[function HotLoot:SetLootOre(info, value)
    self.db.profile.lootOre = value;
    HotLoot:dBug("lootOre", value);
end
function HotLoot:GetLootOre(info)
    return self.db.profile.lootOre;
end

--lootStone
function HotLoot:SetLootStone(info, value)
    self.db.profile.lootStone = value;
    HotLoot:dBug("lootStone", value);
end
function HotLoot:GetLootStone(info)
    return self.db.profile.lootStone;
end
]]
--lootGems
function HotLoot:SetLootGems(info, value)
    self.db.profile.lootGems = value;
    HotLoot:dBug("lootGems", value);
end
function HotLoot:GetLootGems(info)
    return self.db.profile.lootGems;
end

--lootHerbs
function HotLoot:SetLootHerbs(info, value)
    self.db.profile.lootHerbs = value;
    HotLoot:dBug("lootHerbs", value);
end
function HotLoot:GetLootHerbs(info)
    return self.db.profile.lootHerbs;
end

--lootSkinning
function HotLoot:SetLootSkinning(info, value)
    self.db.profile.lootSkinning = value;
    HotLoot:dBug("lootSkinning", value);
end
function HotLoot:GetLootSkinning(info)
    return self.db.profile.lootSkinning;
end

-- lootFishing
function HotLoot:SetLootFishing(info, value)
    self.db.profile.lootFishing = value;
    HotLoot:dBug("lootFishing", value);
end
function HotLoot:GetLootFishing(info)
    return self.db.profile.lootFishing;
end

-- lootEnchanting
function HotLoot:SetLootEnchanting(info, value)
    self.db.profile.lootEnchanting = value;
    HotLoot:dBug("lootEnchanting", value);
end
function HotLoot:GetLootEnchanting(info)
    return self.db.profile.lootEnchanting;
end

-- lootCooking
function HotLoot:SetLootCooking(info, value)
    self.db.profile.lootCooking = value;
    HotLoot:dBug("lootCooking", value);
end
function HotLoot:GetLootCooking(info)
    return self.db.profile.lootCooking;
end

--SetLootRecipes
function HotLoot:SetLootRecipes(info, value)
    self.db.profile.lootRecipes = value;
    HotLoot:dBug("lootRecipes", value);
end
function HotLoot:GetLootRecipes(info)
    return self.db.profile.lootRecipes;
end

--SetLootPigments
function HotLoot:SetLootPigments(info, value)
    self.db.profile.lootPigments = value;
    HotLoot:dBug("lootPigments", value);
end
function HotLoot:GetLootPigments(info)
    return self.db.profile.lootPigments;
end

-- lootPots
function HotLoot:SetLootPots(info, value)
    self.db.profile.lootPots = value;
    HotLoot:dBug("lootPots", value);
end
function HotLoot:GetLootPots(info)
    return self.db.profile.lootPots;
end

--SetPotionType
function HotLoot:SetPotionType(info, value)
    self.db.profile.potionType = value;
    HotLoot:dBug("potionType", value);
end
function HotLoot:GetPotionType(info)
    return self.db.profile.potionType;
end

-- lootFlasks
function HotLoot:SetLootFlasks(info, value)
    self.db.profile.lootFlasks = value;
    HotLoot:dBug("lootFlasks", value);
end
function HotLoot:GetLootFlasks(info)
    return self.db.profile.lootFlasks;
end

-- lootElixirs
function HotLoot:SetLootElixirs(info, value)
    self.db.profile.lootElixirs = value;
    HotLoot:dBug("lootElixirs", value);
end
function HotLoot:GetLootElixirs(info)
    return self.db.profile.lootElixirs;
end

-- lootMoH
function HotLoot:SetLootMoH(info, value)
    self.db.profile.lootMoH = value;
    HotLoot:dBug("lootMoH", value);
end
function HotLoot:GetLootMoH(info)
    return self.db.profile.lootMoH;
end

-- excludeList
function HotLoot:SetExcludeList(info, value)
    --self.db.profile.excludeList = value
    HotLoot:dBug("excludeList", value)
    HotLoot:AddEList(value)
end
function HotLoot:GetExcludeList(info)
    --return self.db.profile.includeList;
end

function HotLoot:SetExcludeDrop(info, value)
    self.db.profile.excludeDrop = value
    HotLoot:dBug("excludeDrop", value)
end
function HotLoot:GetExcludeDrop(info)
    return self.db.profile.excludeDrop;
end
function HotLoot:SetExcludeTable(value)
    self.db.profile.eList[value] = value
    HotLoot:dBug("eList", value)
end
function HotLoot:GetExcludeTable()
    return self.db.profile.eList;
end
-- includeList
function HotLoot:SetIncludeList(info, value)
    --self.db.profile.includeList = value
    HotLoot:dBug("includeList", value)
    HotLoot:AddIList(value)
end
function HotLoot:GetIncludeList(info)
    --return self.db.profile.includeList;
end

function HotLoot:SetIncludeDrop(info, value)
    self.db.profile.includeDrop = value
    HotLoot:dBug("includeDrop", value)
end
function HotLoot:GetIncludeDrop(info)
    return self.db.profile.includeDrop;
end

function HotLoot:SetIncludeTable(value)
    self.db.profile.iList[value] = value
    HotLoot:dBug("iList", value)
end
function HotLoot:GetIncludeTable()
    return self.db.profile.iList;
end
--includeButton
function HotLoot:SetIncludeButton(info, value)
    self.db.profile.includeButton = value
    HotLoot:dBug("includeButton", value)
end
function HotLoot:GetIncludeButton()
    return self.db.profile.includeButton;
end
--excludeButton
function HotLoot:SetExcludeButton(info, value)
    self.db.profile.excludeButton = value
    HotLoot:dBug("excludeButton", value)
end
function HotLoot:GetExcludeButton()
    return self.db.profile.excludeButton;
end

-- SetLootElemental
function HotLoot:SetLootElemental(info, value)
    self.db.profile.lootElemental = value;
    HotLoot:dBug("lootElemental", value);
end
function HotLoot:GetLootElemental(info)
    return self.db.profile.lootElemental;
end

--SetLootBotA
-- function HotLoot:SetLootBotA(info, value)
--  self.db.profile.lootBotA = value;
--  HotLoot:dBug("lootBotA", value);
-- end
-- function HotLoot:GetLootBotA(info)
--  return self.db.profile.lootBotA;
-- end

--SetLootDoEM
-- function HotLoot:SetLootDoEM(info, value)
--  self.db.profile.lootDoEM = value;
--  HotLoot:dBug("lootDoEM", value);
-- end
-- function HotLoot:GetLootDoEM(info)
--  return self.db.profile.lootDoEM;
-- end

--SetLootSC
-- function HotLoot:SetLootSC(info, value)
--  self.db.profile.lootSC = value;
--  HotLoot:dBug("lootSC", value);
-- end
-- function HotLoot:GetLootSC(info)
--  return self.db.profile.lootSC;
-- end

--SetLootRepMeat
-- function HotLoot:SetLootRepMeat(info, value)
--  self.db.profile.lootRepMeat = value;
--  HotLoot:dBug("lootRepMeat", value);
-- end
-- function HotLoot:GetLootRepMeat(info)
--  return self.db.profile.lootRepMeat;
-- end

--lootPoor
function HotLoot:SetLootPoor(info, value)
    self.db.profile.lootPoor = value;
    HotLoot:dBug("lootPoor", value);
end
function HotLoot:GetLootPoor(info)
    return self.db.profile.lootPoor;
end

--SetSellGreys
function HotLoot:SetSellGreys(info, value)
    self.db.profile.sellGreys = value;
    HotLoot:dBug("sellGreys", value);
end
function HotLoot:GetSellGreys(info)
    return self.db.profile.sellGreys;
end

--lootCommon
function HotLoot:SetLootCommon(info, value)
    self.db.profile.lootCommon = value;
    HotLoot:dBug("lootCommon", value);
end
function HotLoot:GetLootCommon(info)
    return self.db.profile.lootCommon;
end

--lootUncommon
function HotLoot:SetLootUncommon(info, value)
    self.db.profile.lootUncommon = value;
    HotLoot:dBug("lootUncommon", value);
end
function HotLoot:GetLootUncommon(info)
    return self.db.profile.lootUncommon;
end

--lootRare
function HotLoot:SetLootRare(info, value)
    self.db.profile.lootRare = value;
    HotLoot:dBug("lootRare", value);
end
function HotLoot:GetLootRare(info)
    return self.db.profile.lootRare;
end

--lootEpic
function HotLoot:SetLootEpic(info, value)
    self.db.profile.lootEpic = value;
    HotLoot:dBug("lootEpic", value);
end
function HotLoot:GetLootEpic(info)
    return self.db.profile.lootEpic;
end

--lootLegendary
function HotLoot:SetLootLegendary(info, value)
    self.db.profile.lootLegendary = value;
    HotLoot:dBug("lootLegendary", value);
end
function HotLoot:GetLootLegendary(info)
    return self.db.profile.lootLegendary;
end

--lootArtifact
function HotLoot:SetLootArtifact(info, value)
    self.db.profile.lootArtifact = value;
    HotLoot:dBug("lootArtifact", value);
end
function HotLoot:GetLootArtifact(info)
    return self.db.profile.lootArtifact;
end

--lootHeirloom
function HotLoot:SetLootHeirloom(info, value)
    self.db.profile.lootHeirloom = value;
    HotLoot:dBug("lootHeirloom", value);
end
function HotLoot:GetLootHeirloom(info)
    return self.db.profile.lootHeirloom;
end

--minILvl
function HotLoot:SetMinILvl(info, value)
    if value == '' or not tonumber(value) then
        self.db.profile.minILvl = 0;
        HotLoot:dBug("minILvl not set (defaulting to 0)");
    else
        self.db.profile.minILvl = value;
        HotLoot:dBug("minILvl", value);
    end
end
function HotLoot:GetMinILvl(info)
    return self.db.profile.minILvl;
end

--lootCurrency
function HotLoot:SetLootCurrency(info, value)
    self.db.profile.lootCurrency = value;
    HotLoot:dBug("lootCurrency", value);
end
function HotLoot:GetLootCurrency(info)
    return self.db.profile.lootCurrency;
end
function HotLoot:ToCopper(input)
    local gold = tonumber(string.match(input,"(%d+)%s?[gG]")) or 0;
    local silver = tonumber(string.match(input,"(%d+)%s?[sS]")) or 0;
    local copper = tonumber(string.match(input,"(%d+)%s?[cC]")) or 0;
    local total = (gold*10000)+(silver*100)+(copper);
    return total;
end

--type1 
function HotLoot:SetType1(info, value)
    self.db.profile.type1 = value;
    HotLoot:dBug("type1", value);
end
function HotLoot:GetType1(info)
    return self.db.profile.type1;
end

--value1
function HotLoot:SetValue1(info, value)
    self.db.profile.value1 = value;
    HotLoot:dBug("value1 to copper", tonumber(HotLoot:ToCopper(value)));
end

function HotLoot:GetValue1(info)
    return self.db.profile.value1;
end

--type2
function HotLoot:SetType2(info, value)
    self.db.profile.type2 = value;
    HotLoot:dBug("type2", value);
end
function HotLoot:GetType2(info)
    return self.db.profile.type2;
end

--value2
function HotLoot:SetValue2(info, value)
    self.db.profile.value2 = value;
    HotLoot:dBug("value2", value);
end
function HotLoot:GetValue2(info)
    return self.db.profile.value2;
end

--type3
function HotLoot:SetType3(info, value)
    self.db.profile.type3 = value;
    HotLoot:dBug("type3", value);
end
function HotLoot:GetType3(info)
    return self.db.profile.type3;
end

--value3
function HotLoot:SetValue3(info, value)
    self.db.profile.value3 = value;
    HotLoot:dBug("value3", value);
end
function HotLoot:GetValue3(info)
    return self.db.profile.value3;
end

-- useQuant
function HotLoot:SetUseQuant(info, value)
    self.db.profile.useQuant = value;
    HotLoot:dBug("useQuant", value);
end
function HotLoot:GetUseQuant(info)
    return self.db.profile.useQuant;
end




--SetTrackerEnable
function HotLoot:SetTrackerEnable(info, value)
    self.db.profile.trackerEnable = value;
    HotLoot:dBug("trackerEnable", value);
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
    HotLoot:dBug("watchList", value);
end
function HotLoot:GetWatchList(info)
    return self.db.profile.watchListD;
end

function HotLoot:SetTrackerName(info, value)
    self.db.profile.trackerName = value;
    HotLoot:dBug("trackerName", value);
end
function HotLoot:GetTrackerName(info)
    return self.db.profile.trackerName;
end

function HotLoot:SetTrackerGoal(info, value)
    self.db.profile.trackerGoal = value;
    HotLoot:dBug("trackerGoal", value);
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







