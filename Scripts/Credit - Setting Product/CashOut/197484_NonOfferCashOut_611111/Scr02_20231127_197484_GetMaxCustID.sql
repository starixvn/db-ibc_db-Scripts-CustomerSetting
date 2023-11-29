/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231127
	Task: get max custID
		https://nexdev.net/issues/197484
	DB: DBCust/CustDB
*/ 
USE CustDB
GO

SELECT MAX (custid) AS max_custid
FROM Customer WITH (NOLOCK)
GO
