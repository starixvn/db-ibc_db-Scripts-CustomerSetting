/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB053
*/

IF @@SERVERNAME NOT IN ('DB053','DB215\SQLSERVER2008R2','DB231\SQLSERVER2008R2') RETURN

USE bodb02
GO

EXEC sp_rename 'Acc_CustomerSelAllInfo_lukas', 'DEL_Acc_CustomerSelAllInfo_lukas'
EXEC sp_rename 'Acc_Rpt_CompanyWinloss', 'DEL_Acc_Rpt_CompanyWinloss'
EXEC sp_rename 'Acc_Rpt_LicWinlossDetail', 'DEL_Acc_Rpt_LicWinlossDetail'
EXEC sp_rename 'Acc_Rpt_LicWinlossDetail_Ag', 'DEL_Acc_Rpt_LicWinlossDetail_Ag'
EXEC sp_rename 'Age_CustomerSelOnlineList_Ag', 'DEL_Age_CustomerSelOnlineList_Ag'
EXEC sp_rename 'Age_CustomerSelOnlineList_MAg', 'DEL_Age_CustomerSelOnlineList_MAg'
EXEC sp_rename 'Age_CustomerSelOnlineList_SAg', 'DEL_Age_CustomerSelOnlineList_SAg'
EXEC sp_rename 'clearLogin', 'DEL_clearLogin'
EXEC sp_rename 'DBA_CreateLicenseeAgent', 'DEL_DBA_CreateLicenseeAgent'
EXEC sp_rename 'GetTotalOnline', 'DEL_GetTotalOnline'
EXEC sp_rename 'Lbs_Rpt_GetTotalTicket', 'DEL_Lbs_Rpt_GetTotalTicket'
EXEC sp_rename 'Lbs_UserLogin', 'DEL_Lbs_UserLogin'
EXEC sp_rename 'Lrf_CustomerSelBalance', 'DEL_Lrf_CustomerSelBalance'
EXEC sp_rename 'Lrf_CustomerSelCheckBelonging', 'DEL_Lrf_CustomerSelCheckBelonging'
EXEC sp_rename 'Lrf_Rpt_WinLoss', 'DEL_Lrf_Rpt_WinLoss'
EXEC sp_rename 'online_admin', 'DEL_online_admin'
EXEC sp_rename 'online_user', 'DEL_online_user'
EXEC sp_rename 'online_usera', 'DEL_online_usera'
EXEC sp_rename 'online_userma', 'DEL_online_userma'
EXEC sp_rename 'Task_BATransaction_Check', 'DEL_Task_BATransaction_Check'
EXEC sp_rename 'Task_BATransaction_Ins', 'DEL_Task_BATransaction_Ins'
EXEC sp_rename 'Task_Licensee_ClearLogin', 'DEL_Task_Licensee_ClearLogin'