/*
	Created: Winnie
	Task: CRM - Check Headlines RedmineID:#108504
	DB: DBCRM/bodb_CRM
	Date: 20190129
*/ 

UPDATE c
SET c.IsVIP=0,c.Ignored=1
FROM crmCustomer c WITH(ROWLOCK,UPDLOCK)
WHERE UserName IN('et888','THAUS','Supertest16') OR CustID=-5634


UPDATE c
SET c.IsVIP=1,c.Ignored=0
FROM crmCustomer c WITH(ROWLOCK,UPDLOCK)
WHERE UserName ='ET889'
