/*
	Created: Winnie
	Task: Copy PT & Bet setting for Card Club new cust  RedmineID: #115322
	DB: DBCUST/CustDB
	Date: 20190626
*/ 

	DECLARE @maxcustid INT
	DECLARE @AgentID	INT,@CustID	INT,@SuperPT SMALLINT = 93
	
	SELECT @maxcustid = xxx
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1		
		AND cs.site IN('11bet','12Bet','368Cash','3star88','88Macao','9bet','9Club','9wickets','Ae88','AG','Aoncash','asiabet88','Athena000','Axiawin','BE7','Bolanation','Boma365','Brown888','Debet','DEWA','Fabet',
				'FB88','GamingSoft','Happy1668','Heaven','Hengcai88','HONBET','Hong88','HonorW','iBET','IONclub','ISC888','ITCbet','Kraton','Kudatogel','Liga','Lucky88','Luckywin88','M8bola','Macaubet',
				'Mayfair','NBCbet','Newhonbet','OLE777','One88','Q8bola','Salon365',
				'Senibet','Sin88','Taipanbet','TLC','UN168','Unobet','Uwoniwin','Vwin','WeBet168','webet88','Winn69','XTD3','Zbet','Zzun88')

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1		
		AND cs.site IN('spondemo')
		AND ci.currency<>20

	DECLARE @SportType INT = 165, @BetType INT=1901
	
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

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT ci.CustID,1
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=ci.CustID)
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,27
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=27)
	--------------------------------------Bet Setting-------------------------------------------------	
	
		CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT
	)

		
	INSERT INTO #MemberTemp (CustID,Currency)
	SELECT custid,currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	

	
	INSERT INTO #SMATemp (CustID,Currency)
	SELECT custid,currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 


	----------------------------------------Betlimit Setting-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID]
											,[SportType]
											,[BetType]
											,[StakeLevelList]) 
	SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50))
	FROM Dep_StakeLevel WITH(NOLOCK) 
	CROSS JOIN  #SMATemp t
	WHERE GameGroupID=10 AND GameTypeID=1901 AND ExchangeId=t.Currency
	--Member Level
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]
										,LastUpdated) 
	SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50)),GETDATE()
	FROM Dep_StakeLevel WITH(NOLOCK) 
	CROSS JOIN  #MemberTemp t
	WHERE GameGroupID=10 AND GameTypeID=1901 AND ExchangeId=t.Currency

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,28
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=28)

	--Status	
	DECLARE @BitOrder INT
	SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,0)
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #SMATemp CI WITH (NOLOCK) ON cs.CustID = ci.CustID

	UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,0)
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #MemberTemp CI WITH (NOLOCK) ON cs.CustID = ci.CustID

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,26
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=26)

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #supers