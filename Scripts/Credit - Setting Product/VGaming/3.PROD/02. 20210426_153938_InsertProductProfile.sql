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
	AND s.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666')
	AND e.exchangeid IN (
							2,  --MYR(RM)
							3,  --USD(US$)
							5,  --HKD(HK$)
							6,  --EUR(EURO)
							7,  --VND(DON)
							9,  --AUD(AUD)
							12,  --GBP(GBP)
							13,  --CNY(RMB)
							15,  --IDR(IN)
							16,  --USD(Yen)
							22,  --IDR(IND)
							33,  --IDR(IDD)
							34,  --IDR(IDR)
							35,  --USD($US)
							41,  --CHF(CHF)
							43,  --THB(THB)
							45,  --KRW(Won)
							47,  --IDR(DDD)
							50,  --CAD(CAN)
							51,  --VND(INH)
							52,  --DKK(DKK)
							53,  --SEK(SEK)
							54,  --NOK(NOK)
							57,  --CZK(CZK)
							58,  --RON(RON)
							64,  --USD(UT)
							67,  --HKD(HKK)
							69,  --MMK(MMK)
							71,  --KHR(KHR)
							81,  --CNY(CY)
							95   --USD(USD)
						
)

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 42 
	AND  e.exchangeid IN (
							2,  --MYR(RM)
							3,  --USD(US$)
							5,  --HKD(HK$)
							6,  --EUR(EURO)
							7,  --VND(DON)
							9,  --AUD(AUD)
							12,  --GBP(GBP)
							13,  --CNY(RMB)
							15,  --IDR(IN)
							16,  --USD(Yen)
							22,  --IDR(IND)
							33,  --IDR(IDD)
							34,  --IDR(IDR)
							35,  --USD($US)
							41,  --CHF(CHF)
							43,  --THB(THB)
							45,  --KRW(Won)
							47,  --IDR(DDD)
							50,  --CAD(CAN)
							51,  --VND(INH)
							52,  --DKK(DKK)
							53,  --SEK(SEK)
							54,  --NOK(NOK)
							57,  --CZK(CZK)
							58,  --RON(RON)
							64,  --USD(UT)
							67,  --HKD(HKK)
							69,  --MMK(MMK)
							71,  --KHR(KHR)
							81,  --CNY(CY)
							95   --USD(USD)
			)

/*
SELECT * FROM ProductSettingDetail WHERE ProductID = 66
SELECT * FROM ProductStatusProfile WHERE SportType = 171
SELECT * FROM dbo.SettingSystem 
SELECT * FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 66
SELECT * FROM dbo.ProductStatusSiteCurrency WHERE SportType = 171
*/




