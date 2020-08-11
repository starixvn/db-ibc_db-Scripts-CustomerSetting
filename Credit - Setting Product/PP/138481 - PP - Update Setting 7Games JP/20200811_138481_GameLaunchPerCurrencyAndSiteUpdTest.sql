/*
    Created: Winfred
    Task: Update data for GameLaunchPerCurrency, GameLaunchPerSite [Redmine: #138481]
    DB: DBCUST/CustDB
    Date: 20200811
*/
USE CustDB
GO

UPDATE glpc 
SET glpc.IsTest =  0
FROM GameLaunchPerCurrency glpc	WITH (ROWLOCK)
WHERE SportType = 248 AND BetType =	 4297


UPDATE glps
SET glps.IsTest =  0
FROM GameLaunchPerSite glps	WITH (ROWLOCK)
WHERE SportType = 248 AND BetType =	 4297
