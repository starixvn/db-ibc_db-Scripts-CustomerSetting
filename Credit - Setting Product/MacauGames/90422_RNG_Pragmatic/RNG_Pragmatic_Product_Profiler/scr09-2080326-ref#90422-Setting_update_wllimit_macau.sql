/*
    Created: Vicky
    Date: 20180326
    Task: setting for WL limit for Macau game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_product SMALLINT = 22

        
---------------------------------------------------------------------------------------------------------
--update level to product
INSERT INTO [LossLimit_GlobalSetting] (ProductId,      ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT                                 @var_product,   72,         MinLossLimit, DefaultLossLimit
FROM [LossLimit_GlobalSetting] WHERE ProductId = @var_product and exchangeid= 20
