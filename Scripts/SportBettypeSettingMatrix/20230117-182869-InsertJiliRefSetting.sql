/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230117@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/182869 RedmineID: #182869
	Database: DBCUST-CustDB
*/
/*
	Jili: 5100-5299
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(5100,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 201)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 158, 0

	SELECT @i = @i + 1
END

INSERT INTO SportBettypeSettingMatrix 
      (SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, RealProductId) 
SELECT sbm.SportType, sbm.BetType, isLicensee, sbm.isLive, Site, 1 as isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting, 'bettransRNG' AS TableBettrans, 75 AS RealProductId
FROM @temp sbm 
INNER JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
	ON sbm.SportType=ref.SportType
	AND sbm.IsLive=ref.isLive
WHERE ref.BetType=5100 AND ref.SportType=155 AND Site<>'CN88'
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix rm WITH (NOLOCK)
                WHERE	ref.SportType=rm.SportType
					AND ref.BetType=rm.BetType
					AND ref.isLicensee=rm.isLicensee
					AND ref.isLive=rm.isLive
					AND ref.Site=rm.Site)