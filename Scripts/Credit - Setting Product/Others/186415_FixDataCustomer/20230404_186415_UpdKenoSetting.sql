/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Update value Status [#RM:174744]
	DB: DBCUST/CustDB 
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@Custid INT
	,@maxcustid INT
	,@Rule_RNGKeno INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT ( dbo.f_CheckRepTable('CustGameType') = 1
		)
	RETURN
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
	
	INSERT INTO #CustList(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.Enabled = 1
		AND ci.custid <= @maxcustid
	
	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustList WHERE isfinished = 0)
	BEGIN
		UPDATE TOP (@batch) #CustList 
		SET isfinished = 1
		OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
		WHERE isfinished = 0

		IF @@ROWCOUNT=0
			BREAK		
		
		--update hideKeno=1, miss update disabled=1 
		UPDATE cs
		SET cs.isDisabled = 1		
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp b ON cs.CustID = b.CustID
		WHERE  GameTypeID BETWEEN 1 AND 31 AND isDisabled = 0
		
		TRUNCATE TABLE #CustListTemp
	END
		
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @srecommend INT , @max_custid INT
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
		AND ci.custid <= @max_custid
		AND s.islicensee = 0
		AND (  ( ci.Site IN ('611111') AND ci.currency IN (2,42))
			OR ( ci.Site IN ('722222','733333') AND ci.currency IN (13))
			OR ( ci.Site IN ('789y') AND ci.currency IN (2,6))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (42)))
		
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

	EXEC dbo.Acc_CustSetting3rd_19 @custid = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	WAITFOR DELAY '00:00:0.100'
END
	DROP TABLE #supers
GO