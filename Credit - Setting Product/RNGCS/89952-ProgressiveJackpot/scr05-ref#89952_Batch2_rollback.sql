/*
    Created: Vicky
    Task: Batch 2 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 0
WHERE SportType = 208 AND IsLaunched = 1 
        AND SiteID NOT IN (
                        SELECT siteid 
                        FROM [Site] 
                        WHERE [site] IN ('INDO', 'Koribc')
                      )
