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
	SELECT SettingType = 6,SportType = 9909,BetType = 3700,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel = 1
			,DisplayOrder,SettingStatus = 2,IntervalValue,RealProductId = 44,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
			,ProductSettingID = 232
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE productid = 44 
		AND SportType = 169 
		AND settingtype = 6

	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
						,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder,ProductSettingID)
	SELECT SettingType,SportType, BetType = 1024,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
			,DisplayOrder,SettingStatus = 2 ,IntervalValue,RealProductId,MaxChoice,Parent_ProductSettingID,Child_DisplayOrder
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
---> Insert update SportBettypeSettingMatrix
	INSERT INTO SportBettypeSettingMatrix (
		SportType
		,BetType
		,isLicensee
		,isLive
		,Site
		,isActive
		,SportTypeRefPT
		,BetTypeRefPT
		,isLivePT
		,TablePT
		,StructureVerPT
		,SportTypeRefComm
		,BetTypeRefComm
		,TableComm
		,StructureVerComm
		,SportTypeRefBetSetting
		,BetTypeRefBetSetting
		,TableBetSetting
		,StructureVerBetSetting
		,IsLiveComm
		,IsLiveBetSetting
		,TableBettrans
		,SporttypeRefWinlossLimit
		,BettypeRefWinlossLimit
	)
	SELECT SportType = 169
		,BetType = 3611
		,isLicensee
		,isLive
		,Site
		,isActive
		,SportTypeRefPT
		,BetTypeRefPT
		,isLivePT
		,TablePT
		,StructureVerPT
		,SportTypeRefComm
		,BetTypeRefComm
		,TableComm
		,StructureVerComm
		,SportTypeRefBetSetting
		,BetTypeRefBetSetting
		,TableBetSetting
		,StructureVerBetSetting
		,IsLiveComm
		,IsLiveBetSetting
		,TableBettrans
		,SporttypeRefWinlossLimit
		,BettypeRefWinlossLimit
	FROM SportBettypeSettingMatrix WITH(NOLOCK)
	WHERE SportType  = 169 
		AND bettype = 3612
		AND isLicensee = 0
		AND NOT EXISTS( SELECT 1 
						FROM SportBettypeSettingMatrix WITH(NOLOCK) 
						WHERE SportType  = 169 
						AND bettype = 3611 
						AND isLicensee = 0
					)
	UNION ALL
	SELECT SportType = 220
		,BetType = 1021
		,isLicensee
		,isLive
		,Site
		,isActive
		,SportTypeRefPT
		,BetTypeRefPT
		,isLivePT
		,TablePT
		,StructureVerPT
		,SportTypeRefComm
		,BetTypeRefComm
		,TableComm
		,StructureVerComm
		,SportTypeRefBetSetting
		,BetTypeRefBetSetting
		,TableBetSetting
		,StructureVerBetSetting
		,IsLiveComm
		,IsLiveBetSetting
		,TableBettrans
		,SporttypeRefWinlossLimit
		,BettypeRefWinlossLimit
	FROM SportBettypeSettingMatrix WITH(NOLOCK)
	WHERE SportType  = 220 
		AND bettype = 1031
		AND isLicensee = 0
		AND NOT EXISTS( SELECT 1 
						FROM SportBettypeSettingMatrix WITH(NOLOCK) 
						WHERE SportType  = 220 
						AND bettype = 1021 
						AND isLicensee = 0
					)

	--> Update ref winloss limit setting
	UPDATE t 
	SET t.SporttypeRefWinlossLimit = 9909
		, t.BettypeRefWinlossLimit = 3700
		, t.RealProductID = CASE WHEN t.SportType = 169 THEN 63
								WHEN t.SportType = 220 THEN 28
								WHEN t.SportType = 222 THEN 40
								WHEN t.SportType = 224 THEN 50
							END
	FROM SportBettypeSettingMatrix t WITH(ROWLOCK) 
	WHERE SportType IN (169,220,222,224) 
		AND bettype in(3611,1021,4901,5500) 
		AND isLicensee = 0

	/*
	SELECT * 
	FROM SportBettypeSettingMatrix WITH(NOLOCK) 
	WHERE SportType IN (169,220,222,224) 
		AND bettype in(3611,1021,4901,5500) 
		AND isLicensee = 0
	*/