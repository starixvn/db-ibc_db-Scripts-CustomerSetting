/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: add some setting of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO

--> Config new for ProductSettingDetail
	DELETE p
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE SportType IN(9908,9909)

	DELETE p
	FROM ProductSettingDetail p WITH(NOLOCK) 
	WHERE sporttype = 220 and bettype = 1024  AND settingtype = 13

	--VS
	--> clone setting to dummy sport
	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
	SELECT SettingType,SportType = 9908,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
			,DisplayOrder,SettingStatus = 2,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
			,ProductSettingID = CASE WHEN SettingType = 1  THEN 230
									WHEN SettingType = 2  THEN 231
									WHEN SettingType = 6  THEN 232
									WHEN SettingType = 13  THEN 233
								END
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 5 
		AND SportType = 180 

	-----Lottery
	--> Clone Winloss limit to new dummy sport
	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
	SELECT SettingType = 6,SportType = 9909,BetType = 3700,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
			,DisplayOrder,SettingStatus = 2,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
			,ProductSettingID = 234
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 44 
		AND SportType = 169 
		AND settingtype = 6

	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
	SELECT SettingType,SportType, BetType = 1024,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
			,DisplayOrder,SettingStatus = 2 ,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
			,ProductSettingID = 235
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 44 
		AND SportType = 220 
		AND bettype = 1021
		AND settingtype = 13

/*
SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 5 
AND settingstatus = 2

SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 44 
AND settingstatus = 2
*/

--> Sync data from ProductSettingDetail--> ProductSettingDetail_UAT
	DELETE FROM ProductSettingDetail_UAT WITH(ROWLOCK)

	INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	)
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE SettingStatus <> 2

--> Config new for ProductSettingDetail_UAT
	--VS
		--> Delete all PT and bet setting bettype of VS exclude Virtual Soccer
		DELETE p
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 5 
			AND SportType <> 180 
			AND settingtype IN(1,2,20)

		--> clone setting to dummy sport
		INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
		SELECT SettingType,SportType = 9908,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
				,DisplayOrder,SettingStatus = 0,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
				,ProductSettingID = CASE WHEN SettingType = 1  THEN 230
										WHEN SettingType = 2  THEN 231
										WHEN SettingType = 6  THEN 232
										WHEN SettingType = 13  THEN 233
									END
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 5 
			AND SportType = 180 

		--> Delete unused setting
		DELETE p
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 5 
			AND SportType = 180 

	-----Lottery
		--> Clone Winloss limit to new dummy sport
		INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
		SELECT SettingType = 22,SportType = 9909,BetType = 3700,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
				,DisplayOrder,SettingStatus = 0 ,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
				,ProductSettingID = 234
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND SportType = 169 
			AND settingtype = 6

		INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType,ProductSettingID)
		SELECT SettingType,SportType, BetType = 1024,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
				,DisplayOrder,SettingStatus = 0 ,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,SubType
				,ProductSettingID = 235
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND SportType = 220 
			AND bettype = 1021
			AND settingtype = 13

		--> Delete unused Winloss limit setting
		DELETE p
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND settingtype = 6

		----> DELETE unused Lottery PT, Bettsetting 
		DELETE p
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND SportType = 220 
			AND bettype <> 1024
			AND settingtype IN(2,18)

		----> Update setting level of RNG Lottery PT, Bettsetting 
		UPDATE p
		SET SettingLevel = 2
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND settingtype IN(2,18)

		--> Update ProductStatus of Lottery bettype from 1021 --> 1024
		DELETE p
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND settingtype = 13
			AND SportType = 220
			AND bettype = 1021

		--Delete temp bitmap order to test Status 
		DELETE
		FROM ProductStatusProfile WITH(ROWLOCK) 
		WHERE bitmapOrder IN(2,3)

		--> Update ProductStatusProfile of VS, Lottery
		UPDATE a
		SET a.Sporttype = 9908
		FROM ProductStatusProfile a WITH(ROWLOCK) 
		WHERE bitmapOrder = 10
			AND Sporttype = 180

		UPDATE a
		SET a.Bettype = 1024
		FROM ProductStatusProfile a WITH(ROWLOCK) 
		WHERE bitmapOrder = 11
			AND Sporttype = 220

/*
SELECT *
FROM ProductSettingDetail_UAT p WITH(NOLOCK) 
WHERE productid = 5 

SELECT *
FROM ProductSettingDetail_UAT p WITH(NOLOCK) 
WHERE productid = 44 

SELECT * FROM ProductStatusProfile WITH(NOLOCK) ORDER BY bitmapOrder

*/
----> DELETE unused setting of ProductStatusSiteCurrency
	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK) 
	WHERE sporttype = 180

	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK)  
	WHERE sporttype = 220 and BetType = 1021

--> DELETE unused setting of ProductBetSetting
	DELETE p
	FROM ProductBetSetting p WITH(ROWLOCK) 
	WHERE Sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)

	DELETE p
	FROM ProductBetSetting p WITH(ROWLOCK) 
	WHERE Sporttype = 220 AND bettype <> 1024
