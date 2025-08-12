/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250618@Johnson	
	Task: Update Max Payout Per Match for E-Sports [redmine:#230652]
	DB: DBCUST-CustDB
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE','DBSPARE1')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE','DBSPARE1')) RETURN -- run at dbcust only
	
	IF OBJECT_ID(N'BetSetting_Agent') IS NULL 
    OR OBJECT_ID(N'BetSetting_Member') IS NULL
		RETURN;
		
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)
	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

    INSERT INTO #tblCust (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 	
		AND Enabled = 1 
		AND custid <= @maxcustid

    WHILE(1=1)
    BEGIN
        DELETE TOP (5000) t
        OUTPUT DELETED.CustID INTO #tmpCust(custid)
        FROM #tblCust t
        WHERE roleid > 1

        IF @@ROWCOUNT = 0 BREAK 

        UPDATE BetSetting_Agent WITH (ROWLOCK)
        SET MaxPayoutPerMatch = 10*MaxPerMatch
        WHERE custid IN (SELECT CustID FROM #tmpCust)
            AND Sporttype IN (43,44)

        DELETE FROM #tmpCust    
    END

    WHILE(1=1)
    BEGIN
        DELETE TOP (5000) t
        OUTPUT DELETED.CustID INTO #tmpCust(custid)
        FROM #tblCust t
        WHERE roleid = 1

        IF @@ROWCOUNT = 0 BREAK 

        UPDATE BetSetting_Member WITH (ROWLOCK)
        SET MaxPayoutPerMatch = 10*MaxPerMatch
        WHERE custid IN (SELECT CustID FROM #tmpCust)
            AND Sporttype IN (43,44)

        DELETE FROM #tmpCust    
    END

    DROP TABLE #tblCust
    DROP TABLE #tmpCust
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE','DBSPARE1')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

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
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	--AND ci.currency <> 20

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, 
        @BeginTime DATETIME, @EndTime DATETIME, @ShowTime DATETIME,  @ConfigID INT
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
	
    SELECT @BeginTime = CONVERT(SMALLDATETIME,GETDATE())
            --,@ShowTime = DATEADD(MINUTE,-5,@BeginTime)
            ,@EndTime = DATEADD(MINUTE,30,@BeginTime)

    IF @@SERVERNAME IN ('DBCUST')
    BEGIN
        INSERT INTO [dbo].[UMConfig]
            ([ProductID]
            ,[SportType]
            ,[BetType]
            ,[IsLive]
            ,[SettingType]
            ,[FunctionType]
            ,[SiteID]
            ,[Currency]
            ,[SuperID]
            ,[BeginTime]
            ,[EndTime]
            ,[ShowTime]
            ,[LockAddingNew])
        SELECT 1,	0,	0,	0,	0,	1,	0,	0, @srecommend, @BeginTime, @EndTime, NULL, 0           

        SELECT @ConfigID = SCOPE_IDENTITY()
    END

    waitfor delay '00:00:0.200'
    
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target

    IF @@SERVERNAME IN ('DBCUST')
    BEGIN		
	    DELETE UMConfig WITH(ROWLOCK) WHERE ConfigID = @ConfigID
    END    		
	
END
drop table #supers
GO