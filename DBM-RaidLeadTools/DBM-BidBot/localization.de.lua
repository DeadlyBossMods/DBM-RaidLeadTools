if GetLocale() == "deDE" then
	local L = DBM_BidBot_Translations

	L.Prefix = "[BidBot]: "

	L.Whisper_Queue 		= "Zur Zeit wird noch geboten. Item(s) landen in der Warteschlange."
	L.Whisper_Bid_OK 		= "Dein Gebot von %d DKP wurde akzeptiert."
	L.Whisper_InUse 		= "Zur Zeit wird noch auf %s geboten."

	L.Message_StartBidding		= "Jetzt für %s bei %s bieten! Mindestgebot: %d"
	L.Message_DoBidding		= "Verbleibende Zeit für %s: %d Sekunden."

	L.Message_ItemGoesTo		= "%s geht an %s für %d Punkte. Gratz!"
	L.Message_NoBidMade		= "Keiner hat auf %s geboten."

	L.Message_Biddings		= "%d. %s hat %d DKP geboten."
	L.Message_BiddingsVisible	= "%d von ingesamt %d sichtbar."
	L.Message_BidPubMessage		= "Neues Gebot: %s hat %d DKP geboten."

	L.Disenchant			= "Disenchant"

	L.PopUpAcceptDKP		= "Speichere Gebot für %s. Bei Disenchant bitte 0 DKP eingeben."

	-- GUI
	L.TabCategory_BidBot	 	= "BidBot (DKP)"
	L.TabCategory_History	 	= "Item History"
	L.AreaGeneral 			= "Gerneal BidBot Options"
	L.AreaItemHistory		= "ItemHistory of BidBot"
	L.Enable			= "Enable Bidbot (!bid [item])"
	L.ChatChannel			= "Chat to use for Output"
	L.Local				= "only local output"
	L.Guild				= "use Guild Chat"
	L.Raid				= "use Raid Chat"
	L.Party				= "use Party Chat"
	L.Officer			= "use Officer Chat"
	L.Error_ChanNotFound		= "Unknown Channel for: %s"
	L.MinBid			= "Minimum Bid"
	L.Duration			= "Time to Bid in Sec (default 30)"
	L.OutputBids			= "How many Top Biddings to output (default Top 3)"
	L.PublicBids			= "Post bids to Chat for public bidding"
	L.PayWhatYouBid			= "Pay Price of bid, (otherwise second bid + 1)"
	L.NoHistoryAvailable		= "No History available"
	L.DateFormat			= "%c"

	L.Button_ShowClients		= "Show clients"
	L.Button_ResetClient		= "Einstellungen zurücksetzen"
	L.Local_NoRaid			= "You have to be in a raid group to use this function"
end
