--
-- ─── CONSTANTS ──────────────────────────────────────────────────────────────────
--
local _G = _G

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

_G.HL_FILTER_TYPE = {
    TYPE = 0,
    VALUE = 1,
    QUALITY = 2,
    NAME = 3,
    ILVL = 4,
    BIND = 5
}

_G.HL_BIND_TYPE = {
    BOA = 0,
    BOP = 1,
    BOE = 2
}

-- @usage
-- *to return the localized name*
-- GetItemClassInfo(itemClassEnum)
-- GetItemSubClassInfo(itemClassEnum, subClassEnum)

_G.HL_ITEM_QUALITY = {
    POOR      = _G.LE_ITEM_QUALITY_POOR,      -- 0
    COMMON    = _G.LE_ITEM_QUALITY_COMMON,    -- 1
    UNCOMMON  = _G.LE_ITEM_QUALITY_UNCOMMON,  -- 2
    RARE      = _G.LE_ITEM_QUALITY_RARE,      -- 3
    EPIC      = _G.LE_ITEM_QUALITY_EPIC,      -- 4
    LEGENDARY = _G.LE_ITEM_QUALITY_LEGENDARY, -- 5
    ARTIFACT  = _G.LE_ITEM_QUALITY_ARTIFACT,  -- 6
    HEIRLOOM  = _G.LE_ITEM_QUALITY_HEIRLOOM,  -- 7
    WOW_TOKEN = _G.LE_ITEM_QUALITY_WOW_TOKEN, -- 8
}

_G.HL_ITEM_CLASS = {
    CONSUMABLE       = _G.LE_ITEM_CLASS_CONSUMABLE,       -- 'Consumable'       NUM = 0
    CONTAINER        = _G.LE_ITEM_CLASS_CONTAINER,        -- 'Container'        NUM = 1
    WEAPON           = _G.LE_ITEM_CLASS_WEAPON,           -- 'Weapon'           NUM = 2
    GEM              = _G.LE_ITEM_CLASS_GEM,              -- 'Gem'              NUM = 3
    ARMOR            = _G.LE_ITEM_CLASS_ARMOR,            -- 'Armor'            NUM = 4
    -- REAGENT          = _G.LE_ITEM_CLASS_REAGENT,          -- 'Reagent'          NUM = 5
    -- PROJECTILE       = _G.LE_ITEM_CLASS_PROJECTILE,       -- 'Projectile'       NUM = 6
    TRADESKILL       = _G.LE_ITEM_CLASS_TRADEGOODS,       -- 'Tradeskill'       NUM = 7
    ITEM_ENHANCEMENT = _G.LE_ITEM_CLASS_ITEM_ENHANCEMENT, -- 'Item Enhancement' NUM = 8
    RECIPE           = _G.LE_ITEM_CLASS_RECIPE,           -- 'Recipe'           NUM = 9
    -- QUIVER           = _G.LE_ITEM_CLASS_QUIVER,           -- 'Quiver'           NUM = 11
    QUEST            = _G.LE_ITEM_CLASS_QUESTITEM,        -- 'Quest'            NUM = 12
    -- KEY              = _G.LE_ITEM_CLASS_KEY,              -- 'Key'              NUM = 13
    MISCELLANEOUS    = _G.LE_ITEM_CLASS_MISCELLANEOUS,    -- 'Miscellaneous'    NUM = 15
    GLYPH            = _G.LE_ITEM_CLASS_GLYPH,            -- 'Glyph'            NUM = 16
    BATTLE_PETS      = _G.LE_ITEM_CLASS_BATTLEPET,        -- 'Battle Pets'      NUM = 17
    -- WOW_TOKEN        = _G.LE_ITEM_CLASS_WOW_TOKEN         -- 'WoW Token'        NUM = 18
}

_G.HL_ITEM_SUB_CLASS = {}
_G.HL_ITEM_SUB_CLASS.CONSUMABLE = {
    EXPLOSIVES_AND_DEVICES = 0, -- 'Explosives and Devices'
    POTION                 = 1, -- 'Potion'
    ELIXIR                 = 2, -- 'Elixir'
    FLASK                  = 3, -- 'Flask'
    -- SCROLL                 = 4, -- 'Scroll (OBSOLETE)'
    FOOD_DRINK             = 5, -- 'Food & Drink'
    -- ITEM_ENHANCEMENT       = 6, -- 'Item Enhancement (OBSOLETE)'
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
    ONE_HANDED_AXES   = _G.LE_ITEM_WEAPON_AXE1H,       -- 'One-Handed Axes'   NUM = 0
    TWO_HANDED_AXES   = _G.LE_ITEM_WEAPON_AXE2H,       -- 'Two-Handed Axes'   NUM = 1
    BOWS              = _G.LE_ITEM_WEAPON_BOWS,        -- 'Bows'              NUM = 2
    GUNS              = _G.LE_ITEM_WEAPON_GUNS,        -- 'Guns'              NUM = 3
    ONE_HANDED_MACES  = _G.LE_ITEM_WEAPON_MACE1H,      -- 'One-Handed Maces'  NUM = 4
    TWO_HANDED_MACES  = _G.LE_ITEM_WEAPON_MACE2H,      -- 'Two-Handed Maces'  NUM = 5
    POLEARMS          = _G.LE_ITEM_WEAPON_POLEARM,     -- 'Polearms'          NUM = 6
    ONE_HANDED_SWORDS = _G.LE_ITEM_WEAPON_SWORD1H,     -- 'One-Handed Swords' NUM = 7
    TWO_HANDED_SWORDS = _G.LE_ITEM_WEAPON_SWORD2H,     -- 'Two-Handed Swords' NUM = 8
    WARGLAIVES        = _G.LE_ITEM_WEAPON_WARGLAIVE,   -- 'Warglaives'        NUM = 9
    STAVES            = _G.LE_ITEM_WEAPON_STAFF,       -- 'Staves'            NUM = 10
    -- BEAR_CLAWS        = _G.LE_ITEM_WEAPON_BEARCLAW,    -- 'Bear Claws'        NUM = 11
    -- CATCLAWS          = _G.LE_ITEM_WEAPON_CATCLAW,     -- 'CatClaws'          NUM = 12
    FIST_WEAPONS      = _G.LE_ITEM_WEAPON_UNARMED,     -- 'Fist Weapons'      NUM = 13
    MISCELLANEOUS     = _G.LE_ITEM_WEAPON_GENERIC,     -- 'Miscellaneous'     NUM = 14
    DAGGERS           = _G.LE_ITEM_WEAPON_DAGGER,      -- 'Daggers'           NUM = 15
    THROWN            = _G.LE_ITEM_WEAPON_THROWN,      -- 'Thrown'            NUM = 16
    -- SPEARS            = 17,                         -- 'Spears'            NUM = 17 --- NOTE: Obsolete? Missing global
    CROSSBOWS         = _G.LE_ITEM_WEAPON_CROSSBOW,    -- 'Crossbows'         NUM = 18
    WANDS             = _G.LE_ITEM_WEAPON_WAND,        -- 'Wands'             NUM = 19
    FISHING_POLES     = _G.LE_ITEM_WEAPON_FISHINGPOLE, -- 'Fishing Poles'     NUM = 20
}

_G.HL_ITEM_SUB_CLASS.GEM = {
    INTELLECT       = _G.LE_ITEM_GEM_INTELLECT,      -- 'Intellect'       NUM = 0
    AGILITY         = _G.LE_ITEM_GEM_AGILITY,        -- 'Agility'         NUM = 1
    STRENGTH        = _G.LE_ITEM_GEM_STRENGTH,       -- 'Strength'        NUM = 2
    STAMINA         = _G.LE_ITEM_GEM_STAMINA,        -- 'Stamina'         NUM = 3
    SPIRIT          = _G.LE_ITEM_GEM_SPIRIT,         -- 'Spirit'          NUM = 4
    CRITICAL_STRIKE = _G.LE_ITEM_GEM_CRITICALSTRIKE, -- 'Critical Strike' NUM = 5
    MASTERY         = _G.LE_ITEM_GEM_MASTERY,        -- 'Mastery'         NUM = 6
    HASTE           = _G.LE_ITEM_GEM_HASTE,          -- 'Haste'           NUM = 7
    VERSATILITY     = _G.LE_ITEM_GEM_VERSATILITY,    -- 'Versatility'     NUM = 8
    OTHER           = 9,                          -- 'Other'           NUM = 9 --- NOTE: No global for this?
    MULTIPLE_STATS  = _G.LE_ITEM_GEM_MULTIPLESTATS,  -- 'Multiple Stats'  NUM = 10
    ARTIFACT_RELIC  = _G.LE_ITEM_GEM_ARTIFACTRELIC,  -- 'Artifact Relic'  NUM = 11
}

_G.HL_ITEM_SUB_CLASS.ARMOR = {
    MISCELLANEOUS = _G.LE_ITEM_ARMOR_GENERIC,  -- 'Miscellaneous' NUM = 0
    CLOTH         = _G.LE_ITEM_ARMOR_CLOTH,    -- 'Cloth'         NUM = 1
    LEATHER       = _G.LE_ITEM_ARMOR_LEATHER,  -- 'Leather'       NUM = 2
    MAIL          = _G.LE_ITEM_ARMOR_MAIL,     -- 'Mail'          NUM = 3
    PLATE         = _G.LE_ITEM_ARMOR_PLATE,    -- 'Plate'         NUM = 4
    COSMETIC      = _G.LE_ITEM_ARMOR_COSMETIC, -- 'Cosmetic'      NUM = 5
    SHIELDS       = _G.LE_ITEM_ARMOR_SHIELD,   -- 'Shields'       NUM = 6
    LIBRAMS       = _G.LE_ITEM_ARMOR_LIBRAM,   -- 'Librams'       NUM = 7
    IDOLS         = _G.LE_ITEM_ARMOR_IDOL,     -- 'Idols'         NUM = 8
    TOTEMS        = _G.LE_ITEM_ARMOR_TOTEM,    -- 'Totems'        NUM = 9
    SIGILS        = _G.LE_ITEM_ARMOR_SIGIL,    -- 'Sigils'        NUM = 10
    RELIC         = _G.LE_ITEM_ARMOR_RELIC,    -- 'Relic'         NUM = 11
}

_G.HL_ITEM_SUB_CLASS.REAGENT = {
    REAGENT  = 0, -- 'Reagent'
    KEYSTONE = 1, -- 'Keystone'
}

_G.HL_ITEM_SUB_CLASS.PROJECTILE = {
    -- WAND   = 0, -- 'Wand(OBSOLETE)'
    -- BOLT   = 1, -- 'Bolt(OBSOLETE)'
    ARROW  = 2, -- 'Arrow'
    BULLET = 3, -- 'Bullet'
    -- THROWN = 4, -- 'Thrown(OBSOLETE)'
}

_G.HL_ITEM_SUB_CLASS.TRADESKILL = {
    -- TRADE_GOODS            = 0,  -- 'Trade Goods (OBSOLETE)'
    PARTS                  = 1,  -- 'Parts'
    -- EXPLOSIVES             = 2,  -- 'Explosives (OBSOLETE)'
    -- DEVICES                = 3,  -- 'Devices (OBSOLETE)'
    JEWELCRAFTING          = 4,  -- 'Jewelcrafting'
    CLOTH                  = 5,  -- 'Cloth'
    LEATHER                = 6,  -- 'Leather'
    METAL_STONE            = 7,  -- 'Metal & Stone'
    COOKING                = 8,  -- 'Cooking'
    HERB                   = 9,  -- 'Herb'
    ELEMENTAL              = 10, -- 'Elemental'
    OTHER                  = 11, -- 'Other'
    ENCHANTING             = 12, -- 'Enchanting'
    -- MATERIALS              = 13, -- 'Materials (OBSOLETE)'
    -- ITEM_ENCHANTMENT       = 14, -- 'Item Enchantment (OBSOLETE)'
    -- WEAPON_ENCHANTMENT     = 15, -- 'Weapon Enchantment - Obsolete'
    INSCRIPTION            = 16, -- 'Inscription'
    -- EXPLOSIVES_AND_DEVICES = 17, -- 'Explosives and Devices (OBSOLETE)'
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
    BOOK           = _G.LE_ITEM_RECIPE_BOOK,          -- 'Book'           NUM = 0
    LEATHERWORKING = _G.LE_ITEM_RECIPE_LEATHERWORKING,-- 'Leatherworking' NUM = 1
    TAILORING      = _G.LE_ITEM_RECIPE_TAILORING,     -- 'Tailoring'      NUM = 2
    ENGINEERING    = _G.LE_ITEM_RECIPE_ENGINEERING,   -- 'Engineering'    NUM = 3
    BLACKSMITHING  = _G.LE_ITEM_RECIPE_BLACKSMITHING, -- 'Blacksmithing'  NUM = 4
    COOKING        = _G.LE_ITEM_RECIPE_COOKING,       -- 'Cooking'        NUM = 5
    ALCHEMY        = _G.LE_ITEM_RECIPE_ALCHEMY,       -- 'Alchemy'        NUM = 6
    FIRST_AID      = _G.LE_ITEM_RECIPE_FIRST_AID,     -- 'First Aid'      NUM = 7
    ENCHANTING     = _G.LE_ITEM_RECIPE_ENCHANTING,    -- 'Enchanting'     NUM = 8
    FISHING        = _G.LE_ITEM_RECIPE_FISHING,       -- 'Fishing'        NUM = 9
    JEWELCRAFTING  = _G.LE_ITEM_RECIPE_JEWELCRAFTING, -- 'Jewelcrafting'  NUM = 10
    INSCRIPTION    = _G.LE_ITEM_RECIPE_INSCRIPTION,   -- 'Inscription'    NUM = 11
}

_G.HL_ITEM_SUB_CLASS.QUIVER = {
    -- QUIVER     = 0, -- 'Quiver(OBSOLETE)'
    -- BOLT       = 1, -- 'Bolt(OBSOLETE)'
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
    JUNK           = _G.LE_ITEM_MISCELLANEOUS_JUNK,          -- 'Junk'           NUM = 0
    REAGENT        = _G.LE_ITEM_MISCELLANEOUS_REAGENT,       -- 'Reagent'        NUM = 1
    COMPANION_PETS = _G.LE_ITEM_MISCELLANEOUS_COMPANION_PET, -- 'Companion Pets' NUM = 2
    HOLIDAY        = _G.LE_ITEM_MISCELLANEOUS_HOLIDAY,       -- 'Holiday'        NUM = 3
    OTHER          = _G.LE_ITEM_MISCELLANEOUS_OTHER,         -- 'Other'          NUM = 4
    MOUNT          = _G.LE_ITEM_MISCELLANEOUS_MOUNT,         -- 'Mount'          NUM = 5
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
