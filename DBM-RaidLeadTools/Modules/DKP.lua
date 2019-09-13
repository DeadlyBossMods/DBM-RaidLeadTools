local mod	= DBM:NewMod("DKP", "RaidLeadTools")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("Enabled", false)
mod:AddBool("Enable_StartEvent", true)--start_event
mod:AddBool("Enable_TimeEvents", false)--time_event
mod:AddBool("Enable_BossEvents", true)--boss_event
mod:AddBool("Enable_SB_Users", true)--sb_as_raid
mod:AddBool("Enable_5ppl_tracking", false)--grpandraid
mod:AddButton("Button_StartDKPTracking", function() end) -- TODO
mod:AddButton("Button_StopDKPTracking", function() end) -- TODO
mod:AddButton("Button_CreateEvent", function() end) -- TODO
mod:AddButton("Button_ResetHistory", function() end) -- TODO
mod:AddSliderOption("StartPoints", 0, 100, 5, 10)--start_points
mod:AddSliderOption("BossPoints", 0, 100, 5, 10)--boss_points
mod:AddSliderOption("TimePoints", 0, 100, 5, 10)--time_points
mod:AddSliderOption("TimeToCount", 1, 300, 5, 60)--time_to_count
mod.Options.working_in = mod.Options.working_in or 0
mod.Options.lastevent = mod.Options.lastevent or 0
mod.Options.items = mod.Options.items or {}
mod.Options.history = mod.Options.history or {}
--[[
CustomPoint				= "Points to award", -- Textbox
CustomDescription		= "Description for this event", -- Textbox
ChatChannel				= nil, -- Dropdown, missing?

boss_desc		= "%s",--BossDescription
time_desc		= "Raid Attendance",--TimeDescription
start_desc		= "Raid Start",--StartDescription
]]--