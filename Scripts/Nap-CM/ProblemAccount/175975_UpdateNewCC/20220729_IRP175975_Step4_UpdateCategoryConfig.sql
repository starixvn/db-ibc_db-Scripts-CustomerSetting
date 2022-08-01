/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220729@Johnson
	Task: Update New customer class for CategoryConfig [redmine:#175975]
	DB: DBCUST/CustDB
*/
DECLARE @tmpCC TABLE (OldCustomerClass SMALLINT, NewCustomerClass SMALLINT)
	
INSERT INTO @tmpCC(OldCustomerClass, NewCustomerClass)	
SELECT 	8	,	301
UNION SELECT 	9	,	302
UNION SELECT 	10	,	303
UNION SELECT 	12	,	304
UNION SELECT 	86	,	3001
UNION SELECT 	96	,	3002
UNION SELECT 	106	,	3003
UNION SELECT 	126	,	3004
UNION SELECT 	131	,	300
UNION SELECT 	132	,	3000

UPDATE c
SET c.CustomerClass = t.NewCustomerClass
FROM CategoryConfig c WITH(ROWLOCK)
	INNER JOIN @tmpCC t ON c.CustomerClass = t.OldCustomerClass
	
	