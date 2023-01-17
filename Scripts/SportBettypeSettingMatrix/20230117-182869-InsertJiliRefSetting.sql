/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230117@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/182869 RedmineID: #182869
	Database: DBCUST-CustDB
*/
/*
	bettype: 5100-5299
*/
INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, RealProductId) 
SELECT SportType, BetType, isLicensee, isLive, Site, 1, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'bettransRNG' as TableBettrans, 75
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
WHERE Site<>'CN88' 
AND BetType BETWEEN 5100 AND 5299
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix rm WITH (NOLOCK)
                WHERE	ref.SportType=rm.SportType
					AND ref.BetType=rm.BetType
					AND ref.isLicensee=rm.isLicensee
					AND ref.isLive=rm.isLive
					AND ref.Site=rm.Site)