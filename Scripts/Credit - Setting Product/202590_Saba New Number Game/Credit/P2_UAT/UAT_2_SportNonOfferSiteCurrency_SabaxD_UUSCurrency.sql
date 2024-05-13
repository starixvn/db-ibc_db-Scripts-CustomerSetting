/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024/04/16
	Task: Inital Data Setting SportNonOfferedSiteCurrency  - UUS Currency [#202590] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	-- Copy From Vgaming , SABA.game For Saba xD
	CREATE TABLE #Temp_NonOffer 
	(
		SportType		SMALLINT 
	    , BetType		INT
	    , Currency		INT
	    , SiteID		INT
	    , RealProductID	TINYINT
	    PRIMARY KEY (SportType,BetType,Currency,SiteID)
	)

	
	; WITH Vgaming AS (
	SELECT 
		s1.SiteID , s1.Currency
	FROM SportNonOfferedSiteCurrency s1 WITH (NOLOCK)
	WHERE s1.SportType = 171
	AND s1.Currency = 20
	)
	, SabaGame AS (
	SELECT 
		s2.SiteID , s2.Currency
	FROM SportNonOfferedSiteCurrency s2 WITH (NOLOCK)
	WHERE s2.SportType = 200
	AND s2.Currency = 20
	)

	INSERT INTO #Temp_NonOffer 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)

	SELECT 
		--DISTINCT v.* , '_____' AS '_____' ,  s.*
		240		AS SportType ,
		10801		AS BetType	,
		v.Currency	,
		v.SiteID	,
		86		AS RealProductID
	FROM Vgaming v
	INNER JOIN SabaGame s ON v.SiteID = s.SiteID AND v.Currency = s.Currency

	IF NOT EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency s WITH (NOLOCK)
					INNER JOIN #Temp_NonOffer tno ON s.SportType = tno.SportType AND s.BetType = tno.BetType AND s.SiteID = tno.SiteID AND s.Currency = tno.Currency)
	BEGIN
		INSERT INTO SportNonOfferedSiteCurrency 
		(
			SportType
		    , BetType
		    , Currency
		    , SiteID
		    , RealProductID
		)
		SELECT SportType
		    , BetType
		    , Currency
		    , SiteID
		    , RealProductID
		FROM #Temp_NonOffer tno
	END

	DROP TABLE #Temp_NonOffer