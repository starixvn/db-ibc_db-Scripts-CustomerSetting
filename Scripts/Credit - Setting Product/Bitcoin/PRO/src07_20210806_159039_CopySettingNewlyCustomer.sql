/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Copy setting for newly created customer of Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 7 Copy setting for newly created customer
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  


	DECLARE @MaxCustID INT
	SELECT @MaxCustID = xxx
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
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
		AND ci.currency IN ( 2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,42,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95)
		--RM,US$,HK$,EURO,DON,AUD,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,CHF,PE,THB,Won,DDD,CAN,INH,DKK,SEK,NOK,CZK,RON,UT,HKK,MMK,KHR,CY,USD

	DECLARE @ProductID TINYINT = 69, @Sporttype INT = 175  ,@Bettype INT  = 7901 
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT,MaxPT SMALLMONEY, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType,MaxPT, IsLive, SettingType, IsFinished)
	SELECT	1, 3, SportType, BetType,MaxPT, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (1) --  PT
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	1, 1, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (3) --  Commission
	UNION ALL
	SELECT	SportType, BetType, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (16,6) -- BetSetting, Win Loss Limit
	
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		recommend INT, 
		mrecommend INT, 
		srecommend INT,
		Currency INT
	)
	CREATE TABLE #SMAList_CommSetting (custid INT PRIMARY KEY CLUSTERED, Discount DECIMAL(9,8))
	
	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID,Currency,srecommend,mrecommend,recommend)
	SELECT custid,Currency,srecommend,mrecommend,recommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @MaxCustID
	
	INSERT INTO #SMATemp (CustID,Currency, roleid)
	SELECT custid,Currency, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @MaxCustID 
	
	CREATE TABLE #PTTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			SMALLMONEY,
		[MasterPT]			SMALLMONEY,
		[AgentPT]			SMALLMONEY,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		SMALLMONEY,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		SMALLMONEY,
		[MinPT]				SMALLMONEY,
		[MaxPT]				SMALLMONEY,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
	)
	CREATE TABLE #PTTempMemBatch
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			SMALLMONEY,
		[MasterPT]			SMALLMONEY,
		[AgentPT]			SMALLMONEY,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		SMALLMONEY,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		SMALLMONEY,
		[MinPT]				SMALLMONEY,
		[MaxPT]				SMALLMONEY,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
	)

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch)
	SELECT 2 AS Currency ,10 AS MinBet,3000 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch UNION  ALL --RM---MYR
	SELECT 3 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --US$---USD
	SELECT 5 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --HK$---HKD
	SELECT 6 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS SuperMinBet,1000 AS SuperMaxBet,6000  AS SuperMaxPerMatch UNION  ALL --EURO---EUR
	SELECT 7 AS Currency ,50000 AS MinBet,15000000 AS MaxBet,75000000 AS MaxPerMatch,50000 AS SuperMinBet,25000000 AS SuperMaxBet,150000000  AS SuperMaxPerMatch UNION  ALL --DON---VND
	SELECT 9 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --AUD---AUD
	SELECT 12 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS SuperMinBet,1000 AS SuperMaxBet,6000  AS SuperMaxPerMatch UNION  ALL --GBP---GBP
	SELECT 13 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --RMB---CNY
	SELECT 15 AS Currency ,35 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,35 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch UNION  ALL --IN---IDR
	SELECT 16 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --Yen---USD
	SELECT 22 AS Currency ,35 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,35 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch UNION  ALL --IND---IDR
	SELECT 33 AS Currency ,35 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,35 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch UNION  ALL --IDD---IDR
	SELECT 34 AS Currency ,35 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,35 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch UNION  ALL --IDR---IDR
	SELECT 35 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --$US---USD
	SELECT 41 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS SuperMinBet,1000 AS SuperMaxBet,6000  AS SuperMaxPerMatch UNION  ALL --CHF---CHF
	SELECT 42 AS Currency ,120 AS MinBet,35000 AS MaxBet,180000 AS MaxPerMatch,120 AS SuperMinBet,60000 AS SuperMaxBet,360000  AS SuperMaxPerMatch UNION  ALL --PE---PHP
	SELECT 43 AS Currency ,100 AS MinBet,25000 AS MaxBet,120000 AS MaxPerMatch,100 AS SuperMinBet,40000 AS SuperMaxBet,240000  AS SuperMaxPerMatch UNION  ALL --THB---THB
	SELECT 45 AS Currency ,2500 AS MinBet,800000 AS MaxBet,4500000 AS MaxPerMatch,2500 AS SuperMinBet,1500000 AS SuperMaxBet,9000000  AS SuperMaxPerMatch UNION  ALL --Won---KRW
	SELECT 47 AS Currency ,35 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,35 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch UNION  ALL --DDD---IDR
	SELECT 50 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --CAN---CAD
	SELECT 51 AS Currency ,50 AS MinBet,12500 AS MaxBet,75000 AS MaxPerMatch,50 AS SuperMinBet,25000 AS SuperMaxBet,150000  AS SuperMaxPerMatch UNION  ALL --INH---VND
	SELECT 52 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --DKK---DKK
	SELECT 53 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --SEK---SEK
	SELECT 54 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --NOK---NOK
	SELECT 57 AS Currency ,50 AS MinBet,12500 AS MaxBet,75000 AS MaxPerMatch,50 AS SuperMinBet,25000 AS SuperMaxBet,150000  AS SuperMaxPerMatch UNION  ALL --CZK---CZK
	SELECT 58 AS Currency ,10 AS MinBet,3000 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch UNION  ALL --RON---RON
	SELECT 64 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --UT---USD
	SELECT 67 AS Currency ,10 AS MinBet,3000 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch UNION  ALL --HKK---HKD
	SELECT 69 AS Currency ,4 AS MinBet,900 AS MaxBet,5400 AS MaxPerMatch,4 AS SuperMinBet,1800 AS SuperMaxBet,10800  AS SuperMaxPerMatch UNION  ALL --MMK---MMK
	SELECT 71 AS Currency ,10 AS MinBet,3000 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch UNION  ALL --KHR---KHR
	SELECT 81 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch UNION  ALL --CY---CNY
	SELECT 95 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch		 --USD---USD
		
	INSERT INTO #PTTemp(
		CustID				,
		roleid				,
		[SportType]			,
		[BetType]			,
		[IsLive]			,
		[SuperPT]			,
		[MasterPT]			,
		[AgentPT]			,
		[IsAutoMasterPT]	,
		[AutoMasterPT]		,
		[IsAutoSuperPT]		,
		[AutoSuperPT]		,
		[MinPT]				,
		[MaxPT]				
		)

	SELECT 
		cs.custid,ci.roleid, dest.tsporttype, dest.tbettype, dest.IsLive
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100
		,cs.isautompositiontaking
		,cs.autompositiontaking *100
		,cs.isautopositiontaking 
		,cs.autopositiontaking  *100
		,co.minpositiontaking  *100
		,100 AS MaxPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
		LEFT JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
		INNER JOIN  #DestinationSportBetType dest ON dest.fSportType=cs.sporttype AND dest.fBetType=cs.bettype AND dest.SettingType = 1
	WHERE ci.srecommend  IN (SELECT custid FROM #supers) AND ci.custid > @maxcustid AND ci.Enabled=1 

	
	--------------------------------------PT Setting-------------------------------------------------	
	--AGENT LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	CustID 
		   ,SportType 
		   ,BetType 
		   ,IsLive 
		   ,SuperPT 
		   ,MasterPT 
		   ,AgentPT 
		   ,IsAutoMasterPT 
		   ,AutoMasterPT 
		   ,IsAutoSuperPT 
		   ,AutoSuperPT 
		   ,MinPT 
		   ,MaxPT )
	SELECT 
			CustID 
		   ,SportType 
		   ,BetType 
		   ,IsLive 
		   ,SuperPT 
		   ,MasterPT 
		   ,AgentPT 
		   ,IsAutoMasterPT 
		   ,AutoMasterPT 
		   ,IsAutoSuperPT 
		   ,AutoSuperPT 
		   ,MinPT 
		   ,MaxPT 
	FROM #PTTemp t
	WHERE t.roleid IN(2,3,4) 
	--MEMBER LEVEL

	WHILE EXISTS(SELECT 1 FROM #PTTemp WHERE roleid=1)
	BEGIN
		DELETE TOP (3000) #PTTemp OUTPUT DELETED.* INTO #PTTempMemBatch WHERE roleid=1  

		IF @@ROWCOUNT=0
			BREAK		

		INSERT INTO dbo.CustPTSetting3rd_Member
			(	custid 
			  ,	sporttype 
			  ,	bettype 
			  ,	islive 
			  ,	superPT 
			  ,	masterPT 
			  ,	agentPT 
			  ,	IsAutoMasterPT 
			  ,	AutoMasterPT 
			  ,	IsAutoSuperPT 
			  ,	AutoSuperPT )
		SELECT 
				CustID 
			   ,SportType 
			   ,BetType 
			   ,IsLive 
			   ,SuperPT 
			   ,MasterPT 
			   ,AgentPT 
			   ,IsAutoMasterPT 
			   ,AutoMasterPT 
			   ,IsAutoSuperPT 
			   ,AutoSuperPT 		
		FROM #PTTempMemBatch t
			WHERE t.roleid =1

		TRUNCATE TABLE #PTTempMemBatch
	END

--------------------------------------Commission Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 3

	--Agent Level --new Agent
	INSERT INTO #SMAList_CommSetting(CustID , Discount)
	SELECT ci.custid, (SELECT MAX(Discount) FROM (VALUES  (groupa), (groupb), (groupc),(groupd)) AS t(Discount))  AS Discount 
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON cs.CustID = ci.custid
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype,ci.Discount 
	FROM #SMAList_CommSetting ci
		CROSS APPLY #DestinationSportBetType dest
	WHERE SettingType = 3
		 
	--Member Level
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.playerdiscount, a.Discount, m.Discount, s.Discount
	FROM dbo.custSetting cs WITH(NOLOCK)
		CROSS APPLY #DestinationSportBetType dest
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN CustDiscount3rd_Agent s WITH(NOLOCK) ON s.CustID = ci.srecommend AND s.SportType = dest.tSportType AND s.BetType = dest.tbettype
		INNER JOIN CustDiscount3rd_Agent m WITH(NOLOCK) ON m.CustID = ci.mrecommend AND m.SportType = dest.tSportType AND m.BetType = dest.tbettype
		INNER JOIN CustDiscount3rd_Agent a WITH(NOLOCK) ON a.CustID = ci.recommend  AND a.SportType = dest.tSportType AND a.BetType = dest.tbettype
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 3

--------------------------------------Bet Setting-------------------------------------------------
	--SMA level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT ci.CustID, dest.tSportType, dest.tBetType, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMinBet ELSE ps.MinBet END, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMaxBet ELSE ps.MaxBet END, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMaxPerMatch ELSE ps.MaxPerMatch END	
	FROM #SMATemp ci  
	CROSS APPLY #DestinationSportBetType dest
	INNER JOIN #ProductBetSetting ps  ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype AND ps.Currency = ci.Currency
	WHERE dest.SettingType = 16
	
	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT ci.CustID, dest.tSportType, dest.tBetType, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
	FROM #MemberTemp ci  
	CROSS APPLY #DestinationSportBetType dest
	INNER JOIN #ProductBetSetting ps  ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype AND ps.Currency =  ci.Currency
	WHERE dest.SettingType = 16

--------------------------------------Win Loss Limit-------------------------------------------------
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0 AS MaxWinLimit, cs.DefaultLossLimit AS MaxLossLimit, 1 AS IsAutoReset
	FROM #SMATemp ci
		INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON  cs.ExchangeId =  ci.Currency  AND cs.ProductId = @ProductID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 

	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0 AS MaxWinLimit, cs.DefaultLossLimit AS MaxLossLimit, 1 AS IsAutoReset
	FROM #MemberTemp ci 
		INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON  cs.ExchangeId =  ci.Currency  AND cs.ProductId = @ProductID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 
/*******************************CUST PRODUCTSTATUS TABLE*******************************/
	DECLARE @BitmapOrder TINYINT = 35
	SELECT custid
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend IN (SELECT custid FROM #supers) 
		AND ci.Enabled = 1
		AND ci.custid > @MaxCustID

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	
	DROP TABLE #PTTemp
	DROP TABLE #PTTempMemBatch
	DROP TABLE #ProductBetSetting
	DROP TABLE #SMAList_CommSetting
	DROP TABLE #CustList
	
	PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
