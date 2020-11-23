/*
	Created: Tina
	Date: 20201117
	Task: Enable Status for Big Gaming Deposit new customer [Redmine: 142458]
	DB: DBCUST/CustDB
*/

	DECLARE @maxcustid INT
	DECLARE @AgentID	INT,@CustID	INT,@SuperPT SMALLINT = 88

	DECLARE @ProductSettingID_PT INT = 84, @ProductSettingID_ProductStatus INT = 82, @ProductSettingID_BetLimit INT = 83

	DECLARE @SportType INT = 239, @BetType INT=3501
	
	SELECT @maxcustid = xxx
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
		AND ci.currency IN (13,-- CNY(RMB)
							66,-- CNY(YUN)
							15,-- IDR(IN)
							51,-- VND(INH) 
							7,-- VND(DON)
							2,-- MYR(RM)
							4,-- THB(TB)
							70,-- MMK(MMK)
							94,-- MMK(MK)   
							32,-- JPY(JPY)
							3,-- USD(US$)
							96,-- USD(USDT)
							6,-- EUR(EURO)
							12,-- GBP(GBP)
							61,-- INR(INR)
							55, -- RUB(RUB)
							20, --UUS(UUS)
							72 --YNG(YNG)
							)
	ORDER BY CI.custid 

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')


	--------------------------------------PT Setting-------------------------------------------------	
		INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,@SuperPT
		   ,@SuperPT
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=4
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,@SuperPT
		   ,0	
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=3
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			ci.CustID
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.CustID=m.CustID
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND m.IsGroupedPT=0
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT ci.CustID,1
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=ci.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=ci.CustID)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,@ProductSettingID_PT
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=@ProductSettingID_PT)

	--------------------------------------Bet Setting-------------------------------------------------
		CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		SiteID INT
	)

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		SiteID INT

	)

	CREATE TABLE #tmpSTListSMA (BettypeID INT, StakeLevelList VARCHAR(500), SiteID INT)
	CREATE TABLE #tmpSTListMember (BettypeID INT, StakeLevelList VARCHAR(500), SiteID INT)
		
	INSERT INTO #SMATemp (CustID,Currency, SiteID)
	SELECT CI.custid, CI.currency, S.siteid 
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER  JOIN SITE S WITH (NOLOCK) ON S.site = C.site
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
			AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp (CustID,Currency, SiteID)
	SELECT CI.custid, CI.currency, S.siteid 
	FROM custInfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.recommend
		INNER  JOIN SITE S WITH (NOLOCK) ON S.site = C.site
	WHERE CI.srecommend IN(SELECT CustID FROM #supers) AND CI.roleid = 1  AND Enabled = 1 AND CI.custid > @maxcustid	
		AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList, SiteID)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) AS StakeLevelList, SMA.SiteID
	FROM #SMATemp SMA CROSS JOIN Dep_StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM Dep_StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID = ST.GameTypeID AND S.ExchangeId = SMA.Currency AND S.SiteID = SMA.SiteID
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @BetType
	ORDER BY ST.GameTypeID

	INSERT INTO #tmpSTListMember(BettypeID, StakelevelList, SiteID)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) AS StakeLevelList, M.SiteID
	FROM #MemberTemp M CROSS JOIN Dep_StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM Dep_StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID = ST.GameTypeID AND S.ExchangeId = M.Currency AND S.SiteID = M.SiteID
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @BetType
	ORDER BY ST.GameTypeID

	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT DISTINCT t.custid,@Sporttype, TB.BettypeID, TB.StakeLevelList
	FROM Dep_StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
		CROSS JOIN  #SMATemp t
	WHERE S.ExchangeID = t.Currency  AND S.SiteID = T.SiteID

	--Member Level
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID],[SportType],[BetType],[StakeLevelList],LastUpdated) 
	SELECT DISTINCT t.custid,@Sporttype,TB.BettypeID, CAST(StakeLevelID AS varchar(50)),GETDATE()
	FROM (SELECT StakeLevelID,GameTypeID,ExchangeId,SiteID,ROW_NUMBER() OVER(PARTITION BY ExchangeId,SiteID ORDER BY MaxStake ASC) AS STT 
			  FROM Dep_StakeLevel WITH(NOLOCK)
			  WHERE GameTypeID = @Bettype) S  INNER JOIN #tmpSTListMember TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID 
		CROSS JOIN  #MemberTemp t
	WHERE S.ExchangeId = t.Currency AND S.SiteID = T.SiteID	 AND S.STT = 1
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,@ProductSettingID_BetLimit
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=@ProductSettingID_BetLimit)

	--------------------------------------Status-------------------------------------------------
	DECLARE @BitOrder INT
	SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	t.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #SMATemp t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	t.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #MemberTemp t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,@ProductSettingID_ProductStatus
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=@ProductSettingID_ProductStatus)

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #tmpSTListSMA
	DROP TABLE #tmpSTListMember

