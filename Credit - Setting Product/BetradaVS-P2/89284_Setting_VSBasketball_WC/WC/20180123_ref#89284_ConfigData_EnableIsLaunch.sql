/*
	Created: 20180223@Vicky
	Task: Enable isLaunch for VS Basketball and WC
	DB: DBCUST/CustDB
*/

UPDATE [ProductLaunchedSiteCurrency]
SET IsLaunched = 1
WHERE siteId = 1 AND SportType IN (192, 193)
