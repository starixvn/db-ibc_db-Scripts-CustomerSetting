/*
	Created: Winnie
	Date: 20190826
	Task: BetBuilder Update UUS for testing [RedmineID: #105664]
	DB: DBCust/CustDB
*/
Update c
SET IsLaunched=0
from ProductLaunchedSiteCurrency c WITH(ROWLOCK,UPDLOCK) where SportType=1 and BetType=38
AND SiteID=1 AND Currency=20