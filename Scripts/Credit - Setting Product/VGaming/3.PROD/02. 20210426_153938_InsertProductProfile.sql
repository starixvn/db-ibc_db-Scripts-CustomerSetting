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
	AND s.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666', 'IBCIndo')
	AND e.exchangeid IN (
							13, --CNY(RMB)
							6, --EUR(EURO)
							12, --GBP(GBP)
							5, --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2, --MYR(RM)
							43, --THB(THB)
							35, --USD($US)
							3, --USD(US$)
							95, --USD(USD)
							64, --USD(UT)
							16 --USD(Yen)
						
)

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 42 
	AND  e.exchangeid IN (
							13, --CNY(RMB)
							6, --EUR(EURO)
							12, --GBP(GBP)
							5, --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2, --MYR(RM)
							43, --THB(THB)
							35, --USD($US)
							3, --USD(US$)
							95, --USD(USD)
							64, --USD(UT)
							16 --USD(Yen)
			)

/*
SELECT * FROM ProductSettingDetail WHERE ProductID = 66
SELECT * FROM ProductStatusProfile WHERE SportType = 171
SELECT * FROM dbo.SettingSystem 
SELECT * FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 66
SELECT * FROM dbo.ProductStatusSiteCurrency WHERE SportType = 171
*/




