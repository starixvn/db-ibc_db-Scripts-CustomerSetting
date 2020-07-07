/*<info serverAlias=”DBCUST-CustDB” ></info>*/
/*
    Created: Winfred
    Date: 20200707
    Task: Del Manage ProductLaunchSiteCurrency / Can See : #131241
    DB: DBCUST-CustDB
*/ 
IF EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductLaunchedSiteCurrency plsc WITH(NOLOCK)
				WHERE 	plsc.IsLaunched = 0 )
BEGIN
	DELETE FROM dbo.ProductLaunchedSiteCurrency WHERE IsLaunched = 0 
END 