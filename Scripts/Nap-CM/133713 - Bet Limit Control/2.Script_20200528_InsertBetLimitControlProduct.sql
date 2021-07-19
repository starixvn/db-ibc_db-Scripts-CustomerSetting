/*
	Created: 20200529@Eden
	Task: Insert offer product for BetLimitControl feature [Redmine:#132736]	
	DB: DBCUST/CustDB
*/
INSERT INTO BetLimitControlProduct(ProductID)
SELECT 1 UNION ALL --SB
SELECT 5 UNION ALL --Virtual Sport
SELECT 8 UNION ALL --RNG Keno
SELECT 23 UNION ALL --NG2
SELECT 28 UNION ALL --Lottery
SELECT 40 --Table Game