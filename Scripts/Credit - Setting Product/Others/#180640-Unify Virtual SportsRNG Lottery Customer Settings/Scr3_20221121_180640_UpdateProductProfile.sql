/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Remove some setting of VS and RNG Lottery 
		ADD new settingtype for Winloss limit [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
--> Sync data from ProductSettingDetail--> ProductSettingDetail_UAT
DELETE FROM ProductSettingDetail_UAT WITH(ROWLOCK)

INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder
)
SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder
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
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
		SELECT SettingType,SportType = 9908,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
				,DisplayOrder,SettingStatus = 0,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
				,ProductSettingID = CASE WHEN SettingType = 1  THEN 228
										WHEN SettingType = 2  THEN 229
										WHEN SettingType = 6  THEN 230
										WHEN SettingType = 13  THEN 231
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
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
		SELECT SettingType = 22,SportType = 9909,BetType = 3700,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
				,DisplayOrder,SettingStatus = 0 ,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
				,ProductSettingID = 232
		FROM ProductSettingDetail_UAT p WITH(ROWLOCK,UPDLOCK) 
		WHERE productid = 44 
			AND SportType = 169 
			AND settingtype = 6

		INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
		SELECT SettingType,SportType, BetType = 1024,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
				,DisplayOrder,SettingStatus = 0 ,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
				,ProductSettingID = 233
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

		--Insert temp bitmap order to test Status ( will be delete when remove)
		IF NOT EXISTS( 
						SELECT 1 
						FROM ProductStatusProfile WITH(NOLOCK) 
						WHERE bitmapOrder IN(2,3)
					)
			INSERT INTO ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
			SELECT 220,1024,3 UNION ALL
			SELECT 9908,1201, 2

/*
SELECT *
FROM ProductSettingDetail_UAT p WITH(NOLOCK) 
WHERE productid = 5 

SELECT *
FROM ProductSettingDetail_UAT p WITH(NOLOCK) 
WHERE productid = 44 

SELECT * FROM ProductStatusProfile WITH(NOLOCK) ORDER BY bitmapOrder

*/
--Insert ProductSettingType
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
SELECT 22,'Win Loss Limit','WinLossLimit'
WHERE NOT EXISTS( SELECT 1 FROM ProductSettingType WITH(NOLOCK) WHERE SettingType = 22)