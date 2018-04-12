/*
    Created: 20180305@Vicky
    Task: delete Customer setting
    DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @target VARCHAR(20) = 'REPLICATED'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend VARCHAR(225)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM Customer c
    INNER JOIN CustPTSetting3rd_Agent csexist ON csexist.CustID = c.custid
    LEFT JOIN CustPTSetting3rd_Agent cs ON cs.CustID = c.custid and cs.SportType = 180
WHERE c.roleid = 4  AND cs.CustID IS NULL AND c.custid <= @max_custid
GROUP BY c.custid
    

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
    
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @target=@target @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 248, @betType = 4101, @isDelPT = 0, @isDelBetSetting = 1,@isDelWinLoss = 0
            
    WAITFOR DELAY '00:00:0.100'
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @target VARCHAR(20) = 'DBCUST'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend VARCHAR(225)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM Customer c
    INNER JOIN CustPTSetting3rd_Agent csexist ON csexist.CustID = c.custid
    LEFT JOIN CustPTSetting3rd_Agent cs ON cs.CustID = c.custid and cs.SportType = 180
WHERE c.roleid = 4  AND cs.CustID IS NULL AND c.custid <= @max_custid
GROUP BY c.custid
    

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
    
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @target=@target @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 248, @betType = 4101, @isDelPT = 0, @isDelBetSetting = 1,@isDelWinLoss = 0
            
    WAITFOR DELAY '00:00:0.100'
END
GO