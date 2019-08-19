/*
	Date: 20190819
	Task: Execute scripts to update all VIP value from NULL to "0 [Redmine:#109775]	
	DB: DBCRM/bodb_CRM	
*/
WHILE EXISTS(SELECT TOP 1 1 FROM crmCustomer WITH(NOLOCK) WHERE IsVip IS NULL)
BEGIN

	UPDATE TOP (3000) crmCustomer WITH(ROWLOCK,UPDLOCK)
		SET IsVIP=0
	WHERE IsVip IS NULL

END


