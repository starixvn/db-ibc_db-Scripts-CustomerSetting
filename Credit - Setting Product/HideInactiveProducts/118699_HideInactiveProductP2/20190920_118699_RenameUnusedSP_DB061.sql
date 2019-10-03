/*	
	Created: 20190920@Elodie
	Task: Rename all unused SP in DB061
	Redmine: https://redmine.nexcel.vn/issues/118699
	DB: DB061
*/
USE bodb02
GO 

EXEC sp_rename '_DEL_Acc_CustomerUpdDisableVS','DEL__DEL_Acc_CustomerUpdDisableVS'
EXEC sp_rename 'Acc_ExecRep_thien','DEL_Acc_ExecRep_thien'
EXEC sp_rename 'DEL_Lrf_Rpt_WinlostRacing','DEL_DEL_Lrf_Rpt_WinlostRacing'
EXEC sp_rename 'LAS_CustSetting_02','DEL_LAS_CustSetting_02'
EXEC sp_rename 'LAS_CustSetting_04','DEL_LAS_CustSetting_04'
EXEC sp_rename 'LAS_CustSetting_06','DEL_LAS_CustSetting_06'
EXEC sp_rename 'OAS_Report_LicenseeWinloss_BetList','DEL_OAS_Report_LicenseeWinloss_BetList'
EXEC sp_rename 'Task_DailySummary_Cust','DEL_Task_DailySummary_Cust'
EXEC sp_rename 'Task_rptHRWinlost_Group','DEL_Task_rptHRWinlost_Group'
EXEC sp_rename 'Task_rptHRWinlost_Group14','DEL_Task_rptHRWinlost_Group14'
EXEC sp_rename 'Task_rptRacingWinlost_Group','DEL_Task_rptRacingWinlost_Group'
EXEC sp_rename 'Task_rptRacingWinlost_Group14','DEL_Task_rptRacingWinlost_Group14'
EXEC sp_rename 'Dot_Dep_ChkMemBetSetting','DEL_Dot_Dep_ChkMemBetSetting'
EXEC sp_rename 'Dot_Dep_CustomerSelMemBetSetting','DEL_Dot_Dep_CustomerSelMemBetSetting'
EXEC sp_rename 'Dot_Dep_CustomerSelMemBetSetting_Cust','DEL_Dot_Dep_CustomerSelMemBetSetting_Cust'

USE bodb_ACC
GO
EXEC sp_rename 'f_GetSettingProductExtraPTGroup','DEL_f_GetSettingProductExtraPTGroup'

USE bodb_Archive
GO

EXEC sp_rename 'Task_Archive_Event_DBSPARE','DEL_Task_Archive_Event_DBSPARE'
EXEC sp_rename 'Task_Archive_Event_DBSPARE_2010','DEL_Task_Archive_Event_DBSPARE_2010'
EXEC sp_rename 'Task_Archive_Event_DBSPARE_2011','DEL_Task_Archive_Event_DBSPARE_2011'
EXEC sp_rename 'Task_Archive_Event_DBSPARE_2013','DEL_Task_Archive_Event_DBSPARE_2013'
EXEC sp_rename '_DEL_Acc_Rpt_WinLostSummary','DEL__DEL_Acc_Rpt_WinLostSummary'
EXEC sp_rename 'Acc_Rpt_WinlostRacing_Group','DEL_Acc_Rpt_WinlostRacing_Group'


