--[[
╦┌┬┐┌─┐┌┬┐
║ │ ├┤ │││
╩ ┴ └─┘┴ ┴

--]]
local LootItem = HotLoot.Class:Create('LootItem')
HotLoot.LootItem = LootItem

--[[
    [1]={
        item="Intact Shimmering Scale",
        quantity=1,
        quality=0,
        texture=443382
        locked=false,
        roll=false,
    }
 ]]

function LootItem:New(item, slot)
    -- if not slot then error('An slot number must be supplied.', 2) end
    if not item or type(item) ~= 'table' then error('An item table must be supplied.', 2) end
    local t = {}
    setmetatable(t, self)
    self.__index = self
    t.__class = 'LootItem'
    t.__data  = {}

    for k,v in pairs(item) do
        if k == 'item' then
            t.__data.name = v
        else
            t.__data[k] = v
        end
    end
    if slot then
        t.__data.link = GetLootSlotLink(slot)
        t.__data.slotType = GetLootSlotType(slot)
        t.__data.slot = slot
    end

    return t
end

function LootItem:NewDummy(itemLink)
    local t = {}
    setmetatable(t, self)
    self.__index = self
    t.__class = 'LootItem'
    t.__data  = {}

    local item = {
        -- texture     = itemTexture,
        -- item        = itemName,
        -- quality     = itemQuality,
        -- isQuestItem = isQuestItem,
        -- questId     = questId,
        -- isActive    = isActive,
        -- link        = itemLink,
        quantity    = 1,
        locked      = false,
        slotType    = HL_LOOT_SLOT_TYPE.ITEM
    }

    item.name, item.link, item.quality, _, _, _, _, _, _, item.texture, _, _, _, _, _, _, _ = GetItemInfo(itemLink)

    for k,v in pairs(item) do
        if k == 'item' then
            t.__data.name = v
        else
            t.__data[k] = v
        end
    end

    return t
end

function LootItem:ToItem()
    local item = HotLoot.Item:New(self:Link())
    item:SetQuantity(self:Quantity())
    item:SetSlotType(self:SlotType())

    return item
end

function LootItem:SetLootReason(value)
    self.__data.reason = tostring(value)
end

function LootItem:GetInfo(key)
    if not key then return end
    return self.__data[key]
end

function LootItem:Slot()
    return self:GetInfo('slot')
end

function LootItem:ID()
    if self.__data.link then
        self.__data.id = self.__data.id or GetItemInfoInstant(self.__data.link)
    end
    return self:GetInfo('id')
end

function LootItem:Link()
    return self:GetInfo('link')
end

function LootItem:Name()
    return self:GetInfo('name')
end

function LootItem:Quantity()
    return self:GetInfo('quantity')
end

function LootItem:Quality()
    return self:GetInfo('quality')
end

function LootItem:SlotType()
    return self:GetInfo('slotType')
end

function LootItem:Locked()
    return self:GetInfo('locked')
end

function LootItem:Roll()
    return self:GetInfo('roll')
end

function LootItem:Texture()
    return self:GetInfo('texture')
end

function LootItem:IsGold()
    return self:GetInfo('slotType') == HL_LOOT_SLOT_TYPE.COIN
end

function LootItem:IsCurrency()
    return self:GetInfo('slotType') == HL_LOOT_SLOT_TYPE.CURRENCY
end

function LootItem:IsItem()
    return self:GetInfo('slotType') == HL_LOOT_SLOT_TYPE.ITEM
end

function LootItem:Loot()
    if self:GetInfo('slot') then
        LootSlot(self:GetInfo('slot'))
    end
end
