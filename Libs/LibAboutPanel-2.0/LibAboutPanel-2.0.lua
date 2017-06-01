--[[
	Whom is doing what with this library
	$Date: 2016-09-11 06:20:19 +0000 (Sun, 11 Sep 2016) $
	$Revision: 2 $
	$Author: myrroddin $
	$URL: file:///media/cf-repositories/svn/wow/libaboutpanel-2-0/mainline/trunk/LibAboutPanel-2.0/LibAboutPanel-2.0.lua $
	$Id: LibAboutPanel-2.0.lua 2 2016-09-11 06:20:19Z myrroddin $
	$Header: file:///media/cf-repositories/svn/wow/libaboutpanel-2-0/mainline/trunk/LibAboutPanel-2.0/LibAboutPanel-2.0.lua 2 2016-09-11 06:20:19Z myrroddin $
]]--

--- **LibAboutPanel-2.0** either creates an "About" panel in your AddOn's
-- Interface/AddOns frame or within said AddOn's options table
-- The word //About// will be localized, among other things, automatically
-- API includes:
-- * **CreateAboutPanel** which works like Ackis' LibAboutPanel
-- * **AboutOptionsTable** which embeds the panel within AceConfig-3.0 options table
--
-- @usage
-- function MyAddOn:OnInitialize()
--     local options = {
--         name = "MyAddOn",
--         type = "group",
--         args = {
--             enableAddOn = {
--                 order = 10,
--                 name = ENABLE, -- use Blizzard's global string
--                 type = "toggle",
--                 get = function() return self.db.profile.enableAddOn end,
--                 set = function(info, value)
--                     self.db.profile.enableAddOn = value
--                     if value then
--                         self:OnEnable()
--                     else
--                         self:OnDisable()
--                     end
--                 end
--             }
--         }
--     }
--     -- support for LibAboutPanel-2.0
--     options.args.aboutTab = self:AboutOptionsTable("MyAddOn")
--     options.args.aboutTab.order = 100

--    -- Register your options with AceConfigRegistry
--    LibStub("AceConfig-3.0"):RegisterOptionsTable("MyAddOn", options)
-- end
-- @class file
-- @name LibAboutPanel-2.0.lua
-- @release $Id: LibAboutPanel-2.0.lua 2 2016-09-11 06:20:19Z myrroddin $

local lib = LibStub:NewLibrary("LibAboutPanel-2.0", "$Revision: 2 $")
if not lib then
	return -- no upgrade necessary
end

-- handy fuction to create Title Case -----------
-- string.gsub(string, "(%a)([%w_']*)", TitleCase)
local function TitleCase(first, rest)
	return first:upper() .. rest:lower()
end

-- localization ---------------------------------
local function defaultTranslations(L, key)
	-- no translation for the key
	-- so it becomes its own translation
	return key
end
local L = setmetatable({},
	{__index = defaultTranslations
})

if GetLocale() == "koKR" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "frFR" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "deDE" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "ruRU" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "zhTW" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "zhCN" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "itIT" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "ptBR" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

elseif GetLocale() == "esES" or GetLocale() == "esMX" then
-- L["About"] = ""
-- L["All Rights Reserved"] = ""
-- L["Author"] = ""
-- L["Click and press Ctrl-C to copy"] = ""
-- L["Credits"] = ""
-- L["Email"] = ""
-- L["LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0"] = ""
-- L["License"] = ""
-- L["Localizations"] = ""
-- L["Notes"] = ""
-- L["Repository"] = ""
-- L["%s on the %s realm"] = ""
-- L["%s on the %s realm (%s)"] = ""
-- L["Version"] = ""
-- L["Website"] = ""
-- L["ToC/Description"] = ""

end

-- per AddOn options ----------------------------
local aboutTable = {}

-- LibAboutPanel stuff --------------------------
local editbox = CreateFrame("EditBox", nil, UIParent)
editbox:Hide()
editbox:SetAutoFocus(true)
editbox:SetHeight(32)
editbox:SetFontObject("GameFontHighlightSmall")
lib.editbox = editbox

local left = editbox:CreateTexture(nil, "BACKGROUND")
left:SetWidth(8) left:SetHeight(20)
left:SetPoint("LEFT", -5, 0)
left:SetTexture("Interface\\Common\\Common-Input-Border")
left:SetTexCoord(0, 0.0625, 0, 0.625)

local right = editbox:CreateTexture(nil, "BACKGROUND")
right:SetWidth(8) right:SetHeight(20)
right:SetPoint("RIGHT", 0, 0)
right:SetTexture("Interface\\Common\\Common-Input-Border")
right:SetTexCoord(0.9375, 1, 0, 0.625)

local center = editbox:CreateTexture(nil, "BACKGROUND")
center:SetHeight(20)
center:SetPoint("RIGHT", right, "LEFT", 0, 0)
center:SetPoint("LEFT", left, "RIGHT", 0, 0)
center:SetTexture("Interface\\Common\\Common-Input-Border")
center:SetTexCoord(0.0625, 0.9375, 0, 0.625)

editbox:SetScript("OnEscapePressed", editbox.ClearFocus)
editbox:SetScript("OnEnterPressed", editbox.ClearFocus)
editbox:SetScript("OnEditFocusLost", editbox.Hide)
editbox:SetScript("OnEditFocusGained", editbox.HighlightText)
editbox:SetScript("OnTextChanged", function(self)
	self:SetText(self:GetParent().val)
	self:HighlightText()
end)

local function OpenEditbox(self)
	editbox:SetText(self.val)
	editbox:SetParent(self)
	editbox:SetPoint("LEFT", self)
	editbox:SetPoint("RIGHT", self)
	editbox:Show()
end

local fields = { "Version", "Author", "X-Category", "X-License", "X-Email", "X-Website", "X-Credits", "X-Localizations" }
local haseditbox = { ["X-Website"] = true, ["X-Feedback"] = true, ["X-Email"] = true }

local function HideTooltip()
	GameTooltip:Hide()
end

local function ShowTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetText(L["Click and press Ctrl-C to copy"])
end

-- embedded functions beginning of file code
lib.embeds = lib.embeds or {}
local mixins = {
	"CreateAboutPanel",
	"AboutOptionsTable"
}

--- Embeds lib on target AddOn
-- So you can call LibStub("LibAboutPanel-2.0"):Embed(myAddOn)
-- @param target AddOn table in which to embed
-- @usage
-- local AddOnName, AddOn = ...
-- LibStub("LibAboutPanel-2.0"):Embed(AddOn)
-- -- **OR**, if using Ace3
-- -- you do not explicitly call :Embed
-- local MyAddOn = LibStub("AceAddon-3.0"):NewAddon("MyAddOn", "LibAboutPanel-2.0")
function lib:Embed(target)
	for k, v in pairs(mixins) do
		target[v] = self[v]
	end
	self.embeds[target] = true
	return target
end

--- Create a new About panel
-- @name //addon//:CreateAboutPanel
-- @paramsig AddOn[, parent]
-- @param AddOn name of which you are attaching the panel. String
-- @param parent AddOn name in Interface Options. String or nil
-- If parent is provided, panel will be under [+]
-- otherwise the panel will be a normal AddOn category
-- @return frame To do as you wish
-- @usage local aboutFrame = MyAddOn:CreateAboutPanel("MyAddOn", "MyAddOn")
-- -- OR
-- MyAddOn:CreateAboutPanel("MyAddOn", "MyAddOn")
function lib:CreateAboutPanel(AddOn, parent)
	-- Remove spaces from AddOn because GetMetadata doesn't like those
	local gsubName = gsub(AddOn, " ", "")
	
	local about = CreateFrame("Frame", nil, UIParent)
	about.name = not parent and gsubName or L["About"]
	about.parent = parent
	about.AddOnName = gsubName
	about:Hide()
	about:SetScript("OnShow", OnShow)
	-- about.refresh = function() OnShow() end
	InterfaceOptions_AddCategory(about)
	return about
end

--- Creates a table of an AddOn's ToC fields
-- see http://www.wowace.com/addons/ace3/pages/api/ace-config-3-0/
-- @name //addon//:AboutOptionsTable
-- @param AddOn name string whose ToC you want parsed
-- @return aboutTable suitable for use with AceConfig-3.0
-- @usage -- assuming options is your top-level table
-- local options = {} -- put your regular stuff here
-- options.args.aboutTable = MyAddOn:AboutOptionsTable("MyAddOn")
-- options.args.aboutTable.order = 100 -- use any number in the hierarchy
-- LibStub("AceConfig-3.0"):RegisterOptionsTable("MyAddOn", options)
function lib:AboutOptionsTable(AddOn)
	assert(LibStub("AceConfig-3.0"), "LibAboutPanel-2.0 API 'AboutOptionsTable' requires AceConfig-3.0", 2)
	aboutTable[AddOn] = aboutTable[AddOn] or {
		order = 10,
		name = L["About"],
		type = "group",
		args = {
			title = {
				order = 10,
				name = "|cffe6cc80" .. AddOn .. "|r",
				type = "description",
				fontSize = "large"
			},
			blank = {
				order = 20,
				name = "",
				type = "description"
			},
			notes = {
				order = 30,
				name = function()
					local notefield = "Notes"
					if GetLocale() ~= "enUS" then
						notefield = notefield .. "-" .. GetLocale()
					end
					local notes = GetAddOnMetadata(AddOn, notefield) or UNKNOWN
					-- return "|cffe6cc80" .. L["Notes"] .. ": |r" .. notes
					return notes
				end,
				type = "description",
				fontSize = "medium"
			},
			blank2 = {
				order = 40,
				name = "",
				type = "description"
			},
			author = {
				order = 50,
				name = function()
					local author = GetAddOnMetadata(AddOn, "Author") or UNKNOWN
					author = string.gsub(author, "(%a)([%w_']*)", TitleCase)
					local authorservername = GetAddOnMetadata(AddOn, "X-Author-Server") or UNKNOWN
					authorservername = string.gsub(authorservername, "(%a)([%w_']*)", TitleCase)
					local authorfaction = GetAddOnMetadata(AddOn, "X-Author-Faction") or UNKNOWN
					authorfaction = string.gsub(authorfaction, "(%a)([%w_']*)", TitleCase)
					authorfaction = string.gsub(authorfaction, "Alliance", FACTION_ALLIANCE)
					authorfaction = string.gsub(authorfaction, "Horde", FACTION_HORDE)

					if authorservername and authorfaction then
						author = string.format(L["%s @ %s (%s)"], author, authorservername, authorfaction)
					elseif authorservername and not authorfaction then
						author = string.format(L["%s @ %s"], author, authorservername)
					elseif not authorservername and authorfaction then
						author = (author .. "( " .. authorfaction .. ")")
					else
						author = author -- redundancy check
					end
					return "|cffe6cc80" .. L["Author"] .. ": |r".. author
				end,
				type = "description"
			},
			version = {
				order = 60,
				name = function()
					local addonversion = GetAddOnMetadata(AddOn, "Version") or UNKNOWN
					-- replace repository keywords
					addonversion = string.gsub(addonversion, "r2", L["Repository"]) -- Curse
					addonversion = string.gsub(addonversion, "wowi:revision", L["Repository"]) -- WoWInterface
					return "|cffe6cc80" .. L["Version"] .. ": |r" .. addonversion
				end,
				type = "description"
			},
			license = {
				order = 70,
				name = function()
					local copyright = GetAddOnMetadata(AddOn, "X-License") or UNKNOWN
					-- replace with © if applicable
					copyright = string.gsub(copyright, "Copyright", "©")
					copyright = string.gsub(copyright, "copyright", "©")
					copyright = string.gsub(copyright, "(C)", "©")
					copyright = string.gsub(copyright, "(c)", "©")
					copyright = string.gsub(copyright, "All Rights Reserved", L["All Rights Reserved"])
					return "|cffe6cc80" .. L["License"] .. ": |r" .. copyright
				end,
				type = "description"
			},
			localizations = {
				order = 80,
				name = function()
					local localizations = GetAddOnMetadata(AddOn, "X-Localizations") or UNKNOWN
					-- replace with global strings
					localizations = string.gsub(localizations, "enUS", LFG_LIST_LANGUAGE_ENUS)
					localizations = string.gsub(localizations, "frFR", LFG_LIST_LANGUAGE_FRFR)
					localizations = string.gsub(localizations, "deDE", LFG_LIST_LANGUAGE_DEDE)
					localizations = string.gsub(localizations, "esES", LFG_LIST_LANGUAGE_ESES)
					localizations = string.gsub(localizations, "esMX", LFG_LIST_LANGUAGE_ESMX)
					localizations = string.gsub(localizations, "koKR", LFG_LIST_LANGUAGE_KOKR)
					localizations = string.gsub(localizations, "itIT", LFG_LIST_LANGUAGE_ITIT)
					localizations = string.gsub(localizations, "ptBR", LFG_LIST_LANGUAGE_PTBR)
					localizations = string.gsub(localizations, "ruRU", LFG_LIST_LANGUAGE_RURU)
					localizations = string.gsub(localizations, "zhCN", LFG_LIST_LANGUAGE_ZHCN)
					localizations = string.gsub(localizations, "zhTW", LFG_LIST_LANGUAGE_ZHTW)
					return "|cffe6cc80" .. L["Localizations"] .. ": |r" .. localizations
				end,
				type = "description"
			},
			credits = {
				order = 90,
				name = function()
					-- TODO: also add coloring syntax and also consider making this universal
					local credits = GetAddOnMetadata(AddOn, "X-Credits")
					credits = string.gsub(credits, '$n', '\n')
					return "|cffe6cc80" .. L["Credits"] .. "|r\n" .. credits or UNKNOWN
				end,
				type = "description"
			},
			website = {
				order = 100,
				name = "|cffe6cc80" .. L["Website"] .. ": |r",
				desc = L["Click and press Ctrl-C to copy"],
				type = "input",
				get = function()
					local website = GetAddOnMetadata(AddOn, "X-Website") or UNKNOWN
					return (haseditbox["X-Website"] and "|cff77ccff" or "") .. website
				end,
				width = "full"
			},
			feedback = {
				order = 101,
				name = "|cffe6cc80" .. L["Feedback"] .. ": |r",
				desc = L["Click and press Ctrl-C to copy"],
				type = "input",
				get = function()
					local feedback = GetAddOnMetadata(AddOn, "X-Feedback") or UNKNOWN
					return (haseditbox["X-Feedback"] and "|cff77ccff" or "") .. feedback
				end,
				width = "full"
			},
			email = {
				order = 110,
				name = "|cffe6cc80" .. L["Email"] .. ": |r",
				desc = L["Click and press Ctrl-C to copy"],
				get = function()
					local eMail = GetAddOnMetadata(AddOn, "X-Email") or UNKNOWN
					eMail = string.gsub(eMail, " [aA][tT] ", "@")
					eMail = string.gsub(eMail, " [dD][oO][tT] ", ".")
					return (haseditbox["X-Email"] and "|cff77ccff" or "") .. eMail
				end,
				type = "input",
				width = "full"
			}
		}
	}
	return aboutTable[AddOn]
end

local function OnShow(frame)
	-- Get the localized version of notes if it exists or fall back to the English one.
	local notefield = "Notes"
	if GetLocale() ~= "enUS" then
		notefield = notefield .. "-" .. GetLocale()
	end
	local notes = GetAddOnMetadata(frame.AddOnName, notefield)

	-- main title about.name or L["About"] ------
	local title = frame.about_title
	if not title then
		title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		frame.about_title = title
	end
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(frame.parent and (frame.parent .. " - " .. L["About"]) or frame.name)

	-- ToC Notes field --------------------------
	if not frame.about_subtitle then
		frame.about_subtitle = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	end
	local subtitle = frame.about_subtitle
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", frame, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(notes)
	
	local anchor
	for i = 1, #fields do
		local field = fields[i]
		local value = GetAddOnMetadata(frame.AddOnName, field)
		if value then
			local title = frame[field .. "_title"]
			if not title then
				title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				frame[field .. "_title"] = title
			end
			title:SetWidth(80)

			if not anchor then
				title:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -12)
			else
				title:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -10)
			end
			title:SetJustifyH("RIGHT")
			title:SetJustifyV("TOP")
			-- fix for display
			-- first strip "X-" from field
			-- then TitleCase field
			local fixed_field = field:gsub("X%-", "")
			fixed_field = string.gsub(fixed_field, "(%a)([%w_']*)", TitleCase)
			title:SetText(L[fixed_field])

			local detail = frame[field .. "_detail"]
			if not detail then
				detail = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
				frame[field .. "_detail"] = detail
			end
			detail:SetPoint("TOPLEFT", title, "TOPRIGHT", 4, 0)
			detail:SetPoint("RIGHT", frame, -16, 0)
			detail:SetJustifyH("LEFT")
			detail:SetJustifyV("TOP")

			if field == "Author" then
				local authorservername = GetAddOnMetadata(frame.AddOnName, "X-Author-Server")
				-- Title Case server
				authorservername = string.gsub(authorservername, "(%a)([%w_']*)", TitleCase)
				local authorfaction = GetAddOnMetadata(frame.AddOnName, "X-Author-Faction")
				authorfaction = string.gsub(authorfaction, "(%a)([%w_']*)", TitleCase)
				-- localize authorfaction -------
				aauthorfaction = string.gsub(authorfaction, "Alliance", FACTION_ALLIANCE)
				authorfaction = string.gsub(authorfaction, "Horde", FACTION_HORDE)

				if authorservername and authorfaction then
					detail:SetFormattedText(L["%s on the %s realm (%s)"], value, authorservername, authorfaction)
				elseif authorservername and not authorfaction then
					detail:SetFormattedText(L["%s on the %s realm"], value, authorservername)
				elseif not authorservername and authorfaction then
					detail:SetText(value .. "( " .. authorfaction .. ")")
				else
					detail:SetText(value)
				end
			elseif field == "Version" then
				local addonversion = GetAddOnMetadata(frame.AddOnName, field)
				-- Remove 2 and replace it with Repository
				addonversion = string.gsub(addonversion, "r2", L["Repository"]) -- Curse
				addonversion = string.gsub(addonversion, "wowi:revision", L["Repository"]) -- WoWInterface
				detail:SetText(addonversion)
			elseif field == "X-License" then
				local copyright = GetAddOnMetadata(frame.AddOnName, "X-Copyright")
				if copyright then
					-- replace with © if applicable
					copyright = string.gsub(copyright, "Copyright", "\0169")
					copyright = string.gsub(copyright, "copyright", "\0169")
					copyright = string.gsub(copyright, "(C)", "\0169")
					copyright = string.gsub(copyright, "(c)", "\0169")
					detail:SetText(copyright .. "\n" .. value)
				else
					detail:SetText(value)
				end
			elseif field == "X-Localizations" then
				local localizations = GetAddOnMetadata(frame.AddOnName, "X-Localizations"):lower()
				-- replace with global strings
				localizations = string.gsub(localizations, "enus", LFG_LIST_LANGUAGE_ENUS)
				localizations = string.gsub(localizations, "frfr", LFG_LIST_LANGUAGE_FRFR)
				localizations = string.gsub(localizations, "dede", LFG_LIST_LANGUAGE_DEDE)
				localizations = string.gsub(localizations, "eses", LFG_LIST_LANGUAGE_ESES)
				localizations = string.gsub(localizations, "esmx", LFG_LIST_LANGUAGE_ESMX)
				localizations = string.gsub(localizations, "kokr", LFG_LIST_LANGUAGE_KOKR)
				localizations = string.gsub(localizations, "itit", LFG_LIST_LANGUAGE_ITIT)
				localizations = string.gsub(localizations, "ptbr", LFG_LIST_LANGUAGE_PTBR)
				localizations = string.gsub(localizations, "ruru", LFG_LIST_LANGUAGE_RURU)
				localizations = string.gsub(localizations, "zhcn", LFG_LIST_LANGUAGE_ZHCN)
				localizations = string.gsub(localizations, "zhtw", LFG_LIST_LANGUAGE_ZHTW)
				detail:SetText(localizations)
			elseif field == "X-Website" then
				detail:SetText((haseditbox[field] and "|cff77ccff" or "") .. gsub(value, "^https?://", ""))
			elseif field == "X-Feedback" then
				detail:SetText((haseditbox[field] and "|cff77ccff" or "") .. gsub(value, "^https?://", ""))
			else
				local email = GetAddOnMetadata(frame.AddOnName, field):lower()
				email = string.gsub(email, " at ", "@")
				email = string.gsub(email, " dot ", ".")
				detail:SetText((haseditbox[field] and "|cff77ccff" or "") .. value)
			end

			local lineheight = math.min(detail:GetStringHeight(), 32)
			title:SetHeight(lineheight)
			detail:SetHeight(lineheight)

			if haseditbox[field] then
				local button = CreateFrame("Button", nil, frame)
				button:SetAllPoints(detail)
				button.value = value
				button:SetScript("OnClick", OpenEditbox)
				button:SetScript("OnEnter", ShowTooltip)
				button:SetScript("OnLeave", HideTooltip)
			end

			anchor = title
		end
	end
end

-- EoF embedding
for AddOn in pairs(lib.embeds) do
	lib:Embed(AddOn)
end
