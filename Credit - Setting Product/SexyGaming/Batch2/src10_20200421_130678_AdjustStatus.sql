/*
	Created: 20200421@Tiara
	Date: 20200421
	Task: Adjust Status for Sexy Gaming - Batch 2 [Redmine: #130678]
	DB: DBCUST/CustDB
*/ 

	
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.Site<>'CN88'
		AND s.islicensee = 0
		AND ci.currency IN (6,78,69,13,66,81,45) --Euro, EUR; MMK, RMB, CY, YUN, WON
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = 41 AND SportType = 241 AND SettingType = 13

--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 22
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 13

	CREATE TABLE #CustList_ST (custid INT, IsDisabledAB BIT, IsFinished BIT default (0))
	INSERT INTO #CustList_ST (custid, IsDisabledAB)
	SELECT CS.CustID, isDisabledAB.value
	FROM DBNOTI.CustDB_AdjustCS.dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.CustID= cs2.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabledAB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsDisabled, @BitmapOrder) as isDisabledSG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsHidden, @BitmapOrder) as isHiddenSG
	WHERE (isDisabledSG.value <> isDisabledAB.value	OR isHiddenSG.value != 0)
		AND ci.Enabled = 1


	WHILE (1 = 1)
	BEGIN	
		UPDATE TOP (1) #DestinationSportBetType
		SET IsFinished = 1
			,@fBetType = fBetType	
			,@fSportType = fSportType
			,@tBetType = tBetType
			,@tSportType = tSportType
			,@IsLive = IsLive
		WHERE IsFinished = 0
			AND SettingType = 13
		IF @@ROWCOUNT = 0 BREAK

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledAB)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList_ST CI WITH(NOLOCK) ON cs.CustID = ci.CustID
	
	END
	DROP TABLE #DestinationSportBetType
	DROP TABLE #CustList_ST
	DROP TABLE #supers
