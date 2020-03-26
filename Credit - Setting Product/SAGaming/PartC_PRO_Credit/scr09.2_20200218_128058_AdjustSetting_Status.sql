/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Adjust Setting for SA Gaming [Redmine: #128128]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
AS
BEGIN
	SET NOCOUNT ON
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN
	
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
		AND s.islicensee = 0
		AND ci.Site<>'CN88'
		AND ci.currency NOT IN (45,13,75,76,77,41) --Won (KRW), RMB, PTU, PS, PTH, CHF

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'
	DECLARE @ProductID TINYINT = 41, @SportType INT = 244
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #CustList_ST (custid INT, bitmapIsDisabledSA BIT, bitmapIsDisabledAB BIT, isHiddenSA BIT)

	CREATE TABLE #TmpProductSettingDetail
	(
		SettingType SMALLINT,
		SportType SMALLINT,
		BetType SMALLINT,
		IsLive BIT,
		ProductID TINYINT,
		MaxPT TINYINT,
		MaxDiscount DECIMAL (9, 8),
		IsSync BIT,
		IsHidden BIT,
		IsDisabled BIT,
		SettingLevel TINYINT,
		DisplayOrder TINYINT,
		SettingStatus TINYINT,
		IntervalValue DECIMAL (19, 8) 
	)
	
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,211,2401,0,41,NULL,NULL,1,0,0,2,1,0,0.0005)

	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,244,3001,0,41,NULL,NULL,1,0,0,2,1,0,0.0005)

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
	FROM #TmpProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @SportType AND SettingType IN (13) -- Status
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 20

	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 13


	INSERT INTO #CustList_ST (custid, bitmapIsDisabledSA, bitmapIsDisabledAB, isHiddenSA)
	SELECT CS.CustID, isDisabledSA.value, isDisabledAB.value, isHiddenSA.value
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabledAB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, @BitmapOrder) as isDisabledSA
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsHidden, @BitmapOrder) as isHiddenSA
	WHERE (isDisabledSA.value <> isDisabledAB.value	OR isHiddenSA.value != 0)
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
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_ST CI WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabled
	END
	DROP TABLE #DestinationSportBetType
	DROP TABLE #CustList_ST
	DROP TABLE #supers
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustomerInfo_09 

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'