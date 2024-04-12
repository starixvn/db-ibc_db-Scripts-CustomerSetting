/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Remove Data Setting Redundant After Released [#198960] 
		https://nexdev.net/issues/198960
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO
	
/*1. Product Profile*/

----------------------------------------ProductProfileSiteCurrency---------------------------------------------

	DECLARE @Temp_ProductSettingID TABLE (ProductSettingID INT)
	
	INSERT INTO @Temp_ProductSettingID 
	(
		ProductSettingID
	)
	SELECT DISTINCT p.ProductSettingID
	FROM ProductProfileSiteCurrency p WITH (NOLOCK)
	LEFT JOIN ProductSettingProfile pu WITH (NOLOCK) ON p.ProductSettingID = pu.ProductSettingID
	WHERE p.ProductSettingID IN (9,22,196,341,212,342)
	AND pu.ProductSettingID IS NULL

	--SELECT * FROM @Temp_ProductSettingID

IF EXISTS (SELECT 1 FROM ProductProfileSiteCurrency p WITH (NOLOCK) INNER JOIN @Temp_ProductSettingID tem ON p.ProductSettingID = tem.ProductSettingID)
	BEGIN 
		DELETE p FROM ProductProfileSiteCurrency     P WITH (ROWLOCK) INNER JOIN @Temp_ProductSettingID tem ON p.ProductSettingID = tem.ProductSettingID

		DELETE p FROM ProductProfileSiteCurrency_UAT  P WITH (ROWLOCK) INNER JOIN @Temp_ProductSettingID tem ON p.ProductSettingID = tem.ProductSettingID
	END

----------------------------------------ProductSettingSystemDisplay---------------------------------------------
	DECLARE @Temp_ProductSettingType TABLE
	(
		ProductName	VARCHAR(50),
		ProductID	TINYINT,
		SettingName	VARCHAR(50),
		SettingType SMALLINT
	)

	INSERT INTO @Temp_ProductSettingType 
	(
		ProductName
	    , ProductID
	    , SettingName
	    , SettingType
	)
	 SELECT 'Saba Casino' AS ProductName , 6 AS ProductID , 'Win Loss Limit' AS SettingName  , 6 AS SettingType  
 UNION SELECT 'Saba Casino' AS ProductName , 6 AS ProductID , 'Product Status' AS SettingName  , 13 AS SettingType  
 UNION SELECT 'Saba Casino' AS ProductName , 6 AS ProductID , 'Position Taking' AS SettingName  , 18 AS SettingType  
 UNION SELECT 'RNG Slot' AS ProductName , 18 AS ProductID , 'Position Taking' AS SettingName  , 1 AS SettingType  
 UNION SELECT 'RNG Slot' AS ProductName , 18 AS ProductID , 'Commission' AS SettingName  , 3 AS SettingType  
 UNION SELECT 'RNG Slot' AS ProductName , 18 AS ProductID , 'Win Loss Limit' AS SettingName  , 6 AS SettingType  
 UNION SELECT 'RNG Slot' AS ProductName , 18 AS ProductID , 'Stake Level' AS SettingName  , 8 AS SettingType  
 UNION SELECT 'RNG Slot' AS ProductName , 18 AS ProductID , 'Product Status' AS SettingName  , 21 AS SettingType  
 UNION SELECT 'Live Casino' AS ProductName , 41 AS ProductID , 'Product Status' AS SettingName  , 13 AS SettingType  
 UNION SELECT 'SABA.games' AS ProductName , 42 AS ProductID , 'Position Taking' AS SettingName  , 1 AS SettingType  
 UNION SELECT 'SABA.games' AS ProductName , 42 AS ProductID , 'Win Loss Limit' AS SettingName  , 6 AS SettingType  
 UNION SELECT 'SABA.games' AS ProductName , 42 AS ProductID , 'Product Status' AS SettingName  , 13 AS SettingType  
 UNION SELECT 'Virtual Games' AS ProductName , 64 AS ProductID , 'Win Loss Limit' AS SettingName  , 6 AS SettingType  
 UNION SELECT 'Virtual Games' AS ProductName , 64 AS ProductID , 'Product Status' AS SettingName  , 13 AS SettingType  
 UNION SELECT 'Virtual Games' AS ProductName , 64 AS ProductID , 'Position Taking' AS SettingName  , 18 AS SettingType  
 UNION SELECT 'Vgaming' AS ProductName , 66 AS ProductID , 'Position Taking' AS SettingName  , 1 AS SettingType  
 UNION SELECT 'Vgaming' AS ProductName , 66 AS ProductID , 'Win Loss Limit' AS SettingName  , 6 AS SettingType  
 UNION SELECT 'Vgaming' AS ProductName , 66 AS ProductID , 'Product Status' AS SettingName  , 13 AS SettingType  

	--SELECT * FROM @Temp_ProductSettingType

IF EXISTS (SELECT 1 FROM ProductSettingSystemDisplay p WITH (NOLOCK) 
		  	  INNER JOIN @Temp_ProductSettingType temp ON p.ProductID = temp.ProductID AND p.SettingType = temp.SettingType
		)
BEGIN
		DELETE p 
		FROM ProductSettingSystemDisplay p WITH (ROWLOCK) 
		INNER JOIN @Temp_ProductSettingType temp ON p.ProductID = temp.ProductID AND p.SettingType = temp.SettingType
END

---------------------------------------------------------------------------------------------------------------

	CREATE TABLE #Temp_SportBetType
	(
		SportName	VARCHAR(50),
		SportType	SMALLINT,
		BetType	SMALLINT
	)

	INSERT INTO #Temp_SportBetType 
	(
		SportName
	    , SportType
	    , BetType
	)
	 SELECT 'Virtual Games' AS SportName , 245 AS SportType , 4601 AS BetType  
 UNION SELECT 'Saba Casino'	AS SportName , 208 AS SportType , 2101 AS BetType  
 UNION SELECT 'FGG'		AS SportName , 176 AS SportType , 8201 AS BetType  
 UNION SELECT 'Vgaming'		AS SportName , 171 AS SportType , 3801 AS BetType  
 UNION SELECT 'SABA.games'	AS SportName , 200 AS SportType , 1611 AS BetType  
 UNION SELECT 'Funky Games'	AS SportName , 224 AS SportType , 5500 AS BetType  

	--SELECT * FROM #Temp_SportBetType

----------------------------------------ProductStatusSiteCurrency---------------------------------------------

IF EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency p WITH (NOLOCK) INNER JOIN #Temp_SportBetType tem ON p.SportType = tem.SportType AND p.BetType = tem.BetType)
BEGIN
	IF EXISTS (SELECT 1 FROM ProductStatusSiteCurrency p WITH (NOLOCK) INNER JOIN #Temp_SportBetType tem ON p.SportType = tem.SportType AND p.BetType = tem.BetType)
	BEGIN
		DELETE p
		FROM ProductStatusSiteCurrency p WITH (ROWLOCK) 
		INNER JOIN #Temp_SportBetType tem ON p.SportType = tem.SportType AND p.BetType = tem.BetType
	END
END


/*2. Product Status*/

----------------------------------------ProductStatusProfile---------------------------------------------

IF EXISTS (SELECT 1 FROM ProductStatusProfile p WITH (NOLOCK) INNER JOIN #Temp_SportBetType tem ON p.SportType = tem.SportType AND p.BetType = tem.BetType)
BEGIN
	DELETE p 
	FROM ProductStatusProfile p WITH (ROWLOCK) 
	INNER JOIN #Temp_SportBetType tem ON p.SportType = tem.SportType AND p.BetType = tem.BetType
END


/*3. Loss Limit Global*/

----------------------------------------LossLimit_GlobalSetting ---------------------------------------------

IF EXISTS (SELECT 1 FROM LossLimit_GlobalSetting WITH (NOLOCK) WHERE ProductId  IN (6 , 18  , 42 , 64 , 66))
BEGIN
	DELETE FROM LossLimit_GlobalSetting WITH (ROWLOCK) WHERE ProductId  IN (6 , 18  , 42 , 64 , 66)
END


/*4. Bet Limit*/
	
	-- Refresh Temp Table SportType - BetType for remove Bet Limit
	TRUNCATE TABLE #Temp_SportBetType

	INSERT INTO #Temp_SportBetType 
		(
			SportName
		    , SportType
		    , BetType
		)
	  SELECT 'Virtual Games'	AS SportName , 245 AS SportType , 4601 AS BetType  
 UNION  SELECT 'Virtual Games'	AS SportName , 245 AS SportType , 4602 AS BetType  
 UNION  SELECT 'Virtual Games'	AS SportName , 245 AS SportType , 4605 AS BetType  
 UNION  SELECT 'Vgaming'		AS SportName , 171 AS SportType , 3801 AS BetType  
 UNION  SELECT 'Funky Games'		AS SportName , 224 AS SportType , 5500 AS BetType  

 UNION  SELECT 'SABA.games'		AS SportName , 200 AS SportType , 1611 AS BetType  
 UNION  SELECT 'Saba Casino'		AS SportName , 208 AS SportType , 2101 AS BetType  


	--SELECT * FROM #Temp_SportBetType

	-- Collect GameGroupID need Remove
	DECLARE @Temp_GameGroup TABLE
	(
		GameGroupID	INT,
		BetType	SMALLINT
	)


	INSERT INTO @Temp_GameGroup 
	(
		GameGroupID,
		BetType
	)
	SELECT gg.GameGroupID , gg.RefBetType
	FROM #Temp_SportBetType tem
	INNER JOIN GameGroup gg WITH (NOLOCK) ON tem.SportType = gg.RefSportType AND tem.BetType = gg.RefBetType
	WHERE gg.IsDeposit = 0

	UNION SELECT 0 AS GameGroupID , BetType FROM #Temp_SportBetType WHERE SportType = 245


	-- Collect StakeLevelID need Remove
	CREATE TABLE #Temp_StakeLevelID
	(
		StakeLevelID	INT,
		GameTypeID		INT
	)


	INSERT INTO #Temp_StakeLevelID 
	(
		StakeLevelID
	    , GameTypeID
	)
	SELECT sl.StakeLevelID , sl.GameTypeID
	FROM StakeLevel sl WITH (NOLOCK)
	INNER JOIN @Temp_GameGroup gg ON sl.GameTypeID = gg.BetType AND  sl.GameGroupID = gg.GameGroupID


----------------------------------------StakeLevelGroupDetail---------------------------------------------
-- Remove Funky Games (224) , Saba Casino	(208) , SABA.games (200) , Vgaming (171)

IF EXISTS (SELECT 1 FROM StakeLevelGroupDetail slgd WITH (NOLOCK)
			INNER JOIN #Temp_StakeLevelID tem ON slgd.StakeLevelID = tem.StakeLevelID AND slgd.GameTypeID = tem.GameTypeID
			INNER JOIN #Temp_SportBetType sb ON tem.GameTypeID = sb.BetType
			WHERE sb.SportType <> 245
		)
BEGIN
	DELETE slgd
	FROM StakeLevelGroupDetail slgd WITH (ROWLOCK) 
	INNER JOIN #Temp_StakeLevelID tem ON slgd.StakeLevelID = tem.StakeLevelID AND slgd.GameTypeID = tem.GameTypeID
	INNER JOIN #Temp_SportBetType sb ON tem.GameTypeID = sb.BetType
	WHERE sb.SportType <> 245
END

----------------------------------------StakeLevel---------------------------------------------

-- Just Remove Vgaming (171) , Funky Games (224) , Virtual Games (245)

IF EXISTS (SELECT 1 FROM StakeLevel slgd WITH (NOLOCK) 
			INNER JOIN #Temp_StakeLevelID tem ON slgd.StakeLevelID = tem.StakeLevelID AND slgd.GameTypeID = tem.GameTypeID
			INNER JOIN #Temp_SportBetType sb ON tem.GameTypeID = sb.BetType
			WHERE sb.SportType IN (171,224,245)
	     )
BEGIN
	DELETE slgd
	FROM StakeLevel slgd WITH (ROWLOCK) 
	INNER JOIN #Temp_StakeLevelID tem ON slgd.StakeLevelID = tem.StakeLevelID AND slgd.GameTypeID = tem.GameTypeID
	INNER JOIN #Temp_SportBetType sb ON tem.GameTypeID = sb.BetType
	WHERE sb.SportType IN (171,224,245)
END

----------------------------------------GameGroup---------------------------------------------

-- Remove Funky Games (224) , Saba Casino	(208) , SABA.games (200) , Vgaming (171)

	-- Remove Virtual Games (245)
	DELETE gg
	FROM @Temp_GameGroup gg
	INNER JOIN #Temp_SportBetType sb ON gg.BetType = sb.BetType
	WHERE sb.SportType = 245

IF EXISTS (SELECT 1 FROM GameGroup slgd WITH (NOLOCK) INNER JOIN @Temp_GameGroup gg ON slgd.GameGroupID = gg.GameGroupID AND slgd.RefBetType = gg.BetType WHERE slgd.IsDeposit = 0)
BEGIN
	DELETE slgd
	FROM GameGroup slgd WITH (ROWLOCK) 
	INNER JOIN @Temp_GameGroup gg ON slgd.GameGroupID = gg.GameGroupID AND slgd.RefBetType = gg.BetType
	WHERE slgd.IsDeposit = 0
END