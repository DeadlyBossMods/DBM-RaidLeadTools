local mod	= DBM:NewMod("BidBot", "RaidLeadTools")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("Enabled", false)
mod:AddBoolOption("ShowinRaidWarn", false)--withraidwarn
mod:AddBoolOption("PublicBids", false)--bidtyp_open
mod:AddBoolOption("PayWhatYouBid", false)--bidtyp_payall
mod:AddButton("Button_ShowClients", function() end) -- TODO
mod:AddDropdownOption("ChatChannel", {}, "GUILD") -- TODO, chatchannel
mod:AddSliderOption("MinBid", 1, 100, 5, 10)--minGebot
mod:AddSliderOption("Duration", 1, 300, 5, 30)--duration
mod:AddSliderOption("OutputBids", 1, 10, 1, 3)--output