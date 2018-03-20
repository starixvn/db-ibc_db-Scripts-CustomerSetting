/*
    Created: Vicky
    Task: init data to test
    DB: DBCUST/CustDB
    Date: 20180220
*/

--offer for BEST-ODDS
UPDATE GameLaunchPerSite 
SET IsLaunched = 1
WHERE SportType = 208 AND SiteID = 1