/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240111@Johnson
	Task: Update SABA casino profile for new site 777777
	DB: DBCUST/CustDB
*/


DELETE ProductProfileSiteCurrency WITH(ROWLOCK)
WHERE SiteID = 1216 
	AND ProductSettingID = 341

