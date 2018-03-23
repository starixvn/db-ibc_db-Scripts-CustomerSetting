/*
    Created: 20180305@Vicky
    Task: Initial Customer setting
    DB: DBCUST/CustDB
*/


-- BEGIN STEP 1: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'DBCUST'

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
    
    --180
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 180, @BetType = 1201, @IsLive = 0
             ,@SportTypeRef = 220, @BetTypeRef = 1021
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1

   --181
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 181, @BetType = 1231, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
   --182    
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 182, @BetType = 1231, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
             
   --183
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 183, @BetType = 1231, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0   
             
   --184             
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 184, @BetType = 1231, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0   
             
   --185             
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 185, @BetType = 1231, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0 
             
   --186             
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 186, @BetType = 1220, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0             

   --190
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 190, @BetType = 2701, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0                
   --191
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 191, @BetType = 2701, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0   
             
   --192
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 192, @BetType = 2701, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0    
             
   --193
   EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommend, @maxcustid = @max_custid, @target = @var_target
             ,@ProductId = 5, @SporttypeDelegate = 180, @betTypeDelegate = 1201
             ,@SportType = 193, @BetType = 2801, @IsLive = 0
             ,@SportTypeRef = 180, @BetTypeRef = 1201
             ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0             
    WAITFOR DELAY '00:00:0.100'
END
GO