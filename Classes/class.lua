--[[
╔═╗┬  ┌─┐┌─┐┌─┐
║  │  ├─┤└─┐└─┐
╚═╝┴─┘┴ ┴└─┘└─┘

--]]
if not HotLoot then return end

local Class = {}
Class.__class = 'Class'
HotLoot.Class = Class

function Class:Create(cl)
    -- if not cl or type(cl) ~= 'string' then error('A string must be passed when creating a class.') end
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.__class = tostring(cl) or self.__class
    return o
end

function Class:GetClass()
    return self.__class
end

function Class:IsClass(cl)
    if not cl.GetClass then return false end
    return self:GetClass() == cl:GetClass()
end
