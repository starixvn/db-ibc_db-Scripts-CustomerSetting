/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221028@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/
/*
	Vgaming: [3801 - 3899]
	SABA.games: [1611 - 1699]
*/

--Vgaming:
INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans])
SELECT sbm.[SportType], sbm.[BetType], [isLicensee], sbm.IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans]
FROM dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sbm.BetType BETWEEN 3801 AND 3899 
AND sm.BetType=3802 AND sm.SportType=171
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)

--SABA.games:
INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans])
SELECT sbm.[SportType], sbm.[BetType], [isLicensee], sbm.IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans]
FROM dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sbm.BetType BETWEEN 1611 AND 1699 
AND sm.BetType=1612 AND sm.SportType=200
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)