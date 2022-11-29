/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221125@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/180620 RedmineID: #180620
	Database: DBCUST-CustDB
*/
/*
	Add New Game 3616 - 'Cricket Lottery'
*/
INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans) 
SELECT SportType, BetType, isLicensee, isLive, Site, 1, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'translog' as TableBettrans
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
WHERE Site<>'CN88' 
AND BetType = 3616
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix rm WITH (NOLOCK)
                WHERE	ref.SportType=rm.SportType
					AND ref.BetType=rm.BetType
					AND ref.isLicensee=rm.isLicensee
					AND ref.isLive=rm.isLive
					AND ref.Site=rm.Site)