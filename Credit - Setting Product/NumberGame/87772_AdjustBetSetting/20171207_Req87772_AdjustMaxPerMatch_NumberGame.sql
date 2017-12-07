/*
	Created: Elodie
	Task: Adjust Max Per Match for NumberGame
	DB: DBCUST/CustDB
	Date: 20171207
*/

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN

	DECLARE @MaxPerMatch MONEY = 30000, @MaxPerBall MONEY = 10000

	SELECT ci.custid, 
		CASE WHEN ci.maxpermatch161 > @MaxPerMatch THEN 1 ELSE 0 END AS MaxPerMatch,
		CASE WHEN ci.MaxPerBall161 > @MaxPerBall THEN 1 ELSE 0 END AS MaxPerBall
	INTO #ListCust
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND ci.Enabled = 1
		AND (ci.maxpermatch161 > @MaxPerMatch OR ci.MaxPerBall161 > @MaxPerBall)				
	
	UPDATE c	
	SET c.maxpermatch161 = CASE WHEN ci.MaxPerMatch = 1 THEN @MaxPerMatch ELSE c.maxpermatch161 END,
		c.MaxPerBall161 = CASE WHEN MaxPerBall = 1 THEN @MaxPerBall ELSE c.MaxPerBall161 END
	FROM dbo.custInfo c WITH (ROWLOCK,UPDLOCK)
		INNER JOIN #ListCust ci WITH (NOLOCK) ON ci.custid = c.custid
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.username IN ('Ky1','Ky6','Nw52','Nw53','Nw63','Nw71','Nc9','Nc47','Nc66','Nc68','Nc69','Nc85')
	AND ci.custid <= @max_custid

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

	EXEC dbo.Acc_CustomerInfo_Execrep_09 
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.200'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.username IN ('Ky1','Ky6','Nw52','Nw53','Nw63','Nw71','Nc9','Nc47','Nc66','Nc68','Nc69','Nc85')
	AND ci.custid <= @max_custid

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

	EXEC dbo.Acc_CustomerInfo_Execrep_09 
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 