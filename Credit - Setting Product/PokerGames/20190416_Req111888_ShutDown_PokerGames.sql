/*
	Created: Elodie 
	Task: Shutdown PokerGames 
	DB: DBCUST/CustDB
	Date: 20190416
*/ 
USE CustDB
GO

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
WHERE SportType IN (163,165)



