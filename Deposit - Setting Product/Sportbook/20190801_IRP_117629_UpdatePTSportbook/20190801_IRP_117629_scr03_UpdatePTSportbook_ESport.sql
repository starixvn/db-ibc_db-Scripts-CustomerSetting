/*
	Created: Elodie
	Task: Update PT settings of Esport for licensees [RedmineID: #117629]
	DB: DBCUST/CustDB
	Date: 20190801
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@PT SMALLMONEY	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBAActive') = 0 RETURN

	--------------------------------------PT Setting-------------------------------------------------	
	CREATE TABLE #tmpMem		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMA		(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #tmpCust		(CustID INT PRIMARY KEY)	

	CREATE TABLE #DummySMA		(CustID INT PRIMARY KEY)
	CREATE TABLE #DummyMember	(CustID INT PRIMARY KEY)

	DECLARE @tmpDummyMaster TABLE (custid INT PRIMARY KEY, username VARCHAR(30))
	DECLARE @SportType SMALLINT = 43

	INSERT INTO @tmpDummyMaster(custid, username)
	SELECT c.CustID, fc.username
	FROM Customer c WITH(NOLOCK) 
		CROSS APPLY (
					SELECT TOP 1 custid, username
					FROM dbo.Customer cc WITH(NOLOCK)
					WHERE c.custid = cc.custid 
					) fc
	WHERE c.srecommend = @srecommend AND c.roleid =3

	INSERT INTO #DummyMember(CustID)
	SELECT c.custid
	FROM @tmpDummyMaster d
	 INNER JOIN dbo.Customer c WITH(NOLOCK) 
	  ON d.custid = c.mrecommend AND c.roleid = 1
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%' OR d.username LIKE '%ClearBal%'

	INSERT INTO #DummySMA(CustID)
	SELECT c.custid
	FROM @tmpDummyMaster d
	 INNER JOIN dbo.Customer c WITH(NOLOCK) 
	  ON d.custid = c.mrecommend AND c.roleid IN(2,3)
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'

	INSERT INTO #tmpMem(CustID)
	SELECT DISTINCT ci.CustID
	FROM Customer ci WITH(NOLOCK)	
		INNER JOIN Dep_CustPTSetting_Member BA WITH(NOLOCK) ON ci.custid=BA.custid	
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid = 1 		
		AND ci.custid NOT IN(SELECT Custid FROM #DummyMember)
		AND ci.custid NOT IN(SELECT Custid FROM dbo.Dep_CustBAActive WITH (NOLOCK))

	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM Customer ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid IN(2,3,4)		
		AND ci.custid NOT IN(SELECT Custid FROM #DummySMA)		

	--AGENT LEVEL	
	UPDATE cs
	SET cs.SuperPT = @PT,
		cs.MasterPT= @PT,
		cs.AgentPT= @PT
	FROM Dep_CustPTSetting_Agent cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID=4 AND cs.SportType = @SportType
	
	UPDATE cs
	SET cs.MasterPT=@PT
	FROM Dep_CustPTSetting_Agent cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID=3 AND cs.SportType = @SportType
		
	UPDATE cs
	SET cs.[AgentPT]=@PT
	FROM Dep_CustPTSetting_Agent cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID=2 AND cs.SportType = @SportType

	UPDATE cs
	SET cs.[AgentPT]=@PT
	FROM Dep_CustPTGroupSetting_Member cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.AgentID=t.CustID
	WHERE RoleID=2 AND cs.SportType = @SportType AND cs.AgentPT <> 0
	
	WHILE EXISTS(SELECT 1 FROM #tmpMem)
	BEGIN
		DELETE TOP (500) #tmpMem OUTPUT DELETED.* INTO #tmpCust

		UPDATE cs
		SET cs.[AgentPT]=@PT
		FROM Dep_CustPTSetting_Member cs WITH(ROWLOCK)
			INNER JOIN #tmpCust t ON cs.CustID=t.CustID
		WHERE cs.SportType = @SportType
	
		TRUNCATE TABLE #tmpCust
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #supersFinal (ID INT IDENTITY(1,1), custid INT, PT SMALLMONEY, NoDownline INT)

DECLARE @max_custid INT, @srecommend INT, @PT SMALLMONEY

SELECT @max_custid = xxx

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 0.89	
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN(	'Ae88')

INSERT INTO #supersFinal (custid, PT, NoDownline)
SELECT ci.srecommend, s.PT, COUNT(1)
FROM #supers s 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.srecommend = s.custid
GROUP BY ci.srecommend, PT
ORDER BY COUNT(1)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 1
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @srecommend = custid, @PT = PT
	FROM #supersFinal
	WHERE ID = @index
	
	IF @@ROWCOUNT = 0 BREAK
		
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend, @PT = @PT
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'

	SET @index = @index + 1						
	WAITFOR DELAY '00:00:0.100'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #supersFinal (ID INT IDENTITY(1,1), custid INT, PT SMALLMONEY, NoDownline INT)

DECLARE @max_custid INT, @srecommend INT, @PT SMALLMONEY

SELECT @max_custid = xxx

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 0.89	
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN(	'Ae88')

INSERT INTO #supersFinal (custid, PT, NoDownline)
SELECT ci.srecommend, s.PT, COUNT(1)
FROM #supers s 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.srecommend = s.custid
GROUP BY ci.srecommend, PT
ORDER BY COUNT(1)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 1
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @srecommend = custid, @PT = PT
	FROM #supersFinal
	WHERE ID = @index
	
	IF @@ROWCOUNT = 0 BREAK
		
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend, @PT = @PT
			,@maxcustid = @max_custid
			,@target = 'DBCUST'

	SET @index = @index + 1						
	WAITFOR DELAY '00:00:0.100'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
