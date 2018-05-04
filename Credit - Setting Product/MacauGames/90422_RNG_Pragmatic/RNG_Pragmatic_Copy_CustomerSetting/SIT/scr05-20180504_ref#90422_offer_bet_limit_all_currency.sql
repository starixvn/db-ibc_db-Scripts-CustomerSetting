/*
    Created: Vicky
    Date: 20180504
    Task: update LossLimit_GlobalSetting 
    DB: DBCUST/CustDB
*/ 
INSERT INTO LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT 22, ex.exchangeid, 1.00, 2000
FROM Exchange ex
WHERE ex.exchangeid NOT IN (SELECT ExchangeId 
                            FROM LossLimit_GlobalSetting 
                            WHERE ProductID = 22)


