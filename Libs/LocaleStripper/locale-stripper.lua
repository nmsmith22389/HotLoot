-- ======================================
-- DEFAULT FILES
-- ======================================
local files = {
    'core.lua',
    'Modules/options/options.lua'
}
-- ======================================

local requireRel
if arg and arg[0] then
    package.path = arg[0]:match("(.-)[^\\/]+$") .. "?.lua;" .. package.path
    requireRel = require
elseif ... then
    local d = (...):match("(.-)[^%.]+$")
    function requireRel(module) return require(d .. module) end
end

requireRel('ansicolors')
requireRel('tbyk')

local reg = [=[L%[["'](%w+)["']%]]=]
local answer
print('Use default files? '..ansicolors.yellow..'[Y/N]'..ansicolors.reset)
answer = tostring(io.read())
if answer:find('^[nN][oO]?$') then
    -- Ask for list of files
    -- print(ansicolors.red..'Ask for file list'..ansicolors.reset)
    print('Please list your file paths seperated by semi-colon.')
    answer = tostring(io.read())
    if answer then
        files = {}
        for f in answer:gmatch('([^;]+)%s*%;?%s*') do
            table.insert(files, f)
        end
    end
end
print('Make a unified list? '..ansicolors.yellow..'[Y/N]'..ansicolors.reset)
answer = tostring(io.read())
local isUnified = false
if answer:find('^[yY][eE]?[sS]?$') then
    isUnified = true
end    
print(ansicolors.green..'Processing files...'..ansicolors.reset)

local fileOutPath = 'LOCALE-OUTPUT.lua'
local fileOutMode = 'w'

local output = {}
local outText = {}
local out = newT()

for i,filePath in ipairs(files) do
    if not isUnified then
        out = newT()
    end
    local found

    for line in io.lines(filePath) do
        if line:find(reg) then
            found = line:match(reg)
            
            out[found] = true
        end
    end

    if isUnified then
        output = out
    else
        output[filePath] = out
    end
end

local function inf(txt)
    table.insert(outText, tostring(txt)..'\n')
end
if isUnified then
    
    -- inf('-- ====================')
    -- inf('-- FILE: '..filePath)
    -- inf('-- ====================')
    -- inf('')
    
    for key, _ in output:spairs() do
        count = count + 1
        inf('L[\''..key..'\'] = \'\'')
    end
    
    -- inf('')
    -- inf('-- END '..filePath:match('[^%/]+%.lua$')..' -- Matches found: '..count)
    -- inf('')
else
    for filePath, keys in pairs(output) do
        local count = 0
        inf('-- ====================')
        inf('-- FILE: '..filePath)
        inf('-- ====================')
        inf('')
    
        for k,v in keys:spairs() do
            count = count + 1
            inf('L[\''..k..'\'] = \'\'')
        end
    
        inf('')
        inf('-- END '..filePath:match('[^%/]+%.lua$')..' -- Matches found: '..count)
        inf('')
    end
end

-- for i,line in ipairs(output) do
--     print(line)
-- end

local fileOut = io.open(fileOutPath, fileOutMode)
io.output(fileOut)

for i,line in ipairs(outText) do
    -- print(line)
    io.write(line or '')
end

io.close()

print(ansicolors.green..'DONE!'..ansicolors.reset)
print('Locales can be found in \"LOCALE-OUTPUT.lua\"')
