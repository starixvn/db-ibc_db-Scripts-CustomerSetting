/*
    Created: 20180305@Vicky
    Task: delete Customer setting
    DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx


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
    
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 180, @betType = 1201, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 181, @betType = 1231, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 182, @betType = 1231, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 183, @betType = 1231, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 184, @betType = 1231, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 185, @betType = 1231, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 186, @betType = 1220, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 190, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 191, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 192, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1
    EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @srecommendList = @srecommend, @maxcustid = @max_custid,@sporttype = 193, @betType = 2801, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 1

            
    WAITFOR DELAY '00:00:0.100'
END
GO