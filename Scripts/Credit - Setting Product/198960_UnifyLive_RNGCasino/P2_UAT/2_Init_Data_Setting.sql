/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting  [#198960] 
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
	    , RealProductID	TINYINT
	)

	INSERT INTO #Temp_SportNonOffer 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
	SELECT 
		CASE WHEN SportType = 176 THEN 200 ELSE pssc.SportType END SportType , 
		pssc.BetType , 
		pssc.Currency , 
		pssc.SiteID , 
		CASE 
			WHEN pssc.SportType = 176		THEN 70	-- FGG
			WHEN pssc.SportType = 208		THEN 6	-- Saba Casino
			WHEN pssc.SportType IN (171,200)	THEN 42	-- Vgaming/SABA.games
		END AS RealProductID
	FROM ProductStatusSiteCurrency pssc WITH (NOLOCK)
	WHERE pssc.SportType IN (171,176,200,208)
	AND pssc.IsHidden = 1
	
	IF NOT EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency snosc WITH (NOLOCK) WHERE snosc.SportType IN (171,176,200,208))
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

	-------------------------2.ProductStatusProfile------------------------------------

	IF NOT EXISTS (SELECT 1 FROM ProductStatusProfile WITH (NOLOCK) WHERE Sporttype = 9918)
	BEGIN
		INSERT INTO ProductStatusProfile 
		(
			Sporttype
		    , Bettype
		    , bitmapOrder
		)
		SELECT 9918 , 4601 , 43
	END

	-------------------------3.ProductSettingType------------------------------------
	IF NOT EXISTS (SELECT 1 FROM ProductSettingType WITH (NOLOCK) WHERE SettingType = 160)
	BEGIN
		INSERT INTO ProductSettingType 
		(
			SettingType
		    , SettingName
		    , SettingNameDetail
		)
		SELECT 160,'Product Status','Product Status'
	END

	
