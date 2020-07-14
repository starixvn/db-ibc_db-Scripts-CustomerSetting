/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200222
	Task:  Insert ProductStatusSiteCurrency [SabaGameSetting] - UUS RedmineID:#136210
	DB: DBCust/CustDB
*/
DECLARE @betType SMALLINT,@siteID SMALLINT,@sportType SMALLINT
-- Saba Virtual Sports : 98
SET @betType = 1 -- Handicap
SET @siteID = 487 --IBCIndo
SET @sportType = 98
-- delete old currency  
DELETE FROM ProductStatusSiteCurrency 
WHERE SportType =@sportType
	AND BetType = @betType
	AND SiteID = 487
-- Insert new currency
INSERT INTO [ProductStatusSiteCurrency]
   ([SportType]
   ,[BetType]
   ,[Currency]
   ,[SiteID]
   ,[IsHidden]
   ,[IsDisabled]
   ,[HasSynced])
-- Saba Virtual Sports - All currency
VALUES 
(
	@sportType,
	@betType,
	0,-- Currency
	487,-- SiteID
	0,-- IsHidden
	0,-- IsDisabled
	1-- HasSynced) 
 )
		 	

