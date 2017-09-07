--
-- ─── CONSTANTS ──────────────────────────────────────────────────────────────────
--

_G.HL_LOOT_SLOT_TYPE = {
    ITEM     = 1,
    COIN     = 2,
    CURRENCY = 3
}

_G.HL_THEME_SIZE = {
    SMALL = 0,
    LARGE = 1
}

_G.HL_TEXT_SIDE = {
    RIGHT = 0,
    LEFT  = 1
}

_G.HL_LOOT_REASON = {
    NOT_FOUND          = 'Not Found in Filter',
    BAGS_FULL          = 'Bags Full',
    GOLD               = 'Gold Filter',
    CURRENCY           = 'Currency Filter',
    INCLUDE            = 'Include List',
    EXCLUDE            = 'Exclude List',
    QUEST              = 'Quest Item Filter',
    PICKPOCKET         = 'Pickpocket Filter',
    CLOTH              = 'Cloth Filter',
    MINING             = 'Mining Filter',
    GEM                = 'Gem Filter',
    HERB               = 'Herb Filter',
    LEATHER            = 'Leather Filter',
    FISHING            = 'Fishing Filter',
    ENCHANTING         = 'Enchanting Filter',
    INSCRIPTION        = 'Inscription Filter',
    COOKING            = 'Cooking Filter',
    RECIPE             = 'Recipe Filter',
    POTION             = 'Potion Filter',
    POTION_HEALTH      = 'Health Potion Filter',
    POTION_MANA        = 'Mana Potion Filter',
    POTION_UNSUPPORTED = 'Unsupported Potion',
    FLASK              = 'Flask Filter',
    ELIXIR             = 'Elixir Filter',
    ELEMENTAL          = 'Elemental Filter',
    ARTIFACT_POWER     = 'Artifact Power Filter',
    AUGMENT_RUNE       = 'Defiled Augment Rune Filter',
    ARTIFACT_RESEARCH  = 'Artifact Research Notes Filter',
    SENTINAX_BEACON    = 'Sentinax Beacons Filter',
    QUALITY_POOR       = 'Poor Quality Filter',
    QUALITY_COMMON     = 'Common Quality Filter',
    QUALITY_UNCOMMON   = 'Uncommon Quality Filter',
    QUALITY_RARE       = 'Rare Quality Filter',
    QUALITY_EPIC       = 'Epic Quality Filter',
    QUALITY_LEGENDARY  = 'Legendary Quality Filter',
    QUALITY_ARTIFACT   = 'Artifact Quality Filter',
    QUALITY_HEIRLOOM   = 'Heirloom Quality Filter',
}

-- @usage
-- *to return the localized name*
-- GetItemClassInfo(itemClassEnum)
-- GetItemSubClassInfo(itemClassEnum, subClassEnum)

_G.HL_ITEM_CLASS = {
    CONSUMABLE       = _G.LE_ITEM_CLASS_CONSUMABLE,       -- 'Consumable'
    CONTAINER        = _G.LE_ITEM_CLASS_CONTAINER,        -- 'Container'
    WEAPON           = _G.LE_ITEM_CLASS_WEAPON,           -- 'Weapon'
    GEM              = _G.LE_ITEM_CLASS_GEM,              -- 'Gem'
    ARMOR            = _G.LE_ITEM_CLASS_ARMOR,            -- 'Armor'
    REAGENT          = _G.LE_ITEM_CLASS_REAGENT,          -- 'Reagent'
    PROJECTILE       = _G.LE_ITEM_CLASS_PROJECTILE,       -- 'Projectile'
    TRADESKILL       = _G.LE_ITEM_CLASS_TRADEGOODS,       -- 'Tradeskill'
    ITEM_ENHANCEMENT = _G.LE_ITEM_CLASS_ITEM_ENHANCEMENT, -- 'Item Enhancement'
    RECIPE           = _G.LE_ITEM_CLASS_RECIPE,           -- 'Recipe'
    QUIVER           = _G.LE_ITEM_CLASS_QUIVER,           -- 'Quiver'
    QUEST            = _G.LE_ITEM_CLASS_QUESTITEM,        -- 'Quest'
    KEY              = _G.LE_ITEM_CLASS_KEY,              -- 'Key'
    MISCELLANEOUS    = _G.LE_ITEM_CLASS_MISCELLANEOUS,    -- 'Miscellaneous'
    GLYPH            = _G.LE_ITEM_CLASS_GLYPH,            -- 'Glyph'
    BATTLE_PETS      = _G.LE_ITEM_CLASS_BATTLEPET,        -- 'Battle Pets'
    WOW_TOKEN        = _G.LE_ITEM_CLASS_WOW_TOKEN         -- 'WoW Token'
}

_G.HL_ITEM_SUB_CLASS = {}
_G.HL_ITEM_SUB_CLASS.CONSUMABLE = {
    EXPLOSIVES_AND_DEVICES = 0, -- 'Explosives and Devices'
    POTION                 = 1, -- 'Potion'
    ELIXIR                 = 2, -- 'Elixir'
    FLASK                  = 3, -- 'Flask'
    SCROLL                 = 4, -- 'Scroll (OBSOLETE)'
    FOOD_DRINK             = 5, -- 'Food & Drink'
    ITEM_ENHANCEMENT       = 6, -- 'Item Enhancement (OBSOLETE)'
    BANDAGE                = 7, -- 'Bandage'
    OTHER                  = 8, -- 'Other'
    VANTUS_RUNES           = 9  -- 'Vantus Runes'
}

_G.HL_ITEM_SUB_CLASS.CONTAINER = {
    BAG                = 0,  -- 'Bag'
    SOUL_BAG           = 1,  -- 'Soul Bag'
    HERB_BAG           = 2,  -- 'Herb Bag'
    ENCHANTING_BAG     = 3,  -- 'Enchanting Bag'
    ENGINEERING_BAG    = 4,  -- 'Engineering Bag'
    GEM_BAG            = 5,  -- 'Gem Bag'
    MINING_BAG         = 6,  -- 'Mining Bag'
    LEATHERWORKING_BAG = 7,  -- 'Leatherworking Bag'
    INSCRIPTION_BAG    = 8,  -- 'Inscription Bag'
    TACKLE_BOX         = 9,  -- 'Tackle Box'
    COOKING_BAG        = 10, -- 'Cooking Bag'
}

_G.HL_ITEM_SUB_CLASS.WEAPON = {
    ONE_HANDED_AXES   = 0,  -- 'One-Handed Axes'
    TWO_HANDED_AXES   = 1,  -- 'Two-Handed Axes'
    BOWS              = 2,  -- 'Bows'
    GUNS              = 3,  -- 'Guns'
    ONE_HANDED_MACES  = 4,  -- 'One-Handed Maces'
    TWO_HANDED_MACES  = 5,  -- 'Two-Handed Maces'
    POLEARMS          = 6,  -- 'Polearms'
    ONE_HANDED_SWORDS = 7,  -- 'One-Handed Swords'
    TWO_HANDED_SWORDS = 8,  -- 'Two-Handed Swords'
    WARGLAIVES        = 9,  -- 'Warglaives'
    STAVES            = 10, -- 'Staves'
    BEAR_CLAWS        = 11, -- 'Bear Claws'
    CATCLAWS          = 12, -- 'CatClaws'
    FIST_WEAPONS      = 13, -- 'Fist Weapons'
    MISCELLANEOUS     = 14, -- 'Miscellaneous'
    DAGGERS           = 15, -- 'Daggers'
    THROWN            = 16, -- 'Thrown'
    SPEARS            = 17, -- 'Spears'
    CROSSBOWS         = 18, -- 'Crossbows'
    WANDS             = 19, -- 'Wands'
    FISHING_POLES     = 20, -- 'Fishing Poles'
}

_G.HL_ITEM_SUB_CLASS.GEM = {
    INTELLECT       = 0,  -- 'Intellect'
    AGILITY         = 1,  -- 'Agility'
    STRENGTH        = 2,  -- 'Strength'
    STAMINA         = 3,  -- 'Stamina'
    SPIRIT          = 4,  -- 'Spirit'
    CRITICAL_STRIKE = 5,  -- 'Critical Strike'
    MASTERY         = 6,  -- 'Mastery'
    HASTE           = 7,  -- 'Haste'
    VERSATILITY     = 8,  -- 'Versatility'
    OTHER           = 9,  -- 'Other'
    MULTIPLE_STATS  = 10, -- 'Multiple Stats'
    ARTIFACT_RELIC  = 11, -- 'Artifact Relic'
}

_G.HL_ITEM_SUB_CLASS.ARMOR = {
    MISCELLANEOUS = 0,  -- 'Miscellaneous'
    CLOTH         = 1,  -- 'Cloth'
    LEATHER       = 2,  -- 'Leather'
    MAIL          = 3,  -- 'Mail'
    PLATE         = 4,  -- 'Plate'
    COSMETIC      = 5,  -- 'Cosmetic'
    SHIELDS       = 6,  -- 'Shields'
    LIBRAMS       = 7,  -- 'Librams'
    IDOLS         = 8,  -- 'Idols'
    TOTEMS        = 9,  -- 'Totems'
    SIGILS        = 10, -- 'Sigils'
    RELIC         = 11, -- 'Relic'
}

_G.HL_ITEM_SUB_CLASS.REAGENT = {
    REAGENT  = 0, -- 'Reagent'
    KEYSTONE = 1, -- 'Keystone'
}

_G.HL_ITEM_SUB_CLASS.PROJECTILE = {
    WAND   = 0, -- 'Wand(OBSOLETE)'
    BOLT   = 1, -- 'Bolt(OBSOLETE)'
    ARROW  = 2, -- 'Arrow'
    BULLET = 3, -- 'Bullet'
    THROWN = 4, -- 'Thrown(OBSOLETE)'
}

_G.HL_ITEM_SUB_CLASS.TRADESKILL = {
    TRADE_GOODS            = 0,  -- 'Trade Goods (OBSOLETE)'
    PARTS                  = 1,  -- 'Parts'
    EXPLOSIVES             = 2,  -- 'Explosives (OBSOLETE)'
    DEVICES                = 3,  -- 'Devices (OBSOLETE)'
    JEWELCRAFTING          = 4,  -- 'Jewelcrafting'
    CLOTH                  = 5,  -- 'Cloth'
    LEATHER                = 6,  -- 'Leather'
    METAL_STONE            = 7,  -- 'Metal & Stone'
    COOKING                = 8,  -- 'Cooking'
    HERB                   = 9,  -- 'Herb'
    ELEMENTAL              = 10, -- 'Elemental'
    OTHER                  = 11, -- 'Other'
    ENCHANTING             = 12, -- 'Enchanting'
    MATERIALS              = 13, -- 'Materials (OBSOLETE)'
    ITEM_ENCHANTMENT       = 14, -- 'Item Enchantment (OBSOLETE)'
    WEAPON_ENCHANTMENT     = 15, -- 'Weapon Enchantment - Obsolete'
    INSCRIPTION            = 16, -- 'Inscription'
    EXPLOSIVES_AND_DEVICES = 17, -- 'Explosives and Devices (OBSOLETE)'
}

_G.HL_ITEM_SUB_CLASS.ITEM_ENHANCEMENT = {
    HEAD              = 0,  -- 'Head'
    NECK              = 1,  -- 'Neck'
    SHOULDER          = 2,  -- 'Shoulder'
    CLOAK             = 3,  -- 'Cloak'
    CHEST             = 4,  -- 'Chest'
    WRIST             = 5,  -- 'Wrist'
    HANDS             = 6,  -- 'Hands'
    WAIST             = 7,  -- 'Waist'
    LEGS              = 8,  -- 'Legs'
    FEET              = 9,  -- 'Feet'
    FINGER            = 10, -- 'Finger'
    WEAPON            = 11, -- 'Weapon'
    TWO_HANDED_WEAPON = 12, -- 'Two-Handed Weapon'
    SHIELD_OFF_HAND   = 13, -- 'Shield/Off-hand'
    MISC              = 14, -- 'Misc'
}

_G.HL_ITEM_SUB_CLASS.RECIPE = {
    BOOK           = 0,  -- 'Book'
    LEATHERWORKING = 1,  -- 'Leatherworking'
    TAILORING      = 2,  -- 'Tailoring'
    ENGINEERING    = 3,  -- 'Engineering'
    BLACKSMITHING  = 4,  -- 'Blacksmithing'
    COOKING        = 5,  -- 'Cooking'
    ALCHEMY        = 6,  -- 'Alchemy'
    FIRST_AID      = 7,  -- 'First Aid'
    ENCHANTING     = 8,  -- 'Enchanting'
    FISHING        = 9,  -- 'Fishing'
    JEWELCRAFTING  = 10, -- 'Jewelcrafting'
    INSCRIPTION    = 11, -- 'Inscription'
}

_G.HL_ITEM_SUB_CLASS.QUIVER = {
    QUIVER     = 0, -- 'Quiver(OBSOLETE)'
    BOLT       = 1, -- 'Bolt(OBSOLETE)'
    QUIVER     = 2, -- 'Quiver'
    AMMO_POUCH = 3, -- 'Ammo Pouch'
}

_G.HL_ITEM_SUB_CLASS.QUEST = {
    QUEST = 0, -- 'Quest'
}

_G.HL_ITEM_SUB_CLASS.KEY = {
    KEY      = 0, -- 'Key'
    LOCKPICK = 1, -- 'Lockpick'
}

_G.HL_ITEM_SUB_CLASS.MISCELLANEOUS = {
    JUNK           = 0, -- 'Junk'
    REAGENT        = 1, -- 'Reagent'
    COMPANION_PETS = 2, -- 'Companion Pets'
    HOLIDAY        = 3, -- 'Holiday'
    OTHER          = 4, -- 'Other'
    MOUNT          = 5, -- 'Mount'
}

_G.HL_ITEM_SUB_CLASS.BATTLE_PETS = {
    HUMANOID   = 0, -- 'Humanoid'
    DRAGONKIN  = 1, -- 'Dragonkin'
    FLYING     = 2, -- 'Flying'
    UNDEAD     = 3, -- 'Undead'
    CRITTER    = 4, -- 'Critter'
    MAGIC      = 5, -- 'Magic'
    ELEMENTAL  = 6, -- 'Elemental'
    BEAST      = 7, -- 'Beast'
    AQUATIC    = 8, -- 'Aquatic'
    MECHANICAL = 9, -- 'Mechanical'
}

_G.HL_ITEM_SUB_CLASS.WOW_TOKEN = {
    WOW_TOKEN = 0, -- 'WoW Token'
}
