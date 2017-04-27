-- FIXME: Look at elvUI's loot code to see how to do it right.
--          Forget a seperate pool and just use the slots in the frame as the pool. Hide slot at all times unless needed and have slots numbered (and named) and just change the text

local HotLootFrame = HotLoot:NewModule('LootFrame', 'AceEvent-3.0')
local module = HotLootFrame -- Alias
HotLootFrame.LootFrame = CreateFrame('Frame', 'HotLoot_LootFrame', UIParent, 'HotLoot_LootFrameTemplate')
local Options = HotLoot:GetModule('Options')

local LSM = LibStub('LibSharedMedia-3.0')

local defaults = {
    profile = {
        toggleLootFrameEnable = true
    }
}

local slotPool = {}
local slotFrames = {}
--[[
    Slot Object Inteface =
    {
        frame: Frame
        active: boolean
        slot: Loot Slot
    }
]]

function module:OnInitialize()
    self.db = Options.db:RegisterNamespace('LootFrame', defaults)
    self.options = self.db.profile
end

function module:OnEnable()
    if Options:Get('toggleLootFrameEnable') then
        -- TODO: IF enabled option is set to false then skip this stuff and just disable the module
        -- TODO: Also consider just getting rid of the ondisable stuff and just force a reload with module disabled

        -- Register events
        -- self:RegisterEvent("LOOT_OPENED")
        self:RegisterEvent("LOOT_CLOSED")
        self:RegisterEvent("LOOT_SLOT_CLEARED")
        -- self:RegisterEvent("MODIFIER_STATE_CHANGED")
        -- self:RegisterEvent("PARTY_MEMBERS_CHANGED")

        -- Disable default frame
        LootFrame:UnregisterEvent("LOOT_OPENED")
        LootFrame:UnregisterEvent("LOOT_CLOSED")
        LootFrame:UnregisterEvent("LOOT_SLOT_CLEARED")

        -- Register for escape close
        table.insert(UISpecialFrames, "HotLootFrame.LootFrame")

        -- Set Up Loot Frame
        self:ApplyOptions()
    end
end

-- function module:OnDisable()
--     -- Register events
--     -- self:UnregisterEvent("LOOT_OPENED")
--     self:UnregisterEvent("LOOT_CLOSED")
--     self:UnregisterEvent("LOOT_SLOT_CLEARED")
--     -- self:UnregisterEvent("MODIFIER_STATE_CHANGED")
--     -- self:UnregisterEvent("PARTY_MEMBERS_CHANGED")

--     -- Disable default frame
--     LootFrame:RegisterEvent("LOOT_OPENED")
--     LootFrame:RegisterEvent("LOOT_CLOSED")
--     LootFrame:RegisterEvent("LOOT_SLOT_CLEARED")

--     -- Register for escape close
--     -- table.insert(UISpecialFrames, "HotLootFrame.LootFrame")

--     if self.LootFrame:IsVisible() then
--         self:Hide()
--     end
-- end

function module:ApplyOptions()
    -- Unit Frame
    self.LootFrame.unitFrame.name:SetFont(HotLoot.media.fonts.Macondo, 16)
    self.LootFrame.unitFrame.name:SetText('N/A')
end

function module:CreateLootSlot()
end

function module:ResetSlot(slotObj)
    if not slotObj then return false end

    slotObj.frame:ClearAllPoints()

    -- Name
    slotObj.frame.name:SetFont(HotLoot.media.fonts.Macondo, 12)
    slotObj.frame.name:SetText('N/A')

    -- Type
    slotObj.frame.space1:SetFont(HotLoot.media.fonts.RobotoCondensedBold, 12)
    slotObj.frame.space1:SetText('N/A')

    -- Info
    slotObj.frame.space2:SetFont(HotLoot.media.fonts.RobotoCondensedBold, 12)
    slotObj.frame.space2:SetText('N/A')

    slotObj.active = false

    slotObj.slot = 0
end

function module:NewLootSlot()
    -- local poolSize = 0
    for i, slotObj in ipairs(slotPool) do
        if not slotObj.active then
            slotObj.active = true
            return slotObj
        end
        -- poolSize = i
    end

    -- No unused slots, create one
    local newFrame = CreateFrame('Frame', nil, HotLoot_LootFrame, 'HotLoot_LootSlotTemplate')
    local newObj = {
        frame = newFrame
    }
    
    self:ResetSlot(newObj)

    newObj.active = true

    table.insert(slotPool, newObj)

    return newObj
end

function module:Update()
    -- Set Unit
    local unitFrame = self.LootFrame.unitFrame
    local targetExists = UnitExists('target')
    local targetDead = UnitIsDead('target')
    
    if targetExists and targetDead then
        SetPortraitTexture(unitFrame.portrait, 'target')
        unitFrame.portrait:SetTexCoord(0.15,0.85,0.15,0.85)
        unitFrame.name:SetText(GetUnitName("target", false))
    end

    -- Loot Slots
    local slot = 1
    for i=1, GetNumLootItems() do
        local lootIcon, lootName, lootQuantity, lootQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(i)
        if lootName then
            local lootLink = GetLootSlotLink(i)

            -- Make Slot
            local lootSlotObj = self:NewLootSlot()

            lootSlotObj.slot = i

            -- Icon
            lootSlotObj.frame.icon:SetTexture(lootIcon)

            -- Name
            lootSlotObj.frame.name:SetText(lootName)

            -- Click
            lootSlotObj.frame:EnableMouse(true)
            lootSlotObj.frame:SetScript("OnMouseDown", function(self, button)
                if button == 'LeftButton' then
                    module:LootSlot(i, slot)
                end
            end)

            -- TODO: CLEAN THIS UP AND FIX THE RELATED XMl... all the anchors for the slots need to be in lua because of no name
            if slot == 1 then
                lootSlotObj.frame:SetPoint('TOP', self.LootFrame.unitFrame, 'BOTTOM', 0, -9)
                -- TODO: maybe move these icon ones to the NewFrame method )slot)
                lootSlotObj.frame.background:SetPoint('LEFT', lootSlotObj.frame.icon, 'RIGHT', 8, 0)
                lootSlotObj.frame.background:SetPoint('RIGHT', lootSlotObj.frame, 'RIGHT', 0, 0)
                -- lootSlotObj.frame:SetPoint('LEFT', HotLoot_LootFrame, 'LEFT', 0, 0)
                -- lootSlotObj.frame:SetPoint('RIGHT', HotLoot_LootFrame, 'RIGHT', 0, 0)
            else
                lootSlotObj.frame:SetPoint('TOP', slotFrames[slot - 1].frame, 'BOTTOM', 0, -8)
                lootSlotObj.frame.background:SetPoint('LEFT', lootSlotObj.frame.icon, 'RIGHT', 8, 0)
                lootSlotObj.frame.background:SetPoint('RIGHT', lootSlotObj.frame, 'RIGHT', 0, 0)
                -- lootSlotObj.frame:SetPoint('LEFT', HotLoot_LootFrame, 'LEFT', 0, 0)
                -- lootSlotObj.frame:SetPoint('RIGHT', HotLoot_LootFrame, 'RIGHT', 0, 0)
            end

            slotFrames[slot] = lootSlotObj

            slot = slot + 1
        end
    end

    local numSlots = slot - 1

    -- Adjust Size
    -- self.LootFrame:SetPoint('BOTTOM', slotFrames[numSlots].frame, 'BOTTOM', 0, -9)
end

function module:AnchorSlots()
    local prevSlot
    for i=1, GetNumLootItems() do
        if slotFrames[i] then
            if not prevSlot then
                firstSlot = false
                slotFrames[i].frame:SetPoint('TOP', self.LootFrame.unitFrame, 'BOTTOM', 0, -9)
                slotFrames[i].frame:SetPoint('LEFT', HotLoot_LootFrame, 'LEFT', 0, 0)
                slotFrames[i].frame:SetPoint('RIGHT', HotLoot_LootFrame, 'RIGHT', 0, 0)
                prevSlot = i
            else
                slotFrames[i].frame:SetPoint('TOP', slotFrames[prevSlot].frame, 'BOTTOM', 0, -8)
                slotFrames[i].frame:SetPoint('LEFT', HotLoot_LootFrame, 'LEFT', 0, 0)
                slotFrames[i].frame:SetPoint('RIGHT', HotLoot_LootFrame, 'RIGHT', 0, 0)
                prevSlot = i
            end
        end
    end
end

function module:LootSlot(slot, slotFrameIndex)
    -- FIXME: TODO: Loot SLot but wait until LOOT_SLOT_CLEARED to actually remove the frame and reset it
    --                  that way you can make sure the item was actually looted before you get rid of it
    -- Something like
    --[[
        func loot_slot_clearedEVENT(blizzesActualSlotNotMine AKA slot)
            allTheSlotsDisplayed[slot]:Hide()
            allTheSlotsDisplayed[slot] = clear() and sendToPool()
        end
        -- Maybe use the reset method and add hide to it? instead of using a clear or something?
    ]]

    LootSlot(slot)
end

function module:Show()
    self.LootFrame:Show()
end

function module:Hide()
    self.LootFrame:Hide()
end

-- function module:LOOT_OPENED()
    -- if HotLoot:isLootFiltered() then
        
    -- end
-- end

function module:LOOT_CLOSED()
    self.LootFrame:Hide()
    for k, slotObj in pairs(slotFrames) do
        -- if slotObj.active then
            self.ResetSlot(slotObj)
        -- end
    end
    slotFrames = {}
end

function module:LOOT_SLOT_CLEARED(event, slot)
    for k, slotObj in pairs(slotFrames) do
        if slotObj.slot == slot then
            slotFrames[k].frame:Hide()
            self:ResetSlot(slotFrames[k])
            slotFrames[k] = nil
        end
    end

    self:AnchorSlots()
end

