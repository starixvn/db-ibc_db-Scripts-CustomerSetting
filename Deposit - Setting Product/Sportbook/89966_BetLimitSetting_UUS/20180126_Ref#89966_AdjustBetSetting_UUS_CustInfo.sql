/*
	Created: 20180130@Vicky
	Task: Adjust MinBet/MaxBet/MaxPerMatch/MaxPerBall for Sportbook,NumberGame,VirtualSport
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY TWO SP on @DBCUST.CustDB --------
-----------------------------Change SP Acc_CustomerInfo_Execrep_09 to update Customer INFO---------------------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
    @srecommend INT 
    ,@maxcustid INT
    ,@target VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON
    
    IF (@target = 'REPLICATED' AND @@SERVERNAME =  'DBCUST') RETURN -- run at all replicated servers
    IF (@target = 'DBCUST'     AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
    
    RAISERROR ('Run at server: %s', 0, 1, @@SERVERNAME) WITH NOWAIT
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN

    CREATE TABLE #Selected (custid INTEGER PRIMARY KEY)
    DECLARE @Batch TABLE   (custid INTEGER PRIMARY KEY)

    DECLARE @MinBet MONEY       = 1
    DECLARE @MaxBet MONEY       = 10
    DECLARE @MaxPerMatch MONEY  = 100
    DECLARE @MaxPerBall MONEY   = 100
    
    INSERT #Selected (custid)
    SELECT custid
    FROM dbo.custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND custid <= @maxcustid

    DECLARE @var_num_cust INT
    SET @var_num_cust = (SELECT COUNT(*) FROM #Selected)
    RAISERROR ('Total customer: %d', 0, 1, @var_num_cust) WITH NOWAIT
    
    WHILE 1 = 1
    BEGIN
        DELETE TOP (5000) #Selected
        OUTPUT DELETED.custid INTO @Batch

        IF @@ROWCOUNT = 0 BREAK
        
        --update maxpermax/MaxPerBall for sportbook/numbergame
        UPDATE custinfo WITH (ROWLOCK, UPDLOCK)
        SET     
            MaxPerMatch     = @MaxPerMatch,
            MaxPerMatch2    = @MaxPerMatch,
            MaxPerMatch3    = @MaxPerMatch,
            MaxPerMatch5    = @MaxPerMatch,
            MaxPerMatch8    = @MaxPerMatch,
            MaxPerMatch10   = @MaxPerMatch,
            MaxPerMatch11   = @MaxPerMatch,
            MaxPerMatch99   = @MaxPerMatch,
            MaxPerMatch99MP = @MaxPerMatch,
            MaxPerMatch1MP  = @MaxPerMatch,
            MaxPerMatch154  = @MaxPerMatch,
            MaxPerMatch161  = @MaxPerMatch,
            MaxPerBall161   = @MaxPerBall
        WHERE custid IN (SELECT b.custid FROM @Batch AS b)
        
        RAISERROR ('Total affected row : %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        DELETE @Batch
    END 
END
GO
----------------- END STEP 1 --------
----------------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'REPLICATED'


CREATE TABLE #supers (custid INTEGER PRIMARY KEY, isfinished bit default(0))
DECLARE @srecommend INT
DECLARE @var_super_total INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'


INSERT INTO #supers(custid)
SELECT custid 
FROM dbo.Dep_CustSuper c INNER JOIN DBLIC.bodb_Licensee.dbo.Licensees l ON c.[site] = l.[LicenseeName]
WHERE   l.isActive = 1 
    AND l.[LicenseeName] NOT IN ('haifa','BBin2') 
    AND c.currency = 20
    AND c.custid <= @max_custid

    
SET @var_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @var_super_total) WITH NOWAIT


WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @index = @index + 1
    RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

    EXEC dbo.Acc_CustomerInfo_Execrep_09
            @srecommend = @srecommend
            ,@maxcustid = @max_custid
            ,@target    = @var_target
            
    WAITFOR DELAY '00:00:0.100'
END
GO
----------- END STEP 2 -----



-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'DBCUST'


CREATE TABLE #supers (custid INTEGER PRIMARY KEY, isfinished bit default(0))
DECLARE @srecommend INT
DECLARE @var_super_total INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'


INSERT INTO #supers(custid)
SELECT custid 
FROM dbo.Dep_CustSuper c INNER JOIN DBLIC.bodb_Licensee.dbo.Licensees l ON c.[site] = l.[LicenseeName]
WHERE   l.isActive = 1 
    AND l.[LicenseeName] NOT IN ('haifa','BBin2') 
    AND c.currency = 20
    AND c.custid <= @max_custid

    
SET @var_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @var_super_total) WITH NOWAIT


WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @index = @index + 1
    RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target    = @var_target
			
	WAITFOR DELAY '00:00:0.100'
END
GO
------------ END STEP 3------------

