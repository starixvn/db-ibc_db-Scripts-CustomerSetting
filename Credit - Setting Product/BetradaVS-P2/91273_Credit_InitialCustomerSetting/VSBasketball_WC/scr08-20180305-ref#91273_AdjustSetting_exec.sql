/*
    Created: Vicky
    Task: Adjust Setting
    DB: DBCUST/CustDB
    Date: 20180308
*/ 

-- RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 
             @sportType = 193, @betType = 2801, @isLive = 0
             ,@sportTypeRef = 180, @betTypeRef = 1201
             ,@isCheckPT = 1, @isCheckBetSetting = 1, @isCheckWinLoss = 0

EXEC dbo.Acc_DynamicCustSetting3rd_09
             @sportType = 192, @betType = 2701, @isLive = 0
             ,@sportTypeRef = 191, @betTypeRef = 2701
             ,@isCheckPT = 1, @isCheckBetSetting = 1, @isCheckWinLoss = 0

