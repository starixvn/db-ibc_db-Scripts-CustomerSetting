/*<info serverAlias="DBCUST-CUSTDB"></info>*/ 
/*
	Created: 20210527@Eden
	Task: UPDATE CM - SupertestTE01 [RM#136423]
	DB: DBCUST/CUSTDB
*/

USE CustDB
GO
UPDATE CustSuper WITH(ROWLOCK,UPDLOCK)
SET CurrencyModifier = 1
WHERE custid = 23003140