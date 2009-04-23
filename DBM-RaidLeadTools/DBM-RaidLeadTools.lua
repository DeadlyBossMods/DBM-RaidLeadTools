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

local function createpanel()
	if GetLocale() ~= "zhTW" then
		DBM_RaidLeadPanel = DBM_GUI:CreateNewPanel("Raidlead Tools "..Revision, "option")
	else
		DBM_RaidLeadPanel = DBM_GUI:CreateNewPanel("團隊隊長工具", "option")
	end
end

DBM:RegisterOnGuiLoadCallback(createpanel, 10)



