/*
    Created: Vicky
    Task: Batch 2 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 1
WHERE SportType = 208 
        AND IsLaunched = 0
        AND SiteID IN (  SELECT siteid 
	                     FROM [Site] 
	                     WHERE isLicensee = 0)
