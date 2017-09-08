local MAJOR, MINOR = "LibTTScan-1.0", 4
assert(LibStub, MAJOR .. " requires LibStub")
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

-- [AUTOLOCAL START]
local ARTIFACT_POWER = ARTIFACT_POWER
local CreateFrame = CreateFrame
local GetItemInfo = GetItemInfo
local ITEM_SOULBOUND = ITEM_SOULBOUND
local ITEM_SPELL_KNOWN = ITEM_SPELL_KNOWN
local ITEM_SPELL_TRIGGER_ONUSE = ITEM_SPELL_TRIGGER_ONUSE
local LE_ITEM_CLASS_CONSUMABLE = LE_ITEM_CLASS_CONSUMABLE
local WorldFrame = WorldFrame
local dump = DevTools_Dump
local gsub = string.gsub
local sfind = string.find
local smatch = string.match
-- [AUTOLOCAL END]

-- Custom tooltip for fast tooltip parsing
local tt, tt_l, tt_r = CreateFrame("GameTooltip"), {}, {}
for idx = 1, 70 do
    tt_l[idx], tt_r[idx] = tt:CreateFontString(), tt:CreateFontString()
    tt_l[idx]:SetFontObject(GameFontNormal)
    tt_r[idx]:SetFontObject(GameFontNormal)
    tt:AddFontStrings(tt_l[idx], tt_r[idx])
end
tt:SetOwner(WorldFrame, "ANCHOR_NONE")

lib.tooltip = tt
lib.tooltip_left = tt_l
lib.tooltip_right = tt_r

local tt_SetOwner = tt.SetOwner
local tt_ClearLines = tt.ClearLines
local tt_SetHyperlink = tt.SetHyperlink
local tt_SetItemByID = tt.SetItemByID
local tt_NumLines = tt.NumLines
local tt_SetMerchantItem = tt.SetMerchantItem
local tt_l_1 = tt_l[1]
local fs_GetText = tt_l[1].GetText

function lib.IsContainerItemSoulbound(bag, slot)
   tt:SetBagItem(bag, slot)
   local max_lines = tt_NumLines(tt)
   if max_lines > 10 then max_lines = 10 end
   for line = 2, max_lines do
      if fs_GetText(tt_l[line]) == ITEM_SOULBOUND then return true end
   end
end

-- /dump LibStub:GetLibrary("LibTTScan-1.0").GetQuestTitle()
function lib.GetQuestTitle(quest_id)
   tt_SetOwner(tt, WorldFrame, "ANCHOR_NONE")
   tt_ClearLines(tt)
   tt_SetHyperlink(tt, "quest:" .. quest_id)
   return fs_GetText(tt_l_1)
end

-- /dump LibStub:GetLibrary("LibTTScan-1.0").GetCreatureName()
function lib.GetCreatureName(creature_id)
   tt_SetOwner(tt, WorldFrame, "ANCHOR_NONE")
   tt_ClearLines(tt)
   tt_SetHyperlink(tt, "unit:Creature-----" .. creature_id)
   return fs_GetText(tt_l_1)
end

local is_consumable_artifact_power = { [139591] = 3 }
local colored_artifact_power_tt_text = "^|c" .. ("%x"):rep(8) .. ARTIFACT_POWER .. "|r$"
--- Extracts amount of Artifact Power granted by item from tooltip.
-- /dump LibStub:GetLibrary("LibTTScan-1.0").GetItemArtifactPower(item_id)
-- @param item_id ID (strictly numerical) of the item.
-- @param only_type If true, only check if item is an Artifact Power consumable and return bool instead of AP amount.
function lib.GetItemArtifactPower(item_id, only_type)
   local start_scan_line = is_consumable_artifact_power[item_id]
   if start_scan_line == false then return end

   local tooltip_set, max_lines
   if start_scan_line == nil then
      local _, _, _, _, _, _, _, _, _, _, _, itemClassID = GetItemInfo(item_id)
      if itemClassID ~= LE_ITEM_CLASS_CONSUMABLE then return end
      tt_SetOwner(tt, WorldFrame, "ANCHOR_NONE")
      tt_ClearLines(tt)
      tt_SetItemByID(tt, item_id)
      tooltip_set = true
      max_lines = tt_NumLines(tt)
      if max_lines > 10 then max_lines = 10 end
      for line = 2, max_lines do
         if sfind(fs_GetText(tt_l[line]), colored_artifact_power_tt_text) then start_scan_line = line + 1 break end
      end
      is_consumable_artifact_power[item_id] = start_scan_line or false
      if not start_scan_line then return end
   end

   if only_type then return true end

   if not tooltip_set then
      tt_SetOwner(tt, WorldFrame, "ANCHOR_NONE")
      tt_ClearLines(tt)
      tt_SetItemByID(tt, item_id)
      max_lines = tt_NumLines(tt)
      if max_lines > 10 then max_lines = 10 end
   end

    for line = start_scan_line, max_lines do
        local text = fs_GetText(tt_l[line])
        if sfind(text, ITEM_SPELL_TRIGGER_ONUSE) and sfind(text, ARTIFACT_POWER) then
            local whole, dec = smatch(text, '(%d+)[,.]?(%d*)')
            local amount = tonumber(whole..'.'..dec)

            if sfind(text, FIRST_NUMBER) then
                -- Thousand
                amount = amount * 1000
            elseif sfind(text, SECOND_NUMBER) then
                -- Million
                amount = amount * 1000000
            elseif sfind(text, THIRD_NUMBER) then
                -- Billion
                amount = amount * 1000000000
            elseif sfind(text, FOURTH_NUMBER) then
                -- Trillion
                amount = amount * 1000000000000
            else
                -- < 1000
                 amount = tonumber(whole..dec)
            end

            return amount or 0
        end
    end
end

-- /run LibStub("LibTTScan-1.0").IsMerchantItemAlreadyKnown(i)
-- @param index - item index to check (number)
function lib.IsMerchantItemAlreadyKnown(index)
   -- tt_SetOwner(tt, WorldFrame, "ANCHOR_NONE")
   -- tt_ClearLines(tt)
   tt_SetMerchantItem(tt, index)
   local max_lines = tt_NumLines(tt)
   for line = max_lines, 2, -1 do
      if fs_GetText(tt_l[line]) == ITEM_SPELL_KNOWN then return true end
   end
end
