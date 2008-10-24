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
--

local function createpanel()
	DBM_RaidLeadPanel = DBM_GUI:CreateNewPanel("Raidlead Tools", "option")
end

DBM:RegisterOnGuiLoadCallback(createpanel, 10)

DBM_Tools = {}

function DBM_Tools:StringCodeFormating(msg)
	msg = string.gsub(msg, "Ç", "c")
	msg = string.gsub(msg, "\195\164", "a")
	msg = string.gsub(msg, "\195\182", "o")
	msg = string.gsub(msg, "\195\188", "u")
	msg = string.gsub(msg, "\195\132", "A")
	msg = string.gsub(msg, "\195\150", "O")
	msg = string.gsub(msg, "\195\156", "U")
	msg = string.gsub(msg, "\195\171", "e")

	msg = string.gsub(msg, "\195\162", "a")
	msg = string.gsub(msg, "\195\161", "a")
	msg = string.gsub(msg, "\195\160", "a")
	msg = string.gsub(msg, "\195\169", "e")
	msg = string.gsub(msg, "\195\168", "e")
	msg = string.gsub(msg, "\195\170", "e")
	msg = string.gsub(msg, "\195\173", "i")
	msg = string.gsub(msg, "\195\172", "i")
	msg = string.gsub(msg, "\195\174", "i")
	msg = string.gsub(msg, "\194\191", "A")
	msg = string.gsub(msg, "\194\161", "A")
	msg = string.gsub(msg, "\194\172", "A")
	msg = string.gsub(msg, "\194\171", "E")
	msg = string.gsub(msg, "\194\160", "E")
	msg = string.gsub(msg, "\195\149", "I")
	msg = string.gsub(msg, "\195\131", "I")
	msg = string.gsub(msg, "\195\146", "I")
	msg = string.gsub(msg, "\195\179", "o")
	msg = string.gsub(msg, "\195\178", "o")
	msg = string.gsub(msg, "\195\180", "o")
	msg = string.gsub(msg, "\195\186", "u")
	msg = string.gsub(msg, "\195\185", "u")
	msg = string.gsub(msg, "\195\187", "u")

	msg = string.gsub(msg, "\195\134", "Ae")
	msg = string.gsub(msg, "\195\166", "ae")
	msg = string.gsub(msg, "\195\167", "c")
	msg = string.gsub(msg, "\195\184", "o")
	msg = string.gsub(msg, "\195\181", "o")
	msg = string.gsub(msg, "\195\177", "n")
	msg = string.gsub(msg, "\195\163", "a")
	msg = string.gsub(msg, "\195\175", "l")
	msg = string.gsub(msg, "\197\147", "o")
	msg = string.gsub(msg, "\195\159", "ss")

	return msg;
end



