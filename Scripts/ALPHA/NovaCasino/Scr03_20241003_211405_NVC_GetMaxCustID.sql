/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20241003
	Task: NovaCasino - Get max CustID [Redmine: #211405]
	DB: DBCust-CustDB
*/ 

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)
GO