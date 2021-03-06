local L = LibStub("AceLocale-3.0"):NewLocale("HotLoot", "enGB")
if not L then return end

L["AllGreysSold"] = "Sold %d Poor items for a total of %s."
L["AnchorReset"] = "Loot Monitor position reset."
L["AnnounceItemExcluded"] = "%s has been excluded from looting."
L["AnnounceListAdd"] = "%s has been added to the %s."
L["BagsFull"] = "Your bags are full. Please make room for HotLoot to keep looting."
L["Both"] = true
L["buttonDisableAll"] = "Disable All"
L["buttonEnableAll"] = "Enable All"
L["buttonRemoveFromListName"] = "Remove Item"
L["buttonResetLootMonitorDesc"] = "Reset the position of the Loot Monitor."
L["buttonResetLootMonitorName"] = "Reset Position"
L["buttonTestLootMonitor"] = "Test Loot Monitor"
L["colorFontColorDesc"] = "Select the font color for the text in the Loot Monitor."
L["colorFontColorName"] = "Font Color"
L["colorThemeBGName"] = "Background Color"
L["colorThemeBorderName"] = "Border Color"
L["descFarmingMode"] = [=[Farming Mode show's the amount of items looted per second/minute/hour in the loot toast. Useful for farming items.
(Smart info must be enabled for it to show.)]=]
L["descHotLoot"] = [=[HotLoot is an autoloot filter designed to streamline the looting process. This AddOn allow you to automatically loot various items related to professions and quests.
]=]
L["descHotLootNote"] = [=[NOTE: In order for HotLoot to work effectively please ensure that all other autoloot AddOns and options are turned off.
]=]
L["descItemQualityFilters"] = "NOTE: These options will loot ALL types of items of that quality."
L["descListAddWarning"] = "NOTE: Items can be added using an Item ID, Item Link, or Item Name. But, Item Name can only be used if it is in your inventory."
L["descOnlyEquipQuality"] = "This option will cause the Item Quality Filters to only work for equippable items."
L["descSmartInfo"] = [=[Smart Info will display pertinent information relating to the looted item.
(ie. AP value, currency info, item type)]=]
L["descValueThresholds"] = "After Item Type is set, use the Threshold input to set the value of the threshold. If an item of that type is currently being looted, it will not be picked up unless its value is greater than or equal to the specified threshold. The corresponding loot filter must also be on. The thresholds don't actually loot anything by themselves."
L["dialogConfirmSkinningMode"] = "Are you sure you want to enable Skinning Mode?"
L["dialogConfirmSkinningModeWarn"] = "WARNING: Skinning mode WILL DELETE anything not caught by the loot filters. HotLoot is not responsible for lost items."
L["Down"] = true
L["ErrorListItemNotFound"] = "The item %q that you tried to add to the %s can't be found. Please try again."
L["FilterDescTemplate"] = "Check to auto loot %s."
L["FilterNameTemplate"] = "Loot %s"
L["genAnimation"] = "Animation"
L["genAppearance"] = "Appearance"
L["genBackground"] = "Background"
L["genBorder"] = "Border"
L["genDisabled"] = "Disabled"
L["genEnable"] = "Enable"
L["genEnabled"] = "Enabled"
L["genFont"] = "Font"
L["genGeneral"] = "General"
L["genIcon"] = "Icon"
L["genLegion"] = "Legion"
L["genModifierKey"] = "Modifier Key"
L["genSettings"] = "Settings"
L["genText"] = "Text"
L["genTexture"] = "Texture"
L["genTransparency"] = "Transparency"
L["GreyItemSold"] = "Sold %s x%s for %s"
L["groupAnnounceEvents"] = "Announce Events"
L["groupCloseLootWindow"] = "Autoclose Loot Window"
L["groupCommonDrops"] = "Common Drops"
L["groupFarmingMode"] = "Farming Mode"
L["groupIncludeExclude"] = "Include/Exclude"
L["groupItemQualityFilters"] = "Item Quality Filter"
L["groupLootFilters"] = "Loot Filters"
L["groupLootMonitor"] = "Loot Monitor"
L["groupOnlyEquipQuality"] = "Filter Equipment Only"
L["groupProfessions"] = "Tradeskills"
L["groupSkinningMode"] = "Skinning Mode"
L["groupSystem"] = "System"
L["groupThreshold1"] = "Threshold 1"
L["groupThreshold2"] = "Threshold 2"
L["groupThreshold3"] = "Threshold 3"
L["groupTSMValue"] = "TradeSkillMaster"
L["groupValueThresholds"] = "Value Thresholds"
L["headerExcludeList"] = "Exclude List"
L["headerIncludeList"] = "Include List"
L["headerLine1Text"] = "Smart Info"
L["headerLine2Text"] = "Value"
L["headerNameText"] = "Item Name"
L["headerQuantText"] = "Quantity"
L["Healing"] = true
L["inputListAddDesc"] = "Enter an Item Name, Item ID, Item Link, or drag it onto the field and hit ok to add it to the list."
L["inputListAddName"] = "Add Item to List"
L["inputMinItemLevelDesc"] = [=[The minimum item level that is acceptable to loot.
(only applies to item quality options)]=]
L["inputMinItemLevelName"] = "Minimum Item Level"
L["inputMinWidthDesc"] = "Sets the minimum width of each toast."
L["inputMinWidthName"] = "Minimum Width"
L["inputThresholdValueDesc"] = "Value must be entered as ##g ##s ##c."
L["inputThresholdValueName"] = "Threshold"
L["inputValueTSMSourceDesc"] = "The TSM source to get a price from."
L["inputValueTSMSourceDescNote"] = "Type %s to see a list of possible sources."
L["inputValueTSMSourceName"] = "Price Source"
L["Large"] = true
L["Left"] = true
L["Mana"] = true
L["MinimapTTAnchor"] = "%s to toggle the Loot Monitor's anchor."
L["MinimapTTOptions"] = "%s to configure HotLoot."
L["None"] = true
L["rangeDisplayTimeDesc"] = "The amount of time before a toast in the Loot Monitor is hidden after being displayed."
L["rangeDisplayTimeName"] = "Toast Display Time"
L["rangeFadeSpeedDesc"] = "The time it takes for a item in the Loot Monitor to fade out."
L["rangeFadeSpeedName"] = "Fade Speed"
L["rangeFontSizeDesc"] = "Change the font size of the Loot Monitor text."
L["rangeFontSizeName"] = "Font Size"
L["rangeIconSizeDesc"] = "Set the size of the Loot Monitor item icons in increments of 8."
L["rangeIconSizeName"] = "Icon Size"
L["rangeMultipleDelayDesc"] = "The amount of time between each toast fading when multiple items are shown in the Loot Monitor at the same time."
L["rangeMultipleDelayName"] = "Multiple Delay"
L["rangeThemeBackgroundTileSizeDesc"] = "The tile size of the background, if tiled."
L["rangeThemeBackgroundTileSizeName"] = "Tile Background Size"
L["rangeThemeBorderEdgeSizeDesc"] = "The edge size of the toast border texture."
L["rangeThemeBorderEdgeSizeName"] = "Border Edge Size"
L["rangeThemeBorderInsetDesc"] = "The size of the toast texture border inset."
L["rangeThemeBorderInsetName"] = "Border Inset"
L["rangeToastPaddingDesc"] = "The amount of space between each toast in the Loot Monitor."
L["rangeToastPaddingName"] = "Toast Padding"
L["rangeToastScaleDesc"] = "Adjusts the overall scale of each loot toast."
L["rangeToastScaleName"] = "Toast Scale"
L["rangeTransparencyDesc"] = "Set the transparency of each toast."
L["Right"] = true
L["selectAnnounceWindowDesc"] = "Select which chat frame announces appear in."
L["selectAnnounceWindowName"] = "Chat Frame"
L["selectCloseLootWindowModifierDesc"] = [=[Modifier key behavior changes depending on auto closing being enabled or not.

%s Temporarily disables auto closing of the loot window.
%s Temporarily enables auto closing of the loot window.]=]
L["selectFarmingModeRateDesc"] = "The rate to display for the farming statistics. (ie Per Hour, Per Second)"
L["selectFarmingModeRateName"] = "Rate"
L["selectGrowthDirectionDesc"] = "Here you can choose whether the monitor grows up or down."
L["selectGrowthDirectionName"] = "Growth Direction"
L["selectListName"] = "Items"
L["selectMinEquipQualityDesc"] = "The minimum quality for the Equippable Only option to apply."
L["selectMinEquipQualityName"] = "Minimum Quality"
L["selectPotionTypeDesc"] = "Choose the type of potion to be looted."
L["selectPotionTypeName"] = "Potion Type"
L["selectSkinningModeModifierDesc"] = [=[Modifier key behavior changes depending on skinning mode being enabled or not.

%s Temporarily disables skinning mode.
%s Temporarily enables skinning mode.]=]
L["selectTextFontDesc"] = "Changes the Loot Monitor text font."
L["selectTextSideDesc"] = "Here you can choose whether the loot item names show on the right or left."
L["selectTextSideName"] = "Text Side"
L["selectThemeBackgroundDesc"] = "Select the texture for the background of the loot toasts."
L["selectThemeBorderDesc"] = "Select the texture for the border of the loot toasts."
L["selectThemeSizeDesc"] = "The size of the Loot Monitor toasts."
L["selectThemeSizeName"] = "Toast Size"
L["selectThresholdTypeDesc"] = "Choose the item type to apply this threshold to."
L["selectThresholdTypeName"] = "Item Type"
L["SkinAnnounce1"] = "Deleting leftover items..."
L["SkinAnnounce2"] = " has been deleted."
L["Small"] = true
L["toggleAdvancedOptionsDesc"] = "Check to see advanced options in various categories."
L["toggleAdvancedOptionsName"] = "Advanced Options"
L["toggleAnnounceBagsFullRaidDesc"] = "Shows a big alert in the middle of the screen when bags are full."
L["toggleAnnounceBagsFullRaidName"] = "Big Alert When Bags Full"
L["toggleAnnounceEventsDesc"] = "Check to have |cFFCD6600HotLoot|r announce various events such as item deletions etc."
L["toggleAnnounceEventsName"] = "Announce Events"
L["toggleAugmentRuneFilterDesc"] = "Check to loot Defiled Augment Runes."
L["toggleAugmentRuneFilterName"] = "Loot Defiled Augment Runes"
L["toggleCloseLootWindowDesc"] = "Check to automatically close the loot window after autolooting."
L["toggleColorByQualityDesc"] = "Colors the border by item quality."
L["toggleColorByQualityName"] = "Color by Quality"
L["toggleCurrencyFilterDesc"] = [=[Check to autoloot Currency.
(i.e. Lesser Charm of Good Fortune)]=]
L["toggleCurrencyFilterName"] = "Loot Currency"
L["toggleDebugModegDesc"] = "Check to enable debugging."
L["toggleDebugModegName"] = "Debug Mode"
L["toggleDisableInRaidDesc"] = "Check this option to stop HotLoot from automatically looting items while Master Loot is turned on."
L["toggleDisableInRaidDescNote"] = "(gold and currency will still be automatically looted if the corresponding filter options are enabled)"
L["toggleDisableInRaidName"] = "Disable for Master Loot"
L["toggleElementalFilterDesc"] = [=[Check to autoloot Elemental items.
(i.e. Mote of Water)]=]
L["toggleElementalFilterName"] = "Loot Elementals"
L["toggleElixirFilterDesc"] = "Check to autoloot elixirs."
L["toggleElixirFilterName"] = "Loot Elixirs"
L["toggleEnableLootMonitorDesc"] = "Check to enable the Loot Monitor."
L["toggleEnableLootMonitorName"] = "Enable Loot Monitor"
L["toggleFishingFilterDesc"] = "Check to autoloot fishing."
L["toggleFishingFilterName"] = "Loot Fishing"
L["toggleFlaskFilterDesc"] = "Check to autoloot flasks."
L["toggleFlaskFilterName"] = "Loot Flasks"
L["toggleFontColorByQualDesc"] = "Color the Loot Monitor text by the item quality."
L["toggleFontColorByQualName"] = "Color Font by Quality"
L["toggleGemFilterDesc"] = "Check to autoloot gems."
L["toggleGemFilterName"] = "Loot Gems"
L["toggleGoldFilterDesc"] = "Check to autoloot gold."
L["toggleGoldFilterName"] = "Loot Gold"
L["toggleHerbFilterDesc"] = "Check to autoloot herbs."
L["toggleHerbFilterName"] = "Loot Herbs"
L["toggleHideMinimapButtonDesc"] = "Check to hide the minimap button."
L["toggleHideMinimapButtonName"] = "Hide Minimap Button"
L["toggleIncludeModifierClickDesc"] = "Will add the item to the Include List when manually looting an item while holding down the selected modifier key."
L["toggleIncludeModifierClickName"] = "Add to Include List on Loot Modifier"
L["toggleItemQualityFilterDesc"] = "Check to autoloot %s items."
L["toggleItemQualityFilterName"] = "Loot %s Items"
L["toggleKnowledgeScrollFilterDesc"] = "Check to loot Artifact Research Notes."
L["toggleKnowledgeScrollFilterName"] = "Loot Artifact Research Notes"
L["toggleLeatherFilterDesc"] = "Check to autoloot leather."
L["toggleLeatherFilterName"] = "Loot Leather"
L["toggleMiningFilterDesc"] = "Check to autoloot ore and stone."
L["toggleMiningFilterName"] = "Loot Ore and Stone"
L["toggleOnlyEquipQualityDesc"] = "Make the Quality Filters only apply to equippable items."
L["togglePickpocketFilterDesc"] = [=[Check to autoloot while pickpocketing.
(for rogues)]=]
L["togglePickpocketFilterName"] = "Loot Pickpocket"
L["togglePigmentsFilterDesc"] = "Check to autoloot pigments."
L["togglePigmentsFilterName"] = "Loot Pigments"
L["togglePotionFilterDesc"] = "Check to autoloot potions."
L["togglePotionFilterName"] = "Loot Potions"
L["toggleQuestFilterDesc"] = "Check to autoloot quest items."
L["toggleQuestFilterName"] = "Loot Quest Items"
L["toggleRecipeFilterDesc"] = "Check to autoloot profession recipes."
L["toggleRecipeFilterName"] = "Loot Recipes"
L["toggleSellPoorItemsDesc"] = "Enable the automatic sale of poor items."
L["toggleSellPoorItemsName"] = "Automatically sell Poor items."
L["toggleSentinaxBeaconFilterDesc"] = "Check to loot Sentinax Beacons."
L["toggleSentinaxBeaconFilterName"] = "Loot Sentinax Beacons"
L["toggleShowAnimationDesc"] = "Applies an animation to each toast when it fades out."
L["toggleShowAnimationName"] = "Show Animations"
L["toggleShowExcludeButtonDesc"] = "Shows an exclude button next to items on the loot monitor."
L["toggleShowExcludeButtonName"] = "Show Exclude Button"
L["toggleShowIncludeButtonDesc"] = "Check to show a button next to loot items in the loot window. When clicked, it will add the item to the Include List"
L["toggleShowIncludeButtonName"] = "Show Include Button"
L["toggleShowItemQuantDesc"] = "Show the quantities of items in the Loot Monitor."
L["toggleShowItemQuantName"] = "Show Item Quantities"
L["toggleShowItemTypeDesc"] = [=[Shows the item type of the looted item on the Loot Monitor.
(Large sized themes only)]=]
L["toggleShowItemTypeName"] = "Show Item Type"
L["toggleShowItemTypeNoInfoDesc"] = "Shows the item's type when there is no Smart Info available."
L["toggleShowItemTypeNoInfoName"] = "Show Item Type When No Smart Info"
L["toggleShowLootMonitorAnchorDesc"] = "Shows the anchor so you can move the Loot Monitor."
L["toggleShowLootMonitorAnchorName"] = "Show Anchor"
L["toggleShowSellPriceDesc"] = [=[Shows the sell price of the looted item on the Loot Monitor.
(Large sized themes only)]=]
L["toggleShowSellPriceName"] = "Show Item Sell Price"
L["toggleShowTotalQuantDesc"] = "Shows the total quantity on hand in the Loot Monitor."
L["toggleShowTotalQuantName"] = "Show Total Quantity On Hand"
L["toggleShowTSMValueDesc"] = "Shows a TSM value or price frome a source instead of the vendor sell value."
L["toggleShowTSMValueName"] = "Show TSM Value"
L["toggleShowValuePrefixDesc"] = "Shows the name of the source price as text in front of the price."
L["toggleShowValuePrefixName"] = "Show Prefix Text"
L["toggleSkinningModeDesc"] = "Skinning mode will pick up and delete any items left over after auto looting."
L["toggleSystemEnableDesc"] = "Check to enable HotLoot."
L["toggleThemeBackgroundTileDesc"] = "Check to tile the background texture."
L["toggleThemeBackgroundTileName"] = "Tile Background"
L["toggleUseQuantValueDesc"] = [=[Take quantity into account when determining value.
(as opposed to an item's single value)]=]
L["toggleUseQuantValueName"] = "Use Quantity Value"
L["Up"] = true
