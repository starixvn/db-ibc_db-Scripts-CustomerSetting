
/*
	Created: Winnie
	Date: 20190307
	Task: Prepare scripts to update all VIP valude from NULL to "0" [RedmineID: #109775]
	DB: DBCRM/bodb_CRM
*/
USE bodb_CRM
GO

WHILE EXISTS(SELECT TOP 1 1 FROM crmCustomer WITH(NOLOCK) WHERE IsVip IS NULL)
BEGIN
	UPDATE TOP (3000) crmCustomer WITH(ROWLOCK,UPDLOCK)
		SET  IsVip = 1
	WHERE IsVIP IS NULL
END
GO
