USE [CustDB]
GO

/*
	Created: 20190409@Percy
	DB: DBCUST.CustDB
	Task: Revoke permission on update function
*/

REVOKE EXECUTE ON dbo.CS_Customer_Credit_Upd TO bodbDownlineNetView
GO

REVOKE EXECUTE ON dbo.CS_Customer_Status_Upd TO bodbDownlineNetView
GO