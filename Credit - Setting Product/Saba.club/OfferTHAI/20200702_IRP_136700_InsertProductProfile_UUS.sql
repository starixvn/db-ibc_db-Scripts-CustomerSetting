/*
	Created: 20200508@Elodie
	Task: Insert product profile for Saba.club
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
	AND s.site IN ('755555')
	AND e.exchangeid IN (20) -- ('UUS')





