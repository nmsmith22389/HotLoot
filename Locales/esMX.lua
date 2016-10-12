local L = LibStub("AceLocale-3.0"):NewLocale("HotLoot", "esMX")
if not L then return end

L["ACEnableDesc"] = [=[Compruebe para cerrar automáticamente la ventana de botín después autolooting

hold |cFFFFCC00Ctrl|r (o cualquier tecla que elija) para desactivar temporalmente mientras los saqueos.]=] -- Needs review
L["ACEnableName"] = "Permitir"
L["ACGroup"] = "Autoclose Loot ventana"
L["ACKeyDesc"] = "Aquí usted puede elegir la tecla de modificación para desactivar temporalmente autoclosing la ventana de botín, si está habilitada."
L["ACKeyName"] = "Tecla modificadora"
L["AdvancedDesc"] = "Compruebe las opciones avanzadas en las distintas categorías." -- Needs review
L["AdvancedName"] = "Opciones avanzadas"
L["AllGreysSold"] = "Se venden todos los grises por un total de %s" -- Needs review
L["AnchorReset"] = "Restauración de la posición de anclaje." -- Needs review
L["AnnounceDesc"] = "Compruebe que tener |cFFCD6600HotLoot|r anunciar varios eventos, como eliminaciones de elementos, etc" -- Needs review
L["AnnounceExcludeAdd"] = " añadido a la lista de exclusión." -- Needs review
L["AnnounceLoadingTheme"] = "Cargando el tema: " -- Needs review
L["AnnounceName"] = "Anuncian Eventos" -- Needs review
L["Appearance"] = "Apariencia" -- Needs review
L["AquadynamicFishAttractor"] = "Atractor peces aquadynamic" -- Needs review
L["BagsFull"] = "Sus maletas están llenas. Por favor, hacer espacio para HotLoot para mantener el saqueo." -- Needs review
L["BoAFilterDesc"] = "Compruebe autoloot Libro de las Eras." -- Needs review
L["BoAFilterName"] = "Loot Libro de la Edad" -- Needs review
L["Both"] = "Ambos" -- Needs review
L["BuffItemsGroup"] = "Buff Artículos" -- Needs review
L["ChatCmdExclude"] = " ha sido añadida a la lista de exclusión." -- Needs review
L["ChatCmdInclude"] = " ha sido añadida a la lista de inclusión." -- Needs review
L["Cloth"] = "Paño"
L["ClothFilterDesc"] = "Compruebe autoloot tela." -- Needs review
L["ClothFilterName"] = "Loot Cloth"
L["ColorQualDesc"] = "Colores de la frontera por la calidad del artículo." -- Needs review
L["ColorQualName"] = "Color de la Calidad" -- Needs review
L["Combat"] = "combate" -- Needs review
L["Common"] = "Común"
L["CommonFilterDesc"] = [=[
Compruebe a autoloot |cffffffffCommon|r artículos.]=] -- Needs review
L["CommonFilterName"] = "Loot | cffffffffCommon | r Artículos"
L["Cooking"] = "Cocina" -- Needs review
L["CookingFilterDesc"] = "Compruebe autoloot ingredientes para cocinar."
L["CookingFilterName"] = "Recoge los ingredientes de cocina"
L["Cooking Ingredient"] = "Cocinar Ingrediente"
L["Cooking Ingredients"] = "Cocinar Ingredientes"
L["CurrFilterDesc"] = [=[Compruebe autoloot moneda.
(es decir, menor Charm of Good Fortune)]=] -- Needs review
L["CurrFilterName"] = "Loot moneda"
L["Daily"] = "diario" -- Needs review
L["DebugDesc"] = "Compruebe para habilitar la depuración."
L["DebugName"] = "Modo de depuración"
L["disenchant"] = "desencantar" -- Needs review
L["DoEMFilterDesc"] = "Compruebe autoloot rocío de la Eterna Mañana."
L["DoEMFilterName"] = "Loot rocío de la Eterna Mañana"
L["Down"] = "Abajo"
L["DropsGroup"] = "Gotas comunes"
L["EleFilterDesc"] = [=[Compruebe autoloot artículos Elementales.
(es decir, Mota de Agua)]=] -- Needs review
L["EleFilterName"] = "Loot Elementales"
L["Elemental"] = "Elemental" -- Needs review
L["Elementals"] = "Elementals" -- Needs review
L["Elixir"] = "Elixir" -- Needs review
L["ElixirFilterDesc"] = "Compruebe autoloot elixires."
L["ElixirFilterName"] = "Loot elixires"
L["Elixirs"] = "Elixirs" -- Needs review
L["EnableDesc"] = "Active para habilitar HotLoot"
L["EnableName"] = "Permitir"
L["Enchanting"] = "Encantador" -- Needs review
L["EnchantingFilterDesc"] = "Compruebe autoloot artículos encantadores." -- Needs review
L["EnchantingFilterName"] = "Loot Encantador" -- Needs review
L["Epic"] = "Épico" -- Needs review
L["EpicFilterDesc"] = "Compruebe autoloot |cffa335eeEpic|r artículos." -- Needs review
L["EpicFilterName"] = "Loot |cffa335eeEpic|r Artículos" -- Needs review
L["ExcludeAnnounce1"] = " ha sido excluido."
L["ExcludeButtonDesc"] = "Muestra un botón de excluir junto a los elementos en el monitor botín." -- Needs review
L["ExcludeButtonName"] = "Mostrar el Botón Excluir" -- Needs review
L["Excluded"] = "Excluidos" -- Needs review
L["ExcludeHeader"] = "Excluir la lista"
L["ExcludeInputDesc"] = ""
L["ExcludeInputName"] = "Nombre"
L["ExcludeListDesc"] = ""
L["ExcludeListName"] = "Artículos"
L["ExcludeRemoveName"] = "Eliminar elemento"
L["Extras"] = "Extras" -- Needs review
L["ExtrasDesc"] = "Extras son módulos opcionales que proporcionan características adicionales y funcionalidad. Los módulos adicionales se pueden activar / desactivar en el administrador de AddOn." -- Needs review
L["FadeDelayDesc"] = ""
L["FadeDelayName"] = "Velocidad de fundido"
L["FilterGroup"] = "Loot Filtros"
L["FishingFilterDesc"] = "Compruebe autoloot pesca."
L["FishingFilterName"] = "Loot Pesca"
L["FishingModeCtrlLureDesc"] = "Ctrl+DoubleRightClick to apply a lure." -- Requires localization
L["FishingModeCtrlLureName"] = "Ctrl Modifier Lure" -- Requires localization
L["FishingModeDesc"] = "Modo de Pesca permite que usted doble clic derecho para emitir y aplicar señuelos." -- Needs review
L["FishingModeEnableDesc"] = "Modo de Pesca permite que usted doble clic derecho para emitir y aplicar señuelos." -- Needs review
L["FishingModeEnableName"] = "Activar el modo de pesca" -- Needs review
L["FishingModeLureDesc"] = "Aplica el señuelo seleccionado para la caña de pescar en la actualidad equipado cuando sea necesario." -- Needs review
L["FishingModeLureName"] = "Aplicar señuelo" -- Needs review
L["FishingModeLureSelectDesc"] = "Seleccione el tipo de señuelo que le gustaría haber aplicado." -- Needs review
L["FishingModeLureSelectName"] = "señuelo seleccione" -- Needs review
L["FishingModeName"] = "Modo Pesca" -- Needs review
L["FishingModeNatAnnounce"] = "El 3 de pescado reputación diario para Nat. Pagle se han agregado al sistema de notificación de botín." -- Needs review
L["FishingModeNatDesc"] = "Agrega el 3 de pescado reputación diario para Nat. Pagle al sistema de notificación de botín." -- Needs review
L["FishingModeNatName"] = "alerta diaria de pescado Nat Pagle" -- Needs review
L["FishingModeRaftDesc"] = "Aplica |cff0070dd[Pescadores Balsa de Pesca]|r mientras que la pesca y aún no se ha aplicado." -- Needs review
L["FishingModeRaftName"] = "Aplicar |cff0070dd[los pescadores de pesca Balsa]|r" -- Needs review
L["Flask"] = "Frasco" -- Needs review
L["FlaskFilterDesc"] = "Compruebe autoloot frascos."
L["FlaskFilterName"] = "Loot Frascos"
L["Flasks"] = "Frascos" -- Needs review
L["Gem"] = "Joya" -- Needs review
L["GemFilterDesc"] = "Compruebe autoloot gemas."
L["GemFilterName"] = "Recoge las gemas"
L["Gems"] = "Joyas" -- Needs review
L["GeneralGroup"] = "General"
L["Goal"] = "Meta" -- Needs review
L["GoldFilterDesc"] = "Compruebe autoloot oro."
L["GoldFilterName"] = "Botín de Oro"
L["greed"] = "codicia" -- Needs review
L["GreyItemSold"] = "Vendido %s x%s para %s" -- Needs review
L["GridColName"] = "Columnas de cuadrícula"
L["GridEnableDesc"] = [=[Iconos de la pantalla en un estilo de cuadrícula.

|cffff0000(demuestre los nombres deben estar apagados)|r]=] -- Needs review
L["GridEnableName"] = "Icono Modo de cuadrícula"
L["GridModeGroup"] = "Modo de cuadrícula"
L["GroupDelayRollDesc"] = "Retrasos rodando automáticamente de modo que se puede elegir una opción diferente si así lo decide." -- Needs review
L["GroupDelayRollName"] = "retrasar automático de rollo" -- Needs review
L["GroupRollDesc"] = "" -- Requires localization
L["GroupRollEnableDesc"] = "" -- Requires localization
L["GroupRollEnableName"] = "Habilitar Rollos del Grupo" -- Needs review
L["GroupRollName"] = "Rollos de grupo" -- Needs review
L["GrowthDircDesc"] = "Aquí puede elegir si el monitor crece hacia arriba o abajo."
L["GrowthDircName"] = "Dirección de Crecimiento"
L["Healing"] = "Curativo" -- Needs review
L["HeatTreatedSpinningLure"] = "Señuelo hilado tratados térmicamente" -- Needs review
L["HelpDesc"] = [=[Seleccione un tema de la lista desplegable para ver un tema de ayuda específico.
]=] -- Needs review
L["HelpGroup"] = "Ayudar"
L["Herb"] = "Hierba" -- Needs review
L["HerbFilterDesc"] = "Compruebe autoloot hierbas."
L["HerbFilterName"] = "Loot Hierbas"
L["Herbs"] = "Hierbas" -- Needs review
L["HideMMDesc"] = "Compruebe para ocultar el botón del minimapa."
L["HideMMName"] = "Botón minimapa Ocultar"
L["HistoryGroup"] = "Historia" -- Needs review
L["hl"] = "hl"
L["hotloot"] = "hotloot"
L["IconSizeDesc"] = "Ajuste el tamaño de los iconos de elementos Loot monitor en incrementos de 8."
L["IconSizeName"] = "Tamaño del icono"
L["IEListHelp1"] = [=[
Para introducir un elemento en la lista, puede escribir el nombre del elemento, shift + clic en el elemento, o arrastrar y soltar el elemento en el feild de entrada.]=] -- Needs review
L["IEListHelp2"] = "AYUDA AYUDA AYUDA AYUDA AYUDA AYUDA AYUDA AYUDA"
L["IEListHelpGroup"] = "Incluir / Lista de exclusión"
L["Include"] = "Incluir" -- Needs review
L["IncludeButtonDesc"] = "Compruebe para mostrar un botón al lado para saquear los elementos de la ventana de botín. Al hacer clic, se añadirá el artículo a la lista de inclusión" -- Needs review
L["IncludeButtonName"] = "incluir botón de loot" -- Needs review
L["Included"] = "Incluido" -- Needs review
L["IncludeHeader"] = "Incluir lista"
L["IncludeInputDesc"] = ""
L["IncludeInputName"] = "Nombre"
L["Include List"] = "Incluir Lista" -- Needs review
L["IncludeListDesc"] = ""
L["IncludeListName"] = "Artículos"
L["IncludeRemoveName"] = "Eliminar elemento"
L["InExGroup"] = "Incluir / Excluir"
L["InitDelayDesc"] = "La demora entre el primer elemento saqueado y antes de que se desvanece."
L["InitDelayName"] = "Initial Delay"
L["InlineQuantDesc"] = "Muestra las cantidades junto con los nombres de los elementos."
L["InlineQuantName"] = "Cantidades Inline"
L["IQHelp1"] = [=[Estas opciones funcionan casi el mismo que los otros filtros de botín con la excepción de estar en un grupo. Si bien en un grupo, artículos con una calidad de Uncommon o superior no serán saqueados automáticamente debido al hecho de que HotLoot no maneja botín rueda todavía.

]=] -- Needs review
L["IQHelp2"] = [=[
Como similar al filtro deseado Loot esta opción no es la misma. Esta opción saquea todos (gris) artículos de baja calidad. Tenga en cuenta que no todos los elementos no deseados son grises.]=] -- Needs review
L["ItemName"] = "Nombre del elemento" -- Needs review
L["ItemQualityDesc"] = "Estas opciones saquear todas las partidas de esa calidad."
L["ItemQualityGroup"] = "Calidad de artículos"
L["Junk"] = "Basura" -- Needs review
L["JunkFilterDesc"] = [=[Compruebe autoloot elementos no deseados.
(no sólo artículos de baja calidad)]=] -- Needs review
L["JunkFilterName"] = "Recoge basura"
L["Leather"] = "Cuero" -- Needs review
L["LeatherFilterDesc"] = "Compruebe autoloot cuero."
L["LeatherFilterName"] = "Botín de piel"
L["Left"] = "Derecha"
L["Legendary"] = "Legendario" -- Needs review
L["LegendaryFilterDesc"] = "Compruebe autoloot |cffff8000Legendary|r artículos." -- Needs review
L["LegendaryFilterName"] = "Loot |cffff8000Legendary|r Artículos" -- Needs review
L["LMHelp1"] = [=[
Themes puede cambiar el aspecto del monitor botín. Los temas son pre-hechos y va a cambiar y, a veces deshabilitar ciertas opciones, para obtener acceso a todas las opciones para fijar el tema en Original. Con el conocimiento de LUA usted también puede crear su propio tema, un tutorial puede estar disponible en el futuro.

]=] -- Needs review
L["LMHelp2"] = [=[
Modo Grid sólo se puede activar si el tema es en original y Mostrar nombres está desactivada. Sólo entonces la opción para activar el modo Rejilla estar disponible.]=] -- Needs review
L["lootDesc"] = [=[HotLoot es un filtro autoloot diseñado para simplificar el proceso de saqueo. Este AddOn le permite saquear de forma automática diversos temas relacionados con las profesiones y misiones.
]=] -- Needs review
L["lootDesc3"] = [=[NOTA:. Para HotLoot para trabajar eficazmente por favor asegúrese de que todos los demás AddOns autoloot y opciones están desactivadas.
]=] -- Needs review
L["LootHistoryClearName"] = "Eliminar Loot Historia" -- Needs review
L["LootHistoryEnableName"] = "Habilitar Loot Historia" -- Needs review
L["LootHistoryGroup"] = "Loot Historia" -- Needs review
L["LootHistoryToggleName"] = "Mostrar / Ocultar Loot Historia" -- Needs review
L["LootMonDesc"] = "Compruebe que el monitor de loot"
L["LootMonGroup"] = "Loot monitor"
L["LootMonName"] = "Activar Monitor Loot"
L["LootNotificationDesc"] = "Le notifica cuando ciertos artículos son saqueados" -- Needs review
L["LootNotificationEnableDesc"] = "" -- Requires localization
L["LootNotificationEnableName"] = "Activar notificación botín" -- Needs review
L["LootNotificationInputName"] = "Nombre del elemento" -- Needs review
L["LootNotificationListName"] = "Elementos de alerta" -- Needs review
L["LootNotificationName"] = "Saquear Notificación" -- Needs review
L["LootNotificationRemoveName"] = "Eliminar elemento" -- Needs review
L["LootNotificationSoundDesc"] = "El sonido que se reproducirá cuando se encuentra un elemento" -- Needs review
L["LootNotificationSoundName"] = "Sonido" -- Needs review
L["LootTrackerAddName"] = "Añadir artículo" -- Needs review
L["LootTrackerAnnounceInvalid"] = "El elemento que ha introducido no es válido o no en su inventario." -- Needs review
L["LootTrackerEnableName"] = "Habilitar Rastreador Loot" -- Needs review
L["LootTrackerGroup"] = "Loot Rastreador" -- Needs review
L["LootTrackerItemName"] = "Nombre del elemento" -- Needs review
L["LootTrackerRemoveName"] = "Eliminar elemento" -- Needs review
L["Mana"] = "Mana" -- Needs review
L["Metal & Stone"] = "Metal y Piedra" -- Needs review
L["MinimumItemLevelDesc"] = [=[El nivel mínimo elemento que sea aceptable para saquear.
(sólo se aplica a las opciones de calidad de elemento)]=] -- Needs review
L["MinimumItemLevelName"] = "Nivel Mínimo" -- Needs review
L["MinWidthDesc"] = "Establece el ancho mínimo para el fondo." -- Needs review
L["MinWidthName"] = "Anchura Mínima" -- Needs review
L["MMIconTT"] = "|cFFFFCC00Haga clic|r para abrir las opciones de HotLoot." -- Needs review
L["MMIconTT2"] = "|cFFFFCC00Haga Clic derecho|r para cambiar la Historia Loot." -- Needs review
L["MMIconTT3"] = "|cFFFFCC00Haga clic en Oriente|r para cambiar de anclaje del monitor Loot." -- Needs review
L["MoHFilterDesc"] = "Compruebe autoloot Motes de la Armonía."
L["MoHFilterName"] = "Loot Motes de la Armonía"
L["MonDescName"] = " N NOTA: Este monitor está diseñado para mostrar sólo el botín que se saqueó específicamente automáticamente. No mostrará objetos que saquear manualmente."
L["Name"] = "Nombre" -- Needs review
L["NatsHat"] = "Sombrero de Nat" -- Needs review
L["need"] = "necesitar" -- Needs review
L["Never"] = "nunca" -- Needs review
L["None"] = "Nada" -- Needs review
L["nothing"] = "nada" -- Needs review
L["on"] = "en" -- Needs review
L["OreFilterDesc"] = "Compruebe mineral autoloot y piedra."
L["OreFilterName"] = "Loot Ore y Stone"
L["pass"] = "pasar" -- Needs review
L["PickFilterDesc"] = [=[Compruebe autoloot mientras los carteristas.
(para los pícaros)]=] -- Needs review
L["PickFilterName"] = "Loot Pickpocket" -- Needs review
L["PigmentsFilterDesc"] = "Compruebe autoloot pigmentos." -- Needs review
L["PigmentsFilterName"] = "Loot Pigmentos" -- Needs review
L["Poor"] = "Pobre" -- Needs review
L["PoorFilterDesc"] = " NCompruebe a autoloot | cff9d9d9dPoor | artículos de r."
L["PoorFilterName"] = "Loot |cff9d9d9dPoor|r Artículos" -- Needs review
L["PoorSellDesc"] = "" -- Requires localization
L["PoorSellName"] = "Vender automáticamente los elementos pobres" -- Needs review
L["Potion"] = "Poción" -- Needs review
L["PotionFilterDesc"] = "Compruebe autoloot pociones."
L["PotionFilterName"] = "Recoge las pociones"
L["Potions"] = "Pociónes" -- Needs review
L["PotionType"] = "Tipo Poción" -- Needs review
L["ProfessionsGroup"] = "Profesiones"
L["Quantity"] = "Cantidad" -- Needs review
L["Quest"] = "Búsqueda" -- Needs review
L["QuestFilterDesc"] = "Compruebe autoloot objetos de misión."
L["QuestFilterName"] = "Recoge objetos de misión"
L["Quest Item"] = "Objeto de Misión" -- Needs review
L["Quest Items"] = "Objetos de Misión" -- Needs review
L["Rare"] = "Raro" -- Needs review
L["RareFilterDesc"] = "Compruebe autoloot |cff0070ddRare|r artículos." -- Needs review
L["RareFilterName"] = "Loot |cff0070ddRare|r Artículos" -- Needs review
L["Recipe"] = "Receta" -- Needs review
L["RecipeFilterDesc"] = "Compruebe autoloot recetas profesión."
L["RecipeFilterName"] = "Loot Recetas"
L["RepGroup"] = "Rep Artículos"
L["RepMeatFilterDesc"] = "Compruebe autoloot carne que se puede convertir en monedas."
L["RepMeatFilterName"] = "Loot Rep Carne"
L["ResetDesc"] = "Elija cuándo o si se borra la historia botín." -- Needs review
L["ResetMonName"] = "Restablecer Anchor"
L["ResetName"] = "restablecer Historia" -- Needs review
L["Right"] = "Izquierda"
L["Rolled"] = "arrollado" -- Needs review
L["SCFilterDesc"] = "Compruebe autoloot Cantando Crystal."
L["SCFilterName"] = "Loot Canto de Cristal"
L["SCHelp1"] = "Comandos de barra no son del todo terminado, pero todavía están incluidos. Para ver una lista de comandos disponibles, por favor escriba  / hl help ."
L["SCHelpGroup"] = "Raya vertical Comandos"
L["SecDelayDesc"] = "El retraso entre artículos después del primer punto se desvanece." -- Needs review
L["SecDelayName"] = "Delay Secundaria"
L["ShowAnchDesc"] = "Muestra el ancla para que pueda mover el monitor Loot."
L["ShowAnchName"] = "Mostrar Anchor"
L["ShowAnimationDesc"] = "Aplica una animación al monitor botín cuando los artículos se desvanecen." -- Needs review
L["ShowAnimationName"] = "Mostrar Animación" -- Needs review
L["ShowNamesDesc"] = [=[. Muestra los nombres de los elementos próximos a los iconos en el Monitor de Loot

|cffff0000(debe estar apagado al modo de rejilla uso)|r]=] -- Needs review
L["ShowNamesName"] = "Mostrar nombres de elementos"
L["ShowQuantDesc"] = "Muestra las cantidades de los artículos encima de los iconos en el Monitor de Loot."
L["ShowQuantName"] = "Mostrar cantidades de artículos"
L["ShowSellDesc"] = [=[Muestra el precio de venta del artículo saqueado en el Monitor Loot. 
(Temas de talla grande solamente)]=] -- Needs review
L["ShowSellName"] = "Mostrar Precio de venta" -- Needs review
L["ShowTotDesc"] = "Muestra la cantidad del artículo en sus maletas."
L["ShowTotName"] = "Mostrar Cantidad En Bolsas"
L["ShowTypeDesc"] = [=[Muestra el tipo de elemento del elemento saqueado en el Monitor Loot. 
(Temas de talla grande solamente)]=] -- Needs review
L["ShowTypeName"] = "Escriba show artículo" -- Needs review
L["SkinAnnounce1"] = "Eliminación de elementos sobrantes ..."
L["SkinAnnounce2"] = " ha sido eliminado."
L["SkinningEnableDesc"] = [=[Modo Desuello será recoger y eliminar cualquier artículo que quedan después de autolooting.
|cffff0000(ADVERTENCIA: Utilizar con precaución este elimina los elementos HL no se hace responsable de los objetos perdidos.)}r]=] -- Needs review
L["SkinningEnableName"] = "Permitir"
L["SkinningGroup"] = "Modo Desuello"
L["SkinningKeyDesc"] = "Aquí usted puede elegir la tecla de modificación temporal a ACTIVADO Modo desollar."
L["SkinningKeyName"] = "Tecla modificadora"
L["SysHelp1"] = [=[
Cuando, esta opción se cerrará automáticamente la ventana de botín si todavía hay elementos de izquierda que no han sido saqueados. Cuando se mantiene, la tecla modificadora inhabilitará temporalmente esta opción y permitir que la ventana de botín para mantenerla abierta.

]=] -- Needs review
L["SysHelp2"] = [=[
Cuando, esta opción seleccionará automáticamente y soltar (borrar) los elementos que no han sido saqueados. Tenga cuidado al usar esta función, ya que puede y va a eliminar elementos. Cuando se mantiene, la tecla modificadora se activará temporalmente el modo de desollar al saqueo.]=] -- Needs review
L["SysHelpGroup"] = "Sistema"
L["TestMonName"] = "Pruebas de monitor"
L["ThemeColorBorderSelect"] = "Color del borde" -- Needs review
L["ThemeColorSelect"] = "Color de fondo" -- Needs review
L["Themes"] = "verdadero"
L["ThemeSelDesc"] = "Aquí se puede elegir si la mirada del monitor."
L["ThemeSelName"] = "Tema"
L["Thresh1Group"] = "Umbral 1"
L["Thresh1TypeDesc"] = "Elija el tipo de elemento para aplicar este umbral a."
L["Thresh1TypeName"] = "Tipo de artículo"
L["Thresh1ValueDesc"] = "El valor debe ser introducido como # # g # # # # s de c."
L["Thresh1ValueName"] = "Umbral"
L["Thresh2Group"] = "Umbral 2"
L["Thresh2TypeDesc"] = "Elija el tipo de elemento para aplicar este umbral a."
L["Thresh2TypeName"] = "Tipo de artículo"
L["Thresh2ValueDesc"] = "El valor debe ser introducido como # # g # # # # s de c."
L["Thresh2ValueName"] = "Umbral"
L["Thresh3Group"] = "Umbral 3"
L["Thresh3TypeDesc"] = "Elija el tipo de elemento para aplicar este umbral a."
L["Thresh3TypeName"] = "Tipo de artículo"
L["Thresh3ValueDesc"] = "El valor debe ser introducido como ##g ##s ##c." -- Needs review
L["Thresh3ValueName"] = "Umbral"
L["ThreshDesc"] = [=[Consulte la sección de ayuda para más detalles.
]=] -- Needs review
L["ThreshGroup"] = "Umbrales Valor"
L["ThreshHelp1"] = [=[
Este es el tipo de elemento que desea que el umbral para aplicar a. No es un tipo de filtro en sí, a fin de que el umbral de trabajar debe tener la opción de filtro botín correspondiente habilitado. Para desactivar un umbral simplemente ajuste del tipo de elemento a "Ninguna" .

]=] -- Needs review
L["ThreshHelp2"] = [=[
Después Tipo de artículo se establece utilizar la entrada de umbral para establecer el valor del umbral. El valor es introducido en el orden de oro, plata, cobre y luego incluyendo la letra de cada tipo. Por ejemplo (##g ##s ##c). El elemento que se está saqueado Actualmente no será recogido a menos que su valor es mayor que el umbral especificado.

]=] -- Needs review
L["ThreshHelp3"] = [=[
Este opción puede estar activada para utilizar (cantidad x de valor) en lugar del valor de uno de los elementos en cuestión.]=] -- Needs review
L["TimelessIsleDesc"] = [=[Estos son algunos elementos que comúnmente caen en el Timeless Isle y generalmente se quieran.
]=] -- Needs review
L["TimelessIsleGroup"] = "Timeless Isle"
L["Trade Goods"] = "Mercados" -- Needs review
L["TransDesc"] = "Establecer la transparencia del Monitor Loot."
L["TransName"] = "Transparencia"
L["TxtSideDesc"] = "Aquí puede elegir si los nombres de los elementos botín muestran a la derecha o izquierda."
L["TxtSideName"] = "Texto Side"
L["Uncommon"] = "Poco Común" -- Needs review
L["UncommonFilterDesc"] = [=[
Compruebe a autoloot |cff1eff00Uncommon|r artículos.]=] -- Needs review
L["UncommonFilterName"] = "Loot |cff1eff00Uncommon|r Artículos" -- Needs review
L["Up"] = "Arriba"
L["UseQuantValDesc"] = [=[Tome la cantidad a la hora de determinar el valor.
(en oposición a valorar por artículo)]=] -- Needs review
L["UseQuantValName"] = "Utilice Cantidad Valor"
L["WatchListName"] = "Vea la lista" -- Needs review
