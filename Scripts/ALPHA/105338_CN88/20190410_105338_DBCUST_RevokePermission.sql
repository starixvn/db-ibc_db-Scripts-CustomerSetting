USE [CustDB]
GO

/*
	Created: 20190410@Elodie
	DB: DBCUST/CustDB
	Task: Revoke permission on update function
*/

REVOKE EXECUTE ON dbo.CS_CustSetting_GeneralInfo_Upd TO bodbDownlineNetView
GO

REVOKE EXECUTE ON dbo.CS_CustSetting_PTSetting_Upd TO bodbDownlineNetView
GO