/*
	Created: 20200918@Winfred
	Task : Insert Comm for Myanmar Odds - UUS [Redmine: #141926]
	DB:  DBCUST/CustDB 
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustCommRate') = 0 RETURN
	IF dbo.f_CheckRepTable('AgentCommRate') = 0 RETURN
	

	DECLARE @Sporttype INT = 1, @Bettype INT = 1 ,@CommSuper DECIMAL(19, 8),@ComMaster DECIMAL(19, 8)  ,@CommAgent DECIMAL(19, 8),@CommMember DECIMAL(19, 8)

	SELECT @Sporttype= 1,@Bettype = 1,@CommSuper = 0.0025,@ComMaster = 0.002,@CommAgent = 0.002, @CommMember = 0.001 

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)
	CREATE TABLE #MemberTempBatch
	(
		CustID	INT PRIMARY KEY CLUSTERED	
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

		CREATE TABLE #DirectTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)


	CREATE TABLE #tmpSTListSMA (BettypeID INT PRIMARY KEY, StakeLevelList VARCHAR(500))
   
	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
		
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 
		
	INSERT INTO #DirectTemp (CustID,roleid) --Direct Master, Agent
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.srecommend = @srecommend 
		AND ci.Enabled=1
		AND ci.roleid IN (2,3)
		AND ci.custid <= @maxcustid 

--------------------------------------Commission Setting-------------------------------------------------
	--Super level
	INSERT INTO dbo.AgentCommRate(CustID, SportType, BetType, CommRate)
	SELECT DISTINCT ci.custid, @Sporttype, @Bettype, @CommSuper
	FROM #SMATemp ci  WITH(NOLOCK) 
	WHERE ci.roleid = 4
	
	--Direct (Master, Agent)
	INSERT INTO dbo.AgentCommRate(CustID, SportType, BetType, CommRate)
	SELECT DISTINCT ci.custid, @Sporttype, @Bettype, @ComMaster
	FROM #DirectTemp ci  WITH(NOLOCK)  
	WHERE ci.roleid IN (2,3)
	
	--Master, Agent level
	INSERT INTO dbo.AgentCommRate(CustID, SportType, BetType, CommRate)
	SELECT DISTINCT ci.custid , @Sporttype, @Bettype, @ComMaster
	FROM #SMATemp ci  WITH(NOLOCK)
	WHERE ci.roleid IN (2,3)
		AND NOT EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE D.CustID = ci.CustID)
	--Member Level
	INSERT INTO dbo.CustCommRate(CustID, SportType, BetType, sdiscount, adiscount, discount, playerdiscount)
	SELECT DISTINCT ci.custid, @Sporttype, @Bettype, @CommSuper,  @ComMaster ,  @CommAgent, @CommMember
	FROM #MemberTemp ci WITH(NOLOCK) 
	--Update Discount info for members of direct master accounts
	UPDATE C
	SET  C.adiscount = @ComMaster
	FROM dbo.CustCommRate C WITH(ROWLOCK, UPDLOCK)
		INNER JOIN custInfo CI WITH (NOLOCK) ON C.CustID = CI.custid
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE CI.mrecommend = D.CustID)
		AND C.SportType = @Sporttype 
		AND C.BetType = @Bettype
	--Update Discount info for members of direct agent accounts
	UPDATE C
	SET  C.adiscount = @ComMaster, C.discount = @CommAgent
	FROM dbo.CustCommRate C WITH(ROWLOCK, UPDLOCK)
		INNER JOIN custInfo CI WITH (NOLOCK) ON C.CustID = CI.custid
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE CI.recommend = D.CustID)
		AND C.SportType = @Sporttype 
		AND C.BetType = @Bettype


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #tmpSTListSMA

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid			
	AND ci.Site = '76666B'
	AND ci.currency IN (20) -- UUS
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid			
	AND ci.Site = '76666B'
	AND ci.currency IN (20) -- UUS

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
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
