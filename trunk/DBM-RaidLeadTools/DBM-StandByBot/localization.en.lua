DBM_StandbyBot_Translations = {}

local L = DBM_StandbyBot_Translations

L.InRaidGroup		= "Sorry, but you have to leave the RaidGroup before going StandBy."
L.LeftRaidGroup 	= "You have left our RaidGroup. Please don't forget to whisper me !sb if you wan't to be StandBy."
L.AddedSBUser		= "You are now Standby. Please stay available until required or removed from the SB List."
L.UserIsAllreadySB	= "Sorry, but you are already Standby. To remove yourself from the List please type '!sb off' in reply."
L.NotStandby		= "Sorry, you are currently not registerd as a Standby Member. Please type '!sb' in reply."
L.NoLongerStandby	= "You are no longer Standby. Your were Standby for %d Hour(s) and %02d Minutes."
L.PostStandybyList	= "Currently Standby:"

L.Local_AddedPlayer	= "[SB]: %s is now Standby."
L.Local_RemovedPlayer	= "[SB]: %s is no longer Standby."
L.Local_CantRemove	= "Sorry, can't add player."

L.Current_StandbyTime	= "StandbyTimes from %s:"
L.DateTimeFormat	= "%c"

L.History_OnJoin	= "%s joins StandBy at %s"
L.History_OnLeave	= "%s leaves StandBy at %s after %s min"
L.SB_History_Saved	= "The Standbylist where saved as %s"
L.SB_History_NotSaved	= "No player where Standby, no History where saved"


-- GUI
L.TabCategory_Standby	= "StandbyBot"
L.AreaGeneral		= "Gernal StandbyBot Settings"
L.Enable		= "Enable StandbyBot (!sb)"
L.AreaStandbyHistory	= "Standby History"
L.NoHistoryAvailable	= "Sorry, no saved Raids with Standby Players"

L.SB_Documentation	= [[This Standby module allows a Raidleader to manage players who currently can't raid because of a full raid or something like this. All listed commands are for Guildchat use. 
!sb	       - shows a list of standby players
!sb times      - shows the current standby times (how long a player is standby)
!sb add <nick> - add a player to standby
!sb del <nick> - remove a player from stanbdy
!sb save       - save the current state to the history and remove all player from SB
!sb reset      - clears all standby informations (just a failsave function)

Players who want to get standby have to whisper '!sb' to the Player with the Standby response from GuildChat commands. A confirmation will be send to the player. Otherwise to leave the standby they have to whisper '!sb off'.
]]



