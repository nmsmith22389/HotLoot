--[[
╦  ┌─┐┌─┐┌┬┐  ╦┌┐┌┌─┐┌─┐
║  │ ││ │ │   ║│││├┤ │ │
╩═╝└─┘└─┘ ┴   ╩┘└┘└  └─┘

--]]
local LootList = HotLoot.Class:Create('LootList')
HotLoot.LootList = LootList

--[[
    [1]={
        quantity=1,
        item="Intact Shimmering Scale",
        quality=0,
        locked=false,
        roll=false,
        texture=443382
    }
 ]]

function LootList:New()
    local t = {}
    setmetatable(t, self)
    self.__index = self
    self.__class = 'LootList'
    return t
end

function LootList:ImportLootInfo(lootInfo, basic)
    self.__data = lootInfo

    if not basic then
        for slot, item in pairs(self.__data) do
            item.link = GetLootSlotLink(slot)
        end
    end
end

function LootList:GetLootInfo()
    if not self.__data then return end
    return self.__data
end

function LootList:GetSlot(slot)
    if not self.__data then return end
    return self.__data[slot]
end

function LootList:GetInfo(slot, info)
    if not self.__data then return end
    local item = self.__data[slot]

    info = info == 'name' and 'item' or info

    return item[info]
end

function LootList:ToItem(slot)
    local link = self:GetInfo(slot, link)
    -- local id = GetItemInfoInstant(link)
    local item = HotLoot.Item:New(link)
    return item
end
