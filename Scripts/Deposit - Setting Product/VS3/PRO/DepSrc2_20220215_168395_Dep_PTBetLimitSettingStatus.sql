/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220215
	Task: Insert PT and Betlimit for Leap Gaming Virtual Sports 3 - Deposit [Redmine: 168395]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Insert PT and Betlimit for Leap Gaming Virtual Sports 3 - Deposit
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN
	
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	DECLARE @BitOrder INT 
	DECLARE @batch SMALLINT = 5000
	DECLARE @PT smallmoney = 88.00 

	DECLARE @Currency INT 
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend
		
	CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,MaxBet MONEY,ExchangeId	INT)

	INSERT INTO #TempBetLimit(currency,MinBet,MaxBet,ExchangeId)
	VALUES	('GBP',1,2000,12),
			('US$',2,2500,3),
			('EURO',2,2500,6),
			('UUS',2,2500,20),
			('CAN',2,2500,50),
			('USDT',2,2500,96),
			('RM',5,10000,2),
			('RMB',10,20000,13),
			('IN',18,18000,15),
			('TB',50,50000,4),
			('Won',2000,3000000,45),
			('BND',2,400,46),
			('BDT',100,30000,97),
			('PKR',250,60000,121),
			('INR',100,30000,61),
			('INH',30,10000,51)
	
	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK)   
	WHERE SportType=@Sporttype AND Bettype = @betType

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT, 
		MinBet		MONEY,
		MaxBet		MONEY
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype, MinBet, MaxBet) 
	SELECT 231 AS SportType, 5301 AS BetType, 
		   180 AS fSportType,1201 AS fBettype,
		   a.MinBet , a.MaxBet
	FROM #TempBetLimit a where a.ExchangeId = @Currency

	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID INTO #tmpSMATemp(CustID,RoleID)
		FROM #tmpSMA c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------PT Setting-----------------------------------------------
		--Agent Level
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
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0 AS IsLive
			   ,CASE WHEN a.RoleID = 4 THEN @PT ELSE 0 END AS SuperPT
			   ,CASE WHEN a.RoleID IN (3,4) THEN @PT ELSE 0 END AS MasterPT
			   ,CASE WHEN a.RoleID IN (2,4) THEN @PT ELSE 0 END AS AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
			CROSS APPLY @SportBetType t 

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
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0
			   ,0
			   ,0
			   ,@PT AS AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
			CROSS APPLY @SportBetType t 
		WHERE a.RoleID=2
		
		-------------------------------------Betlimit Setting----------------------------------------------
		INSERT INTO Dep_CustBetSetting_Agent(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT CustID,SportType,BetType,MinBet, CASE WHEN MinBet > MaxBet THEN MinBet ELSE MaxBet END AS MaxBet, MaxPerMatch
		FROM (
			SELECT t.CustID,b.SportType,b.BetType,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet 
				WHEN cs.MinBet <  b.MinBet THEN b.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #tmpSMATemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			) KQ
			
		TRUNCATE TABLE #tmpSMATemp
	END
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------PT Setting-----------------------------------------------
		--Member Level
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
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0
			   ,0
			   ,0
			   ,@PT AS AgentPT
		FROM #tmpCustTemp a WITH(NOLOCK)
			INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
			CROSS APPLY @SportBetType t 
		WHERE m.IsGroupedPT=0

		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #tmpCustTemp t WITH(NOLOCK) 
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		-------------------------------------Betlimit Setting----------------------------------------------
		INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT CustID,SportType,BetType,MinBet, CASE WHEN MinBet > MaxBet THEN MinBet ELSE MaxBet END AS MaxBet, MaxPerMatch
		FROM (
			SELECT t.CustID,b.SportType,b.BetType,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet 
				WHEN cs.MinBet <  b.MinBet THEN b.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #tmpCustTemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			) KQ			
		TRUNCATE TABLE #tmpCustTemp
	END 	
	---------------------------------Check Licensee-----------------------------------------------------
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=124)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,124
	END
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=125)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,125
	END
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

	WHILE (1 = 1) 
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

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)) AS bitmapIsDisabled
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0))  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=123)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,123
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 2.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')  AND ci.currency IN (12,3,6,20,96,2,13,15,4,45,46,51,61,97,121)  -- GBP,US$,EURO,UUS,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR
	OR  (cs.site IN('spondemo','Athena000') AND ci.currency IN (12,3,6,96,2,13,15,4,45,46,51,61,97,121))) -- GBP,US$,EURO,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')  AND ci.currency IN (12,3,6,20,96,2,13,15,4,45,46,51,61,97,121)  -- GBP,US$,EURO,UUS,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR
	OR  (cs.site IN('spondemo','Athena000') AND ci.currency IN (12,3,6,96,2,13,15,4,45,46,51,61,97,121))) -- GBP,US$,EURO,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
		
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		

-- END STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
