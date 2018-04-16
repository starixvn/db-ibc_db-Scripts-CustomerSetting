/*
    Created: Vicky
    Task: Batch 1 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 0
WHERE SportType = 208 AND 
      SiteID IN (SELECT siteid 
                 FROM [Site] 
                 WHERE [site] IN ('INDO', 'Koribc')
                 )
