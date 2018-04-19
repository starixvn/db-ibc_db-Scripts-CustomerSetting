/*
    Created: 20180305@Vicky
    Task: delete Customer setting
    DB: DBCUST/CustDB
*/

--**************** BEGIN STEP 1: RUN THIS SCRIPT AT DBCUST SERVERS ****************
DECLARE @target VARCHAR(20) = 'REPLICATED'
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target, @sporttype = 193, @betType = 2801, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target, @sporttype = 180, @betType = 1201, @isDelPT = 0, @isDelBetSetting = 0,@isDelWinLoss = 1 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target, @sporttype = 192, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --WC
--**************** END STEP 1: RUN THIS SCRIPT AT DBCUST SERVERS ****************
