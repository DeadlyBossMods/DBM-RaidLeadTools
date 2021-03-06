local mod	= DBM:NewMod("WarnForLootmaster", "DBM-RaidLeadTools")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
do
	local GetLootMaster = GetLootMaster

	function mod:OnInitialize()
		DBM:RegisterCallback("pull", function()
			if GetLootMaster() ~= "master" then
				self:AddMsg(L.WarningNoLootMaster)
			end
		end)
	end
end
