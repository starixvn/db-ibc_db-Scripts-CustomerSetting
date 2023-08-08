/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230808@Luke
	Task: YeeBet - Change Bet Limit [Redmine: #191947]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS max_custid
FROM custinfo WITH (NOLOCK)