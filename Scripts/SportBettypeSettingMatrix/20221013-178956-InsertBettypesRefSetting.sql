/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02"></info>*/

/*
	Created: 20221013@Tacy
	Task: Insert new bettypes' reference setting into SportBettypeSettingMatrix
		https://nexdev.net/issues/178956 RedmineID: #178956
	Database: DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02
*/
INSERT INTO SportBettypeSettingMatrix 
	(SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans) 
SELECT SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting,'bettransRNG'
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
WHERE Site<>'CN88' 
AND ref.BetType BETWEEN 3855 AND 3857
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix rm WITH (NOLOCK)
				WHERE	ref.SportType=rm.SportType
					AND ref.BetType=rm.BetType
					AND ref.isLicensee=rm.isLicensee
					AND ref.isLive=rm.isLive
					AND ref.Site=rm.Site)