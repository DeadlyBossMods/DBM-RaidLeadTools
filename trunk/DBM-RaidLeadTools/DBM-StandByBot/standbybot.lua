-- **********************************************************
-- **             Deadly Boss Mods - StandbyBot            **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * deDE: Nitram/Tandanu
--    * enGB: Nitram/Tandanu
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

local mainframe = CreateFrame("frame", "DBM_StandyByBot", UIParent)

local default_settings = {
	enabled = true,
	sb_users = {},		-- currently standby
	sb_times = {},		-- times since last reset
	history = {},		-- save history on raidleave
	log = {}		-- bla joins at xx   bla leaves at xx
}

DBM_Standby_Settings = {}
local settings = default_settings

local L = DBM_StandbyBot_Translations
local sbbot_clients = {}

local SaveTimeHistory

do 
	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_Standby, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 150, true)
			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)


			local ptext = panel:CreateText(L.SB_Documentation, nil, nil, GameFontNormal)
			ptext:ClearAllPoints()
			ptext:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 20, -50)
			ptext:SetPoint('BOTTOMRIGHT', enabled, "BOTTOMRIGHT", -20, 10)
			
		end
		do	
			local area = panel:CreateArea(L.AreaStandbyHistory, nil, 260, true)

			local history = area:CreateScrollingMessageFrame(area.frame:GetWidth()-40, 220)
			history:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10)

			history:SetScript("OnShow", function(self)
				self:SetMaxLines(#settings.history+1)
				for k,v in pairs(settings.history) do
					local mytext = mytext.."["..k.."]: "
					for name,sbtime in pairs(v) do
						local hours = math.floor(sbtime/60/60)
						local minutes = math.floor((sbtime-(hours*60*60))/60)
						mytext = mytext..name.."("..string.format("%02d", hours)..":"..string.format("%02d", minutes)..") "
					end
					self:AddMessage(mytext)
				end
			end)
		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 13)
end

local function setStandby(name, nowsb)
	-- set player StandBy
	if nowsb then
		if settings.sb_users[name] then return false end -- allready SB
		table.insert(settings.log, L.History_OnJoin:format(name, date("%c")))
		settings.sb_users[name] = time()
		return true

	else -- remove from StandBy
		if not settings.sb_users[name] then return false end

		local sbtime = (time() - settings.sb_users[name]) / 60 	-- time in minutes
		table.insert(settings.log, L.History_OnLeave:format(name, date("%c"), sbtime))
		
		if not settings.sb_times[name] then settings.sb_times[name] = 0 end
		settings.sb_times[name] = settings.sb_times[name] + sbtime

		settings.sb_users[name] = nil
		return settings.sb_times[name]
	end
end

-- Function to update (save) all times to prevent problems from disconnects / stuff like this!
-- also required for !sb times to show users their SB Time
local function UpdateTimes()
	if #settings.sb_users > 0 then
		for name, starttime in pairs(settings.sb_users) do
			settings.sb_times[name] = settings.sb_times[name] + ((time() - starttime) / 60)
			settings.sb_users[name] = time()
		end
	end
end


local function amIactive()
	for k,v in pairs(sbbot_clients) do
		if UnitIsConnected(DBM:GetRaidUnitId(k)) and k < UnitName("player") then
			-- we don't need to start, the player with hightest name is used
			return false
		end
	end
	return true
end

local function AddStandbyMember(name, quiet)
	if not settings.enabled then return end
	if not name then return false end
	if not amIactive() then quite = true end

	if settings.sb_users[name] == nil then
		-- a brand new member
		if not quiet then
			DBM:AddMsg( L.Local_AddedPlayer:format(name) )
			SendChatMessage("<DBM> "..L.AddedSBUser, "WHISPER", nil, name)
		end
		setStandby(name, true)
	else
		-- member allready on the list
		if not quiet then 
			SendChatMessage("<DBM> "..L.UserIsAllreadySB, "WHISPER", nil, name)
		end
	end
end

local function RemoveStandbyMember(name, quiet)
	if not settings.enabled then return end
	if not name then return false end
	if not amIactive() then quite = true end

	if settings.sb_users[name] == nil then
		-- user issn't standby
		if not quiet then
			SendChatMessage("<DBM> "..L.NotStandby, "WHISPER", nil, name)
		end
		return false
	else
		-- remove user
		local sbtime = setStandby(name, false)
		if not sbtime then 
			DBM:AddMsg( "ERROR while removing player !!! " ) 
		end

		if not quiet then
			DBM:AddMsg( L.Local_RemovedPlayer:format(name) )
		end

		local hours = math.floor(sbtime/60)
		local minutes = math.floor((sbtime-(hours*60))/60)

		if not quiet then
			SendChatMessage("<DBM> "..L.NoLongerStandby:format(hours, minutes), "WHISPER", nil, name)
		end

		return true
	end
end

do
	function SaveTimeHistory()
		if #settings.sb_times > 0 then
			local key = date(L.DateTimeFormat)
			UpdateTimes()
			table.wipe(settings.sb_users)
			settings.history[key] = settings.sb_times
			settings.sb_times = {}

			DBM:AddMsg( L.SB_History_Saved:format(key) )
		else
			DBM:AddMsg( L.SB_History_NotSaved )
		end
	end
	DBM:RegisterCallback("raidLeave", function(name) if DBM:IsInRaid() and name == UnitName("player") then SaveTimeHistory() end end)

	local function send_leave_whisper(name)
		if not settings.enabled then return end
		if not amIactive() then return end
		SendChatMessage("<DBM> "..L.LeftRaidGroup, "WHISPER", nil, name)
	end

	DBM:RegisterCallback("raidLeave", send_leave_whisper)
	DBM:RegisterCallback("raidJoin", RemoveStandbyMember)
end

do
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end
	local function RegisterEvents(...)
		for i = 1, select("#", ...) do
			mainframe:RegisterEvent(select(i, ...))
		end
	end

	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			-- Update settings of this Addon
			settings = DBM_Standby_Settings
			addDefaultOptions(settings, default_settings)

			RegisterEvents(
				"CHAT_MSG_GUILD",
				"CHAT_MSG_RAID",
				"CHAT_MSG_PARTY",
				"CHAT_MSG_OFFICER",
				"CHAT_MSG_RAID_LEADER",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_ADDON"
			)
	
		elseif settings.enabled and event == "CHAT_MSG_WHISPER" and DBM:IsInRaid() then
			local msg, author = select(1, ...)
			if msg == "!sb" then
				if DBM:GetRaidUnitId(author) == "none" then
					AddStandbyMember(author)
				else
					SendChatMessage("<DBM> "..L.InRaidGroup, "WHISPER", nil, author)
				end
			elseif msg == "!sb off" then
				RemoveStandbyMember(author)
			end

		elseif settings.enabled and event == "CHAT_MSG_ADDON" then
			local prefix, msg, channel, sender = select(1, ...)
			if prefix ~= "DBM_SbBot" then return end

			if msg == "Hi!" then
				sbbot_clients[sender] = true
				if channel == "RAID" then
					SendAddonMessage("DBM_SbBot", "Hi!", "WHISPER", sender)				
				end

			elseif msg:find("^!sb add") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				AddStandbyMember(name, true)

			elseif msg:find("^!sb del") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				RemoveStandbyMember(name, true)
			end
		end
		
		if settings.enabled and event:sub(0, 9) == "CHAT_MSG_" and event ~= "CHAT_MSG_WHISPER" and event ~= "CHAT_MSG_ADDON" then
			if not amIactive() then return end

			local msg, author = select(1, ...)
			if msg == "!sb" then
				local output = ""
				for k,v in pairs(settings.sb_users) do
					output = output..", "..k
				end
				output = output:sub(2)
				if output == "" then output = "none" end
				SendChatMessage("<DBM> "..L.PostStandybyList.." "..output, "WHISPER", nil, author)

			elseif msg == "!sb time" then
				if #settings.sb_times then
					SendChatMessage(L.Current_StandbyTime:format(date(L.DateTimeFormat)), "GUILD")
					local users = ""
					local count = 0
					UpdateTimes()
					for k,v in pairs(settings.sb_times) do
						count = count + 1 
						local hours = math.floor(settings.sb_times[k]/60)
						local minutes = math.floor((settings.sb_times[k]-(hours*60))/60)
						users = users..k.."("..string.format("%02d", hours)..":"..string.format("%02d", minutes).."), "

						if count >= 3 then
							count = 0
							SendChatMessage(users:sub(0, -2), "GUILD")
							users = ""
						end
					end
					if count > 0 then
						SendChatMessage(users:sub(0, -2), "GUILD")
					end
				end

			elseif msg:find("^!sb add") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				AddStandbyMember(name)

			elseif msg:find("^!sb del") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				if not RemoveStandbyMember(name) then
					DBM:AddMsg(L.Local_CantRemove)
				end

			elseif msg == "!sb reset" and author == UnitName("player") then
				table.wipe(settings.sb_times)
				table.wipe(settings.sb_users)

			elseif msg == "!sb save" and author == UnitName("player") then
			end

		end
	end)
	
	-- lets register the Events
	RegisterEvents("ADDON_LOADED")
end





