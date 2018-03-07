/*
	Created: 20180223@Vicky
	Task: Insert product profile for Virtual Soccer World Cup
	DB: DBCUST/CustDB
*/

UPDATE [ProductLaunchedSiteCurrency]
SET IsLaunched = 1
WHERE siteId = 1 AND SportType = 192
