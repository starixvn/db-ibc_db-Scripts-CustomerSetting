/*
	Created: Tiara	
	Task: Enable Product Status for all disabled customers under 789y Headline- DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191219
*/ 
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_17]
	@Custid INT,
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN

	CREATE TABLE #DownlineTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsFinishedStatus BIT DEFAULT(0)
	)	
	
	INSERT INTO #DownlineTemp (CustID)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @Custid 
		AND Enabled = 1 
		AND (ci.DisableNumber = 1
			OR ci.DisableGoldDeluxe = 1)

	/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	DECLARE @MemberBatch table(CustId INT)

	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET IsFinishedStatus = 1
		OUTPUT INSERTED.CustID INTO @MemberBatch
		FROM #DownlineTemp t
		WHERE IsFinishedStatus = 0
	 
		IF @@ROWCOUNT = 0
			BREAK
		
		UPDATE ci
		SET ci.DisableNumber = 0,
			ci.DisableGoldDeluxe = 0
		FROM custInfo ci WITH(ROWLOCK)
			INNER JOIN @MemberBatch c ON ci.CustID = c.CustId

		DELETE @MemberBatch
	END

	--Drop all temp tables
	DROP TABLE #DownlineTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @Custid INT, @max_custid INT

--SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('789y')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND Enabled = 1 		
	
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, Disabled Customer: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Disabled Customers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT

--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@Custid = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_17 @custid = @Custid
			,@target = 'REPLICATED'			
	WAITFOR DELAY '00:00:0.100'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @Custid INT, @max_custid INT

--SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('789y')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND Enabled = 1 		
	
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, Disabled Customer: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Disabled Customers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT

--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@Custid = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_17 @custid = @Custid
			,@target = 'DBCUST'			
	WAITFOR DELAY '00:00:0.100'
END

--Drop all temp tables
DROP TABLE #supers

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
GO