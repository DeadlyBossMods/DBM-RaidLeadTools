if GetLocale() ~= "zhTW" then return end

DBM_AutoInvite_Translations = {}

local L = DBM_AutoInvite_Translations

L.TabCategory_AutoInvite 	= "自動邀請工具"
L.AreaGeneral 			= "基本邀請選項"
L.AllowGuildMates 		= "允許來自公會成員的自動邀請"
L.AllowFriends 			= "允許來自好友的自動邀請"
L.AllowOthers 			= "允許來自任何人的自動邀請"
L.Activate 			= "開啟關鍵字自動邀請"
L.KeyWord 			= "用於密語邀請的關鍵字"
L.InviteFailed 			= "不能邀請玩家 %s"
L.ConvertRaid 			= "轉換隊伍為團隊"
L.WhisperMsg_RaidIsFull 	= "對不起，我不能邀請你。團隊已滿了。"
L.WhisperMsg_NotLeader 		= "對不起，我不能邀請你。我不是組長。"
L.WarnMsg_NoRaid		= "使用AoE-邀請前請先建立一個團隊"
L.WarnMsg_NotLead		= "對不起，你必須為RL或提升才能使用此命令"
L.WarnMsg_InviteIncoming	= "<DBM> AoE-邀請即將來臨! 請現在離開你的隊伍."
L.Button_AOE_Invite		= "AoE 公會邀請"
L.AOEbyGuildRank		= "邀請所有等於或大於所選階級的玩家"

-- RaidInvite Options
L.AreaRaidOptions		= "團隊選項"
L.PromoteEveryone		= "提升所有新進來的玩家 (不建議)"
L.PromoteGuildRank		= "根據公會階級提升"
L.PromoteByNameList		= "自動提升以下玩家 (用空格分開)"

L.DontPromoteAnyRank		= "不根據公會階級提升"