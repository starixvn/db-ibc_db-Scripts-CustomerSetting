/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
*/ 
--	Keno
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	CREATE TABLE #DownlineTemp ( 
		CustID INT PRIMARY KEY, 
		IsFinishedStatus BIT DEFAULT(0)
	)	
	
	INSERT INTO #DownlineTemp(custid)	
	SELECT VALUE AS RuleID 
	FROM STRING_SPLIT(@CustIDs,',') WHERE VALUE <> ''

	----------------------------------------BetSetting------------------------------------
	DECLARE @MemberBatch TABLE(CustId INT)
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedStatus = 1
		OUTPUT INSERTED.CustID INTO @MemberBatch
		FROM #DownlineTemp t
		WHERE IsFinishedStatus = 0
	 
		IF @@ROWCOUNT = 0
			BREAK
		
		--update disabled=0 miss update hideKeno=0 
		UPDATE g 
		SET HideKeno = 0
		FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @MemberBatch b ON g.CustID = b.CustID 

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
--Create Supers temp table:
DECLARE @max_custid INT

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
PRINT 'Server Name : ' + @target

DECLARE @batch SMALLINT = 20000
DECLARE @CustIDs VARCHAR(MAX) = ''
CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Cust: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM Temp_DownlineTemp )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''

	UPDATE TOP (@batch) a
	SET a.IsFinishedStatus = 1
	OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
	FROM Temp_DownlineTemp a	
	WHERE IsFinishedStatus = 0 
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + @batch
	RAISERROR (@msg, 0, 1, @index) WITH NOWAIT

	SET @CustIDs = @CustIDs + (SELECT string_agg(convert(varchar(max),custid),',')  FROM #tmpCustTemp)

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			@CustIDs = @CustIDs
			,@target = @target
	
	TRUNCATE TABLE #tmpCustTemp
	WAITFOR DELAY '00:00:0.1'
END
DROP TABLE #tmpCustTemp
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------