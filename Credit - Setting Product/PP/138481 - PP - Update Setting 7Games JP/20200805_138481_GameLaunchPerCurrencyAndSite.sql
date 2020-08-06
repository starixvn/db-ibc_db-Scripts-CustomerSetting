/*
    Created: Elodie
    Task: initial data for GameLaunchPerCurrency, GameLaunchPerSite [Redmine: #89952]
    DB: DBCUST/CustDB
    Date: 20200805
*/
USE CustDB
GO

INSERT INTO GameLaunchPerCurrency(SportType,BetType,Currency,IsLaunched,IsTest)
SELECT 248,4297,exchangeid,1,1
FROM exchange

INSERT INTO GameLaunchPerSite(SportType,BetType,[SiteId],IsLaunched,IsTest)
SELECT 248,4297,[siteId],1,1
FROM [Site]
