/*
	Created: Elodie
	Task: Adjust Max Per Match for Sportbook
	DB: DBCUST/CustDB
	Date: 20171206
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

	DECLARE @MaxPerMatch MONEY = 30000

	SELECT ci.custid,
		CASE WHEN ci.maxpermatch > @MaxPerMatch THEN 1 ELSE 0 END AS Soccer,
		CASE WHEN ci.MaxPerMatch1MP > @MaxPerMatch THEN 1 ELSE 0 END AS SoccerMP,
		CASE WHEN ci.maxpermatch2 > @MaxPerMatch THEN 1 ELSE 0 END AS Basketball,
		CASE WHEN ci.maxpermatch3 > @MaxPerMatch THEN 1 ELSE 0 END AS Football,
		CASE WHEN ci.maxpermatch5 > @MaxPerMatch THEN 1 ELSE 0 END AS Tennis,
		CASE WHEN ci.maxpermatch8 > @MaxPerMatch THEN 1 ELSE 0 END AS Baseball,
		CASE WHEN ci.maxpermatch10 > @MaxPerMatch THEN 1 ELSE 0 END AS Golf,
		CASE WHEN ci.maxpermatch11 > @MaxPerMatch THEN 1 ELSE 0 END AS MotoSports,
		CASE WHEN ci.maxpermatch99 > @MaxPerMatch THEN 1 ELSE 0 END AS OtherSports,
		CASE WHEN ci.MaxPerMatch99MP > @MaxPerMatch THEN 1 ELSE 0 END AS MixParlay, 
		CASE WHEN ci.maxpermatch154 > @MaxPerMatch THEN 1 ELSE 0 END AS HRFixedOdds
	INTO #ListCust
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND ci.custid <= @maxcustid
		AND ci.Enabled = 1
		AND (ci.maxpermatch > @MaxPerMatch
				OR ci.MaxPerMatch1MP > @MaxPerMatch
				OR ci.maxpermatch2 > @MaxPerMatch
				OR ci.maxpermatch3 > @MaxPerMatch
				OR ci.maxpermatch5 > @MaxPerMatch
				OR ci.maxpermatch8 > @MaxPerMatch
				OR ci.maxpermatch10 > @MaxPerMatch
				OR ci.maxpermatch11 > @MaxPerMatch
				OR ci.maxpermatch99 > @MaxPerMatch
				OR ci.MaxPerMatch99MP > @MaxPerMatch
				OR ci.maxpermatch154 > @MaxPerMatch				
			)
	
	UPDATE c	
	SET c.maxpermatch = CASE WHEN Soccer = 1 THEN @MaxPerMatch ELSE c.maxpermatch END,
		c.MaxPerMatch1MP = CASE WHEN SoccerMP = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch1MP END,
		c.maxpermatch2 = CASE WHEN Basketball = 1 THEN @MaxPerMatch ELSE c.maxpermatch2 END,
		c.maxpermatch3 = CASE WHEN Football = 1 THEN @MaxPerMatch ELSE c.maxpermatch3 END,
		c.maxpermatch5 = CASE WHEN Tennis = 1 THEN @MaxPerMatch ELSE c.maxpermatch5 END,
		c.maxpermatch8 = CASE WHEN Baseball = 1 THEN @MaxPerMatch ELSE c.maxpermatch8 END,
		c.MaxPerMatch10 = CASE WHEN Golf = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch10 END,
		c.MaxPerMatch11 = CASE WHEN MotoSports = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch11 END,
		c.maxpermatch99 = CASE WHEN OtherSports = 1 THEN @MaxPerMatch ELSE c.maxpermatch99 END,
		c.MaxPerMatch99MP = CASE WHEN MixParlay = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch99MP END,
		c.maxpermatch154 = CASE WHEN HRFixedOdds = 1 THEN @MaxPerMatch ELSE c.maxpermatch154 END
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