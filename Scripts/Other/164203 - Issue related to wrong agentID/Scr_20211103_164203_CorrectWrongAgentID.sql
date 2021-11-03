/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@21210712
	Task: Correct Wrong agentID and Username - Customer Setting tables [Redmine: #164203] 
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

DECLARE @CustTable TABLE (CustID INT, recommend INT, new_recommend INT, Username VARCHAR(30), New_username VARCHAR(30) )

INSERT INTO @CustTable(CustID,recommend,new_recommend,Username,New_username)
SELECT custid, 
       recommend, 
       56713996 AS new_recommend, 
       username, 
       REPLACE(username, 'MYGAMECVRMB201', 'MYGAMECVRMB203') AS New_username
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE recommend = 56713984
      AND username LIKE 'MYGAMECVRMB%'
      AND username <> 'MYGAMECVRMB201'
      AND username <> 'MYGAMECVRMB201ClearBal'
      AND username <> 'MYGAMECVRMB201CashOut'
UNION ALL
SELECT custid, 
       recommend, 
       56948082 AS new_recommend, 
       username, 
       REPLACE(username, 'dfbetCVRMB201', 'dfbetCVRMB203') AS New_username
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE recommend = 56948071
      AND username LIKE 'dfbetCVRMB%'
      AND username <> 'dfbetCVRMB201'
      AND username <> 'dfbetCVRMB201ClearBal'
      AND username <> 'dfbetCVRMB201CashOut';

--Update Username of MYGAMECVRMB201001 
UPDATE t
SET t.New_username = 'MYGAMECVRMB201xxx' 
FROM @CustTable t
WHERE t.username = 'MYGAMECVRMB201001'

SELECT * FROM @CustTable

--Update custInfo
UPDATE ci
SET ci.recommend = t.new_recommend,
	ci.username = T.New_username
FROM custInfo ci WITH(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON ci.custid = t.CustID

--Update customer
UPDATE ci
SET ci.recommend = t.new_recommend,
	ci.username = T.New_username
FROM customer ci WITH(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON ci.custid = t.CustID

--Update CustSearch
UPDATE C 
SET C.username = T.New_username
FROM CustSearch c with(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON c.username = t.Username