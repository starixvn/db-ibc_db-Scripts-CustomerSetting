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
----> Insert ProductStatusSiteCurrency
	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK) 
	WHERE sporttype = 9908 AND BetType = 1201

	INSERT INTO ProductStatusSiteCurrency(SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
	SELECT SportType = 9908 ,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced 
	FROM ProductStatusSiteCurrency WITH(NOLOCK) 
	WHERE sporttype = 180 and BetType = 1201

	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK)  
	WHERE sporttype = 220 and BetType = 1024

	INSERT INTO ProductStatusSiteCurrency(SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
	SELECT SportType,BetType = 1024,Currency,SiteID,IsHidden,IsDisabled,HasSynced 
	FROM ProductStatusSiteCurrency WITH(NOLOCK)  
	WHERE sporttype = 220 and BetType = 1021

---->Insert ProductSettingType
	INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
	SELECT 22,'Win Loss Limit','WinLossLimit'
	WHERE NOT EXISTS( SELECT 1 FROM ProductSettingType WITH(NOLOCK) WHERE SettingType = 22)

--> Insert ProductBetSetting
	DELETE p
	FROM ProductBetSetting p WITH(NOLOCK) 
	WHERE Sporttype = 9908 AND bettype = 1201

	INSERT INTO ProductBetSetting(Sporttype,Bettype,Currency,MinBet,IsDep,MaxBet
		,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)
	SELECT Sporttype = 9908,Bettype,Currency,MinBet,IsDep,MaxBet
		,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch
	FROM ProductBetSetting p WITH(NOLOCK) 
	WHERE Sporttype = 180 AND bettype = 1201

--> INSERT ProductSettingSystemDisplay ( Hide on Ext NAP)
	INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
	SELECT 5,44,22,3 UNION ALL
	SELECT 9,44,22,3 