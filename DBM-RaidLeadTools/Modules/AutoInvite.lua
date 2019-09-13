local mod	= DBM:NewMod("BidBot", "RaidLeadTools")
local L		= mod:GetLocalizedStrings()

local pairs, insert = table.insert, pairs
local GuildControlGetNumRanks, GuildControlGetRankName, GetNumGroupMembers, UnitIsGroupLeader, UnitIsGroupAssistant, SendChatMessage, GuildRoster, IsInRaid, GetNumSubgroupMembers, InviteUnit, ConvertToRaid = GuildControlGetNumRanks, GuildControlGetRankName, GetNumGroupMembers, UnitIsGroupLeader, UnitIsGroupAssistant, SendChatMessage, GuildRoster, IsInRaid, GetNumSubgroupMembers, InviteUnit, ConvertToRaid
local guildMates, guildRank = {}, {}

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

local function DoInvite(name)
	local pplcount = GetNumGroupMembers();
	if not IsInRaid() then
		pplcount = GetNumSubgroupMembers() or 0
		if pplcount > 0 and not UnitIsGroupLeader("player") then
			DBM:AddMsg(L.InviteFailed:format(name))
		else
			if pplcount < 4 then
				InviteUnit(name)
			elseif pplcount == 4 then
				DBM:AddMsg(L.ConvertRaid)
				ConvertToRaid()
				InviteUnit(name)
			end
		end
	elseif DBM:GetRaidRank() > 0 and pplcount < 40 then
		InviteUnit(name)
	elseif DBM:GetRaidRank() == 0 then
		SendChatMessage("<DBM> " .. L.WhisperMsg_NotLeader, "WHISPER", nil, name)
	elseif pplcount >= 40 then
		SendChatMessage("<DBM> " .. L.WhisperMsg_RaidIsFull, "WHISPER", nil, name)
	end
end

local function slashfunction()
	if GetNumGroupMembers() == 0 then
		DBM:AddMsg(L.WarnMsg_NoRaid)
	elseif not (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
		DBM:AddMsg(L.WarnMsg_NotLead)
	else
		SendChatMessage(L.WarnMsg_InviteIncoming, "GUILD")
		GuildRoster()
		DBM:Schedule(10, function()
			for _,v in pairs(guildMates) do
				if mod.Options.AOEbyGuildRank > 0 and guildRank[v] <= mod.Options.AOEbyGuildRank then
					DoInvite(v)
				end
			end
		end)
	end
end
SLASH_DBMAUTOINVITE1 = "/inviteguild"
SlashCmdList["DBMAUTOINVITE"] = slashfunction

mod:AddBoolOption("Enabled", false, "General")
mod:AddBoolOption("AllowGuildMates", true, "General")
mod:AddBoolOption("AllowFriends", true, "General")
mod:AddBoolOption("AllowOthers", false, "General")
mod:AddEditboxOption("KeyWord", "invite, inv", "General")
local ranks = {}
for i = 1, GuildControlGetNumRanks(), 1 do
	insert(ranks, {
		text	= i .. ". " .. GuildControlGetRankName(i),
		value	= i
	})
end
mod:AddDropdownOption("AOEbyGuildRank", ranks, 0, "General")
mod:AddButton("Button_AOE_Invite", slashfunction, "General")

mod:AddBoolOption("PromoteEveryone", false, "Raid")
ranks = {}
insert(ranks, {
	text	= L.DontPromoteAnyRank,
	value	= 0
})
for i = 1, GuildControlGetNumRanks(), 1 do
	insert(ranks, {
		text	= i .. ". " .. GuildControlGetRankName(i),
		value	= i
	})
end
mod:AddDropdownOption("PromoteGuildRank", ranks, 0, "Raid")
mod:AddEditboxOption("PromoteByNameList", "", "Raid")

mod:RegisterEvents(
	"CHAT_MSG_WHISPER",
	"GUILD_ROSTER_UPDATE"
)

do
	local IsGuildMember, PromoteToAssistant = IsGuildMember, PromoteToAssistant

	local function GetGuildRank(name)
		return guildRank and guildRank[name] or 99
	end

	function mod:OnInitialize()
		GuildRoster()
		DBM:RegisterCallback("raidJoin", function(_, name)
			if mod.Options.Enabled and name and DBM:GetRaidRank() > 0 then
				if (IsGuildMember(name) and GetGuildRank(name, true) <= mod.Options.PromoteGuildRank) or mod.Options.PromoteByNameList[name] or mod.Options.PromoteEveryone then
					PromoteToAssistant(name)
				end
			end
		end)
	end
end

do
	local wipe = table.wipe
	local GetNumFriends, GetFriendInfo, GetNumGuildMembers, GetGuildRosterInfo = GetNumFriends, GetFriendInfo, GetNumGuildMembers, GetGuildRosterInfo
	local waitinginvites = {}

	local function IsFriend(name)
		for i = 1, GetNumFriends(), 1 do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		return false
	end

	local function IsGuildMember(name)
		for _,v in pairs(guildMates) do
			if v == name then
				return true
			end
		end
		return false
	end

	local function IsKeyword(msg)
		for _,v in pairs(mod.Options.Keywords) do
			if v == msg then
				return true
			end
		end
		return false
	end

	function mod:CHAT_MSG_WHISPER(msg, name)
		if self.Options.Enabled and IsKeyword(msg:lower()) then
			if self.Options.AllowFriends and IsFriend(name) then
				DoInvite(name)
			elseif self.Options.AllowOther then
				DoInvite(name)
			elseif self.Options.AllowGuildmates then
				insert(waitinginvites, name)
				GuildRoster()
			end
		end
	end

	function mod:GUILD_ROSTER_UPDATE()
		wipe(guildMates)
		wipe(guildRank)
		for i = 1, GetNumGuildMembers(), 1 do
			local name, _, rankIndex = GetGuildRosterInfo(i)
			if name then
				insert(guildMates, name)
				guildRank[name] = rankIndex + 1
			end
		end
		for i = #waitinginvites, 1, -1 do
			if IsGuildMember(waitinginvites[i]) then
				DoInvite(waitinginvites[i])
			end
			waitinginvites[i] = nil
		end
	end
end