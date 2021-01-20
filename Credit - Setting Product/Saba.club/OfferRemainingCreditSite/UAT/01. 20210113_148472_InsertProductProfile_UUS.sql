/*
	Created: 20210113@Tina
	Task: Insert product profile for Saba.club [RedmineID: 148472] - Test currrency
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
FROM dbo.Site s WITH(NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK) 
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('222223', '611111', '722222', '733333', '7aa666', 'BEST-ODDS', 'KORIBC', 'XYZBET')
	AND e.exchangeid IN (20) -- ('UUS')
	AND NOT EXISTS (SELECT 1 
					FROM [ProductStatusSiteCurrency] PC WITH (NOLOCK) 
					WHERE PC.SportType = 200 AND PC.BetType = 1611 and PC.Currency = e.ExchangeId AND PC.SiteID = S.siteid)

