/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230918@Eden
	Task: Delete redudant customers [#RedmineID:#181595]
	DB: DBCUST/CustDB 
*/
USE custdb
GO
CREATE TABLE #Cust_redudant(CustID INT)

--> Get redudant data
INSERT INTO #Cust_redudant(CustID)
SELECT c.custid
FROM dbo.vw_Customer c WITH (NOLOCK)
	LEFT JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
WHERE c.site in ('789y')
	AND ci.custid IS NULL
	AND c.custid IN(
		 62737790
		,62737781
		,72277109
		,72281752
		,72277148
		,72284437
		,72275260
		,72231131
		,62737826
		,72275509
	)

SELECT * FROM #Cust_redudant

--> Delete redudant
DELETE c
FROM #Cust_redudant t
	INNER JOIN dbo.Customer c WITH (ROWLOCK,UPDLOCK) 
		ON t.custid = c.custid

DROP TABLE #Cust_redudant