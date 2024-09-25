/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 03/05/2024
	Task: Inital Data Product Profile Setting  [#204358] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	DECLARE	
		@NewDummySportType		SMALLINT = 9919,
		@NewDummyBetType			SMALLINT = 1501
		,
		@NewDummySportType_PT		SMALLINT = 9909,
		@NewDummyBetType_PT		SMALLINT = 3700

CREATE TABLE #Profile_Temp
		(
			[ProductSettingID]	  [int]
		    , [SettingType]		  [smallint]
		    , [SportType]			  [smallint]
		    , [BetType]			  [smallint]
		    , [IsLive]			  [bit]
		    , [ProductID]			  [tinyint]
		    , [MaxPT]			  [smallmoney]
		    , [MaxDiscount]		  [decimal](9 , 8)
		    , [IsSync]			  [bit]
		    , [IsHidden]			  [bit]
		    , [IsDisabled]		  [bit]
		    , [SettingLevel]		  [tinyint]
		    , [DisplayOrder]		  [tinyint]
		    , [SettingStatus]		  [tinyint]
		    , [IntervalValue]		  [decimal](19 , 8)
		    , [RealProductId]		  [tinyint]
		    , [MaxChoice]			  [tinyint]
		    , [Parent_ProductSettingID] [int]
		    , [Child_DisplayOrder]	  [int]
		    , [SubType]			  [tinyint]
		    , [GroupID]			  [tinyint]
		    , [GroupType]			  [tinyint]
		    , [GroupTypeOrder]		  [tinyint]
		    , [SubGroupID]		  [tinyint]
		    , [SubGroupOrder]		  [tinyint]
		    , [CreationStatus]		  [tinyint]
		    , [DisplayType]		  [tinyint]
		    , [MarketType]		  [tinyint]
	PRIMARY KEY (ProductSettingID , SettingType , SportType , BetType , IsLive)
		)


	INSERT INTO #Profile_Temp 
	(
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	)

SELECT ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
FROM ProductSettingProfile WITH (NOLOCK)
WHERE  ProductId IN (5,44)


-- Part 1: All Product Status
	-- Remove redundat
	DELETE FROM #Profile_Temp WHERE SettingType = 13 AND SportType IN (220,222,202)
	
	UPDATE tem SET MaxPT = NULL , MaxDiscount = NULL ,  SettingLevel = 2  , GroupID = 2 , GroupType = 160 , GroupTypeOrder = 1 , DisplayType = 3 , SettingType = 21
	FROM #Profile_Temp tem WHERE SettingType = 13

	--Number Game : RealProductId = 3
	UPDATE tem SET tem.Child_DisplayOrder = 1  FROM #Profile_Temp tem WHERE SettingType = 21 AND tem.RealProductId = 3
	
	--Sports Lottery : RealProductId = 63
	UPDATE tem SET tem.Child_DisplayOrder = 2  FROM #Profile_Temp tem WHERE SettingType = 21 AND tem.RealProductId = 63
	
	--Virtual Sports : RealProductId = 5
	UPDATE tem SET tem.Child_DisplayOrder = 4  FROM #Profile_Temp tem WHERE SettingType = 21 AND tem.RealProductId = 5

	--Keno/Lottery : 44
	INSERT INTO #Profile_Temp 
	(
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	)
	SELECT
		370 AS ProductSettingID
	    , SettingType
	    , @NewDummySportType AS SportType
	    , @NewDummyBetType   AS BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , 44 AS RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , 3 AS Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	FROM #Profile_Temp
	WHERE SettingType = 21 AND RealProductId = 5

-- Part 2: All Bet Setting
	DELETE FROM #Profile_Temp WHERE SettingType IN (8,23) AND SportType IN (220,202,222,164)

	UPDATE tem SET MaxPT = NULL , MaxDiscount = NULL , SettingLevel = 2 , GroupTypeOrder = 2 ,  DisplayOrder = 2 , tem.SettingType  = 23 , DisplayType = 1 , SubGroupID = NULL , SubGroupOrder = NULL
	FROM #Profile_Temp tem 
	WHERE SettingType IN (2,23)

	-- Sports Lottery
	UPDATE tem SET Child_DisplayOrder = 1 FROM #Profile_Temp tem WHERE SettingType = 23 AND SportType = 169
	-- Virtual Sports
	UPDATE tem SET Child_DisplayOrder = 3 FROM #Profile_Temp tem WHERE SettingType = 23 AND SportType = 9908
	-- Number Game
	UPDATE tem SET Child_DisplayOrder = 4 FROM #Profile_Temp tem WHERE SettingType = 23 AND SportType = 161
	-- RNG Games
	INSERT INTO #Profile_Temp 
	(
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	)
	SELECT 
		371 AS ProductSettingID
	    , SettingType
	    , @NewDummySportType AS SportType
	    , @NewDummyBetType   AS BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , 44 AS RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , 2 AS Child_DisplayOrder
	    , 1 AS SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	FROM #Profile_Temp pt
	WHERE SettingType = 23
	AND SportType = 161
	     
-- Part 3: Position Taking
	INSERT INTO #Profile_Temp 
		(
			ProductSettingID
		    , SettingType
		    , SportType
		    , BetType
		    , IsLive
		    , ProductID
		    , MaxPT
		    , MaxDiscount
		    , IsSync
		    , IsHidden
		    , IsDisabled
		    , SettingLevel
		    , DisplayOrder
		    , SettingStatus
		    , IntervalValue
		    , RealProductId
		    , MaxChoice
		    , Parent_ProductSettingID
		    , Child_DisplayOrder
		    , SubType
		    , GroupID
		    , GroupType
		    , GroupTypeOrder
		    , SubGroupID
		    , SubGroupOrder
		    , CreationStatus
		    , DisplayType
		    , MarketType
		)
	SELECT	372 AS ProductSettingID
		    , 18 AS SettingType
		    , @NewDummySportType_PT AS SportType
		    , @NewDummyBetType_PT AS BetType
		    , IsLive
		    , ProductID
		    , MaxPT
		    , NULL AS MaxDiscount
		    , IsSync
		    , IsHidden
		    , IsDisabled
		    , SettingLevel
		    , 3 AS DisplayOrder
		    , SettingStatus
		    , IntervalValue
		    , 44 AS RealProductId
		    , MaxChoice
		    , Parent_ProductSettingID
		    , 1 AS Child_DisplayOrder
		    , SubType
		    , GroupID
		    , GroupType
		    , 3 AS GroupTypeOrder
		    , SubGroupID
		    , SubGroupOrder
		    , CreationStatus
		    , DisplayType
		    , MarketType
	FROM #Profile_Temp
	WHERE SettingType IN (1,18)
	AND SportType = 169

	DELETE FROM #Profile_Temp WHERE SettingType IN (1,18) AND SportType IN (220,202,169,222,161,9908)
	
-- Part 4: Win Loss Limit
	UPDATE t
		SET MaxPT = NULL , MaxDiscount = NULL , SettingLevel = 2 , DisplayOrder = 4  , GroupTypeOrder = 4 ,  DisplayType = 4 , SettingType = 22
	FROM #Profile_Temp t
	WHERE SettingType IN (6,22)


-- Refresh ProductID Is DummyProductID
	UPDATE t SET ProductID = 44 FROM #Profile_Temp t


-- Refresh Parent_ProductSettingID
	
	UPDATE pt
		SET pt.Parent_ProductSettingID = CASE 
									WHEN ProductSettingID IN (372,234)  THEN 0
									WHEN ProductSettingID IN (231,232)	THEN 233
									WHEN ProductSettingID = 43		THEN 162
									WHEN ProductSettingID = 239		THEN 236
									WHEN ProductSettingID = 371		THEN 370
							   END
	FROM #Profile_Temp pt
	WHERE pt.SettingType <> 21


--***************************************************************************************************************************************--
--SELECT *
--FROM #Profile_Temp t
--ORDER BY t.DisplayOrder , t.Child_DisplayOrder

-------------------------1.ProductSettingProfile_UAT------------------------------------

IF EXISTS (SELECT 1 FROM ProductSettingProfile_UAT WITH (NOLOCK) WHERE  ProductId IN (3,63,5,44))
BEGIN
	DELETE FROM ProductSettingProfile_UAT WITH (ROWLOCK) WHERE  ProductId IN (3,63,5,44)
END

INSERT INTO ProductSettingProfile_UAT 
	(
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	)
SELECT	ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
FROM #Profile_Temp pt


-------------------------2.ProductSettingDetail_UAT------------------------------------

IF EXISTS (SELECT 1 FROM ProductSettingDetail_UAT WITH (NOLOCK) WHERE  ProductId IN (3,63,5,44))
BEGIN
	DELETE FROM ProductSettingDetail_UAT WITH (ROWLOCK) WHERE  ProductId IN (3,63,5,44)
END

INSERT INTO ProductSettingDetail_UAT 
	(
		SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , ProductSettingID
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	)
SELECT	SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , ProductSettingID
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
FROM #Profile_Temp pt


DROP TABLE #Profile_Temp
