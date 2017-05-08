-- FIXME: Look at elvUI's loot code to see how to do it right.
--          Forget a seperate pool and just use the slots in the frame as the pool. Hide slot at all times unless needed and have slots numbered (and named) and just change the text

local HotLootFrame = HotLoot:NewModule('LootFrame', 'AceEvent-3.0')
local module = HotLootFrame -- Alias
HotLootFrame.LootFrame = CreateFrame('Frame', 'HotLoot_LootFrame', UIParent, 'HotLoot_LootFrameTemplate')
local Options = HotLoot:GetModule('Options')
local Util = HotLoot:GetModule('Util')
module.slots = {}

local LSM = LibStub('LibSharedMedia-3.0')

local defaults = {
    profile = {
        toggleLootFrameEnable = true
    }
}

local slotPool = {}
local slotFrames = {}

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
        -- self:ApplyOptions()
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
    self.LootFrame.unitFrame.name:SetFont(LSM:Fetch('font', 'Macondo'), 16)
    self.LootFrame.unitFrame.name:SetText('N/A')
end

function module:SetUnit()
    local unitFrame =    self.LootFrame.unitFrame
    local targetExists = UnitExists('target')
    local targetDead =   UnitIsDead('target')

    if targetExists and targetDead then
        -- SetPortraitTexture(unitFrame.portrait, 'target')
        -- unitFrame.portrait:SetTexCoord(0.15,0.85,0.15,0.85)
        
        local unitName = GetUnitName("target", false)
        if unitName then
            -- unitName = unitName:gsub('%s', '\n')
            self.LootFrame.name:SetFont(LSM:Fetch('font', 'Macondo'), 16)            
            self.LootFrame.name:SetText(unitName)
        else
            self.LootFrame.name:Hide()
        end
    else
        self.LootFrame.name:Hide()
    end
end

local function SetLoot(frame, loot)
    -- Icon
    frame.icon:SetTexture(loot.texture)

    -- Name
    frame.name:SetFont(LSM:Fetch('font', 'Macondo'), 12)
    frame.name:SetText(loot.item)

    frame.space1:SetFont(LSM:Fetch('font', 'Roboto Condensed Bold'), 12)
    frame.space2:SetFont(LSM:Fetch('font', 'Roboto Condensed Bold'), 12)

    -- Click
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if button == 'LeftButton' then
            module:LootSlot(loot.slot)
        end
    end)

    frame.pos = 1
    frame.slot = loot.slot
end

function module:UpdateAnchors()
    local totalHeight = 0
    for i, frame in ipairs(self.slots) do
        self:SetLootSlotAnchor(frame)
        totalHeight = totalHeight + 48
    end
    self.LootFrame:SetHeight(totalHeight)
end

function module:SetLootSlotAnchor(frame)
    local pos = frame.pos
    local padding = HotLoot.options.rangeToastPadding
    -- This offsets all slots by `padding` so the first one isn't touching the unitFrame
    local initialOffset = padding * -1
    local offset = ((pos - 1) * (40 + padding) * -1)

    frame:ClearAllPoints()
    frame:SetPoint('TOP', self.LootFrame, 'TOP', 8, offset + initialOffset)
end

function module:ShiftSlotPosUp()
    for i, frame in ipairs(self.slots) do
        frame.pos = frame.pos + 1
    end
end

function module:CreateLootSlot()
    local frame = CreateFrame('Frame', nil, HotLoot_LootFrame, 'HotLoot_LootSlotTemplate')

    frame.SetLoot = SetLoot

    frame:Hide()

    frame:SetScript('OnEnter', function(self, motion)
        self.hover:Show()
    end)

    frame:SetScript('OnLeave', function(self, motion)
        self.hover:Hide()
    end)

    -- table.insert(self.slots, frame)

    return frame
end

function module:LootSlot(slot)
    LootSlot(slot)
end

function module:Update()

    self:SetUnit()

    local lootInfo = GetLootInfo()

    for slot, lootItem in pairs(lootInfo) do
        lootInfo[slot].link = GetLootSlotLink(slot)
        lootInfo[slot].slotType = (Util:SlotIsGold(slot)     and HL_LOOT_SLOT_TYPE.COIN) or
                                  (Util:SlotIsCurrency(slot) and HL_LOOT_SLOT_TYPE.CURRENCY) or
                                  HL_LOOT_SLOT_TYPE.ITEM
        lootInfo[slot].slot = slot

        local frame
        local nextIndex = self:GetNextLootSlotIndex()

        if not nextIndex then
            frame = self:CreateLootSlot()
            self:ShiftSlotPosUp()
            frame:SetLoot(lootItem)
            table.insert(self.slots, frame)
        else
            frame = self.slots[nextIndex]
            self:ShiftSlotPosUp()
            frame:SetLoot(lootInfo[slot])
        end

        self:UpdateAnchors()

        frame:Show()

    end
end

function module:Show()
    self.LootFrame:Show()
end

function module:Hide()
    self.LootFrame:Hide()
end

-- Returns the next inactive index
function module:GetNextLootSlotIndex()
    for i, frame in ipairs(self.slots) do
        if not frame:IsShown() then
            return i
        end
    end

    return false
end

function module:LOOT_CLOSED()
    self.LootFrame:Hide()
    for i, frame in ipairs(self.slots) do
        frame:Hide()
    end
end

function module:LOOT_SLOT_CLEARED(event, slot)
    local deletedPos = 0
    for i, frame in ipairs(self.slots) do
        
        
        if frame.slot == slot and frame:IsShown() then
            frame:Hide()
            deletedPos = frame.pos
            frame.pos = 1
            for i, frame in ipairs(self.slots) do
                if frame.pos > deletedPos then
                    frame.pos = frame.pos - 1
                end
            end
        end
    end

    self:UpdateAnchors()
end

