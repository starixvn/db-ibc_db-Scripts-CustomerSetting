/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230714@Elodie
	Task: Update data site of tables: Customer [#RedmineID:#188707]
	DB: DBCust/CustDB
*/
USE CustDB
GO
-- 67 effected rows
UPDATE c
SET c.site = s.site
FROM customer c WITH (ROWLOCK)
	INNER JOIN Customer s WITH (NOLOCK) ON c.srecommend = s.custid
WHERE c.srecommend = 916498 and c.site <> '12Bet'

SELECT *
FROM customer c WITH (ROWLOCK)
	INNER JOIN Customer s WITH (NOLOCK) ON c.srecommend = s.custid
WHERE c.srecommend = 916498 and c.site <> '12Bet'