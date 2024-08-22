/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: get max custID
		https://nexdev.net/issues/205654
	DB: DBCust/CustDB
*/ 
USE CustDB
GO

SELECT MAX (custid) AS max_custid
FROM Customer WITH (NOLOCK)
GO
