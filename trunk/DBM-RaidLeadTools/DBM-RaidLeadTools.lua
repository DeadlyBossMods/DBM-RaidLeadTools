-- **********************************************************
-- **                Deadly Boss Mods - GUI                **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * enGB/enUS: Nitram/Tandanu        http://www.deadlybossmods.com		
--    * deDE: Nitram/Tandanu             http://www.deadlybossmods.com
--    * zhCN: yleaf(yaroot@gmail.com)
--    * zhTW: yleaf(yaroot@gmail.com)/Juha
--    * koKR: BlueNyx(bluenyx@gmail.com)
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
--
local Revision = ("$Revision$"):sub(12, -3)

local L = DBM_Raidlead_Translation

DBM_RaidLead_Settings = {}
local default_settings = {
	WarnWhenNoLootmaster = false
}
local settings = default_settings

local mainframe = CreateFrame("Frame", "DBM_Raidleadtool", UIParent)

local function createpanel()
	if GetLocale() ~= "zhTW" then
		DBM_RaidLeadPanel = DBM_GUI:CreateNewPanel("Raidlead Tools - r"..Revision, "option")
	else
		DBM_RaidLeadPanel = DBM_GUI:CreateNewPanel("團隊隊長工具 - r"..Revision, "option")
	end

	local area = DBM_RaidLeadPanel:CreateArea(L.Area_Raidleadtool, nil, 180, true)

	local enabled = area:CreateCheckButton(L.ShowWarningForLootMaster, true)
	enabled:SetScript("OnShow", function(self) self:SetChecked(settings.WarnWhenNoLootmaster) end)
	enabled:SetScript("OnClick", function(self)
		settings.WarnWhenNoLootmaster = not not self:GetChecked()
	end)
end

	
DBM:RegisterOnGuiLoadCallback(createpanel, 10)

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
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			-- Update settings of this Addon
			settings = DBM_RaidLead_Settings
			addDefaultOptions(settings, default_settings)

			DBM:RegisterCallback("pull", function()
				if GetLootMethod() ~= "master" and DBM_BidBot_Translations.WarnWhenNoLootmaster then
					DBM:AddMsg(L.Warning_NoLootMaster)
				end
			end)			
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end






