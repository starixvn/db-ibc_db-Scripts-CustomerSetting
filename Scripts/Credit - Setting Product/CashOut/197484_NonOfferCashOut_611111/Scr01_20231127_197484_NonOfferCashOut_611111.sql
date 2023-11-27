/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231127
	Task: Non offer Cash Out for site 611111
		https://nexdev.net/issues/197484
	DB: DBCust/CustDB
*/ 
USE CustDB
GO

INSERT INTO ProductStatusSiteCurrency ([SportType], [BetType], [Currency], [SiteID], [IsHidden], [IsDisabled], [HasSynced])
SELECT 9903, 1, 0, 16, 1, 1, 1
GO