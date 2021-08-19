/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20210819
	Task:  Insert ProductStatusSiteCurrency [RedmineID: #160419]
	DB: DBCust/CustDB
*/
USE CustDB
GO 

DECLARE @betType SMALLINT, @sportType SMALLINT
DECLARE @SiteOffer TABLE (SiteId INT)
DECLARE @CurrencyOffer TABLE (CurrencyID INT)

INSERT INTO @CurrencyOffer (CurrencyID)
SELECT 2 UNION ALL SELECT 67

INSERT INTO @SiteOffer (SiteId)
SELECT 23 UNION ALL SELECT 20 UNION ALL SELECT 21

-- Saba Virtual Sports : 98
SET @betType = 1 -- Handicap
SET @sportType = 98

-- delete old currency  
DELETE ps 
FROM ProductStatusSiteCurrency ps
	INNER JOIN @SiteOffer s ON s.SiteId = ps.SiteID
WHERE ps.SportType =@sportType
	AND ps.BetType = @betType

-- Insert new currency
INSERT INTO [ProductStatusSiteCurrency]
   ([SportType]
   ,[BetType]
   ,[Currency]
   ,[SiteID]
   ,[IsHidden]
   ,[IsDisabled]
   ,[HasSynced])
SELECT @sportType, @betType, CurrencyID, SiteID, 0, 0, 1
FROM @SiteOffer s
	CROSS JOIN @CurrencyOffer c 

