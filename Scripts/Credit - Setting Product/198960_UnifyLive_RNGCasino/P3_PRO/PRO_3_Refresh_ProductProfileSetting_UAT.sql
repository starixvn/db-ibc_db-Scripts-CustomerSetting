/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Refresh Data Product Profile Setting UAT [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------0. Collect Data in Temp Table------------------------------------

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
	-- Get Affected Product in Project:
	SELECT * 
	FROM ProductSettingProfile psp WITH (NOLOCK)
	WHERE ProductID IN (6 , 18 , 41 , 42 , 64 , 66)
	OR 
	(ProductID = 44 AND SportType = 224 AND psp.BetType  = 5500) -- FunkyGame affected


	-- No.1: SettingType = 13,21 - Product Status

	-- Remove Redundant data setting Product Status
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType IN (13,21)
	AND pt.ProductSettingID NOT IN (224,225,330)

	-- Add data setting Other RNG Casino Product Status
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
		367
	    , SettingType
	    , 9918
	    , 4601
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
	WHERE pt.SettingType = 21 
	AND pt.SportType = 9906

	
	UPDATE pt SET Child_DisplayOrder = 1 , SettingLevel = 2 , SettingType = 21	FROM #Profile_Temp pt WHERE pt.SettingType = 13 AND SportType = 9911	-- Live Casino 
	UPDATE pt SET Child_DisplayOrder = 2							FROM #Profile_Temp pt WHERE pt.SettingType = 21 AND SportType = 9906	-- RNG Casino 
	UPDATE pt SET Child_DisplayOrder = 3							FROM #Profile_Temp pt WHERE pt.SettingType = 21 AND SportType = 9904	-- Jackpot 
	UPDATE pt SET Child_DisplayOrder = 4							FROM #Profile_Temp pt WHERE pt.SettingType = 21 AND SportType = 9918	-- Other RNG Casino 

	UPDATE pt
		SET GroupID = 3 , IntervalValue = NULL , GroupType  = 160 , DisplayType = 3
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 21

	-- No.2: SettingType = 19		 - Commission (Don't Changed)

	-- No.3: SettingType = 1,18	 - Position Taking
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType IN (1,18)
	AND pt.ProductID NOT IN (18,41)

	UPDATE pt
		SET SettingType = 18
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 1
	
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
		368
	    , SettingType
	    , 9918
	    , 4601
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
	WHERE pt.SettingType = 18 
	AND pt.SportType = 9906

	UPDATE pt SET Child_DisplayOrder = 1								FROM #Profile_Temp pt WHERE pt.SettingType = 18 AND SportType = 9911	-- Live Casino 
	UPDATE pt SET Child_DisplayOrder = 2 , SettingLevel = 2 , IntervalValue = NULL	FROM #Profile_Temp pt WHERE pt.SettingType = 18 AND SportType = 9906	-- RNG Casino 
	UPDATE pt SET Child_DisplayOrder = 3 , SettingLevel = 2 , IntervalValue = NULL 
								, SubGroupID  = 5 , SubGroupOrder = 2	FROM #Profile_Temp pt WHERE pt.SettingType = 18 AND SportType = 9918	-- Other RNG Casino 
	UPDATE pt SET Child_DisplayOrder = 4								FROM #Profile_Temp pt WHERE pt.SettingType = 18 AND SportType = 242	-- IBCBet Live Casino 

	-- No.4: SettingType = 7,17,8	 - Stake Level
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType IN (7,8)
	AND (pt.ProductID = 64 AND pt.SportType = 245 OR pt.ProductID IN (66,44))

	-- Remove Old Sport Redundant - GDG
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 17
	AND pt.SportType = 236


	UPDATE pt
		SET ProductID  = 41 , DisplayOrder = 6 , RealProductId = 41 , Settinglevel = 2
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 7 AND pt.ProductID = 64

	UPDATE pt
		SET SettingType  = 7 , ProductID  = 18 , Settinglevel = 2 , RealProductId = 18 
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 8

	UPDATE pt SET Child_DisplayOrder = 1 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 159	-- YeeBet 
	UPDATE pt SET Child_DisplayOrder = 2 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 170	-- PP Live Casino 
	UPDATE pt SET Child_DisplayOrder = 3 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 225	-- ION 
	UPDATE pt SET Child_DisplayOrder = 4 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 241	-- BBIN 
	UPDATE pt SET Child_DisplayOrder = 5 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 176	-- FGG 
	UPDATE pt SET Child_DisplayOrder = 6 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 242	-- IBCBet Live Casino 
	UPDATE pt SET Child_DisplayOrder = 7 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 211	-- Allbet 
	UPDATE pt SET Child_DisplayOrder = 8 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 228	-- WE Live Casino 
	UPDATE pt SET Child_DisplayOrder = 9 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 233	-- WM 
	UPDATE pt SET Child_DisplayOrder = 10 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 239	-- BG 
	UPDATE pt SET Child_DisplayOrder = 11 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 243	-- AE Sexy 
	UPDATE pt SET Child_DisplayOrder = 12 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType IN (7,17) AND SportType = 244	-- SA Gaming 
	UPDATE pt SET Child_DisplayOrder = 13 FROM #Profile_Temp pt WHERE pt.ProductID = 18 AND pt.SettingType IN (7,17) AND SportType = 208	-- Saba Casino - RNG Game
	UPDATE pt SET Child_DisplayOrder = 14 FROM #Profile_Temp pt WHERE pt.ProductID = 18 AND pt.SettingType IN (7,17) AND SportType = 200	-- SABA.games

	
	--UPDATE pt SET IsHidden = 1 FROM #Profile_Temp pt WHERE pt.ProductID = 41 AND pt.SettingType = 7 AND SportType = 176	-- FGG 
	--UPDATE pt SET IsHidden = 1 FROM #Profile_Temp pt WHERE pt.ProductID = 18 AND pt.SettingType = 7 AND SportType = 200	-- SABA.games 
	--UPDATE pt SET IsHidden = 1 FROM #Profile_Temp pt WHERE pt.ProductID = 18 AND pt.SettingType = 7 AND SportType = 208	-- Saba Casino - RNG Game 
	

	UPDATE pt SET GroupType = 158
	FROM #Profile_Temp pt
	WHERE pt.ProductID IN (18,41)
	AND pt.SettingType IN (7,17)

	-- No.5: SettingType = 6,22	 - Win Loss Limit
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType IN (6,22)
	AND pt.SportType NOT IN (9911,9906)
	
	UPDATE pt
		SET SettingType = 22
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 6
	

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
		369
	    , SettingType
	    , 9918
	    , 4601
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
	WHERE pt.SettingType = 22
	AND pt.SportType = 9906

	UPDATE pt
		SET SettingLevel  = 2 , IntervalValue = NULL
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 22


	UPDATE pt SET Child_DisplayOrder = 2 FROM #Profile_Temp pt WHERE pt.SettingType = 22 AND SportType = 9906	-- RNG Casino 
	UPDATE pt SET Child_DisplayOrder = 3 FROM #Profile_Temp pt WHERE pt.SettingType = 22 AND SportType = 9918	-- Other RNG Casino

	UPDATE pt SET GroupType = 155
	FROM #Profile_Temp pt
	WHERE pt.ProductID IN (18,41)
	AND pt.SettingType = 22

	-- No.6: SettingType = 23		 - Bet Setting
	-- Remove Setting Funky Games
	DELETE pt
	FROM #Profile_Temp pt
	WHERE pt.SettingType = 23

	---------------

	-- No.7: Refresh Real ProductID , Dummy ProductID >> RNG Casino
	UPDATE pt SET ProductID = 53 , RealProductId = 53
	FROM #Profile_Temp pt
	WHERE pt.ProductID = 18

	--Update GroupTypeOrder
	UPDATE pt 
	SET GroupTypeOrder = CASE	WHEN GroupType = 160 THEN 1
						WHEN GroupType = 156 THEN 2
						WHEN GroupType = 153 THEN 3
						WHEN GroupType = 155 THEN 4
						WHEN GroupType = 158 THEN 5
						ELSE GroupTypeOrder END
	FROM #Profile_Temp pt


	-- Include Product Non-Affected
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
	FROM ProductSettingProfile psd  WITH (NOLOCK)
	WHERE psd.ProductID NOT IN (6 , 53 , 41 , 42 , 44 , 64 , 66 , 18)
	UNION ALL
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
	FROM ProductSettingProfile psd  WITH (NOLOCK)
	WHERE psd.ProductID = 44 AND psd.SportType <> 224


-------------------------1.ProductSettingProfile_UAT------------------------------------

--> Step 1.1: Clear Old Data Product Profile Setting . Ignore: Number Game , Happy 5 , Sports Lottery , RNG Keno , Lottery , Table Game:
	DELETE FROM ProductSettingProfile_UAT WITH (ROWLOCK)
	 
--> Step 1.2: Sync Data UAT from Main Table
	INSERT INTO ProductSettingProfile_UAT
	( 
			 ProductSettingID
			,SettingType
			,SportType
			,BetType
			,IsLive
			,ProductID
			,MaxPT
			,MaxDiscount
			,IsSync
			,IsHidden
			,IsDisabled
			,SettingLevel
			,DisplayOrder
			,SettingStatus
			,IntervalValue
			,RealProductId
			,MaxChoice
			,Parent_ProductSettingID
			,Child_DisplayOrder
			,SubType
			,GroupID
			,GroupType
			,GroupTypeOrder
			,SubGroupID
			,SubGroupOrder
			,CreationStatus
			,DisplayType
			,MarketType 		
	)
	SELECT  ProductSettingID
			,SettingType
			,SportType
			,BetType
			,IsLive
			,ProductID
			,MaxPT
			,MaxDiscount
			,IsSync
			,IsHidden
			,IsDisabled
			,SettingLevel
			,DisplayOrder
			,SettingStatus
			,IntervalValue
			,RealProductId
			,MaxChoice
			,Parent_ProductSettingID
			,Child_DisplayOrder
			,SubType
			,GroupID
			,GroupType
			,GroupTypeOrder
			,SubGroupID
			,SubGroupOrder
			,CreationStatus
			,DisplayType
			,MarketType 
	FROM #Profile_Temp pt

	-------------------------2.ProductSettingDetail_UAT------------------------------------

--> Step 2.1: Clear Old Data Product Detail Setting . Ignore: Number Game , Happy 5 , Sports Lottery , RNG Keno , Lottery , Table Game:
	DELETE FROM ProductSettingDetail_UAT WITH (ROWLOCK)

--> Step 2.2: Sync Data UAT
	INSERT INTO ProductSettingDetail_UAT 
	(
		 ProductSettingID
		,SettingType
		,SportType
		,BetType
		,IsLive
		,ProductID
		,MaxPT
		,MaxDiscount
		,IsSync
		,IsHidden
		,IsDisabled
		,SettingLevel
		,DisplayOrder
		,SettingStatus
		,IntervalValue
		,RealProductId
		,MaxChoice
		,Parent_ProductSettingID
		,Child_DisplayOrder
		,SubType		
	)
	SELECT DISTINCT
		ProductSettingID
		,SettingType
		,SportType
		,BetType
		,IsLive
		,ProductID
		,MaxPT
		,MaxDiscount
		,IsSync
		,IsHidden
		,IsDisabled
		,SettingLevel
		,DisplayOrder
		,SettingStatus
		,IntervalValue
		,RealProductId
		,MaxChoice
		,Parent_ProductSettingID
		,Child_DisplayOrder
		,SubType
	FROM #Profile_Temp pt

	DROP TABLE #Profile_Temp
