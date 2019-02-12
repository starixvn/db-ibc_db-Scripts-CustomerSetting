/*
	Created: Winnie
	Task: CRM - Check Headlines RedmineID:#108504
	DB: DBCRM/bodb_CRM
	Date: 20190212
*/ 

UPDATE c
SET c.IsVIP=0
FROM crmCustomer c WITH(ROWLOCK,UPDLOCK)
WHERE UserName IN('D-KKT') 

