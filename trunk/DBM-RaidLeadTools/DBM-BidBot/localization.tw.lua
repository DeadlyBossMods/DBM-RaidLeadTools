if GetLocale() ~= "zhTW" then return end

DBM_BidBot_Translations = {}

local L = DBM_BidBot_Translations

L.Prefix = "[BidBot]: "

L.Whisper_Queue 		= "另一個拍賣正在進行。您的裝備已排隊。"
L.Whisper_Bid_OK 		= "您的出價，共%dDKP已被接受。"
L.Whisper_InUse 		= "<remove me>"
L.Message_StartBidding		= "現在競投 %s，請密[%s]出價! 最低出價: %d"
L.Message_DoBidding		= "%s的剩餘時間: %d秒"
L.Message_ItemGoesTo		= "%s 羸得 %s，使用 %d DKP!"
L.Message_NoBidMade		= "沒有人競投 %s."
L.Message_Biddings		= "%d. %s 出價 %d DKP."
L.Message_BiddingsVisible	= "%d 玩家競投這個裝備."
L.Message_BidPubMessage		= "新出價: %s 出價 %d DKP"
L.Disenchant			= "放棄"

L.PopUpAcceptDKP		= "對%s儲存出價. 如想放棄請輸入0 DKP."


-- GUI
L.TabCategory_BidBot	 	= "出價助手 (DKP)"
L.TabCategory_History	 	= "裝備記錄"
L.AreaGeneral 			= "基本出價助手選項"
L.AreaItemHistory		= "裝備記錄"
L.Enable			= "開啟出價助手 (!bid [item])"
L.ChatChannel			= "使用下列頻道輸出"
L.Local				= "只使用說話"
L.Guild				= "使用公會頻道"
L.Raid				= "使用團隊頻道"
L.Party				= "使用隊伍頻道"
L.Officer			= "使用幹部頻道"
L.Error_ChanNotFound		= "未知頻道: %s"
L.MinBid			= "最低出價"
L.Duration			= "出價時間 (預設 30秒)"
L.OutputBids			= "輸出多少個最高出價者 (預設 3)"
L.PublicBids			= "發表公開競標到頻道"
L.PayWhatYouBid			= "支付的競標價格 (否則第二次出價+1)"
L.NoHistoryAvailable		= "沒有有效記錄"
L.DateFormat			= "%c"

L.Button_ShowClients		= "顯示客戶"
L.Button_ResetClient		= "重啟出價助手"
L.Local_NoRaid			= "仕你必需在一個團隊才能使用這個功能"
L.Local_Version			= "%s: %s"	-- Lacrosa: r123	(no translation required ^^)

