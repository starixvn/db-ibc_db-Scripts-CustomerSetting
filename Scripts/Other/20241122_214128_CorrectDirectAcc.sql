/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie@20241122
	Task: Correct Direct Acc [Redmine:#214128]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE da 
FROM CustDirectAccount da WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON da.CustID = ci.custid
WHERE srecommend = 1176070 AND da.custid <> 1176070

DELETE da 
FROM Acc_CustDirect da WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON da.CustID = ci.custid
WHERE srecommend = 1176070

GO