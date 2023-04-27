/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230427@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/184677
	Database: DBCUST-CustDB
*/
/* 
	PG Soft: 6105-6300
*/
DECLARE @temp TABLE (Sporttype SMALLINT, bettype INT IDENTITY(6105,1), IsLive BIT)
DECLARE @i INT = 1

WHILE (@i < 197)
BEGIN
	INSERT INTO @temp( Sporttype, IsLive)
	SELECT 232, 0

	SELECT @i = @i + 1
END

INSERT INTO SportBettypeSettingMatrix 
	([SportType],	 [BetType],	[isLicensee],	 [isLive],	[Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans], [SporttypeRefWinlossLimit], [BettypeRefWinlossLimit], [RealProductId])
SELECT 
sbm.[SportType], sbm.[BetType], [isLicensee], sbm.[isLive], [Site], [isActive],	[SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans], [SporttypeRefWinlossLimit], [BettypeRefWinlossLimit], [RealProductId]
FROM @temp sbm 
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sm.BetType=6021 AND sm.SportType=232
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)
