local L = LibStub("AceLocale-3.0"):NewLocale("HotLoot", "zhCN")
if not L then return end

L["AllGreysSold"] = "出售的所有灰色，总的 %s" -- Needs review
L["AnchorReset"] = "锚点位置复位。"
L["AnnounceExcludeAdd"] = "添加到排除列表。"
L["AnnounceLoadingTheme"] = "正在加载主题："
L["AquadynamicFishAttractor"] = "水下诱鱼"
L["BagsFull"] = "你的背包都满了。请腾出空间HotLoot保持趁火打劫。"
L["BoAFilterDesc"] = "检查至中世纪的自动战利品书。" -- Needs review
L["BoAFilterName"] = "历代的战利品书"
L["Both"] = "两" -- Needs review
L["BuffItemsGroup"] = "巴夫项目"
-- L["buttonDisableAll"] = ""
-- L["buttonDisableAllFiltersCommonDesc"] = ""
-- L["buttonDisableAllFiltersGeneralDesc"] = ""
-- L["buttonDisableAllFiltersProfessionsDesc"] = ""
-- L["buttonDisableAllFiltersQualityDesc"] = ""
-- L["buttonEnableAll"] = ""
-- L["buttonEnableAllFiltersCommonDesc"] = ""
-- L["buttonEnableAllFiltersGeneralDesc"] = ""
-- L["buttonEnableAllFiltersProfessionsDesc"] = ""
-- L["buttonEnableAllFiltersQualityDesc"] = ""
L["buttonRemoveFromExcludeListName"] = "删除项目" -- Needs review
L["buttonRemoveFromIncludeListName"] = "删除项目" -- Needs review
-- L["buttonResetLootMonitorDesc"] = ""
L["buttonResetLootMonitorName"] = "重设锚" -- Needs review
L["buttonTestLootMonitor"] = "测试监控" -- Needs review
L["ChatCmdExclude"] = "已添加到排除列表。"
L["ChatCmdInclude"] = "已经被添加到包含列表。"
L["Cloth"] = "布" -- Needs review
-- L["colorFontColorDesc"] = ""
-- L["colorFontColorName"] = ""
L["colorThemeBGName"] = "背景颜色" -- Needs review
L["colorThemeBorderName"] = "边框颜色" -- Needs review
L["Combat"] = "战斗" -- Needs review
L["Common"] = "常见" -- Needs review
L["Cooking"] = "烹饪" -- Needs review
L["Cooking Ingredient"] = "烹饪原料" -- Needs review
L["Cooking Ingredients"] = "烹饪原料" -- Needs review
L["Daily"] = "每日" -- Needs review
L["descHotLoot"] = [=[HotLoot是autoloot滤波器设计简化抢劫过程。这个插件允许你自动抢劫有关的专业和任务的各种项目。
]=] -- Needs review
L["descHotLootNote"] = [=[注：为了让HotLoot有效地开展工作，请确保所有其他autoloot附加元件和选项被关闭。
]=] -- Needs review
L["descItemQualityFilters"] = "这些选项将掠夺的所有类型的优质项目。" -- Needs review
L["descLootMonitorNote"] = [=[
注：该显示器被设计为只显示战利品，是专门自动洗劫一空。它不会显示您手动抢劫物品。]=] -- Needs review
L["descValueThresholds"] = [==[详情请参阅帮助部分。
=]
L["ThreshGroup"] = "值阈值"
L["ThreshHelp1"] = [=[
这是您要的门槛适用于项目的类型。这是不是一个类型过滤器本身，为了工作，你必须启用相应的赃物过滤器选项门槛。要禁用阈值只需设置项目类型为"无。"

]==] -- Needs review
-- L["dialogConfirmSkinningMode"] = ""
L["disenchant"] = "分解" -- Needs review
L["DoEMFilterDesc"] = "检查autoloot永恒的早晨露水。"
L["DoEMFilterName"] = "战利品永恒的早晨露水"
L["Down"] = "向下" -- Needs review
L["Elemental"] = "元素" -- Needs review
L["Elementals"] = "元素生物" -- Needs review
L["Elixir"] = "酏" -- Needs review
L["Elixirs"] = "长生不老药" -- Needs review
L["Enchanting"] = "妖娆" -- Needs review
L["Epic"] = "史诗" -- Needs review
L["ExcludeAnnounce1"] = "已被排除。"
L["Excluded"] = "排除" -- Needs review
L["Extras"] = "演员" -- Needs review
L["ExtrasDesc"] = "附加功能是提供额外的特性和功能的可选模块。额外的模块可以启用/在你的AddOn管理员禁用。"
-- L["FishingModeCtrlLureDesc"] = ""
-- L["FishingModeCtrlLureName"] = ""
L["FishingModeDesc"] = "捕鱼模式，您可以双击右键施放和应用的诱惑。"
L["FishingModeEnableDesc"] = "捕鱼模式，您可以双击右键施放和应用的诱惑。"
L["FishingModeEnableName"] = "启用钓鱼模式"
L["FishingModeLureDesc"] = "在需要时将所选择的诱惑到目前装备的钓竿。"
L["FishingModeLureName"] = "应用诱惑"
L["FishingModeLureSelectDesc"] = "选择引诱你想申请的类型。"
L["FishingModeLureSelectName"] = "引诱选择"
L["FishingModeName"] = "钓鱼模式"
L["FishingModeNatAnnounce"] = "三日的声誉鱼纳特·帕格已经添加到窝藏，销售赃物通知系统。"
L["FishingModeNatDesc"] = "将在3日的声誉鱼纳特·帕格的战利品通知系统。"
L["FishingModeNatName"] = "警报日报纳特鱼"
L["FishingModeRaftDesc"] = "适用 |cff0070dd[钓鱼渔筏]|r 捕鱼时，它是不是已经应用。" -- Needs review
L["FishingModeRaftName"] = "应用 |cff0070dd[钓鱼渔筏]|r"
L["Flask"] = "长颈瓶" -- Needs review
L["Flasks"] = "烧瓶" -- Needs review
L["Gem"] = "宝石" -- Needs review
L["Gems"] = "宝石" -- Needs review
L["genAppearance"] = "外形" -- Needs review
L["genEnable"] = "启用" -- Needs review
-- L["genFont"] = ""
-- L["genGeneral"] = ""
L["genModifierKey"] = "修改键" -- Needs review
-- L["genSettings"] = ""
-- L["genText"] = ""
L["genTransparency"] = "透明度" -- Needs review
L["Goal"] = "目标" -- Needs review
L["greed"] = "贪心" -- Needs review
L["GreyItemSold"] = "卖%s x%s 为 %s" -- Needs review
L["GridColName"] = "格列"
L["GridEnableDesc"] = [=[图标的网格样式显示。 

（节目名称必须关闭）]=] -- Needs review
L["GridEnableName"] = "图标网格模式"
L["GridModeGroup"] = "网格模式"
L["groupCloseLootWindow"] = "自动闭窗战利品" -- Needs review
L["groupCommonDrops"] = "通用滴" -- Needs review
L["GroupDelayRollDesc"] = "延迟自动滚动，这样您就可以在决定选择不同的选项。"
L["GroupDelayRollName"] = "延时自动滚动"
L["groupGeneral"] = "常规" -- Needs review
L["groupIncludeExclude"] = "包含/排除" -- Needs review
L["groupItemQualityFilters"] = "产品质量" -- Needs review
L["groupLootFilters"] = "战利品过滤器" -- Needs review
L["groupLootMonitor"] = "战利品监视器" -- Needs review
L["groupProfessions"] = "专业" -- Needs review
-- L["GroupRollDesc"] = ""
-- L["GroupRollEnableDesc"] = ""
L["GroupRollEnableName"] = "启用组"
L["GroupRollName"] = "组劳斯莱斯"
L["groupSkinningMode"] = "剥皮模式" -- Needs review
-- L["groupSystem"] = ""
L["groupThreshold1"] = "阈值1" -- Needs review
L["groupThreshold2"] = "阈值2" -- Needs review
L["groupThreshold3"] = "阈值3" -- Needs review
L["groupValueThresholds"] = "阈值" -- Needs review
L["headerExcludeList"] = "排除列表" -- Needs review
L["headerIncludeList"] = "包含列表" -- Needs review
L["Healing"] = "复原" -- Needs review
L["HeatTreatedSpinningLure"] = "热处理纺纱诱惑"
L["HelpDesc"] = [=[从下拉框中选择一个主题，看看具体的帮助主题。
]=] -- Needs review
L["HelpGroup"] = "帮助"
L["Herb"] = "草本植物" -- Needs review
L["Herbs"] = "草药" -- Needs review
L["HistoryGroup"] = "历史"
L["hl"] = "hl" -- Needs review
L["hotloot"] = "hotloot" -- Needs review
L["IEListHelp1"] = [=[
要进入一个项目到列表中，您可以键入项目，移名+单击该项目，或拖放项目到输入费尔德。]=]
-- L["IEListHelp2"] = ""
L["IEListHelpGroup"] = "包含/排除列表"
L["Include"] = "包括" -- Needs review
L["Included"] = "包括" -- Needs review
L["Include List"] = "包括列表" -- Needs review
L["InlineQuantDesc"] = "显示数量旁边的项目名称。"
L["InlineQuantName"] = "内嵌数量"
-- L["inputExcludeListAddDesc"] = ""
L["inputExcludeListAddName"] = "名字" -- Needs review
-- L["inputIncludeListAddDesc"] = ""
L["inputIncludeListAddName"] = "名字" -- Needs review
L["inputMinItemLevelDesc"] = [=[最小值项目水平是可以接受的战利品。
（仅适用于项目质量选项）]=] -- Needs review
L["inputMinItemLevelName"] = "最低等级" -- Needs review
L["inputMinWidthDesc"] = "设置最小宽度为背景" -- Needs review
L["inputMinWidthName"] = "最小宽度" -- Needs review
-- L["InputStringName"] = ""
L["inputThresholdValueDesc"] = "值必须输入为 ##g ##s ##c." -- Needs review
L["inputThresholdValueName"] = "门槛" -- Needs review
L["IQHelp1"] = [=[这些选项的作用几乎一样，除了在一组被其他赃物过滤器。而在一组，以优秀的品质或以上的物品不会自动由于这一事实，即HotLoot不处理战利品卷还洗劫一空。

]=]
L["IQHelp2"] = [=[
虽然类似的战利品垃圾过滤器这个选项是不一样的。此选项共抢得所有的穷人（灰色）质量的项目。请记住，不是所有的垃圾项目是灰色的。]=]
L["ItemName"] = "项目名称" -- Needs review
L["Junk"] = "破烂" -- Needs review
L["Leather"] = "皮革" -- Needs review
L["Left"] = "左" -- Needs review
L["Legendary"] = "传奇" -- Needs review
L["LMHelp1"] = [=[
主题可以改变战利品显示器的外观。主题是预先制作，并会改变，有时会禁用某些选项。用LUA你也可以创建自己的主题知识，教程可能在将来提供。

]=]
L["LMHelp2"] = [=[
如果主题设置为原始和显示名称网格模式只能启用被关闭。只有这样，选择启用网格模式提供。]=]
L["LootHistoryClearName"] = "清除历史战利品"
L["LootHistoryEnableName"] = "启用战利品历史"
L["LootHistoryGroup"] = "战利品历史"
L["LootHistoryToggleName"] = "显示/隐藏赃物历史"
L["LootNotificationDesc"] = "通知您，当某些项目被洗劫一空"
-- L["LootNotificationEnableDesc"] = ""
L["LootNotificationEnableName"] = "启用战利品通知"
L["LootNotificationInputName"] = "项目名称"
L["LootNotificationListName"] = "提示信息"
L["LootNotificationName"] = "战利品通知"
L["LootNotificationRemoveName"] = "删除项目"
L["LootNotificationSoundDesc"] = "当一个项目被发现播放的声音"
L["LootNotificationSoundName"] = "声音"
L["LootTrackerAddName"] = "添加项目"
L["LootTrackerAnnounceInvalid"] = "您输入的产品无效或不能在您的库存。"
L["LootTrackerEnableName"] = "启用战利品跟踪器"
L["LootTrackerGroup"] = "战利品跟踪器"
L["LootTrackerItemName"] = "项目名称"
L["LootTrackerRemoveName"] = "删除项目"
L["Mana"] = "法力" -- Needs review
L["Metal & Stone"] = "金属和矿石" -- Needs review
L["MMIconTT"] = "左键点击打开HotLoot的选项。" -- Needs review
L["MMIconTT2"] = "右键单击切换战利品历史。" -- Needs review
L["MMIconTT3"] = "中间点击切换战利品监视器的锚。" -- Needs review
L["MoHFilterDesc"] = "检查以和谐的汽车战利品微尘。" -- Needs review
L["MoHFilterName"] = "和谐之战利品微尘"
L["Name"] = "名称" -- Needs review
L["NatsHat"] = "纳特的帽子"
L["need"] = "需要" -- Needs review
-- L["NeedStringDesc"] = ""
-- L["NeedStringName"] = ""
L["Never"] = "从来没有" -- Needs review
L["None"] = "无" -- Needs review
L["nothing"] = "无" -- Needs review
L["on"] = "上" -- Needs review
L["pass"] = "通过" -- Needs review
L["Poor"] = "差" -- Needs review
L["Potion"] = "一剂" -- Needs review
L["Potions"] = "药水" -- Needs review
L["Quantity"] = "数量" -- Needs review
L["Quest"] = "探索" -- Needs review
L["Quest Item"] = "任务物品" -- Needs review
L["Quest Items"] = "任务物品" -- Needs review
-- L["rangeFadeSpeedDesc"] = ""
L["rangeFadeSpeedName"] = "褪色速​​度" -- Needs review
-- L["rangeFontSizeDesc"] = ""
-- L["rangeFontSizeName"] = ""
L["rangeIconSizeDesc"] = "设置的战利品监控项目的图标以8为增量的大小。" -- Needs review
L["rangeIconSizeName"] = "图标大小" -- Needs review
L["rangeInitialDelayDesc"] = "中的第一项之间的延迟洗劫一空，并淡出之前。" -- Needs review
L["rangeInitialDelayName"] = "初始延迟" -- Needs review
L["rangeSecondaryDelayDesc"] = "的第一个项目后，项目之间的延迟淡出。" -- Needs review
L["rangeSecondaryDelayName"] = "二次延迟" -- Needs review
L["rangeTransparencyDesc"] = "设置战利品监控的透明度。" -- Needs review
L["Rare"] = "罕见" -- Needs review
L["Recipe"] = "食谱" -- Needs review
-- L["RemoveStringName"] = ""
L["RepGroup"] = "代表项目"
L["RepMeatFilterDesc"] = "检查自动战利品肉，可以打开的硬币。" -- Needs review
L["RepMeatFilterName"] = "战利品声望肉"
L["ResetDesc"] = "选择何时或是否窝藏，销售赃物历史记录将被清除。"
L["ResetName"] = "复位史"
L["Right"] = "右边" -- Needs review
L["Rolled"] = "轧制" -- Needs review
L["SCFilterDesc"] = "检查汽车的战利品歌唱水晶。" -- Needs review
L["SCFilterName"] = "战利品歌唱水晶"
L["SCHelp1"] = "斜杠命令都没有完全结束，但仍包括在内。要查看可用命令的列表，请键入 \"/hl help\"。" -- Needs review
L["SCHelpGroup"] = "斜杠命令"
-- L["SearchStringsName"] = ""
L["selectCloseLootWindowModifierDesc"] = "在这里，你可以选择修改键可暂时禁用自动关闭战利品窗口，如果它被启用。" -- Needs review
L["selectExcludeListName"] = "项目" -- Needs review
L["selectGrowthDirectionDesc"] = "在这里你可以选择显示器是否长大上涨或下跌。" -- Needs review
L["selectGrowthDirectionName"] = "生长方向" -- Needs review
L["selectIncludeListName"] = "项目" -- Needs review
-- L["selectPotionTypeDesc"] = ""
L["selectPotionTypeName"] = "药水型" -- Needs review
L["selectSkinningModeModifierDesc"] = "在这里你可以选择修改键暂时启用剥皮模式。" -- Needs review
-- L["selectTextFontDesc"] = ""
L["selectTextSideDesc"] = "在这里你可以选择战利品项目名称是否显示在右边或左边。" -- Needs review
L["selectTextSideName"] = "文字方" -- Needs review
L["selectThemeName"] = "主题" -- Needs review
L["selectThresholdTypeDesc"] = "选择项目类型为这个阈值应用到。" -- Needs review
L["selectThresholdTypeName"] = "项目类型" -- Needs review
L["SkinAnnounce1"] = "删除遗留物品..."
L["SkinAnnounce2"] = "已删除。"
L["SysHelp1"] = [=[
启用时，此选项将自动关闭战利品窗口，如果仍然有未洗劫一空留项目。当举行的修饰键会暂时禁用此选项并允许战利品窗口保持打开状态。
]=] -- Needs review
L["SysHelp2"] = [=[
启用时，此选项将自动接送（删除）没有被洗劫的任何项目。使用此功能，因为它可以时一定要小心，并会删除项目。当举行的修饰键将抢劫时临时启用剥皮模式。]=] -- Needs review
L["SysHelpGroup"] = "系统" -- Needs review
L["Themes"] = "主题" -- Needs review
L["ThemeSelDesc"] = "在这里，你可以选择是否在显示器的外观。"
L["ThreshHelp1"] = [=[
这是您要的门槛适用于项目的类型。这是不是一个类型过滤器本身，为了工作，你必须启用相应的赃物过滤器选项门槛。要禁用阈值只需设置项目类型为“无”。
]=] -- Needs review
L["ThreshHelp2"] = [=[
经过项目类型设置使用阈值输入到设定的阈值。输入数值的金，银，铜则包含字母的顺序。例如（＃＃G＃＃S＃＃C）。目前正在洗劫该项目将不会被拾起，除非其值大于指定的阈值。

]=]
L["ThreshHelp3"] = [=[
可以启用此选项使用，而不是在问题的项目之一的值（量x值）。]=]
L["TimelessIsleDesc"] = [=[这些都是一些项目，经常滴在永恒岛，一般希望。
]=]
L["TimelessIsleGroup"] = "永恒岛"
L["toggleAdvancedOptionsDesc"] = "请检查在各类高级选项。" -- Needs review
L["toggleAdvancedOptionsName"] = "高级选项" -- Needs review
L["toggleAnnounceEventsDesc"] = "检查有|cFFCD6600HotLoot|r公布的各种活动，如项目的缺失等。" -- Needs review
L["toggleAnnounceEventsName"] = "公布事件" -- Needs review
-- L["toggleArtifactQualityFilterDesc"] = ""
-- L["toggleArtifactQualityFilterName"] = ""
L["toggleCloseLootWindowDesc"] = [=[检查自动抢后自动关闭窗口的战利品 

按住|cFFFFCC00控制|r（或者无论你选择键），同时抢暂时停用。]=] -- Needs review
L["toggleClothFilterDesc"] = "检查自动战利品布。" -- Needs review
L["toggleClothFilterName"] = "战利品布" -- Needs review
L["toggleColorByQualityDesc"] = "颜色由项目质量的边界。" -- Needs review
L["toggleColorByQualityName"] = "颜色以质量" -- Needs review
L["toggleCommonQualityFilterDesc"] = "检查汽车的战利品的共同项目。" -- Needs review
L["toggleCommonQualityFilterName"] = "抢劫的共同项目" -- Needs review
L["toggleCookingFilterDesc"] = "检查汽车的战利品烹饪原料。" -- Needs review
L["toggleCookingFilterName"] = "战利品烹饪原料" -- Needs review
L["toggleCurrencyFilterDesc"] = [=[检查自动战利品货币。 
（招财进宝之即小吊饰）]=] -- Needs review
L["toggleCurrencyFilterName"] = "拾取货币" -- Needs review
L["toggleDebugModegDesc"] = "检查启用调试。" -- Needs review
L["toggleDebugModegName"] = "调试模式" -- Needs review
L["toggleElementalFilterDesc"] = [=[检查自动拾取元素的项目。 
（即水莫特）]=] -- Needs review
L["toggleElementalFilterName"] = "战利品元素之" -- Needs review
L["toggleElixirFilterDesc"] = "检查自动战利品长生不老药。" -- Needs review
L["toggleElixirFilterName"] = "战利品长生不老药" -- Needs review
L["toggleEnableLootMonitorDesc"] = "检查，使显示器战利品" -- Needs review
L["toggleEnableLootMonitorName"] = "启用战利品监视器" -- Needs review
L["toggleEnchantingFilterDesc"] = "检查汽车的战利品妖娆项目。" -- Needs review
L["toggleEnchantingFilterName"] = "战利品附魔" -- Needs review
L["toggleEpicQualityFilterDesc"] = "检查汽车的战利品史诗物品。" -- Needs review
L["toggleEpicQualityFilterName"] = "拾取史诗物品" -- Needs review
L["toggleFishingFilterDesc"] = "检查自动战利品钓鱼。" -- Needs review
L["toggleFishingFilterName"] = "拾取钓鱼" -- Needs review
L["toggleFlaskFilterDesc"] = "检查自动战利品瓶。" -- Needs review
L["toggleFlaskFilterName"] = "战利品瓶" -- Needs review
-- L["toggleFontColorByQualDesc"] = ""
-- L["toggleFontColorByQualName"] = ""
L["toggleGemFilterDesc"] = "检查自动拾取宝石。" -- Needs review
L["toggleGemFilterName"] = "战利品宝石" -- Needs review
L["toggleGoldFilterDesc"] = "检查自动拾取金币。" -- Needs review
L["toggleGoldFilterName"] = "战利品金" -- Needs review
-- L["toggleHeirloomQualityFilterDesc"] = ""
-- L["toggleHeirloomQualityFilterName"] = ""
L["toggleHerbFilterDesc"] = "检查自动拾取草药。" -- Needs review
L["toggleHerbFilterName"] = "战利品草药" -- Needs review
L["toggleHideMinimapButtonDesc"] = "检查隐藏小地图按钮。" -- Needs review
L["toggleHideMinimapButtonName"] = "隐藏小地图按钮" -- Needs review
L["toggleJunkFilterDesc"] = [=[检查自动拾取垃圾项目。 
（不只是质量差的项目）]=] -- Needs review
L["toggleJunkFilterName"] = "拾取垃圾" -- Needs review
L["toggleLeatherFilterDesc"] = "检查自动战利品皮革。" -- Needs review
L["toggleLeatherFilterName"] = "战利品皮革" -- Needs review
L["toggleLegendaryQualityFilterDesc"] = "检查汽车的战利品传说中的项目。" -- Needs review
L["toggleLegendaryQualityFilterName"] = "掠夺传说中的项目。" -- Needs review
L["toggleMiningFilterDesc"] = "检查自动拾取矿石和石头。" -- Needs review
L["toggleMiningFilterName"] = "战利品矿石和石头" -- Needs review
L["togglePickpocketFilterDesc"] = [=[检查汽车的战利品，而扒窃。 
（对于盗贼）]=] -- Needs review
L["togglePickpocketFilterName"] = "战利品扒手" -- Needs review
L["togglePigmentsFilterDesc"] = "检查自动战利品颜料。" -- Needs review
L["togglePigmentsFilterName"] = "战利品颜料" -- Needs review
L["togglePoorQualityFilterDesc"] = "检查汽车的战利品可怜项目。" -- Needs review
L["togglePoorQualityFilterName"] = "拾取可怜项目" -- Needs review
L["togglePotionFilterDesc"] = "检查自动战利品药水。" -- Needs review
L["togglePotionFilterName"] = "战利品魔药" -- Needs review
L["toggleQuestFilterDesc"] = "检查自动拾取任务物品。" -- Needs review
L["toggleQuestFilterName"] = "掉落物品任务物品" -- Needs review
L["toggleRareQualityFilterDesc"] = "检查汽车的战利品稀有物品。" -- Needs review
L["toggleRareQualityFilterName"] = "掠夺稀有物品。" -- Needs review
L["toggleRecipeFilterDesc"] = "检查汽车的战利品专业食谱。" -- Needs review
L["toggleRecipeFilterName"] = "战利品食谱" -- Needs review
-- L["toggleSellPoorItemsDesc"] = ""
L["toggleSellPoorItemsName"] = "自动售卖可怜项目" -- Needs review
L["toggleShowAnimationDesc"] = "已进行动画处理的战利品监控项目时淡出。" -- Needs review
L["toggleShowAnimationName"] = "显示动画" -- Needs review
L["toggleShowExcludeButtonDesc"] = "显示一个排除旁边的战利品显示器上的项目按钮。" -- Needs review
L["toggleShowExcludeButtonName"] = "显示排除按钮" -- Needs review
L["toggleShowIncludeButtonDesc"] = "检查显示掠夺的战利品窗口中的项目旁边的按钮。当点击时，它会将该项目添加到包含列表" -- Needs review
L["toggleShowIncludeButtonName"] = "包含战利品按钮" -- Needs review
L["toggleShowItemNamesDesc"] = "显示项目名称旁边的战利品监视器的图标。" -- Needs review
L["toggleShowItemNamesName"] = "显示项目名称" -- Needs review
L["toggleShowItemQuantDesc"] = "显示的项目数量上，在战利品显示器图标上面。" -- Needs review
L["toggleShowItemQuantName"] = "显示项目数量" -- Needs review
L["toggleShowItemTypeDesc"] = [=[显示项目类型上的战利品监视器的洗劫项目。使用
（大尺寸的主题只）]=] -- Needs review
L["toggleShowItemTypeName"] = "显示项目类型" -- Needs review
L["toggleShowLootMonitorAnchorDesc"] = "显示主播这样你就可以将战利品监视器。" -- Needs review
L["toggleShowLootMonitorAnchorName"] = "显示锚" -- Needs review
L["toggleShowSellPriceDesc"] = [=[显示于监视器战利品掠夺的物品的卖出价格。使用
（大尺寸的主题只）]=] -- Needs review
L["toggleShowSellPriceName"] = "显示卖价" -- Needs review
L["toggleShowTotalQuantDesc"] = "显示项目的随身行李的数量。" -- Needs review
L["toggleShowTotalQuantName"] = "显示数量在袋" -- Needs review
L["toggleSkinningModeDesc"] = [=[剥皮模式将拿起和删除自动抢后留下的任何物品。 
|cFFFF0000（警告：请谨慎使用该删除项目HL是不负责丢失的物品。）|r]=] -- Needs review
L["toggleSystemEnableDesc"] = "检查，使HotLoot" -- Needs review
L["toggleUncommonQualityFilterDesc"] = [=[
检查汽车的战利品优秀项目。]=] -- Needs review
L["toggleUncommonQualityFilterName"] = "抢劫优秀项目。" -- Needs review
L["toggleUseQuantValueDesc"] = [=[以数量计测定值时。
（而不是每个项目的值）]=] -- Needs review
L["toggleUseQuantValueName"] = "使用数量价值" -- Needs review
L["Tradeskill"] = "市场产品" -- Needs review
L["Uncommon"] = "稀有" -- Needs review
L["Up"] = "向上" -- Needs review
L["WatchListName"] = "观察名单"
