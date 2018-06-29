/*
	Created: 20180629@Elodie
	Task: Close AllBet
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = 211 AND Currency <> 72