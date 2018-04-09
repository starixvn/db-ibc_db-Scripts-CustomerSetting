/*
    Created: 20180305@Vicky
    Task: copy setting for newly created customer
    DB: DBCUST/CustDB
*/


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @maxcustid INT = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @maxcustid = @maxcustid
         ,@productId = 32 
         ,@sportType = 248, @betType = 4101, @isLive = 0
         ,@SportTypeRef = 212, @BetTypeRef = 4001
         ,@isInsPT = 0, @isInsBetSetting = 1, @isInsWinLoss = 0
         