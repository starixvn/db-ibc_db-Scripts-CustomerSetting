/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230807@Tacy
	Task: Get maxCustID
	DB: DBCust/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO