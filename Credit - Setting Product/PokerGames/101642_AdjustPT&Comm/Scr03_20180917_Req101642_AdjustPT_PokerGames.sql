/*
	Created: Elodie
	Date: 20180917
	Task: Adjust PT setting of Poker Games
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT		
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	
	DECLARE @MaxPT TINYINT, @MinPT TINYINT, @Sporttype SMALLINT, @batchUpdate INT
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY, roleid TINYINT)

	SELECT @MaxPT = 80, @Sporttype = 163
	SET @batchUpdate = 5000
	
	IF EXISTS (	SELECT 1 
				FROM CustInfo WITH (NOLOCK) 
				WHERE username IN (	'ABS','ABB','ABW','BBA','BBD','BBE','BBF','SQ','SM','EE','ET','XE','XF','XL','XXC','XXF','EAL','SCV','EH5','EH6',
									'ZW1','ZW2','ZW3','ZW4','ZW5','ZW6','ZW7','ZW8','ZW9','ZW10','ZW11','ZW12','ZW13','ZW14','ZW15','ZW16','ZW17',
									'ZW18','ZW19','ZW20','ZW21','ZW22','ZW23','ZW24','ZW25','ZW26','ZW27','ZW28','ZW29','ZW30','KY48','S05','KP100',
									'KP200','KP300','PV100','TWW','TV','SJK.','XTV','COPA','TK','TKH','SJK','ED24','SC') AND custid = @srecommend)
			SELECT @MinPT = 0
	ELSE
		SELECT @MinPT = @MaxPT

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	
	INSERT INTO #MemberTemp (CustID)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN CustPTSetting3rd_Member cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND ci.custid <= @maxcustid		
		AND cs.SuperPT = 85 AND cs.SportType = @Sporttype
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	--------------------------------------PT Setting-------------------------------------------------	
	--SUPER LEVEL
	UPDATE cs
	SET cs.SuperPT = @MaxPT, cs.MasterPT = @MaxPT, cs.AgentPT = @MaxPT, cs.MinPT = @MinPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #SMATemp ci ON ci.CustID = cs.CustID
	WHERE cs.SportType = @Sporttype AND ci.roleid = 4
	
	--MASTER, AGENT LEVEL
	WHILE(1=1)
	BEGIN
		DELETE @tmpCust
				
		DELETE TOP (@batchUpdate) t
		OUTPUT DELETED.custid, DELETED.roleid INTO @tmpCust
		FROM #SMATemp t
				
		IF @@rowcount = 0 
			BREAK;
					
		UPDATE cs
		SET cs.SuperPT = CASE WHEN cs.SuperPT = 85 THEN @MaxPT ELSE cs.SuperPT END
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN @tmpCust ci ON ci.CustID = cs.CustID
		WHERE cs.SportType = @Sporttype AND ci.roleid IN (2,3)

		UPDATE cs
		SET cs.SuperPT = CASE WHEN cs.SuperPT = 85 THEN @MaxPT ELSE cs.SuperPT END
		FROM dbo.CustPTGroupSetting3rd_Member cs WITH (ROWLOCK)
			INNER JOIN @tmpCust ci ON ci.CustID = cs.AgentID
		WHERE cs.SportType = @Sporttype AND ci.roleid IN (2)
	END		

	--MEMBER LEVEL
	WHILE(1=1)
	BEGIN
		DELETE @tmpCust
				
		DELETE TOP (@batchUpdate) t
		OUTPUT DELETED.custid, 1 INTO @tmpCust
		FROM #MemberTemp t
				
		IF @@rowcount = 0 
			BREAK;
					
		UPDATE cs
		SET cs.SuperPT = @MaxPT
		FROM dbo.CustPTSetting3rd_Member cs WITH (ROWLOCK)
			INNER JOIN #MemberTemp ci ON ci.CustID = cs.CustID
		WHERE cs.SportType = @Sporttype
	END	

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp	
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT, @MinPT TINYINT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND c.site = '789y'
 AND c.currency <> 20
 AND c.custid <= @max_custid
 AND c.custid NOT IN (16) -- dummy account
 AND c.currency IN (16,64)
 AND c.username <> 'MPK'

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
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND c.site = '789y'
 AND c.currency <> 20
 AND c.custid <= @max_custid
 AND c.custid NOT IN (16) -- dummy account
 AND c.currency IN (16,64)
 AND c.username <> 'MPK'

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
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

