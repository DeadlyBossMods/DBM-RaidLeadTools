DBM_BidBot_Translations = {}

local L = DBM_BidBot_Translations

L.Prefix = "[BidBot]: "

L.Whisper_Queue 		= "Another auction is currently running. Your Item has been queued."
L.Whisper_Bid_OK 		= "Your bid of %d DKP was accepted."
L.Whisper_InUse 		= "<remove me>"
L.Message_StartBidding		= "Please bid on %s now by whispering to [%s]! Lowest possible bid: %d"
L.Message_DoBidding		= "Time remaining for %s: %d seconds."
L.Message_ItemGoesTo		= "%s won %s for %d DKP!"
L.Message_NoBidMade		= "There was no bid on %s."
L.Message_Biddings		= "%d. %s bid %d DKP."
L.Message_BiddingsVisible	= "%d players bid on this item."
L.Message_BidPubMessage		= "New bid: %s bids %d DKP"
L.Disenchant			= "Disenchant"

L.PopUpAcceptDKP		= "Save Bid for %s. For disenchant please type in 0 DKP."


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
L.Button_ResetClient		= "reset bidbot"
L.Local_NoRaid			= "You have to be in a raid group to use this function"
L.Local_Version			= "%s: %s"	-- Lacrosa: r123	(no translation required ^^)

