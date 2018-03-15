/*
    Created: 20180305@Vicky
    Task: Initial Customer setting
    DB: DBCUST/CustDB
*/


-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'REPLICATED'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend VARCHAR(225)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.custid <= @max_custid

SET @var_msg_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR ('Total of supers: %d.', 0, 1, @var_msg_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = STR(custid)   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %s.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT2 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 193, @BetType = 2801, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT2 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 192, @BetType = 2701, @IsLive = 0
             ,@SportTypeRef = 191, @BetTypeRef = 2701
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
            
    WAITFOR DELAY '00:00:0.100'
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'DBCUST'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.custid <= @max_custid

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %d.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 193, @BetType = 2801, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 192, @BetType = 2701, @IsLive = 0
             ,@SportTypeRef = 191, @BetTypeRef = 2701
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
             
    WAITFOR DELAY '00:00:0.100'
END
GO