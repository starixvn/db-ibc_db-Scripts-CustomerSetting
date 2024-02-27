/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Data Setting  [#193083]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	-------------------------1.ProductSettingProfile_UAT------------------------------------

--> Step 1.1: Clear Old Data Product Profile Setting:
		DELETE FROM ProductSettingProfile_UAT WITH (ROWLOCK) 

--> Step 1.2: Sync Data UAT from Main Table
		INSERT INTO ProductSettingProfile_UAT( 
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
				,MarketType 		)

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
		FROM ProductSettingProfile WITH (NOLOCK)
		WHERE SettingStatus = 0

----> Step 1.3 Config Product Profile Setting:
	
		-- Remove PT setting SB2:
		DELETE
		FROM ProductSettingProfile_UAT WITH (ROWLOCK)
		WHERE ProductID IN (16,1)


		-- Initial data setting profile for ProductSettingProfile_UAT
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
	
			 SELECT 343 , 13 , 44 , 3 , 0 , 1 , NULL , NULL , 1 , 0 , 0 , 2 , 1 , 0 , NULL , 1 , NULL , NULL , NULL , NULL , 1 , NULL , NULL , NULL , NULL , 0 , NULL , 0 
		 UNION SELECT 344 , 25 , 1 , 1 , 0 , 1 , NULL , 0.0025 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 1 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 0 
		 UNION SELECT 345 , 25 , 1 , 3 , 0 , 1 , NULL , 0.005 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 2 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 1 
		 UNION SELECT 346 , 25 , 1 , 4 , 0 , 1 , NULL , 0.01 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 6 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 0 
		 UNION SELECT 347 , 25 , 1 , 5 , 0 , 1 , NULL , 0.0025 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 5 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 0 
		 UNION SELECT 348 , 25 , 1 , 7 , 0 , 1 , NULL , 0.0075 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 3 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 1 
		 UNION SELECT 349 , 25 , 1 , 8 , 0 , 1 , NULL , 0.01 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 4 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 1 
		 --UNION SELECT 350 , 25 , 2 , 1 , 0 , 1 , NULL , 0.01 , NULL , NULL , NULL , 4 , 1 , 0 , 0.0005 , 1 , NULL , NULL , 7 , NULL , 1 , 150 , 1 , NULL , NULL , 0 , 5 , 1 -- Don't Init for Myanmar Odds Discount
		 UNION SELECT 351 , 26 , 1 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 1 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 352 , 26 , 1 , 9 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 3 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 353 , 26 , 2 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 4 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 354 , 26 , 3 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 6 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 355 , 26 , 5 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 7 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 356 , 26 , 8 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 8 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 357 , 26 , 10 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 9 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 358 , 26 , 11 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 10 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 359 , 26 , 43 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 2 , 2 , 0 , NULL , 1 , NULL , NULL , 13 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 360 , 26 , 44 , 3 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 2 , 2 , 0 , NULL , 1 , NULL , NULL , 14 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 361 , 26 , 99 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 11 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 362 , 26 , 99 , 9 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 12 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 363 , 26 , 9901 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 2 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 364 , 26 , 9902 , 1 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 2 , 0 , NULL , 1 , NULL , NULL , 5 , NULL , 1 , 151 , 2 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 365 , 27 , 1 , 9 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 15 , NULL , 1 , 152 , 3 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 366 , 27 , 99 , 9 , 0 , 1 , NULL , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 16 , NULL , 1 , 152 , 3 , NULL , NULL , 0 , 1 , 0 
		 UNION SELECT 336 , 28 , 9913 , 915 , 1 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 4 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 337 , 28 , 9913 , 916 , 1 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 5 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 338 , 28 , 9913 , 917 , 1 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 6 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 333 , 28 , 9914 , 915 , 0 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 1 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 334 , 28 , 9914 , 916 , 0 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 2 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 335 , 28 , 9914 , 917 , 0 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 3 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 
		 UNION SELECT 339 , 28 , 9915 , 918 , 0 , 1 , 93 , NULL , NULL , NULL , NULL , 4 , 3 , 0 , NULL , 1 , NULL , NULL , 7 , NULL , 1 , 153 , 4 , 1 , 1 , 0 , 2 , 0 



	-------------------------2.ProductProfileSiteCurrency_UAT------------------------------
--> Step 2.1: Clear Old Data:
		DELETE FROM ProductProfileSiteCurrency_UAT WITH (ROWLOCK)

--> Step 2.2: Sync Data UAT
		INSERT INTO ProductProfileSiteCurrency_UAT(SiteID , Currency , ProductSettingID)
		SELECT SiteID , Currency , ProductSettingID
		FROM ProductProfileSiteCurrency WITH (NOLOCK)

--> Step 2.3: Update ProductSettingID
		UPDATE p
			SET ProductSettingID = 345
		FROM ProductProfileSiteCurrency_UAT p WITH (ROWLOCK) WHERE ProductSettingID = 250

		UPDATE p
			SET ProductSettingID = 348
		FROM ProductProfileSiteCurrency_UAT p WITH (ROWLOCK) WHERE ProductSettingID = 251

		UPDATE p
			SET ProductSettingID = 349
		FROM ProductProfileSiteCurrency_UAT p WITH (ROWLOCK) WHERE ProductSettingID = 252

--> Remove Setting for MyanmarOdds
		DELETE p
		FROM ProductProfileSiteCurrency_UAT p WITH (ROWLOCK) WHERE ProductSettingID = 255

	-------------------------3.ProductSettingDetail_UAT------------------------------------

--> Step 3.1: Clear Old Data Product Detail Setting:
		DELETE FROM ProductSettingDetail_UAT WITH (ROWLOCK)

--> Step 3.2: Sync Data UAT
		INSERT INTO ProductSettingDetail_UAT (
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
			,SubType		)

		SELECT ProductSettingID
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
		FROM ProductSettingDetail WITH (NOLOCK)
		WHERE SettingStatus = 0	
	

----> Step 3.3 Config Product Profile Setting:
	
		-- Remove setting SB2 If Exist:
		IF EXISTS (SELECT TOP 1 1 FROM ProductSettingDetail_UAT WITH (NOLOCK) WHERE ProductID IN (1,16) )
		BEGIN
			DELETE
			FROM ProductSettingDetail_UAT WITH (ROWLOCK)
			WHERE ProductID IN (1,16)
		END

		-- AND Clone Setting SB From ProductSettingProfile_UAT For ProductSettingDetail_UAT
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
		SELECT 
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
		FROM ProductSettingProfile_UAT WITH (NOLOCK)
		WHERE ProductID = 1

		-- AND Clone Setting SB From ProductSettingDetail_UAT with SettingStatus = 2 For test UM
		IF EXISTS (SELECT 1 FROM ProductSettingDetail WITH (NOLOCK) WHERE ProductID = 1 AND SettingStatus = 2)
		BEGIN
			DELETE d FROM ProductSettingDetail d WITH (ROWLOCK) WHERE ProductID = 1 AND SettingStatus = 2
		END

		INSERT INTO ProductSettingDetail
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
		SELECT 
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
		    , 2
		    , IntervalValue
		    , RealProductId
		    , MaxChoice
		    , ProductSettingID
		    , Parent_ProductSettingID
		    , Child_DisplayOrder
		    , SubType
		FROM ProductSettingDetail_UAT WITH (NOLOCK)
		WHERE ProductID = 1
		AND SettingType <> 13
