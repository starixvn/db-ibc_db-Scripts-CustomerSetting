/*
	Created: 20190529@Johnson
	DB: DBCUST/CUSTDB
	Task: correct PT setting for dummy master for custsettinggame table
*/


-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT		
	,@max_custid INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT, roleid TINYINT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY)
	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY)
	DECLARE @tmpCust TABLE(Custid INT, roleid TINYINT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY)
	DECLARE @rowcount INT
		
	INSERT INTO #DirectMaster (CustID)													
	SELECT custid												
	FROM custInfo ci WITH(NOLOCK)											
	WHERE roleid=3 
		AND srecommend = @srecommend											
		AND EXISTS (SELECT TOP (1) 1
					FROM dbo.CustDirectAccount WITH(NOLOCK) 
					WHERE CustID = ci.custid
					)													
		AND custid < @max_custid	
	
	INSERT INTO #tblCust (custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking)			
	SELECT ci.custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN CustSettingGame cs WITH(NOLOCK) ON ci.custid = cs.custid
	WHERE srecommend =@srecommend
		AND ci.custid <= @max_custid
		AND mrecommend IN (SELECT custid FROM #DirectMaster)
		AND roleid IN (1,3)
		AND enabled = 1
		AND sporttype <> 162
		AND spositiontaking <> 0
		
	WHILE(1=1)
	BEGIN			
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, DELETED.roleid, DELETED.sporttype, DELETED.bettype, DELETED.spositiontaking, DELETED.mpositiontaking 
		INTO @tmpCust(custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking)
		FROM #tblCust t
		
		SELECT @rowcount = @@rowcount	
		
		UPDATE cs
		SET cs.spositiontaking = 0,
			cs.mpositiontaking = CASE WHEN roleid = 3 THEN t.mpositiontaking + t.spositiontaking ELSE cs.mpositiontaking END
		FROM custsettinggame cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custID
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
			
		IF @rowcount < 5000
			BREAK;
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.01'
	END
	
	DROP TABLE #tblCust
	DROP TABLE #DirectMaster	
END	
GO

-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

CREATE TABLE #tmpSupers (custid INT)
CREATE TABLE #DirectMaster (CustID INT)
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))


INSERT INTO #tmpSupers(custid)				
SELECT ci.custid				
FROM Customer ci WITH (NOLOCK)				
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site				
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid				
WHERE ci.roleid = 4				
	AND ci.username NOT LIKE '3rdSuper%'				
	AND cs.isinternal = 0				
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))				
	AND s.islicensee = 0				
	AND ci.currency <> 20				
	AND ci.site<>'CN88'	
	AND ci.custid <= @max_custid
																		
														
--- get direct master													
INSERT INTO #DirectMaster (CustID)													
SELECT ci.custid												
FROM custInfo ci WITH(NOLOCK) 										
WHERE  EXISTS (SELECT custid 
				FROM dbo.CustDirectAccount WITH(NOLOCK) 
				WHERE CustID = ci.custid)													
	AND ci.roleid=3 
	AND ci.srecommend in (select custid from #tmpSupers)												
	AND ci.custid <= @max_custid

INSERT INTO #supers(custid)	
SELECT DISTINCT c.srecommend 
FROM CustSettingGame cs WITH (NOLOCK)--member									
	INNER JOIN custinfo c WITH (NOLOCK) on c.custid=cs.custid										
WHERE 1=1																		
	AND spositiontaking<>0									
	AND c.enabled=1									
	AND cs.sporttype<>162 --Live Casino									
	AND c.roleid IN (1,3)								
	AND mrecommend IN (SELECT custid FROM #DirectMaster)									
	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'REPLICATED'
				
	--WAITFOR DELAY '00:00:00.280'			
END	
GO																			
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

CREATE TABLE #tmpSupers (custid INT)
CREATE TABLE #DirectMaster (CustID INT)
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))


INSERT INTO #tmpSupers(custid)				
SELECT ci.custid				
FROM Customer ci WITH (NOLOCK)				
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site				
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid				
WHERE ci.roleid = 4				
	AND ci.username NOT LIKE '3rdSuper%'				
	AND cs.isinternal = 0				
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))				
	AND s.islicensee = 0				
	AND ci.currency <> 20				
	AND ci.site<>'CN88'	
	AND ci.custid <= @max_custid
																		
														
--- get direct master													
INSERT INTO #DirectMaster (CustID)													
SELECT ci.custid												
FROM custInfo ci WITH(NOLOCK) 										
WHERE  EXISTS (SELECT custid 
				FROM dbo.CustDirectAccount WITH(NOLOCK) 
				WHERE CustID = ci.custid)													
	AND ci.roleid=3 
	AND ci.srecommend in (select custid from #tmpSupers)												
	AND ci.custid <= @max_custid

INSERT INTO #supers(custid)	
SELECT DISTINCT c.srecommend 
FROM CustSettingGame cs WITH (NOLOCK)--member									
	INNER JOIN custinfo c WITH (NOLOCK) on c.custid=cs.custid										
WHERE 1=1																		
	AND spositiontaking<>0									
	AND c.enabled=1									
	AND cs.sporttype<>162 --Live Casino									
	AND c.roleid IN (1,3)								
	AND mrecommend IN (SELECT custid FROM #DirectMaster)									
	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'DBCUST'
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------

	