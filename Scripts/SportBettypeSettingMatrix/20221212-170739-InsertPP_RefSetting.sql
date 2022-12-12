/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221212@Elodie
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/
/*
	PP: [4101 - 4300]
	    [6701 - 7000]
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(6799,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 203)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 248, 0

	SELECT @i = @i + 1
END

--SELECT * FROM @temp WHERE bettype IN ( 6798, 6799,6999,7000)

--PP:
INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans])
SELECT sbm.[SportType], sbm.[BetType], [isLicensee], sbm.IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans]
FROM dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sbm.BetType BETWEEN 4101 AND 4300 
AND sm.BetType=4101 AND sm.SportType=248
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)

INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans])
SELECT sbm.[SportType], sbm.[BetType], [isLicensee], sbm.IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans]
FROM @temp sbm 
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sbm.BetType BETWEEN 6701 AND 7000 
AND sm.BetType=6701 AND sm.SportType=248
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)