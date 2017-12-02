--[[
╦┌┬┐┌─┐┌┬┐
║ │ ├┤ │││
╩ ┴ └─┘┴ ┴

--]]
local Item = HotLoot.Class:Create('Item')
HotLoot.Item = Item

-- NOTE: These are the returns for GetItemInfo()
-- local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemID)

function Item:New(id, silent)
    if not id then
        if not silent then
            error('An item must be supplied.', 2)
        else
            return
        end
    end
    local t = {}
    setmetatable(t, self)
    self.__index = self
    t.__class = 'Item'
    t.__data  = {}
    -- self.__hasLootInfo = false

    local data = {GetItemInfo(id)}
    if #data < 1 then
        if not silent then
            error('No item info.', 2)
        else
            return
        end
    end
    local keys = {'name', 'link', 'quality', 'level', 'minLevel', 'type', 'subType', 'stackCount', 'equipLoc', 'texture', 'value', 'class', 'subClass', 'bindType', 'expacID', 'setID', 'isReagent'}
    for i,v in ipairs(data) do
       t.__data[keys[i]] = v
    end
    t.__data.id = GetItemInfoInstant(id)

    return t
end

function Item:NewDelayed(id, callback)
    local t = {}
    setmetatable(t, self)
    self.__index = self
    t.__class = 'Item'
    t.__data  = {}

    Util:GetItemInfoDelayed(item,
        function(itemID, ...)
            local data = {...}
            if not data[1] then error('No item info.', 2) end
            local keys = {'name', 'link', 'quality', 'level', 'minLevel', 'type', 'subType', 'stackCount', 'equipLoc', 'texture', 'value', 'class', 'subClass', 'bindType', 'expacID', 'setID', 'isReagent'}
            for i,v in ipairs(data) do
                t.__data[keys[i]] = v
            end
            t.__data.id = itemID

            callback(t)
        end
    )
end

function Item:GetInfo(key)
    if not key then return end
    return self.__data[key]
end

function Item:SetQuantity(value)
    if not value then return end

    self.__data.quantity = value
end

function Item:SetSlotType(value)
    if not value then return end

    self.__data.slotType = value
end

function Item:ID()
    return self:GetInfo('id')
end

function Item:Name()
    return self:GetInfo('name')
end

function Item:Link()
    return self:GetInfo('link')
end

function Item:Quality()
    return self:GetInfo('quality')
end

function Item:iLvl()
    return self:GetInfo('level')
end

function Item:StackCount()
    return self:GetInfo('stackCount')
end

function Item:Value()
    return self:GetInfo('value')
end

function Item:Class()
    return self:GetInfo('class')
end

function Item:LocalClass()
    return GetItemClassInfo(self:GetInfo('class'))
end

function Item:SubClass()
    return self:GetInfo('subClass')
end

function Item:LocalSubClass()
    return GetItemSubClassInfo(self:GetInfo('class'), self:GetInfo('subClass'))
end

function Item:Quantity()
    return self:GetInfo('quantity') or 0
end

function Item:SlotType()
    return self:GetInfo('slotType')
end

function Item:Texture()
    return self:GetInfo('texture')
end

function Item:IsEquippable()
    return IsEquippableItem(self:Link()) or (self:Class() == HL_ITEM_CLASS.GEM and self:SubClass() == HL_ITEM_SUB_CLASS.GEM.ARTIFACT_RELIC)
end

--[[ function Item:ToLootItem()
    local itemData = {
        id = self:ID(),
        name = self:Name(),
        link = self:Link(),
        quantity = self:Quantity(),
        quality = self:Quality(),
        slotType = self:SlotType(),
        texture = self:Texture(),
        locked = false,
        roll = false
    }
    local item = HotLoot.LootItem:New(self.__data)
end
 ]]
