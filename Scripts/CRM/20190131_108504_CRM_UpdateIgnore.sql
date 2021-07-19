/*
	Created: Winnie
	Task: CRM - Check Headlines RedmineID:#108504
	DB: DBCRM/bodb_CRM
	Date: 20190131
*/ 

UPDATE c
SET c.IsVIP=0
FROM crmCustomer c WITH(ROWLOCK,UPDLOCK)
WHERE UserName IN('733HK', 'M8RMB') 


UPDATE c
SET c.Ignored=0
FROM crmCustomer c WITH(ROWLOCK,UPDLOCK)
WHERE UserName IN('SKKC') 
