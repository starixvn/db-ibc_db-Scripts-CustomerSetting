/*
	Created: Elodie	
	Task:  Update BonusWalletFlag
	DB: DBCUST/CustDB
	Date: 20180223
*/  

DECLARE  @max_custid INT
SELECT @max_custid = xxx

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT c.custid
FROM custInfo c WITH(NOLOCK)
	INNER JOIN Dep_CustSuper s WITH(NOLOCK) ON s.custid = c.custid
WHERE c.roleid = 4

UPDATE ci
SET	ci.BonusWalletFlag=0
FROM CustInfo ci WITH (ROWLOCK,UPDLOCK) 
	INNER JOIN #supers s ON s.custid = ci.srecommend
WHERE ci.custid > @max_custid AND roleid = 1


