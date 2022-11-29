/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: add some setting of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DELETE p
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE SportType IN(9908,9909)

DELETE p
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE sporttype = 220 and bettype = 1024  AND settingtype = 13

--> Config new for ProductSettingDetail
	--VS
	--> clone setting to dummy sport
	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
	SELECT SettingType,SportType = 9908,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
			,DisplayOrder,SettingStatus = 2,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
			,ProductSettingID = CASE WHEN SettingType = 1  THEN 228
									WHEN SettingType = 2  THEN 229
									WHEN SettingType = 6  THEN 230
									WHEN SettingType = 13  THEN 231
								END
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 5 
		AND SportType = 180 

	-----Lottery
	--> Clone Winloss limit to new dummy sport
	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
	SELECT SettingType = 22,SportType = 9909,BetType = 3700,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
			,DisplayOrder,SettingStatus = 2,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
			,ProductSettingID = 232
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 44 
		AND SportType = 169 
		AND settingtype = 6

	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
	SELECT SettingType,SportType = 220, BetType = 1024,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
			,DisplayOrder,SettingStatus = 2 ,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
			,ProductSettingID = 233
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