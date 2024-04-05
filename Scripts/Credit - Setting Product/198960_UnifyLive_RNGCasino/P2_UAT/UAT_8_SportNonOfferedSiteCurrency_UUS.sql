/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting SportNonOfferedSiteCurrency - UUS Currency [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	-------------------------1.SportNonOfferedSiteCurrency------------------------------------

	CREATE TABLE #Temp_SportNonOffer 
	(
		SportType		SMALLINT
	    , BetType		INT
	    , Currency		INT
	    , SiteID		INT
	    , RealProductID	TINYINT,
	    PRIMARY KEY([SportType] ,[BetType]  ,[Currency] , [SiteID])
	)

	INSERT INTO #Temp_SportNonOffer 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
	SELECT DISTINCT
		pssc.SportType , 
		pssc.BetType ,  
		pssc.Currency , 
		pssc.SiteID , 
		CASE 
			WHEN pssc.SportType = 176		THEN 70	-- FGG
			WHEN pssc.SportType = 208		THEN 6	-- Saba Casino
			WHEN pssc.SportType = 200		THEN 42	-- SABA.games
			WHEN pssc.SportType = 171		THEN 66	-- Vgaming
			WHEN pssc.SportType = 224		THEN 50	-- Funky Games
			WHEN pssc.SportType = 245		THEN 38	-- Virtual Games
		END AS RealProductID
	FROM ProductStatusSiteCurrency pssc WITH (NOLOCK)
	WHERE pssc.SportType IN (171,176,200,208,224,245)
	AND pssc.IsHidden = 1
	AND pssc.Currency = 20

	--SELECT c.*--DISTINCT RealProductID , s.ProductName  , s1.SportType , s1.SportName , BetType ,  b.typenamee --, c.*
	--FROM #Temp_SportNonOffer c
	--INNER JOIN DBAGE.bodb02.dbo.Products  s ON c.RealProductID = s.ProductID
	--INNER JOIN DBAGE.bodb02.dbo.Sports s1 ON  c.SportType = s1.SportType
	--INNER JOIN DBAGE.bodb02.dbo.bettype b ON c.BetType = b.typeid
	--WHERE c.SportType = 200
	
	IF NOT EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency snosc WITH (NOLOCK) 
					INNER JOIN #Temp_SportNonOffer tsno ON snosc.SportType = tsno.SportType AND snosc.BetType = tsno.BetType AND snosc.Currency = tsno.Currency AND snosc.SiteID = tsno.SiteID)
	BEGIN
		INSERT INTO SportNonOfferedSiteCurrency 
		(
			SportType
		    , BetType
		    , Currency
		    , SiteID
		    , RealProductID
		)
		SELECT 
		DISTINCT SportType
		    , BetType
		    , Currency
		    , SiteID
		    , RealProductID
		FROM #Temp_SportNonOffer tsno
	END

	DROP TABLE #Temp_SportNonOffer
