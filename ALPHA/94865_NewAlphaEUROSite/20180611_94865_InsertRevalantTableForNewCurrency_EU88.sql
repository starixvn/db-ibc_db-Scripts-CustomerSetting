/*
	Created: 20180611@Elodie
	Task: Insert data into relevant table when inserting new currency for EU88
	DB: DBCUST/CustDB
*/
USE CustDB
GO
DECLARE @site INT, @ToCurrency INT

SELECT @site = 294, @ToCurrency = 3

--------------PlayCurrencySetting(AllBet)-----------------
INSERT INTO dbo.PlayCurrencySetting(SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate)
SELECT @site,'EU88',211,@ToCurrency,5,GETDATE(),'2050-01-01'

--------------WinLimit_ProductSettingDetail-----------------
--(All product apply CWL: Allbet,Bullfighting,Fishing World,Gold Deluxe,Keno,Lottery,Lucky 3,Macau Games,Number Game,Pragmatic,RNG Casino,Virtual Sports,Virtual Sports 2)
DELETE WinLimit_ProductSettingDetail WHERE ExchangeID NOT IN (78,72,20) AND SiteID = @site

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, ExchangeID, @site, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID NOT IN (78,72,20) AND SiteID = 1

UPDATE PSD
SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK)          
	INNER JOIN Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 
		AND PSD.ExchangeID NOT IN (78,72,20)
		AND PSD.SiteID = @Site


