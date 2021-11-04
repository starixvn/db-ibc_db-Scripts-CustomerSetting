/*<info serverAlias="DBCRM-bodb_CRM"></info>*/ 
/*
	Created: Eden@21210712
	Task: Correct Wrong agentID and Username - CRM tables [Redmine: #164203] 
	DB: DBCRM-bodb_CRM
*/
USE bodb_CRM
GO

DECLARE @CustTable TABLE (CustID INT, Username VARCHAR(30), New_username VARCHAR(30) )

INSERT INTO @CustTable(CustID,Username,New_username)
SELECT custid, 
       username, 
       REPLACE(username, 'MYGAMECVRMB201', 'MYGAMECVRMB203') AS New_username
FROM dbo.crmCustomer ci WITH (NOLOCK)
WHERE username LIKE 'MYGAMECVRMB201%'
      AND username <> 'MYGAMECVRMB201'
      AND username <> 'MYGAMECVRMB201ClearBal'
      AND username <> 'MYGAMECVRMB201CashOut'
UNION ALL
SELECT custid, 
       username, 
       REPLACE(username, 'dfbetCVRMB201', 'dfbetCVRMB203') AS New_username
FROM dbo.crmCustomer ci WITH (NOLOCK)
WHERE username LIKE 'dfbetCVRMB201%'
      AND username <> 'dfbetCVRMB201'
      AND username <> 'dfbetCVRMB201ClearBal'
      AND username <> 'dfbetCVRMB201CashOut'

--Update Username of MYGAMECVRMB201001 
UPDATE t
SET t.New_username = 'MYGAMECVRMB203xxx' 
FROM @CustTable t
WHERE t.username = 'MYGAMECVRMB201001'

SELECT * FROM @CustTable

--Update crmCustomer
UPDATE ci
SET ci.username = T.New_username
FROM crmCustomer ci WITH(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON ci.custid = t.CustID

--Update crmCustomerSearch
UPDATE ci
SET ci.username = T.New_username
FROM crmCustomerSearch ci WITH(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON ci.custid = t.CustID

--Update crmCustSearch
UPDATE ci
SET ci.username = T.New_username
FROM crmCustSearch ci WITH(ROWLOCK,UPDLOCK)
	INNER JOIN @CustTable t ON ci.custid = t.CustID