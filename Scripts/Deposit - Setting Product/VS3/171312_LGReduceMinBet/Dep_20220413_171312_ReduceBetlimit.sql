/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220413
	Task: Reduce min bet for Leap Gaming Virtual Sports 3 - Deposit[Redmine: 171312]
	DB: DBCUST/CustDB
	
	P/s : Step 1 Reduce min bet for Leap Gaming Virtual Sports 3 - Deposit
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
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
	   )
		RETURN
	
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	DECLARE @batch SMALLINT = 5000

	DECLARE @Currency INT 
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend
		
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

	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID INTO #tmpSMATemp(CustID,RoleID)
		FROM #tmpSMA c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE tmp.MinBet END
		FROM Dep_CustBetSetting_Agent cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #tmpSMATemp t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
			INNER JOIN Dep_ProductBetSetting tmp  WITH(NOLOCK) ON tmp.Currency = @currency AND tmp.SportType = @SportType AND tmp.BetType = @betType
		
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
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE tmp.MinBet END
		FROM Dep_CustBetSetting_Member cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustTemp t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
			INNER JOIN Dep_ProductBetSetting tmp  WITH(NOLOCK) ON tmp.Currency = @currency AND tmp.SportType = @SportType AND tmp.BetType = @betType
					
		TRUNCATE TABLE #tmpCustTemp
	END 	

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
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
	AND cs.site IN('spondemo','Athena000','Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')
	AND ci.currency in (12,3,6,20,96,2,13,15,4,45,46,51,61,97,121)  -- GBP,US$,EURO,UUS,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR
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
	AND cs.site IN('spondemo','Athena000','Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')
	AND ci.currency in (12,3,6,20,96,2,13,15,4,45,46,51,61,97,121)  -- GBP,US$,EURO,UUS,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR	  
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
