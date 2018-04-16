/*
    Created: Vicky
    Task: set IsLaunched = 0 [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20180413
*/

UPDATE GameLaunchPerSite
SET IsLaunched = 0
WHERE SportType = 208