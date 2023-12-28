/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231006
	Task: get max custID
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
USE CustDB
GO

SELECT MAX (custid) AS max_custid
FROM Customer WITH (NOLOCK)
WHERE creatdate <= '2023-10-05' --Released date: RedmineID #174511
GO