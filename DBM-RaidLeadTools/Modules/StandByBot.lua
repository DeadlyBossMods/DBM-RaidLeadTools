local mod	= DBM:NewMod("BidBot", "RaidLeadTools")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("Enabled", false)
mod:AddBoolOption("SendWhispers", false)--send_whisper
mod:AddButton("Button_ShowClients", function() end) -- TODO
mod:AddButton("Button_ResetHistory", function() end) -- TODO
mod.Options.sbUsers = mod.Options.sb_users or {}
mod.Options.sbTimes = mod.Options.sb_times or {}
mod.Options.history = mod.Options.history or {}
mod.Options.log = mod.Options.log or {}
