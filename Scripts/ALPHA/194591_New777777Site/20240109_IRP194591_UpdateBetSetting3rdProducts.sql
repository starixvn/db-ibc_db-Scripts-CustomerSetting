/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240109@Johnson
	Task: Update bet setting 3rd products for new site 777777, currency PC
	DB: DBCUST/CustDB
*/

DECLARE @siteID INT, @Currency INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

DELETE StakeLevel WITH(ROWLOCK)
WHERE GameTypeID IN (2401, 3151)
	AND ExchangeId = @Currency
	
--Add data for StakeLevel
INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT 2401, '50', '20,000', 50, 20000, @currency, NULL, 0 -- Allbet
UNION SELECT 2401, '100', '50,000', 100, 50000, @currency, NULL, 0
UNION SELECT 2401, '500', '100,000', 500, 100000, @currency, NULL, 0
UNION SELECT 2401, '1000', '200,000', 1000, 200000, @currency, NULL, 0

UNION SELECT 3151, '50', '20,000', 50, 20000, @currency, NULL, 0--Yeebet	
UNION SELECT 3151, '100', '50,000', 100, 50000, @currency, NULL, 0
UNION SELECT 3151, '200', '100,000', 200, 100000, @currency, NULL, 0
UNION SELECT 3151, '500', '200,000', 500, 200000, @currency, NULL, 0