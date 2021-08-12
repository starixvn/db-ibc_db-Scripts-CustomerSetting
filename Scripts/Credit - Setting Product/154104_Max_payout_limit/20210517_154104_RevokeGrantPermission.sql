/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210513@Winfred
	Task: revoke permission bodbDownlineNetView Acc_CustSetting_MaxPayoutUpd_xtest [#RM:154104]
	DB: DBCUST/CustDB 
*/


USE CUSTDB
GO

REVOKE EXECUTE ON [dbo].[Acc_CustSetting_MaxPayoutUpd_xtest] TO [bodbDownlineNetView] AS [dbo]
GO
