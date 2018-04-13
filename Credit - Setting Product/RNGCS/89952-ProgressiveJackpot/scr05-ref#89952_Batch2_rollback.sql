/*
    Created: Vicky
    Task: release Batch 1 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 0
WHERE SportType = 208 AND 
      SiteID IN (SELECT siteid 
                 FROM [Site] 
                 WHERE [site] IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet')
                 )
