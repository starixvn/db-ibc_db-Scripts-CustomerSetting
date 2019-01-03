/*
	Created: Johnson
	Date: 2019-01-02
	Task: reset MPM bet setting for Happy 5 
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT	
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN

	CREATE TABLE #tblCust (CustID INT PRIMARY KEY, ID INT IDENTITY(1,1))
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @max_custid		
		AND Enabled = 1	
	ORDER BY roleid DESC	
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID
		
		UPDATE ci
		SET maxpermatch164 = maxpermatch161
		FROM dbo.CustInfo ci WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
		
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;			
			
		WAITFOR DELAY '00:00:00.200'
	END	
	
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBTXN -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT,@currency INT, @site VARCHAR(50)

SELECT  @max_custid= xxx, ---input maxcustid
		@site = 'abc',
		@currency = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN DBCUST.CUSTDB.dbo.site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN DBCUST.CUSTDB.dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM DBCUST.CUSTDB.dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = @site
	AND ci.currency = @currency
	AND ci.custid <= @max_custid
	
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
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 2: Run this SP at DBTXN -----
-------------------------------------------------

------------------------------------------------------	
-- BEGIN STEP 3: Run this SP at replicated DB exclude DBTXN -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT,@currency INT, @site VARCHAR(50)

SELECT  @max_custid= xxx, ---input maxcustid
		@site = 'abc',
		@currency = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = @site
	AND ci.currency = @currency
	AND ci.custid <= @max_custid
	
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
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 3: Run this SP at replicated DB exclude DBTXN-----
-------------------------------------------------

---
-- BEGIN STEP 4: Run this SP at DBCust -----
-------------------------------------------------
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT,@currency INT, @site VARCHAR(50)

SELECT  @max_custid= xxx, ---input maxcustid
		@site = 'abc',
		@currency = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = @site
	AND ci.currency = @currency
	AND ci.custid <= @max_custid
	
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
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 4: Run this SP at DBCust -----
-------------------------------------------------