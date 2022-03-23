/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220323
	Task: update licensee odds group for customers
	DB: DBCust/CustDB
*/
CREATE TABLE #CustBatch (CustId INT)
SELECT c.custid, roleid, 0 AS IsFinished INTO #CustList
FROM Dep_CustSuper s WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON s.custid = c.srecommend
WHERE c.ugroup IN ('hka','hkb','hkc','hkd')

WHILE (1=1)
BEGIN
	UPDATE TOP (4000) t
	SET IsFinished = 1
	OUTPUT deleted.custid INTO #CustBatch
	FROM #CustList t
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE c
	SET c.ugroup = CASE WHEN ugroup = 'hka' THEN 'a'
						WHEN ugroup = 'hkb' THEN 'b'
						WHEN ugroup = 'hkc' THEN 'c'
						WHEN ugroup = 'hkd' THEN 'd' END
	FROM Customer c WITH (ROWLOCK)
		INNER JOIN #CustBatch t ON c.custid = t.CustId
END