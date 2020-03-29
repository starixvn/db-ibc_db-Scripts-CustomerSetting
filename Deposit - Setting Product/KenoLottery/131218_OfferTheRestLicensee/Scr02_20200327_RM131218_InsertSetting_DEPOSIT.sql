/*
	Created: Elodie
	Date: 20200327
	Task: Insert setting for Lottery - Real Currency
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	,@PT smallmoney
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN

	DECLARE @currency INT, @siteId INT

	SELECT @currency = ci.currency, @siteId = s.siteid 
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s ON s.site = ci.site
	WHERE ci.custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND username LIKE '%Acc%'
		AND custid<=@max_custid 

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #SMATemp (CustID,roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (220, 1021)

	--------------------------------------------Product Status------------------------------------------------
	DECLARE @bitmapOrder INT
	 
	SELECT @bitmapOrder = bitmapOrder 
	FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
		INNER JOIN @SportBetType t ON t.Sporttype = m.SportType AND t.Bettype = m.BetType

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid
	
	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
		SELECT	t.custid
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
		FROM #TempProductStatus t
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

		WAITFOR DELAY '00:00:00.100'
	END

	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 28
							AND dp.SettingType IN (4,1,2) -- Product Status, PT, BetSetting
						) st
	WHERE temp.roleid = 4

	------------------------------------PT Setting-------------------------------------------------	
	--SMA LEVEL
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
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = CASE WHEN d.roleid = 4 THEN @PT ELSE 0 END
			,[MasterPT] = CASE WHEN d.roleid IN (4,3) THEN @PT ELSE 0 END
			,[AgentPT] = CASE WHEN d.roleid IN (4,2) THEN @PT ELSE 0 END
	FROM #SMATemp d
		CROSS APPLY @SportBetType t

	----MEMBER LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
		)
	SELECT 
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = 0
			,[MasterPT] = 0
			,[AgentPT] = @PT
	FROM #MemberTemp d
		CROSS APPLY @SportBetType t
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON d.CustID = m.CustID
	WHERE m.IsGroupedPT = 0

	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT d.[CustID]
		,t.[SportType]
		,t.[BetType]
		,[IsLive] = 0
		,[SuperPT] = 0
		,[MasterPT] = 0
		,[AgentPT] = @PT
	FROM #SMATemp d
		CROSS APPLY @SportBetType t	
	WHERE roleid = 2

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #MemberTemp t WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode d WITH(NOLOCK) ON  d.CustID = t.CustID
	WHERE d.CustID IS NULL


	-------------------------------------------------BetSetting----------------------------------------------------------------
	DECLARE @SportBettype_BetSetting TABLE (SportType SMALLINT, BetType SMALLINT,Code VARCHAR(3), MinBet MONEY,MaxBet MONEY, MaxPerMatch MONEY)
	INSERT INTO @SportBettype_BetSetting(SportType, BetType, Code, MinBet, MaxBet, MaxPerMatch)
	SELECT 220, 1021, 'UUS', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'GBP', 1, 2000, 10000 UNION ALL
	SELECT 220, 1021, 'EUR', 1, 2500, 12500 UNION ALL
	SELECT 220, 1021, 'CHF', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'USD', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'AUD', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'BND', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'CAD', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'MKK', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'NZD', 2, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'SGD', 2, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'PEN', 5, 9000, 45000 UNION ALL
	SELECT 220, 1021, 'MYR', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'PLN', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'RON', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'BRL', 5, 11000, 55000 UNION ALL
	SELECT 220, 1021, 'KHR', 5, 12000, 60000 UNION ALL
	SELECT 220, 1021, 'TRY', 10, 15000, 75000 UNION ALL
	SELECT 220, 1021, 'GHS', 10, 16000, 80000 UNION ALL
	SELECT 220, 1021, 'CNY', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'DKK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'HKD', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'NOK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'SEK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'ZAR', 20, 35000, 175000 UNION ALL
	SELECT 220, 1021, 'IDR', 15, 40000, 200000 UNION ALL
	SELECT 220, 1021, 'MXN', 20, 50000, 250000 UNION ALL
	SELECT 220, 1021, 'CZK', 20, 65000, 325000 UNION ALL
	SELECT 220, 1021, 'INH', 20, 65000, 325000 UNION ALL
	SELECT 220, 1021, 'THB', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'TWD', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'UYU', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'ARS', 50, 125000, 625000 UNION ALL
	SELECT 220, 1021, 'PHP', 50, 150000, 750000 UNION ALL
	SELECT 220, 1021, 'INR', 50, 200000, 1000000 UNION ALL
	SELECT 220, 1021, 'RUB', 50, 200000, 1000000 UNION ALL
	SELECT 220, 1021, 'KES', 100, 300000, 1500000 UNION ALL
	SELECT 220, 1021, 'JPY', 100, 330000, 1650000 UNION ALL
	SELECT 220, 1021, 'CLP', 500, 2000000, 10000000 UNION ALL
	SELECT 220, 1021, 'KRW', 1000, 3000000, 15000000 UNION ALL
	SELECT 220, 1021, 'COP', 1000, 9000000, 45000000 UNION ALL
	SELECT 220, 1021, 'VES', 1000, 10000000, 50000000 UNION ALL
	SELECT 220, 1021, 'VND', 20000, 65000000, 325000000 UNION ALL
	SELECT 220, 1021, 'PYG', 1000, 15000000, 75000000
	

	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxBet
	FROM #SMATemp t
		CROSS APPLY @SportBettype_BetSetting b 
		INNER JOIN dbo.exchange e WITH (NOLOCK) ON b.Code = CASE WHEN e.exchangeid = 20 THEN 'UUS' ELSE e.Code END
	WHERE e.exchangeid = @currency

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxBet
	FROM #MemberTemp t
		CROSS APPLY @SportBettype_BetSetting b
		INNER JOIN dbo.exchange e WITH (NOLOCK) ON b.Code = CASE WHEN e.exchangeid = 20 THEN 'UUS' ELSE e.Code END
	WHERE e.exchangeid = @currency

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0), PT SMALLMONEY)

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON ci.currency = e.exchangeid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.custid <= @max_custid
	AND (e.Code IN ('GBP','EUR','CHF','USD','AUD','BND','CAD','MKK','NZD','SGD','PEN','MYR','PLN','RON','BRL','KHR','TRY','GHS','CNY',
				'DKK','HKD','NOK','SEK','ZAR','IDR','MXN','CZK','INH','THB','TWD','UYU','ARS','PHP','INR','RUB','KES','JPY',
				'CLP','KRW','COP','VES','VND','PYG') OR e.exchangeid = 20)
	AND s.site IN ('12B','18Luck','24TECH','365online','368Cash','3star88','568Win','633esports','818Bet','88Macao','9Club','9Wsports',
				'A1game','Abcasino','AEUG','afb99','AG','alog','ALPHA88','AMG','AnvoFH','Aplus','Apollo','asiabet88','Asian88',
				'B24VN','BBIN2','BBIN3','BBIN4','BetDeal','BETSUN','BigGaming','Bobbet','Bobo88','Bodog','BOG22','BoinGroup',
				'Boma365','Bonanza88','BOSSB','Boying','BPLE','BWGaming','Cali','Calibet','Callmeboss','CGame','CGame4','Champion',
				'dabo88','Dachen','Dade','Datang','Datang001','Dawoo','DBP','DEWA','DF88','DingTai','DTGW','e8casino','ECLBET',
				'ENT22','ENTAPLAY','erhaozhan','FB88','Five88','FLC','G2Win','Gameroom','GamingSoft','Gampag','Gaobet','gbkj',
				'GESAB','GGBOOK','GGBOOKES','GMASTER','GPgaming88','GPIGAME','haifa','Happy1668','Happy8','HBO999','HCVIP',
				'Heaven','Hecbet','Heji888','HeleThai','Hengcai88','hjccasino','HJTK','HL8','HONBET','HonorW','HOT88','HuangMa',
				'IBG','IBO','ID88','ig128','IGPTech','INSERTGAME','ISC888','IvoryBet','JGQP8','JIBET','JIDU','Jinyazhou',
				'JZFortune','K8VN','KeenOcean','KhmerG','Kraton','Kudatogel','KUTECH','Leng4D','Liga','LLGAME','Man1878',
				'mansion88','MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Monaco','Mopgaming','MRCATSB','MTech',
				'mtegames','Mybet88','N88','N8B','N8G','Nbbet','Newbet','NewFuture','NextBet','Nova88','OCMS','Okada','OLE777',
				'Onegaming','OneSports','Opadmin','Opal88','OPEBET','PanguGame','Pinbo','PKbet','PKKing','Raisetech','Royal',
				'Salon365','sbt88','shengboyun','Siamgame','skykey','Soon88','Spark','SSSGaming','Starnet','Sun988','Sunbet138',
				'Sunrise','Sunriseb2b','Sunwin','Swin','TangChao','TaoCai','TCbet','TGO','TitanCraft','TitanOne','TLC','TopGame',
				'Tripleone','TXG','txwl002','TYCgame','UN168','UwinY','VCBA','VN88','VWIN66','W88','Wanbo','Wanfang','WB101',
				'WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88','WINCLUB88','WKCUR','WKIBPH','WKPHIL','WUYICP',
				'Xinbo','XinYo','XTD3','XTDGT','Xtu168','YAYOU','YBTech','Yibo','YongBao','YTX','Yunji','ZhiFeng032',
				'ZhiFeng035','Zowin','zt828')

UPDATE s 
SET s.PT = cs.spositiontaking
FROM #supers s 
	INNER JOIN dbo.custSettingGame cs WITH (NOLOCK) ON cs.CustID = s.custid
WHERE cs.Sporttype = 202 AND cs.Bettype = 1501

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@PT = PT
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0), PT SMALLMONEY)

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON ci.currency = e.exchangeid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.custid <= @max_custid
	AND (e.Code IN ('GBP','EUR','CHF','USD','AUD','BND','CAD','MKK','NZD','SGD','PEN','MYR','PLN','RON','BRL','KHR','TRY','GHS','CNY',
				'DKK','HKD','NOK','SEK','ZAR','IDR','MXN','CZK','INH','THB','TWD','UYU','ARS','PHP','INR','RUB','KES','JPY',
				'CLP','KRW','COP','VES','VND','PYG') OR e.exchangeid = 20)
	AND s.site IN ('12B','18Luck','24TECH','365online','368Cash','3star88','568Win','633esports','818Bet','88Macao','9Club','9Wsports',
				'A1game','Abcasino','AEUG','afb99','AG','alog','ALPHA88','AMG','AnvoFH','Aplus','Apollo','asiabet88','Asian88',
				'B24VN','BBIN2','BBIN3','BBIN4','BetDeal','BETSUN','BigGaming','Bobbet','Bobo88','Bodog','BOG22','BoinGroup',
				'Boma365','Bonanza88','BOSSB','Boying','BPLE','BWGaming','Cali','Calibet','Callmeboss','CGame','CGame4','Champion',
				'dabo88','Dachen','Dade','Datang','Datang001','Dawoo','DBP','DEWA','DF88','DingTai','DTGW','e8casino','ECLBET',
				'ENT22','ENTAPLAY','erhaozhan','FB88','Five88','FLC','G2Win','Gameroom','GamingSoft','Gampag','Gaobet','gbkj',
				'GESAB','GGBOOK','GGBOOKES','GMASTER','GPgaming88','GPIGAME','haifa','Happy1668','Happy8','HBO999','HCVIP',
				'Heaven','Hecbet','Heji888','HeleThai','Hengcai88','hjccasino','HJTK','HL8','HONBET','HonorW','HOT88','HuangMa',
				'IBG','IBO','ID88','ig128','IGPTech','INSERTGAME','ISC888','IvoryBet','JGQP8','JIBET','JIDU','Jinyazhou',
				'JZFortune','K8VN','KeenOcean','KhmerG','Kraton','Kudatogel','KUTECH','Leng4D','Liga','LLGAME','Man1878',
				'mansion88','MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Monaco','Mopgaming','MRCATSB','MTech',
				'mtegames','Mybet88','N88','N8B','N8G','Nbbet','Newbet','NewFuture','NextBet','Nova88','OCMS','Okada','OLE777',
				'Onegaming','OneSports','Opadmin','Opal88','OPEBET','PanguGame','Pinbo','PKbet','PKKing','Raisetech','Royal',
				'Salon365','sbt88','shengboyun','Siamgame','skykey','Soon88','Spark','SSSGaming','Starnet','Sun988','Sunbet138',
				'Sunrise','Sunriseb2b','Sunwin','Swin','TangChao','TaoCai','TCbet','TGO','TitanCraft','TitanOne','TLC','TopGame',
				'Tripleone','TXG','txwl002','TYCgame','UN168','UwinY','VCBA','VN88','VWIN66','W88','Wanbo','Wanfang','WB101',
				'WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88','WINCLUB88','WKCUR','WKIBPH','WKPHIL','WUYICP',
				'Xinbo','XinYo','XTD3','XTDGT','Xtu168','YAYOU','YBTech','Yibo','YongBao','YTX','Yunji','ZhiFeng032',
				'ZhiFeng035','Zowin','zt828')

UPDATE s 
SET s.PT = cs.spositiontaking
FROM #supers s 
	INNER JOIN dbo.custSettingGame cs WITH (NOLOCK) ON cs.CustID = s.custid
WHERE cs.Sporttype = 202 AND cs.Bettype = 1501

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@PT = PT
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO