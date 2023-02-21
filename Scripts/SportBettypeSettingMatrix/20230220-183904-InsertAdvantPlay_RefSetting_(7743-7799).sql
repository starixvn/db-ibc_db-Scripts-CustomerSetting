/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230220@Tacy
	Task: Insert range AdvantPlay's bettype reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/183904 RedmineID: #183904
	Database: DBCUST-CustDB
*/
/* 
	AdvantPlay: 7743 - 7799
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(7743,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 58)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 172, 0

	SELECT @i = @i + 1
END

INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, RealProductId) 
SELECT sbm.SportType, sbm.BetType, isLicensee, sbm.isLive, Site, 1 as isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'bettransRNG' AS TableBettrans, 67 AS RealProductId
FROM @temp sbm 
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sm.BetType=7701 AND sm.SportType=172
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)
