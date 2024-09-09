/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230328
	Task: Update SportID of CustomerClassSetting Feature name[redmine: #210321]
	DB: DBCUST-CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_19]
 	 @CustIDs VARCHAR(MAX) 	= ''
	, @target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbtrans only
	
	IF NOT (dbo.f_CheckRepTable('CustomerClassSetting') = 1 )
		RETURN
	
	CREATE TABLE #CustListID (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustListID(custid)	
	SELECT VALUE AS custid 
	FROM STRING_SPLIT(@CustIDs,',') WHERE VALUE <> ''

	DELETE a 
	FROM CustomerClassSetting a WITH (ROWLOCK)
		INNER JOIN #CustListID b ON a.CustID = b.CustID
	WHERE (a.SportType = 145 AND EXISTS(SELECT TOP 1 1 FROM CustomerClassSetting WITH(NOLOCK) WHERE custid = a.custid AND SportType IN (9901)))
	OR (a.SportType = 912 AND EXISTS(SELECT TOP 1 1 FROM CustomerClassSetting WITH(NOLOCK) WHERE custid = a.custid AND SportType IN (9902)))
	OR (a.SportType = 107 AND EXISTS(SELECT TOP 1 1 FROM CustomerClassSetting WITH(NOLOCK) WHERE custid = a.custid AND SportType IN (9921)))

	UPDATE a 
	SET a.SportType = CASE WHEN a.SportType = 145 THEN 9901 --Saba Soccer
						   WHEN a.SportType = 912 THEN 9902 --Saba Basketball
						   WHEN a.SportType = 107 THEN 9921 --Parlay
						ELSE a.SportType END
	FROM CustomerClassSetting a WITH(ROWLOCK, UPDLOCK) 
	INNER JOIN #CustListID c ON a.CustID = c.CustID
	WHERE NOT EXISTS(SELECT TOP 1 1 FROM CustomerClassSetting WITH(NOLOCK) 
					WHERE custid = a.custid AND 
					((a.SportType = 145 AND SportType = 9901) OR (a.SportType = 912 AND SportType = 9902) OR (a.SportType = 107 AND SportType = 9921)))


	DROP TABLE #CustListID
END
GO
------------------------------------------------------	
-- BEGIN Step 2: Run this SP at DBCUST & replicated DB
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE SET @target = 'REPLICATED'

CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)

INSERT INTO #CustList(CustID)
SELECT DISTINCT CustID
FROM CustomerClassSetting WITH(NOLOCK) 

DECLARE @cust_cnt INT, @index INT = 0
SET @cust_cnt = (SELECT COUNT(*) FROM #CustList )
DECLARE @CustIDs VARCHAR(MAX) 
DECLARE @batch SMALLINT = 2500
DECLARE @msg nvarchar(200) = 'Currently at order %d.'
DECLARE @msg_total nvarchar(200) = 'Total of CustID: %d.'

RAISERROR (@msg_total, 0, 1, @cust_cnt) WITH NOWAIT

WHILE(1=1)
BEGIN
	SELECT @CustIDs = ''

	UPDATE TOP(@batch) t
	SET IsFinished = 1
	OUTPUT INSERTED.CustID INTO #CustListTemp(CustID)	
	FROM #CustList t 
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
	BREAK;
	
	SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',') FROM #CustListTemp)

	SET @index = @index + @batch
	
	RAISERROR (@msg, 0, 1,@index) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_19] 
				@CustIDs = @CustIDs, 
				@target = @target
				
	TRUNCATE TABLE #CustListTemp
	WAITFOR DELAY '00:00:00.050'	
END	

DROP TABLE #CustList	
GO