local L = LibStub("AceLocale-3.0"):NewLocale("HotLoot", "frFR")
if not L then return end

L["AllGreysSold"] = "Vendu tous les gris pour un total de %s" -- Needs review
L["AnchorReset"] = "Anchor position de réinitialisation." -- Needs review
L["AnnounceExcludeAdd"] = " ajouté à la liste des exclusions." -- Needs review
L["AnnounceLoadingTheme"] = "Thème de chargement:" -- Needs review
L["AquadynamicFishAttractor"] = "Attracteur de poissons aquadynamique" -- Needs review
L["BagsFull"] = "Vos sacs sont pleins. S'il vous plaît faire de la place pour HotLoot de garder le pillage." -- Needs review
L["BoAFilterDesc"] = "Vérifiez récupérer automatiquement Livre des Ages" -- Needs review
L["BoAFilterName"] = "Ramassez Livre des Ages" -- Needs review
L["Both"] = "tous les deux" -- Needs review
L["BuffItemsGroup"] = "Buff Articles" -- Needs review
-- L["buttonDisableAll"] = "Disable All"
-- L["buttonDisableAllFiltersCommonDesc"] = "Disable all Common Drops loot filters."
-- L["buttonDisableAllFiltersGeneralDesc"] = "Disable all General loot filters."
-- L["buttonDisableAllFiltersProfessionsDesc"] = "Disable all Professions loot filters"
-- L["buttonDisableAllFiltersQualityDesc"] = "Disable all Quality loot filters."
-- L["buttonEnableAll"] = "Enable All"
-- L["buttonEnableAllFiltersCommonDesc"] = "Enable all Common Drops loot filters."
-- L["buttonEnableAllFiltersGeneralDesc"] = "Enable all General loot filters."
-- L["buttonEnableAllFiltersProfessionsDesc"] = "Enable all Professions loot filters."
-- L["buttonEnableAllFiltersQualityDesc"] = "Enable all Quality loot filters."
L["buttonRemoveFromExcludeListName"] = "Supprimer l'élément" -- Needs review
L["buttonRemoveFromIncludeListName"] = "Enlever l'objet" -- Needs review
-- L["buttonResetLootMonitorDesc"] = "Reset the position of the Loot Monitor."
L["buttonResetLootMonitorName"] = "réinitialiser ancre" -- Needs review
L["buttonTestLootMonitor"] = "Testez le moniteur" -- Needs review
L["ChatCmdExclude"] = " a été ajoutée à la liste des exclusions." -- Needs review
L["ChatCmdInclude"] = " a été ajouté à la liste d'inclusion." -- Needs review
L["Cloth"] = "Tissus"
L["colorThemeBGName"] = "Couleur de fond" -- Needs review
L["colorThemeBorderName"] = "Couleur de la bordure" -- Needs review
L["Combat"] = "Combat" -- Needs review
L["Common"] = "Commun"
L["Cooking"] = "cuisinière" -- Needs review
L["Cooking Ingredient"] = "Ingrédients de cuisine"
L["Cooking Ingredients"] = "Ingrédients de cuisine"
L["Daily"] = "quotidien" -- Needs review
L["descHotLoot"] = [=[HotLoot est un filtre autoloot conçu pour simplifier le processus de pillage. Cet addon vous permet de récupérer automatiquement différents éléments liés à des professions et des quêtes.
]=] -- Needs review
L["descHotLootNote"] = "NOTE: Pour HotLoot de travailler efficacement s'il vous plaît veiller à ce que tous les autres add-ons et des options autoloot sont éteints." -- Needs review
L["descItemQualityFilters"] = "Cette option va prendre TOUS les objets de cette quallité." -- Needs review
L["descLootMonitorNote"] = "REMARQUE: Ce moniteur est conçu pour montrer que le butin qui est spécifiquement pillé automatiquement. Il ne sera pas afficher les éléments qui vous ramassez manuellement." -- Needs review
L["descValueThresholds"] = [=[Voir la section d'aide pour plus de détails.
]=] -- Needs review
--[==[ L["dialogConfirmSkinningMode"] = [=[Are you sure you want to enable Skinning Mode?

|cffec5840(WARNING: Skinning mode WILL DELETE anything not caught by the loot filters)|r]=] ]==]
L["disenchant"] = "désenchanter" -- Needs review
L["DoEMFilterDesc"] = "Vérifiez récupérer automatiquement rosée de l'éternel matin." -- Needs review
L["DoEMFilterName"] = "Loot de rosée de l'éternel Matin" -- Needs review
L["Down"] = "Bas"
L["Elemental"] = "Elementaire"
L["Elementals"] = "Elementaires"
L["Elixir"] = "Elixir"
L["Elixirs"] = "Elixirs"
L["Enchanting"] = "enchanteur" -- Needs review
L["Epic"] = "Epique"
L["ExcludeAnnounce1"] = " a été exclu." -- Needs review
L["Excluded"] = "Exclu" -- Needs review
L["Extras"] = "Extras" -- Needs review
L["ExtrasDesc"] = "Extras sont des modules facultatifs qui offrent des fonctionnalités supplémentaires et des fonctionnalités. Des modules supplémentaires peuvent être activés / désactivés dans votre gestionnaire AddOn." -- Needs review
-- L["FishingModeCtrlLureDesc"] = "Ctrl+DoubleRightClick to apply a lure."
-- L["FishingModeCtrlLureName"] = "Ctrl Modifier Lure"
L["FishingModeDesc"] = "Mode de pêche vous permet de doubler un clic droit pour lancer et appliquer des leurres." -- Needs review
L["FishingModeEnableDesc"] = "Mode de pêche vous permet de doubler un clic droit pour lancer et appliquer des leurres." -- Needs review
L["FishingModeEnableName"] = "Activer le mode de pêche" -- Needs review
L["FishingModeLureDesc"] = "Applique le leurre sélectionné à la canne à pêche a équipé en cas de besoin." -- Needs review
L["FishingModeLureName"] = "appliquer leurre" -- Needs review
L["FishingModeLureSelectDesc"] = "Sélectionnez le type de leurre que vous aimeriez avoir appliqué." -- Needs review
L["FishingModeLureSelectName"] = "Sélectionnez Lure" -- Needs review
L["FishingModeName"] = "Mode de pêche" -- Needs review
L["FishingModeNatAnnounce"] = "Le 3 poissons de réputation quotidien pour Nat Pagle ont été ajoutées au système de notification de butin." -- Needs review
L["FishingModeNatDesc"] = "Ajoute le 3 poissons de réputation quotidien pour Nat Pagle au système de notification de butin." -- Needs review
L["FishingModeNatName"] = "Alerte quotidienne Nat Pagle poisson" -- Needs review
L["FishingModeRaftDesc"] = "S'applique |cff0070dd[Pêcheurs pêchant Raft]|r tandis que la pêche et il n'est pas déjà appliquée." -- Needs review
L["FishingModeRaftName"] = "Appliquer |cff0070dd[Pêcheurs pêchant Raft]|r" -- Needs review
L["Flask"] = "Flacon"
L["Flasks"] = "Flacons"
L["Gem"] = "Gemme"
L["Gems"] = "Gemmes"
L["genAppearance"] = "apparence" -- Needs review
L["genEnable"] = "Permettre" -- Needs review
L["genModifierKey"] = "Touche de modification" -- Needs review
-- L["genSettings"] = "Settings"
L["genTransparency"] = "transparence" -- Needs review
L["Goal"] = "objectif" -- Needs review
L["greed"] = "avidité" -- Needs review
L["GreyItemSold"] = "Vendu %s x%s pour %s" -- Needs review
L["GridColName"] = "Colonne de la grille" -- Needs review
L["GridEnableDesc"] = [=[Afficher les icones dans un style "grille"
|cFFFF0000(L'affichage des noms doit être éteint)|r]=] -- Needs review
L["GridEnableName"] = "Icones en mode grille" -- Needs review
L["GridModeGroup"] = "Mode grille" -- Needs review
L["groupCloseLootWindow"] = "Autoclose Loot Fenêtre" -- Needs review
L["groupCommonDrops"] = "Gouttes communes" -- Needs review
L["GroupDelayRollDesc"] = "Retards rouler automatiquement de sorte que vous pouvez choisir une option différente si décidé." -- Needs review
L["GroupDelayRollName"] = "Délai d'auto Rouleau" -- Needs review
L["groupGeneral"] = "Général" -- Needs review
L["groupIncludeExclude"] = "Autorisés/exclus." -- Needs review
L["groupItemQualityFilters"] = "Qualité d’objet." -- Needs review
L["groupLootFilters"] = "Ramassez les filtres" -- Needs review
L["groupLootMonitor"] = "Ramassez Moniteur" -- Needs review
L["groupProfessions"] = "professions libérales" -- Needs review
-- L["GroupRollDesc"] = "This extra module can automatically roll on loot for you based on your preferences"
-- L["GroupRollEnableDesc"] = ""
L["GroupRollEnableName"] = "Activer rouleaux Groupe" -- Needs review
L["GroupRollName"] = "Rouleaux de groupe" -- Needs review
L["groupSkinningMode"] = "mode Dépeceur" -- Needs review
-- L["groupSystem"] = "System"
L["groupThreshold1"] = "seuil 1" -- Needs review
L["groupThreshold2"] = "seuil 2" -- Needs review
L["groupThreshold3"] = "seuil 3" -- Needs review
L["groupValueThresholds"] = "Seuils de valeur" -- Needs review
L["headerExcludeList"] = "Exclure la liste" -- Needs review
L["headerIncludeList"] = "Listes des autorisés" -- Needs review
L["Healing"] = "Guérison" -- Needs review
L["HeatTreatedSpinningLure"] = "Traitée à chaud leurre filature" -- Needs review
L["HelpDesc"] = "Sélectionnez un sujet de la boite de dialogue pour afficher l'aide" -- Needs review
L["HelpGroup"] = "Aide" -- Needs review
L["Herb"] = "Herbe"
L["Herbs"] = "Herbes"
L["HistoryGroup"] = "Histoire" -- Needs review
L["hl"] = "hl"
L["hotloot"] = "HotLoot"
L["IEListHelp1"] = "pour ajouter un objet dans la liste vous pouvez : écrire son nom, faire MAJ+Clique sur l'objet ou un glisser-déposer dans le champs approprié. " -- Needs review
L["IEListHelp2"] = "AIDE AIDE AIDE AIDE" -- Needs review
L["IEListHelpGroup"] = "List autorisés/exclus." -- Needs review
L["Include"] = "Inclus"
L["Included"] = "inclus" -- Needs review
L["Include List"] = "Liste des inclus/acceptés"
L["InlineQuantDesc"] = "Afficher la quantité à coté du nom de l'objet" -- Needs review
L["InlineQuantName"] = "Quantités Inline" -- Needs review
L["inputExcludeListAddDesc"] = "." -- Needs review
L["inputExcludeListAddName"] = "Nom" -- Needs review
-- L["inputIncludeListAddDesc"] = "Type an item name (or use Shift+Click on and item to paste the name) and hit ok to add it to the Include List."
L["inputIncludeListAddName"] = "Nom" -- Needs review
L["inputMinItemLevelDesc"] = [=[Le niveau minimum de l'article qui est acceptable de piller.
(uniquement pour les options de qualité d'article)]=] -- Needs review
L["inputMinItemLevelName"] = "Niveau d'Objet Minimum" -- Needs review
L["inputMinWidthDesc"] = "Définit la largeur minimale pour le fond." -- Needs review
L["inputMinWidthName"] = "largeur minimale" -- Needs review
-- L["InputStringName"] = "Input String"
L["inputThresholdValueDesc"] = "Valeur doit être entrée en tant que ##g ##s ##c." -- Needs review
L["inputThresholdValueName"] = "seuil" -- Needs review
L["IQHelp1"] = [=[Ces options fonctionnent presque la même que les autres filtres de butin à l'exception de l'être dans un groupe. Alors que dans un groupe, les articles avec une qualité de Inhabituel ou ci-dessus ne seront pas automatiquement pillé en raison du fait que HotLoot n'a pas encore manipuler les rouleaux de butin.

]=] -- Needs review
L["IQHelp2"] = [=[
Bien que similaire au filtre de courrier indésirable de Loot cette option n'est pas la même. Cette option pille tous (gris) articles de mauvaise qualité. Gardez à l'esprit que tous les éléments indésirables sont gris.]=] -- Needs review
L["ItemName"] = "Nom de l'article" -- Needs review
L["Junk"] = "Dechets"
L["Leather"] = "Cuir"
L["Left"] = "Gauche"
L["Legendary"] = "Légendaire"
L["LMHelp1"] = [=[
Les thèmes peuvent changer l'apparence de l'écran de butin. Les thèmes sont pré-faites et va changer et parfois désactiver certaines options. Avec la connaissance de LUA vous pouvez aussi créer votre propre thème, un tutoriel peut être mis à disposition à l'avenir.

]=] -- Needs review
L["LMHelp2"] = "Mode Grille ne peut être activée que si le thème est défini à l'original et Afficher les noms est éteint. C'est alors seulement que l'option pour activer le mode Grille être mis à disposition." -- Needs review
L["LootHistoryClearName"] = "Effacer l'historique de butin" -- Needs review
L["LootHistoryEnableName"] = "Activer l'historique de butin" -- Needs review
L["LootHistoryGroup"] = "Ramassez Histoire" -- Needs review
L["LootHistoryToggleName"] = "Afficher / Masquer Loot Histoire" -- Needs review
L["LootNotificationDesc"] = "Vous avertit lorsque certains articles sont pillés" -- Needs review
-- L["LootNotificationEnableDesc"] = ""
L["LootNotificationEnableName"] = "Activer la notification de butin" -- Needs review
L["LootNotificationInputName"] = "Nom de l'article" -- Needs review
L["LootNotificationListName"] = "Articles alerte" -- Needs review
L["LootNotificationName"] = "Ramassez notification" -- Needs review
L["LootNotificationRemoveName"] = "Supprimer l'élément" -- Needs review
L["LootNotificationSoundDesc"] = "Le son à jouer quand un élément est trouvé" -- Needs review
L["LootNotificationSoundName"] = "son" -- Needs review
L["LootTrackerAddName"] = "Ajouter article" -- Needs review
L["LootTrackerAnnounceInvalid"] = "L'article que vous avez entré n'est pas valide ou pas dans votre inventaire." -- Needs review
L["LootTrackerEnableName"] = "Activer butin traqueur" -- Needs review
L["LootTrackerGroup"] = "butin traqueur" -- Needs review
L["LootTrackerItemName"] = "Nom de l'élément" -- Needs review
L["LootTrackerRemoveName"] = "Supprimer l'élément" -- Needs review
L["Mana"] = "Mana" -- Needs review
L["Metal & Stone"] = "Pierre et Métal"
L["MMIconTT"] = "|cFFFFCC00Cliquez|r pour ouvrir les options de HotLoot." -- Needs review
L["MMIconTT2"] = "|cFFFFCC00Faites un clic droit|r pour activer l'Histoire butin." -- Needs review
L["MMIconTT3"] = "|cFFFFCC00Moyen-cliquez sur|r pour basculer l'ancre du moniteur de butin." -- Needs review
L["MoHFilterDesc"] = "Vérifiez récupérer automatiquement Motes de l'Harmonie." -- Needs review
L["MoHFilterName"] = "Ramassez Motes de l'Harmonie" -- Needs review
L["Name"] = "Nom" -- Needs review
L["NatsHat"] = "Chapeau de Nat" -- Needs review
L["need"] = "besoin" -- Needs review
-- L["NeedStringDesc"] = "Here you can input different string of text to have search for among the items up for roll. This accepts partial words and proper capitalization is required."
-- L["NeedStringName"] = "Need by String"
L["Never"] = "jamais" -- Needs review
L["None"] = "Rien"
L["nothing"] = "rien" -- Needs review
L["on"] = "sur" -- Needs review
L["pass"] = "passer" -- Needs review
L["Poor"] = "Pauvre"
L["Potion"] = "Potion"
L["Potions"] = "Potions" -- Needs review
L["Quantity"] = "Quantité" -- Needs review
L["Quest"] = "Quête" -- Needs review
L["Quest Item"] = "objet de quête" -- Needs review
L["Quest Items"] = "Objet de quête" -- Needs review
-- L["rangeFadeSpeedDesc"] = "The time it takes for a item in the Loot Monitor to fade out."
L["rangeFadeSpeedName"] = "Vitesse Fade" -- Needs review
L["rangeIconSizeDesc"] = "Modifiez la taille des icones du moniteur de gain par incrément de 8" -- Needs review
L["rangeIconSizeName"] = "Taille des icones" -- Needs review
L["rangeInitialDelayDesc"] = "Délai entre le premier affichage de l'objet et sa disparition" -- Needs review
L["rangeInitialDelayName"] = "Délai initial" -- Needs review
L["rangeSecondaryDelayDesc"] = "Le délai entre les éléments après le premier élément disparaît." -- Needs review
L["rangeSecondaryDelayName"] = "Retard secondaire" -- Needs review
L["rangeTransparencyDesc"] = "Définissez la transparence de l'écran de butin." -- Needs review
L["Rare"] = "Rare" -- Needs review
L["Recipe"] = "recette" -- Needs review
-- L["RemoveStringName"] = "Remove String"
L["RepGroup"] = "Réputation Articles" -- Needs review
L["RepMeatFilterDesc"] = "Vérifiez récupérer automatiquement la viande qui peut être transformé en pièces de monnaie." -- Needs review
L["RepMeatFilterName"] = "Ramassez Réputation viande" -- Needs review
L["ResetDesc"] = "Choisissez quand ou si l'histoire de butin est effacé." -- Needs review
L["ResetName"] = "réinitialiser Histoire" -- Needs review
L["Right"] = "Droite"
L["Rolled"] = "roulé" -- Needs review
L["SCFilterDesc"] = "Vérifiez récupérer automatiquement Chant de cristal." -- Needs review
L["SCFilterName"] = "Ramassez chant de cristal" -- Needs review
L["SCHelp1"] = "Slash commandes sont pas complètement fini, mais sont toujours inclus. Pour voir une liste des commandes disponibles s'il vous plaît taper \"/hl help\"." -- Needs review
L["SCHelpGroup"] = "Slash Commandes" -- Needs review
-- L["SearchStringsName"] = "Search Strings"
L["selectCloseLootWindowModifierDesc"] = "Ici vous pouvez choisir la touche de modification pour désactiver temporairement autoclosing la fenêtre de butin si elle est activée." -- Needs review
L["selectExcludeListName"] = "Articles" -- Needs review
L["selectGrowthDirectionDesc"] = "Ici vous choisissez si le moniteur affiche vers le haut ou le bas" -- Needs review
L["selectGrowthDirectionName"] = "Direction d'affichage" -- Needs review
L["selectIncludeListName"] = "Objet" -- Needs review
-- L["selectPotionTypeDesc"] = "Choose the type of potion to be looted."
L["selectPotionTypeName"] = "Type de potion" -- Needs review
L["selectSkinningModeModifierDesc"] = "Ici vous pouvez choisir la touche de modification PERMETTRE temporairement mode dépecer." -- Needs review
L["selectTextSideDesc"] = "Ici vous pouvez choisir si les noms butin d'éléments montrent à droite ou à gauche." -- Needs review
L["selectTextSideName"] = "Côté texte" -- Needs review
L["selectThemeName"] = "thème" -- Needs review
L["selectThresholdTypeDesc"] = "Choisissez le type d'élément d'appliquer ce seuil à." -- Needs review
L["selectThresholdTypeName"] = "type d'élément" -- Needs review
L["SkinAnnounce1"] = "Suppression d'éléments restants ..." -- Needs review
L["SkinAnnounce2"] = " a été supprimée." -- Needs review
L["SysHelp1"] = [=[
Lorsqu'elle est activée, cette option se ferme automatiquement la fenêtre de butin si il ya encore des objets laissés qui n'ont pas été pillés. Quand a eu lieu, la touche de modification sera désactiver temporairement cette option et laisser la fenêtre de butin de rester ouvert.

]=] -- Needs review
L["SysHelp2"] = [=[
Lorsqu'elle est activée, cette option sera automatiquement ramasser et déposer (supprimer) tous les éléments qui n'ont pas été pillés. Soyez prudent lorsque vous utilisez cette fonction comme il peut et va supprimer des éléments. Quand a eu lieu, la touche de modification sera temporairement activer le mode Dépeceur quand pillage.]=] -- Needs review
L["SysHelpGroup"] = "système" -- Needs review
L["Themes"] = "thèmes" -- Needs review
L["ThemeSelDesc"] = "Ici vous pouvez choisir l'apparence de l'écran." -- Needs review
L["ThreshHelp1"] = [=[
C'est le type d'élément que vous voulez le seuil s'applique à. Ce n'est pas un filtre de type lui-même, pour que le seuil de travailler, vous devez avoir l'option de filtre de butin correspondant activé. Pour désactiver un seuil simplement définir le type de l'article sur "Aucun".

]=] -- Needs review
L["ThreshHelp2"] = [=[
Après type d'élément est d'utiliser l'entrée de seuil pour définir la valeur du seuil. La valeur est entrée dans l'ordre de l'or, de l'argent, alors cuivre, y compris la lettre de chaque type. Par exemple (##g ##s ##c). L'article a pillé ne sera pas ramassé si sa valeur est supérieure au seuil spécifié.

]=] -- Needs review
L["ThreshHelp3"] = "Cette option peut être activée à utiliser (quantité x valeur) au lieu de la valeur de l'un des élément en question." -- Needs review
L["TimelessIsleDesc"] = [=[Ce sont des articles qui tombent souvent dans l'Intemporel Isle et sont généralement voulaient.
]=] -- Needs review
L["TimelessIsleGroup"] = "Timeless Isle" -- Needs review
L["toggleAdvancedOptionsDesc"] = "Vérifiez les options avancées dans diverses catégories." -- Needs review
L["toggleAdvancedOptionsName"] = "options avancées" -- Needs review
L["toggleAnnounceEventsDesc"] = "Vérifiez d'avoir |cFFCD6600HotLoot|r annoncer divers événements tels que les suppressions de poste, etc" -- Needs review
L["toggleAnnounceEventsName"] = "annoncer des événements" -- Needs review
-- L["toggleArtifactQualityFilterDesc"] = "Check to autoloot |cffe6cc80Artifact|r items."
-- L["toggleArtifactQualityFilterName"] = "Loot |cffe6cc80Artifact|r Items"
L["toggleCloseLootWindowDesc"] = [=[Vérifiez fermer automatiquement la fenêtre de butin après autolooting 

Tenez |cFFFFCC00Ctrl|r (ou tout autre clé de votre choix) pour désactiver temporairement tout pillage.]=] -- Needs review
L["toggleClothFilterDesc"] = "Vérifiez récupérer automatiquement chiffon." -- Needs review
L["toggleClothFilterName"] = "Ramassez Tissu" -- Needs review
L["toggleColorByQualityDesc"] = "Couleurs de la frontière par la qualité de l'ouvrage." -- Needs review
L["toggleColorByQualityName"] = "Couleur de la qualité" -- Needs review
L["toggleCommonQualityFilterDesc"] = "Vérifiez récupérer automatiquement les éléments communs." -- Needs review
L["toggleCommonQualityFilterName"] = "piller les éléments communs" -- Needs review
L["toggleCookingFilterDesc"] = "Vérifiez récupérer automatiquement des ingrédients de cuisine." -- Needs review
L["toggleCookingFilterName"] = "Ramassez cuisine Ingrédients" -- Needs review
L["toggleCurrencyFilterDesc"] = [=[Vérifiez récupérer automatiquement devise. 
(c'est à dire moins de charme de bonne chance)]=] -- Needs review
L["toggleCurrencyFilterName"] = "Ramassez devise" -- Needs review
L["toggleDebugModegDesc"] = "Cocher pour activer le débogage." -- Needs review
L["toggleDebugModegName"] = "Mode Debug" -- Needs review
L["toggleElementalFilterDesc"] = [=[Vérifiez récupérer automatiquement les éléments élémentaires. 
(c'est-à-Mote de l'eau)]=] -- Needs review
L["toggleElementalFilterName"] = "Ramassez Elémentaires" -- Needs review
L["toggleElixirFilterDesc"] = "Vérifiez récupérer automatiquement élixirs" -- Needs review
L["toggleElixirFilterName"] = "Ramassez Elixirs" -- Needs review
L["toggleEnableLootMonitorDesc"] = "Cocher pour activer le moniteur de butin." -- Needs review
L["toggleEnableLootMonitorName"] = "Activer le moniteur de butin" -- Needs review
L["toggleEnchantingFilterDesc"] = "Vérifiez récupérer automatiquement les éléments enchanteurs." -- Needs review
L["toggleEnchantingFilterName"] = "Ramassez Enchanteur" -- Needs review
L["toggleEpicQualityFilterDesc"] = "Vérifiez récupérer automatiquement des objets |cffa335eeEpiques|r." -- Needs review
L["toggleEpicQualityFilterName"] = "Ramassez les objets |cffa335eeépiques|r" -- Needs review
L["toggleFishingFilterDesc"] = "Vérifiez récupérer automatiquement la pêche." -- Needs review
L["toggleFishingFilterName"] = "Ramassez Pêche" -- Needs review
L["toggleFlaskFilterDesc"] = "Vérifiez récupérer automatiquement flacons." -- Needs review
L["toggleFlaskFilterName"] = "Ramassez Flacons" -- Needs review
L["toggleGemFilterDesc"] = "Vérifiez récupérer automatiquement gemmes." -- Needs review
L["toggleGemFilterName"] = "Ramassez Gems" -- Needs review
L["toggleGoldFilterDesc"] = "Vérifiez récupérer automatiquement or." -- Needs review
L["toggleGoldFilterName"] = "Ramassez l'or" -- Needs review
-- L["toggleHeirloomQualityFilterDesc"] = "Check to autoloot |cff00ccffHeirloom|r items."
-- L["toggleHeirloomQualityFilterName"] = "Loot |cff00ccffHeirloom|r Items"
L["toggleHerbFilterDesc"] = "cochez pour prendre les herbes automatiquement" -- Needs review
L["toggleHerbFilterName"] = "Prendre les herbes" -- Needs review
L["toggleHideMinimapButtonDesc"] = "Cochez pour effacer l'icone de la minimap" -- Needs review
L["toggleHideMinimapButtonName"] = "Caachez le bouton de la minimap" -- Needs review
L["toggleJunkFilterDesc"] = [=[Vérifiez récupérer automatiquement les éléments indésirables. 
(et pas seulement les articles de mauvaise qualité)]=] -- Needs review
L["toggleJunkFilterName"] = "Ramassez indésirable" -- Needs review
L["toggleLeatherFilterDesc"] = "Vérifiez récupérer automatiquement cuir." -- Needs review
L["toggleLeatherFilterName"] = "Ramassez cuir" -- Needs review
L["toggleLegendaryQualityFilterDesc"] = "Vérifiez récupérer automatiquement les objets |cffff8000Légendaires|r." -- Needs review
L["toggleLegendaryQualityFilterName"] = "Ramassez les objets |cffff8000Légendaires|r." -- Needs review
L["toggleMiningFilterDesc"] = "Vérifiez minerai de autoloot et pierre." -- Needs review
L["toggleMiningFilterName"] = "Ramassez Ore et Pierre" -- Needs review
L["togglePickpocketFilterDesc"] = [=[Vérifiez récupérer automatiquement tout vol à la tire. 
(pour les voleurs)]=] -- Needs review
L["togglePickpocketFilterName"] = "Ramassez Pickpocket" -- Needs review
L["togglePigmentsFilterDesc"] = "Vérifiez récupérer automatiquement pigments." -- Needs review
L["togglePigmentsFilterName"] = "Pigment en butin" -- Needs review
L["togglePoorQualityFilterDesc"] = "Vérifiez récupérer automatiquement les éléments |cff9d9d9dPauvres|r." -- Needs review
L["togglePoorQualityFilterName"] = "Ramassez les objets |cff9d9d9dPauvres|r" -- Needs review
L["togglePotionFilterDesc"] = "Vérifiez récupérer automatiquement potions." -- Needs review
L["togglePotionFilterName"] = "Ramassez Potions" -- Needs review
L["toggleQuestFilterDesc"] = "Vérifiez récupérer automatiquement des objets de quête." -- Needs review
L["toggleQuestFilterName"] = "Ramassez les objets de quête" -- Needs review
L["toggleRareQualityFilterDesc"] = "Vérifiez récupérer automatiquement les articles |cff0070ddRares|r." -- Needs review
L["toggleRareQualityFilterName"] = "Ramassez articles |cff0070ddRares|r" -- Needs review
L["toggleRecipeFilterDesc"] = "Vérifiez récupérer automatiquement les recettes de la profession." -- Needs review
L["toggleRecipeFilterName"] = "Ramassez Recettes" -- Needs review
-- L["toggleSellPoorItemsDesc"] = "Enable the automatic sale of poor items."
L["toggleSellPoorItemsName"] = "Vendre automatiquement les éléments Pauvres" -- Needs review
L["toggleShowAnimationDesc"] = "Applique une animation à l'écran butin lorsque des éléments s'estompent." -- Needs review
L["toggleShowAnimationName"] = "Voir l'animation" -- Needs review
L["toggleShowExcludeButtonDesc"] = "Affiche un bouton d'exclure à côté des éléments sur l'écran de butin." -- Needs review
L["toggleShowExcludeButtonName"] = "Afficher Exclure Bouton" -- Needs review
L["toggleShowIncludeButtonDesc"] = "Vérifiez montrer un bouton à côté de piller les articles dans la fenêtre de butin. Lorsque vous cliquez dessus, il va ajouter l'article à la liste d'inclusion." -- Needs review
L["toggleShowIncludeButtonName"] = "Inclure bouton Butin" -- Needs review
L["toggleShowItemNamesDesc"] = [=[Affiche les noms des éléments suivants pour les icônes dans le Moniteur du butin. 

|cFFFF0000(doit être éteint pour utiliser le mode grille)|r]=] -- Needs review
L["toggleShowItemNamesName"] = "Afficher les noms des ouvrages" -- Needs review
L["toggleShowItemQuantDesc"] = "Affiche les quantités des objets sur le dessus d'icônes dans le Moniteur du butin." -- Needs review
L["toggleShowItemQuantName"] = "Afficher quantités des ouvrages" -- Needs review
L["toggleShowItemTypeDesc"] = [=[Indique le type de l'objet volé sur l'écran de butin de l'article. 
(Thèmes de grande taille uniquement)]=] -- Needs review
L["toggleShowItemTypeName"] = "Type de spectacle de l'article" -- Needs review
L["toggleShowLootMonitorAnchorDesc"] = "Montre l'ancrage de sorte que vous pouvez déplacer le moniteur de butin." -- Needs review
L["toggleShowLootMonitorAnchorName"] = "Afficher ancre" -- Needs review
L["toggleShowSellPriceDesc"] = [=[Affiche le prix de vente de l'objet volé sur l'écran de butin. 
(Thèmes de grande taille uniquement)]=] -- Needs review
L["toggleShowSellPriceName"] = "Afficher Prix de vente" -- Needs review
L["toggleShowTotalQuantDesc"] = "Affiche la quantité de l'article dans vos sacs." -- Needs review
L["toggleShowTotalQuantName"] = "Afficher Quantité En Sacs" -- Needs review
L["toggleSkinningModeDesc"] = [=[Le mode le dépouillement va ramasser et supprimer des éléments restants après autolooting. 
(ATTENTION: à utiliser avec prudence cette supprime les éléments. HL n'est pas responsable des objets perdus.)]=] -- Needs review
L["toggleSystemEnableDesc"] = "Vérifiez pour activer HotLoot" -- Needs review
L["toggleUncommonQualityFilterDesc"] = "Vérifiez récupérer automatiquement les articles |cff1eff00Non-commun|r." -- Needs review
L["toggleUncommonQualityFilterName"] = "Ramassez articles |cff1eff00Non-commun|r" -- Needs review
L["toggleUseQuantValueDesc"] = [=[Prenez la quantité en compte lors de la détermination de la valeur. 
(par opposition à la valeur par article)]=] -- Needs review
L["toggleUseQuantValueName"] = "Utilisez Quantité Valeur" -- Needs review
L["Tradeskill"] = "Marchandises commerciales" -- Needs review
L["Uncommon"] = "Non-commun"
L["Up"] = "Haut"
L["WatchListName"] = "Liste regarder" -- Needs review
