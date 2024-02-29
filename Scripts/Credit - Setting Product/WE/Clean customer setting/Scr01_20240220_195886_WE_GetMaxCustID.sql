/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240220
	Task: WE Live Casino - Clean redundant customer setting data
		https://nexdev.net/issues/195886
	DB: DBCust-CustDB
*/ 
USE CustDB
GO

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)
GO