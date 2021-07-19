/*
	Created: 20200716@Eden
	Task: Insert offer products for BetLimitControl feature - RNGWar [Redmine:#133713]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO BetLimitControlProduct(ProductID)
SELECT 50  --RNGWar