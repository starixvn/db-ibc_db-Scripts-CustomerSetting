/*
	Created: 20200423@Tiara
	Task:  Adjust status for GT Casino [Redmine: #130689]
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
		AND ci.Site<>'CN88'
		AND s.islicensee = 0
		AND ci.currency IN (16,64,35,3,74,12,6,78, 69,2,67,5,13,81,66,4,43,45,72) --Yen, UT, $US, US$, TH, GBP, Euro, EUR, MMK, RM, HKK, HK$, RMB, CY, YUN, TB, THB, Won,YNG

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'
	DECLARE @ProductID TINYINT = 41, @SportType INT = 242
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #CustList_ST (custid INT, bitmapIsDisabledGT BIT, bitmapIsDisabledSG BIT, isHiddenGT BIT)

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	243, 3101, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @SportType AND SettingType IN (13) -- Status
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 25

	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 13


	INSERT INTO #CustList_ST (custid, bitmapIsDisabledGT, bitmapIsDisabledSG, isHiddenGT)
	SELECT CS.CustID, isDisabledGT.value, isDisabledSG.value, isHiddenGT.value
	FROM DBNOTI.CustDB_AdjustCS.dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabledSG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, @BitmapOrder) as isDisabledGT
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsHidden, @BitmapOrder) as isHiddenGT
	WHERE (isDisabledGT.value <> isDisabledSG.value	OR isHiddenGT.value != 0)
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
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabled
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