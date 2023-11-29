/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231120
	Task: Get Max CustID
		https://nexdev.net/issues/196503
	DB: DBCust/CustDB
*/
USE CustDB
GO

SELECT MAX(custid)
FROM custInfo WITH (NOLOCK)
GO