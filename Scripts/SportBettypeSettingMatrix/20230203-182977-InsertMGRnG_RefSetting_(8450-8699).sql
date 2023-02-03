/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230203@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/182977 RedmineID: #182977
	Database: DBCUST-CustDB
*/
/* 
	MG-RNG: 8450-8699
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(8450,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 251)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 155, 0

	SELECT @i = @i + 1
END

INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, RealProductId) 
SELECT sbm.SportType, sbm.BetType, isLicensee, sbm.isLive, Site, 1 as isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'bettransRNG' AS TableBettrans, 73 AS RealProductId
FROM @temp sbm 
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sm.BetType=8400 AND sm.SportType=155
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)