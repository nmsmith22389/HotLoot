local Util = HotLoot:NewModule('Util')
local module = Util -- Alias

-- FIXME: Figure out a way to get the options module without errors

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
        -- TODO: add error handling
		frame = _G[HotLoot.modules.Options:Get('selectAnnounceWindow')]
	end
    if type(frame) ~= 'table' or not frame.AddMessage then
		frame = DEFAULT_CHAT_FRAME
	end

    frame:AddMessage(self:ColorText('HotLoot', 'addon')..': '..tostring(text))
end

function Util:Announce(text)
    if HotLoot.modules.Options:Get('toggleAnnounceEvents') then
        self:Print(text)
    end
end

function Util:Debug(text)
    if HotLoot.modules.Options:Get('toggleDebugMode') then
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
    local gold, silver, copper = 0, 0, 0
    local goldPatColored = '(%d+)[ ]?%|cffffd700[ ]?[gG]'
    local silverPatColored = '(%d+)[ ]?%|cffc7c7cf[ ]?[sS]'
    local copperPatColored = '(%d+)[ ]?%|cffeda55f[ ]?[cC]'

    if input:find(goldPatColored) then
        gold = tonumber(string.match(input, goldPatColored)) or 0
        input = input:gsub(goldPatColored, '', 1)
    else
        gold = tonumber(string.match(input,"(%d+)%s?[gG]")) or 0
    end
    if input:find(silverPatColored) then
        silver = tonumber(string.match(input, silverPatColored)) or 0
        input = input:gsub(silverPatColored, '', 1)
    else
        silver = tonumber(string.match(input,"(%d+)%s?[sS]")) or 0
    end
    if input:find(copperPatColored) then
        copper = tonumber(string.match(input, copperPatColored)) or 0
        input = input:gsub(copperPatColored, '', 1)
    else
        copper = tonumber(string.match(input,"(%d+)%s?[cC]")) or 0
    end
    local total = (gold*10000)+(silver*100)+(copper)
    return total
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
    local modKey = HotLoot.modules.Options:Get('selectCloseLootWindowModifier')
    if     (modKey == "ctrl")  then keyDown = IsControlKeyDown()
    elseif (modKey == "shift") then keyDown = IsShiftKeyDown()
    elseif (modKey == "alt")   then keyDown = IsAltKeyDown()
    end
    return keyDown
end

function Util:IsSkinKeyDown()
    local keyDown = false
    local modKey = HotLoot.modules.Options:Get('selectSkinningModeModifier')
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

--Money text formatting, code taken from Scrooge by thelibrarian ( http://www.wowace.com/addons/scrooge/ )
local COLOR_COPPER = "|cffeda55f"
local COLOR_SILVER = "|cffc7c7cf"
local COLOR_GOLD = "|cffffd700"
local ICON_COPPER = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
local ICON_SILVER = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
local ICON_GOLD = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
function Util:FormatMoney(amount, style, textonly)
	local coppername = textonly and COLOR_COPPER..COPPER_AMOUNT_SYMBOL..'|r' or ICON_COPPER
	local silvername = textonly and COLOR_SILVER..SILVER_AMOUNT_SYMBOL..'|r' or ICON_SILVER
	local goldname = textonly and COLOR_GOLD..GOLD_AMOUNT_SYMBOL..'|r' or ICON_GOLD

	local value = abs(amount)
	local gold = floor(value / 10000)
	local silver = floor(mod(value / 100, 100))
	local copper = floor(mod(value, 100))

	if not style or style == "SMART" then
		local str = "";
		if gold > 0 then
			str = format("%d%s%s", gold, goldname, (silver > 0 or copper > 0) and " " or "")
		end
		if silver > 0 then
			str = format("%s%d%s%s", str, silver, silvername, copper > 0 and " " or "")
		end
		if copper > 0 or value == 0 then
			str = format("%s%d%s", str, copper, coppername)
		end
		return str
	end

	if style == "FULL" then
		if gold > 0 then
			return format("%d%s %d%s %d%s", gold, goldname, silver, silvername, copper, coppername)
		elseif silver > 0 then
			return format("%d%s %d%s", silver, silvername, copper, coppername)
		else
			return format("%d%s", copper, coppername)
		end
	elseif style == "SHORT" then
		if gold > 0 then
			return format("%.1f%s", amount / 10000, goldname)
		elseif silver > 0 then
			return format("%.1f%s", amount / 100, silvername)
		else
			return format("%d%s", amount, coppername)
		end
	elseif style == "SHORTINT" then
		if gold > 0 then
			return format("%d%s", gold, goldname)
		elseif silver > 0 then
			return format("%d%s", silver, silvername)
		else
			return format("%d%s", copper, coppername)
		end
	elseif style == "CONDENSED" then
		if gold > 0 then
			return format("%s%d|r.%s%02d|r.%s%02d|r", COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper)
		elseif silver > 0 then
			return format("%s%d|r.%s%02d|r", COLOR_SILVER, silver, COLOR_COPPER, copper)
		else
			return format("%s%d|r", COLOR_COPPER, copper)
		end
	elseif style == "BLIZZARD" then
		if gold > 0 then
			return format("%s%s %d%s %d%s", BreakUpLargeNumbers(gold), goldname, silver, silvername, copper, coppername)
		elseif silver > 0 then
			return format("%d%s %d%s", silver, silvername, copper, coppername)
		else
			return format("%d%s", copper, coppername)
		end
	end

	-- Shouldn't be here; punt
	return self:FormatMoney(amount, "SMART")
end