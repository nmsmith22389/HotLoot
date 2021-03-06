local LSM = LibStub('LibSharedMedia-3.0')

-- Get Font -->
-- LSM:Fetch('font', self.db['general'].font)
-- LSM:Fetch('font', 'Macondo')

LSM:Register('font', 'Macondo'              , [[Interface\AddOns\HotLoot\media\fonts\Macondo-Regular.ttf]])
LSM:Register('font', 'Roboto Condensed Bold', [[Interface\AddOns\HotLoot\media\fonts\RobotoCondensed-Bold.ttf]])

-- Background
LSM:Register('background', 'HotLoot Custom', [[Interface\AddOns\HotLoot\media\textures\backgrounds\colorbg]])

-- Border
LSM:Register('border', 'HotLoot Custom', [[Interface\AddOns\HotLoot\media\textures\borders\colorborder]])
