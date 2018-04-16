/*
    Created: Vicky
    Task: Batch 3 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 1
WHERE SportType = 208 AND 
      SiteID IN (SELECT siteid 
                 FROM [Site] 
                 WHERE [site] IN ('789y', '755555')
                 )
