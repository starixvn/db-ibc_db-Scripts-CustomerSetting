/*
	Created: Eden
	Date: 20191029
	Task: Insert CustProductStatus setting for Virtual game follow by Macau games UUS
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_19]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	
	CREATE TABLE #CustTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)
	
	INSERT INTO #CustTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND Enabled = 1 AND custid <= @max_custid
	
	DECLARE @SportBettype TABLE
	(
		fSportType SMALLINT, 
		fBetType   SMALLINT, 
		tSportType SMALLINT, 
		tBetType   SMALLINT
	)
	INSERT INTO @SportBettype(fSportType, fBetType, tSportType, tBetType) VALUES (212, 4001, 245, 4601)

	--------------------------------------------Product Status------------------------------------------------
	
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #CustStatus
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN #CustTemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType

	UPDATE c 
	SET  c.bitmapHasSynced = dbo.f_GenerateProductStatus (c.bitmapHasSynced,psp.bitmapOrder,1)
		,c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #CustStatus temp ON temp.CustID = c.custid

	DROP TABLE #CustTemp
	DROP TABLE #CustStatus
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT,@max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 0
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20
 AND c.site <> 'CN88'

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

	EXEC dbo.Acc_CustomerInfo_Execrep_19 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT,@max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 0
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20
 AND c.site <> 'CN88'

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

	EXEC dbo.Acc_CustomerInfo_Execrep_19 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO