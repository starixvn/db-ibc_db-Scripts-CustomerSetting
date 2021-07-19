/*
	Created: 20200728@Eden
	Task: Insert offer products for BetLimitControl feature - RNGWar [Redmine:#132736]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO BetLimitControlProduct(ProductID)
SELECT 50  --RNGWar