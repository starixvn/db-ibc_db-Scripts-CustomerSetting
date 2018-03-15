/*
    Created: 20180305@Vicky
    Task: Initial Customer setting
*/


-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @max_custid, @target = 'REPLICATED'
         ,@productId = 5, ,@sporttypeDelegate = 180, @sportType 193, @betType = 2801, @isLive = 0
         ,@SportTypeRef = 180, @BetTypeRef = 1201, @isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1

EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @max_custid, @target = 'REPLICATED'
         ,@productId = 5, ,@sporttypeDelegate = 180, @sportType 192, @betType = 2701, @isLive = 0
         ,@sportTypeRef = 191, @betTypeRef = 2701, @isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
            


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
    
EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @max_custid, @target    = 'DBCUST'
         ,@productId = 5, ,@sporttypeDelegate = 180, @sportType 193, @betType = 2801, @isLive = 0
         ,@sportTypeRef = 180, @betTypeRef = 1201, @isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1

EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @max_custid, @target    = 'DBCUST'
         ,@productId = 5, ,@sporttypeDelegate = 180, @sportType 192, @betType = 2701, @isLive = 0
         ,@sportTypeRef = 191, @betTypeRef = 2701, @isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
         