/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert product profile for VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT = 66, @sporttype smallint = 171, @bettype int = 3801

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])
SELECT @sporttype,@bettype, e.exchangeid AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM dbo.[Site] s WITH(NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK) 
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('733333','722222','222223','222225')
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
WHERE ProductId = 42 
	AND  e.exchangeid IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12, --GBP(GBP)
						45  --KRW(Won)
			)

/*
SELECT * FROM ProductSettingDetail WHERE ProductID = 66
SELECT * FROM ProductStatusProfile WHERE SportType = 171
SELECT * FROM dbo.SettingSystem 
SELECT * FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 66
SELECT * FROM dbo.ProductStatusSiteCurrency WHERE SportType = 171
*/




