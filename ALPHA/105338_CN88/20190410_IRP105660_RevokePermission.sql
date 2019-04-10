/*
	Created By: Johnson
	Created Date: 20190410
	Task: revoke permission for internal login
	DB: DBCUST/CUSTDB	
*/	

REVOKE EXECUTE ON [dbo].[CS_Customer_SecurityCode_upd_UAT3] TO [bodbDownlineNetView] AS [dbo]
GO
