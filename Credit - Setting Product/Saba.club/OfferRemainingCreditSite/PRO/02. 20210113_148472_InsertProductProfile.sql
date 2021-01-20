/*
	Created: 20210113@Tina
	Task: Insert product profile for Saba.club [RedmineID: 148472]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @ProductID INT
SELECT @ProductID = 42

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])
SELECT 200,1611, e.exchangeid AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM dbo.[Site] s WITH(NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK) 
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.[site] IN ('222223', '611111', '722222', '733333', '7aa666', 'BEST-ODDS', 'KORIBC', 'XYZBET')
	AND e.exchangeid IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12, --GBP(GBP)
						45  --KRW(Won)
						
)

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 38 AND  e.exchangeid IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12, --GBP(GBP)
						45  --KRW(Won)
)

--SELECT * FROM ProductSettingDetail WHERE ProductID = 42
--SELECT * FROM ProductStatusProfile 
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 42
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 200

--DELETE FROM dbo.ProductStatusSiteCurrency WHERE SportType = 200 AND SiteID IN (487,11)





