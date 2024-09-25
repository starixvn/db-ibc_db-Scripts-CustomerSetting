/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 2024/04/17 Helios
	Task: Customer Setting - Unify Live Casino & RNG slot/RNG Casino [RM:#198960]   
	DB: DBTXN/bodb02
*/


UPDATE wp
	SET 
		wp.BetType = CASE 
					WHEN wp.ProductID IN (6,38,42,66) THEN 4601
					WHEN wp.ProductID = 50 THEN 4001
					WHEN wp.ProductID = 70 THEN 8201
				END,
		wp.IsActive_SMA = 1
FROM WinLimit_ProductOffer wp WITH (ROWLOCK ,UPDLOCK)
WHERE ProductID IN (6,38,42,66,50,70) 
