/*
    Created: 20180305@Vicky
    Task: delete Customer setting
    DB: DBCUST/CustDB
*/

--**************** BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS ****************
EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @target='REPLICATED', @sporttype = 193, @betType = 2801, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @target='REPLICATED', @sporttype = 180, @betType = 1201, @isDelPT = 0, @isDelBetSetting = 0,@isDelWinLoss = 1 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09_UAT1 @target='REPLICATED', @sporttype = 192, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --WC
--**************** END STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS ****************




-- ****************BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST *****************
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target='DBCUST', @Sporttype = 193, @betType = 2801, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target='DBCUST', @Sporttype = 180, @betType = 1201, @isDelPT = 0, @isDelBetSetting = 0,@isDelWinLoss = 1 --VSBasketball
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target='DBCUST', @Sporttype = 192, @betType = 2701, @isDelPT = 1, @isDelBetSetting = 1,@isDelWinLoss = 0 --WC
-- ****************END STEP 2: RUN THIS SCRIPT AT DBCUST *****************