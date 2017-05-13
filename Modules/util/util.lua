local Util = HotLoot:NewModule('Util')
local module = Util -- Alias

--
-- ─── GLOBAL ─────────────────────────────────────────────────────────────────────
--

function Util:ColorText(text, hex)
    -- TODO: add hex error checking
    if hex == 'addon' then
        hex = 'FF3D00'
    elseif hex == 'info' then
        hex = '8BE9FD'
    elseif hex == 'success' then
        hex = '50FA7B'
    elseif hex == 'warning' then
        hex = 'ffb86c'
    elseif hex == 'alert' then
        hex = 'ff5555'
    end

    if string.len(hex) == 6 then
        hex = 'ff'..hex
    end

    return '|c'..tostring(hex):upper()..tostring(text)..'|r'
end

function Util:Print(text, frame)
    if not frame then
        -- TODO: Put option for chat ouput frame here
		frame = DEFAULT_CHAT_FRAME
	elseif type(frame) ~= 'table' or not frame.AddMessage then
		frame = DEFAULT_CHAT_FRAME
	end

    frame:AddMessage(self:ColorText('HotLoot', 'addon')..': '..tostring(text))
end

function Util:Announce(text)
    if HotLoot.options.toggleAnnounceEvents then
        self:Print(text)
    end
end

function Util:Debug(text)
    if HotLoot.options.toggleDebugMode then
        self:Print(self:ColorText('<DEBUG> ', 'alert')..text)
    end
end

function Util:DebugOption(option, value, old)
    if old ~= nil then
        self:Debug(tostring(option)..': '..tostring(old)..' -> '..tostring(value))
    else
        self:Debug(tostring(option)..' => '..tostring(value))
    end
end

function Util:ToCopper(input)
    local gold = tonumber(string.match(input,"(%d+)%s?[gG]")) or 0;
    local silver = tonumber(string.match(input,"(%d+)%s?[sS]")) or 0;
    local copper = tonumber(string.match(input,"(%d+)%s?[cC]")) or 0;
    local total = (gold*10000)+(silver*100)+(copper);
    return total;
end
-------------
function Util:UCFirst(str)
    return (str:gsub("^%l", string.upper))
end

function Util:Round(num, idp)
    local mult = 10^(idp or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

function Util:GetItemID(itemString)
    local itemId = select(2, strsplit(':', itemString))
    return tonumber(itemId)
end

-- RealUI Support
function Util:IsRealUILootOn()
    if IsAddOnLoaded('nibRealUI') then
        return RealUI:GetModuleEnabled('Loot');
    else
        return false;
    end
end

function Util:IsCloseKeyDown()
    local keyDown = false
    local modKey = HotLoot.options.selectCloseLootWindowModifier
    if     (modKey == "ctrl")  then keyDown = IsControlKeyDown()
    elseif (modKey == "shift") then keyDown = IsShiftKeyDown()
    elseif (modKey == "alt")   then keyDown = IsAltKeyDown()
    end
    return keyDown
end

function Util:IsSkinKeyDown()
    local keyDown = false
    local modKey = HotLoot.options.selectSkinningModeModifier
    if     (modKey == "ctrl")  then keyDown = IsControlKeyDown()
    elseif (modKey == "shift") then keyDown = IsShiftKeyDown()
    elseif (modKey == "alt")   then keyDown = IsAltKeyDown()
    end
    return keyDown
end

function Util:IsEmpty(t)
    return next(t) == nil
end

function Util:SlotIsGold(slot)
    if GetLootSlotType(slot) == HL_LOOT_SLOT_TYPE.COIN then 
        return true
    end
end

function Util:SlotIsCurrency(slot)
    if GetLootSlotType(slot) == HL_LOOT_SLOT_TYPE.CURRENCY then 
        return true
    end
end
