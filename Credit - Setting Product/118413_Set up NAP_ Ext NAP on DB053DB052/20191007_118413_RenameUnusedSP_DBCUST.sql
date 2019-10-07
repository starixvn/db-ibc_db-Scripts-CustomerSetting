/*	
	Created: 20191007@Eden
	Task: Rename all unused SP in DBCUST
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DBCUST
*/

USE CUSTDB
GO 


EXEC sp_rename 'Acc_CustomerMaxNewMemPerDay_SAg','DEL_Acc_CustomerMaxNewMemPerDay_SAg'
GO
EXEC sp_rename 'Acc_CustomerSelByPlayerId','DEL_Acc_CustomerSelByPlayerId'
GO
EXEC sp_rename 'Acc_CustomerSelIsDirectMaster','DEL_Acc_CustomerSelIsDirectMaster'
GO
EXEC sp_rename 'Acc_CustomerSelMemberSearch_AutoSuspend','DEL_Acc_CustomerSelMemberSearch_AutoSuspend'
GO
EXEC sp_rename 'Acc_CustomerUpdDisableEsports','DEL_Acc_CustomerUpdDisableEsports'
GO
EXEC sp_rename 'Acc_CustomerUpdSecurityCode_Sub','DEL_Acc_CustomerUpdSecurityCode_Sub'
GO
EXEC sp_rename 'Acc_Dep_CustomerUpdMoveAgent','DEL_Acc_Dep_CustomerUpdMoveAgent'
GO
EXEC sp_rename 'Acc_Dep_CustomerUpdMoveMaster','DEL_Acc_Dep_CustomerUpdMoveMaster'
GO
EXEC sp_rename 'Acc_Rpt_CasinoSynchronise','DEL_Acc_Rpt_CasinoSynchronise'
GO
EXEC sp_rename 'Acc_SelCustomerGivenCredit','DEL_Acc_SelCustomerGivenCredit'
GO
EXEC sp_rename 'Age_LoginAdminVerifyTicket','DEL_Age_LoginAdminVerifyTicket'
GO
EXEC sp_rename 'NAP_CustomerInsRobotAccount','DEL_NAP_CustomerInsRobotAccount'
GO
EXEC sp_rename 'NAP_CustomerSelRobotAccounts','DEL_NAP_CustomerSelRobotAccounts'
GO
EXEC sp_rename 'NAP_CustomerUpdInfoRobotAccount','DEL_NAP_CustomerUpdInfoRobotAccount'
GO
EXEC sp_rename 'NAP_CustomerUpdStatusRobotAccount','DEL_NAP_CustomerUpdStatusRobotAccount'
GO
EXEC sp_rename 'NAP_WinLimit_CustNotConfigProductSel','DEL_NAP_WinLimit_CustNotConfigProductSel'
GO
EXEC sp_rename 'NAP_WinLimit_CustSettingRelatedToCurrencySettingUpd','DEL_NAP_WinLimit_CustSettingRelatedToCurrencySettingUpd'
GO
EXEC sp_rename 'NAP_WinLimit_GreaterWinLimitPlayerSel','DEL_NAP_WinLimit_GreaterWinLimitPlayerSel'
GO
