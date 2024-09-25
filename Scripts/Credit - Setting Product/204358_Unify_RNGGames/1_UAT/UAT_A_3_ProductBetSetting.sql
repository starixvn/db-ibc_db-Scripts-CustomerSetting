/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:12/06/2024
	Task: Inital Data ProductBetSetting [#204358]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT TOP 1 1
		FROM ProductBetSetting pbs WITH (NOLOCK)
		WHERE pbs.Sporttype = 9919
		AND pbs.Bettype = 1501
		AND pbs.Currency = 20)
BEGIN
	RAISERROR ( N'Exist Data', 0, 1) ;
	RETURN;
END

INSERT INTO ProductBetSetting 
	(
		Sporttype
	    , Bettype
	    , Currency
	    , MinBet
	    , IsDep
	    , MaxBet
	    , MaxPerMatch
	    , DefaultMinBet
	    , DefaultMaxBet
	    , DefaultMaxPerMatch
	)
SELECT	
		9919 AS Sporttype
	    , 1501 AS Bettype
	    , Currency
	    , MinBet
	    , IsDep
	    , MaxBet
	    , MaxPerMatch
	    , DefaultMinBet
	    , DefaultMaxBet
	    , DefaultMaxPerMatch
FROM ProductBetSetting pbs WITH (NOLOCK)
WHERE pbs.Sporttype = 202
AND pbs.Bettype = 1501
AND pbs.Currency = 20