/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230131@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/182407 RedmineID: #182407
	Database: DBCUST-CustDB
*/
/* 
	AE Sexy: 3101-3150
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(3101,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 51)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 243, 0

	SELECT @i = @i + 1
END

INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, RealProductId) 
SELECT sbm.SportType, sbm.BetType, isLicensee, sbm.isLive, Site, 1 as isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'bettransLC' AS TableBettrans, 45 AS RealProductId
FROM @temp sbm 
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sm.BetType=3101 AND sm.SportType=243
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)