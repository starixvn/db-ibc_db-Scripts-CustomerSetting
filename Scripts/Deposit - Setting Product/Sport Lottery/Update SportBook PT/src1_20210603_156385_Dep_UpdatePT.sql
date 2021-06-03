/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210603
	Task: Update PT sport book for Licensee Deposit Sports Lottery RedmineID:#156385
	DB: DBCUST/CustDB
	
	P/s : Step 1 Update PT sport book for Licensee Deposit Sports Lottery
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@PT SMALLMONEY
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT val
	FROM dbo.strSplit(@CustIDs,',')
	
	DECLARE @batch SMALLINT = 2500
	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (169, 3611)
	
	-- SMA LEVEL
	IF @RoleID <>1
	BEGIN
		WHILE(1 =1)
		BEGIN
			--1 turn run 2500 member safe (large line) .
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
						
			UPDATE a 
			SET a.SuperPT = CASE WHEN @RoleID = 0 AND a.CustID = @srecommend THEN @PT ELSE 0 END
				,a.MasterPT = CASE WHEN @RoleID = 0 THEN @PT ELSE 0 END
				,a.AgentPT= CASE WHEN @RoleID = 2 OR a.CustID = @srecommend  THEN @PT ELSE 0 END
			FROM dbo.Dep_CustPTSetting_Agent a WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.CustID = c.CustID
			INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
				
			--Agent Level
			IF @RoleID = 2
			BEGIN				
				UPDATE a 
				SET a.AgentPT= @PT
				FROM dbo.Dep_CustPTGroupSetting_Member a WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.AgentID = c.CustID
				INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
			END 
			
			TRUNCATE TABLE #CustListTemp
		END
	END	
	
	IF @RoleID  = 1
	BEGIN
		WHILE(1 = 1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
			--Member Level
			UPDATE a 
			SET a.AgentPT= @PT
			FROM dbo.Dep_CustPTSetting_Member a WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.CustID = c.CustID
			INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
		
			TRUNCATE TABLE #CustListTemp
		END 	
	END
	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY,isfinished bit default(0),PT_SB MONEY)
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT SMALLMONEY , @Role SMALLINT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid,PT_SB)
SELECT ci.custid,cs_sb.apositiontaking * 100 AS PT_SB
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN Dep_CustPTSetting_Agent cps  WITH (NOLOCK) ON ci.custid = cps.custid AND cps.SportType =  169 AND  cps.BetType = 3611
	INNER JOIN Dep_CustSetting cs_sb WITH (NOLOCK) ON ci.custid = cs_sb.custid AND cs_sb.sporttype = 1 AND cs_sb.bettype = 2
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site NOT IN ('Saba789')
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@PT = PT_SB
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0		
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
	END
	ELSE
	BEGIN
		-- WAITFOR DELAY 5000 member 1 turn
	    UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role,@PT = @PT,@srecommend = @srecommend,@target = 'REPLICATED' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, isfinished bit default(0),PT_SB MONEY)
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT SMALLMONEY , @Role SMALLINT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid,PT_SB)
SELECT ci.custid,cs_sb.apositiontaking * 100 AS PT_SB
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN Dep_CustPTSetting_Agent cps  WITH (NOLOCK) ON ci.custid = cps.custid AND cps.SportType =  169 AND  cps.BetType = 3611
	INNER JOIN Dep_CustSetting cs_sb WITH (NOLOCK) ON ci.custid = cs_sb.custid AND cs_sb.sporttype = 1 AND cs_sb.bettype = 2
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site NOT IN ('Saba789')
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@PT = PT_SB
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0		
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	END
	ELSE
	BEGIN
	
	    UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role,@PT = @PT,@srecommend = @srecommend,@target = 'DBCUST' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
