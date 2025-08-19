/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250819@Elodie
	Task: Insert data into CustSearch [Redmine:#236418]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO CustSearch([userid], [username], [searchcount], [firstname], [lastname], [Currency], [GroupName], [username2], [RepUpdateTime])
SELECT 5284570,username, 1, NULL, NULL, NULL, 'ACCTHAI', NULL, dbo.f_GetDateTime2()
FROM vw_Customer c WITH (NOLOCK)
	INNER JOIN dbo.Acc_CustGroup g WITH(NOLOCK) ON c.srecommend = g.custid
WHERE c.roleid IN (3, 4)
	AND username LIKE 'SM%'
	AND GroupName = 'ACCTHAI'
    AND username NOT IN (SELECT username FROM CustSearch (NOLOCK) WHERE userid = 5284570 and groupname = 'ACCTHAI')



	