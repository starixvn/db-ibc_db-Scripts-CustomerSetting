/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@202305230
	Task: Delete redudant data of the following tables [Redmine: #162050]   
		CustMaxPayoutSetting_Member
		CustMaxPayoutSetting_Agent
	DB: DBCUST/CustDB and all subscribers of CustDB_CustSetting publication
*/
-- STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_09
	 @CustList VARCHAR(MAX)
	,@target VARCHAR(20)
	,@Mode TINYINT -- 1: SMA, 2: Member

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustMaxPayoutSetting_Member') = 1
	   AND dbo.f_CheckRepTable('CustMaxPayoutSetting_Agent') = 1
	   )
		RETURN

	DECLARE @Custtemp TABLE (CustID INT PRIMARY KEY)

	INSERT INTO @Custtemp (CustID)
	SELECT a.value
	FROM string_split(@CustList,',') a
	WHERE a.value <> ''
		
	IF @Mode = 1
	BEGIN
		DELETE c
		FROM CustMaxPayoutSetting_Agent c WITH(ROWLOCK,UPDLOCK,FORCESEEK)
			INNER JOIN @Custtemp t
				ON t.CustID = c.CustID
	END
	ELSE
	BEGIN
		DELETE c
		FROM CustMaxPayoutSetting_Member c WITH(ROWLOCK,UPDLOCK,FORCESEEK)
			INNER JOIN @Custtemp t
				ON t.CustID = c.CustID
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS and DBCUST -----
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step : Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target
DECLARE @batch INT = 2000
DECLARE @CustList VARCHAR(MAX) = ''

CREATE TABLE #SMATemp(CustID INT)
CREATE TABLE #MemberTemp(CustID INT)
CREATE TABLE #TempBatch(CustID INT)

INSERT INTO #SMATemp(CustID)
SELECT DISTINCT c.CustID
FROM CustMaxPayoutSetting_Agent c WITH (NOLOCK)
	LEFT JOIN custinfo ci WITH(NOLOCK)
		ON c.CustID = ci.custid
WHERE ci.custid IS NULL

INSERT INTO #MemberTemp(CustID)
SELECT DISTINCT c.CustID
FROM CustMaxPayoutSetting_Member c WITH (NOLOCK)
	LEFT JOIN custinfo ci WITH(NOLOCK)
		ON c.CustID = ci.custid
WHERE ci.custid IS NULL

-- For deployer info
DECLARE @cnt INT
	, @msg_total NVARCHAR(200) = 'Total redudant SMA(s) : %d.'
	, @index INT = 0
	, @msgtmp nvarchar(200) =  'Processing %d/%d'
	, @totalBatch INT

SET @cnt = (SELECT COUNT(*) FROM #SMATemp )
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

SELECT @totalBatch = @cnt/@batch + 1

-------process for SMA
WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #TempBatch
	SET @CustList = ''

	DELETE TOP (@batch) t 
	OUTPUT deleted.CustID INTO #TempBatch(CustID)
	FROM #SMATemp t	
	
	IF @@ROWCOUNT = 0 
		BREAK

	SET @index = @index + 1
	RAISERROR (@msgtmp, 0, 1,@index, @totalBatch) WITH NOWAIT


	SELECT @CustList = @CustList +  CONVERT( VARCHAR(MAX), ',' + CONVERT(VARCHAR(10),CustID))
	FROM #TempBatch

	EXEC dbo.Acc_DynamicCustSetting3rd_09 
				@CustList = @CustList, 
				@target = @target,
				@Mode = 1
			
	WAITFOR DELAY '00:00:00.050'
END
-------process for SMA - END
-------process for Member
SET @msg_total = 'Total redudant Member(s) : %d.'

SET @cnt = (SELECT COUNT(*) FROM #MemberTemp )
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

SELECT @totalBatch = @cnt/@batch + 1
SET @index = 0

WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #TempBatch
	SET @CustList = ''

	DELETE TOP (@batch) t 
	OUTPUT deleted.CustID INTO #TempBatch(CustID)
	FROM #MemberTemp t	
	
	IF @@ROWCOUNT = 0 
		BREAK

	SET @index = @index + 1
	RAISERROR (@msgtmp, 0, 1,@index, @totalBatch) WITH NOWAIT

	SELECT @CustList = @CustList +  CONVERT( VARCHAR(MAX), ',' + CONVERT(VARCHAR(10),CustID))
	FROM #TempBatch

	EXEC dbo.Acc_DynamicCustSetting3rd_09 
				@CustList = @CustList, 
				@target = @target,
				@Mode = 2
			
	WAITFOR DELAY '00:00:00.050'
END
-------process for Member --END
drop table #MemberTemp
drop table #SMATemp
drop table #TempBatch

PRINT N'Step : End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF
GO