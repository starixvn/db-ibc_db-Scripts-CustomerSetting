/*
    Created: 20180305@Vicky
    Task: copy setting for newly created customer
    DB: DBCUST/CustDB
*/


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @maxcustid INT = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @maxcustid
         ,@productId = 5, @sporttypeDelegate = 180, @bettypeDelegate = 1201 
         ,@sportType = 193, @betType = 2801, @isLive = 0
         ,@SportTypeRef = 180, @BetTypeRef = 1201
         ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 1

EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @maxcustid
         ,@productId = 5, @sporttypeDelegate = 180, @bettypeDelegate = 1201 
         ,@sportType = 192, @betType = 2701, @isLive = 0
         ,@sportTypeRef = 191, @betTypeRef = 2701
         ,@isInsPT = 1, @isInsBetSetting = 1, @isInsWinLoss = 0
         