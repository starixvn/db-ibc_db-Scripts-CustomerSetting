/*<info serverAlias="DBCUST-CUSTDB"></info>*/
 /*
	Created: 20200522@Eden
	Task: Correct CustDirectAccount Table [Redmine:#83206]	
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO

DELETE cd
FROM CustDirectAccount cd WITH(ROWLOCK)
	INNER JOIN Acc_CustDirect ac WITH(NOLOCK)
		ON ac.custid = cd.CustID
	INNER JOIN custInfo c  WITH(NOLOCK) 
		ON c.custid = ac.custid
