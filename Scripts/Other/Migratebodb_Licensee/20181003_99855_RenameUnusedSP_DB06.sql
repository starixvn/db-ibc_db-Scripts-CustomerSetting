/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB06
*/

IF @@SERVERNAME NOT IN ('DB06','DB234','DB232') RETURN

USE bodb_Report
GO

EXEC sp_rename '_DEL_Task_DepWinloss_CheckData', 'DEL__DEL_Task_DepWinloss_CheckData'
EXEC sp_rename '_DEL_Task_DepWinloss_Product_CheckData', 'DEL__DEL_Task_DepWinloss_Product_CheckData'
EXEC sp_rename '_DEL_Task_DepWinloss_ProductSum_CheckData', 'DEL__DEL_Task_DepWinloss_ProductSum_CheckData'
EXEC sp_rename '_DEL_Task_DepWinloss_Sum_CheckData', 'DEL__DEL_Task_DepWinloss_Sum_CheckData'

USE bodb02
GO

EXEC sp_rename '_DEL_Acc_LicenseeSelAll', 'DEL__DEL_Acc_LicenseeSelAll'
EXEC sp_rename '_DEL_Acc_SelCurrencyByLicensee', 'DEL__DEL_Acc_SelCurrencyByLicensee'
EXEC sp_rename '_DEL_Lrf_CustomerSelBalance', 'DEL__DEL_Lrf_CustomerSelBalance'
EXEC sp_rename '_DEL_Lrf_Lrf_UserLog_LoginSel', 'DEL__DEL_Lrf_Lrf_UserLog_LoginSel'
EXEC sp_rename '_DEL_Task_DailyRptLicIPBetting_Archive', 'DEL__DEL_Task_DailyRptLicIPBetting_Archive'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_Company_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_Company_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_Currency_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_Currency_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_Daily_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_Daily_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_GameTable_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_GameTable_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_GameType_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_GameType_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_Hourly_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_Hourly_Bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_Monthly_bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_Monthly_bettrans'
EXEC sp_rename '_delete_Acc_Rpt_CasinoGameStatistics_UserName_Bettrans', 'DEL__delete_Acc_Rpt_CasinoGameStatistics_UserName_Bettrans'
EXEC sp_rename 'Acc_Licensee_Product3rdSel', 'DEL_Acc_Licensee_Product3rdSel'
EXEC sp_rename 'Acc_Rpt_AGCasinoWinloss', 'DEL_Acc_Rpt_AGCasinoWinloss'
EXEC sp_rename 'Acc_Rpt_AGCasinoWinloss_Ag', 'DEL_Acc_Rpt_AGCasinoWinloss_Ag'
EXEC sp_rename 'Acc_Rpt_AGCasinoWinloss_MAg', 'DEL_Acc_Rpt_AGCasinoWinloss_MAg'
EXEC sp_rename 'Acc_Rpt_AGCasinoWinloss_Mem', 'DEL_Acc_Rpt_AGCasinoWinloss_Mem'
EXEC sp_rename 'Acc_Rpt_AGCasinoWinloss_SAg', 'DEL_Acc_Rpt_AGCasinoWinloss_SAg'
--EXEC sp_rename 'Acc_Rpt_BALicWinlossByCommissionLevel', 'DEL_Acc_Rpt_BALicWinlossByCommissionLevel'
EXEC sp_rename 'Acc_Rpt_PlaytechWinloss2', 'DEL_Acc_Rpt_PlaytechWinloss2'
EXEC sp_rename 'Acc_Rpt_TicketsListingDetail', 'DEL_Acc_Rpt_TicketsListingDetail'
EXEC sp_rename 'clearLogin', 'DEL_clearLogin'
EXEC sp_rename 'GetTotalOnline', 'DEL_GetTotalOnline'
EXEC sp_rename 'Lrf_BetList_MobileReport_SelWinloss_Mem', 'DEL_Lrf_BetList_MobileReport_SelWinloss_Mem'
EXEC sp_rename 'Lrf_BetList_SelByDayAll_Mem_Old_Francis', 'DEL_Lrf_BetList_SelByDayAll_Mem_Old_Francis'
EXEC sp_rename 'Lrf_BetList_SelWinloss_Mem_Jim', 'DEL_Lrf_BetList_SelWinloss_Mem_Jim'
EXEC sp_rename 'Lrf_BetList_SelWinlossDaily_17905', 'DEL_Lrf_BetList_SelWinlossDaily_17905'
EXEC sp_rename 'Lrf_BetList_SelWinlossDaily_support', 'DEL_Lrf_BetList_SelWinlossDaily_support'
EXEC sp_rename 'Lrf_Rpt_CustomerBalance_viet', 'DEL_Lrf_Rpt_CustomerBalance_viet'
EXEC sp_rename 'Lrf_Rpt_CustomerPerformance', 'DEL_Lrf_Rpt_CustomerPerformance'
EXEC sp_rename 'Lrf_Rpt_CustomerTurnOver', 'DEL_Lrf_Rpt_CustomerTurnOver'
EXEC sp_rename 'Lrf_Rpt_TurnOver_kiwi', 'DEL_Lrf_Rpt_TurnOver_kiwi'
EXEC sp_rename 'Lrf_Rpt_TurnOver_viet', 'DEL_Lrf_Rpt_TurnOver_viet'
EXEC sp_rename 'NAP_Rpt_TicketsListingDetail', 'DEL_NAP_Rpt_TicketsListingDetail'
EXEC sp_rename 'online_admin', 'DEL_online_admin'
EXEC sp_rename 'online_user', 'DEL_online_user'
EXEC sp_rename 'online_usera', 'DEL_online_usera'
EXEC sp_rename 'online_userma', 'DEL_online_userma'
EXEC sp_rename 'Task_DailyRptIPBettingWinloss', 'DEL_Task_DailyRptIPBettingWinloss'
EXEC sp_rename 'Task_rptCustomerMatch_Bettrans_bk', 'DEL_Task_rptCustomerMatch_Bettrans_bk'
EXEC sp_rename 'Task_rptCustomerTurnOver_Bettrans_bk', 'DEL_Task_rptCustomerTurnOver_Bettrans_bk'
EXEC sp_rename 'Task_rptCustomerTurnOver_Bettrans_bk_2', 'DEL_Task_rptCustomerTurnOver_Bettrans_bk_2'
EXEC sp_rename 'Lrf_BetList_SelWinloss_Mem_Jim', 'DEL_Lrf_BetList_SelWinloss_Mem_Jim'
EXEC sp_rename 'Lrf_Rpt_PlaytechWinloss', 'DEL_Lrf_Rpt_PlaytechWinloss'
EXEC sp_rename 'Lrf_Rpt_PlaytechWinlossDetail', 'DEL_Lrf_Rpt_PlaytechWinlossDetail'
EXEC sp_rename 'Lrf_Rpt_PlaytechWinlossDetail_Ag', 'DEL_Lrf_Rpt_PlaytechWinlossDetail_Ag'
EXEC sp_rename 'Task_Correct_tranfer_bk_Data', 'DEL_Task_Correct_tranfer_bk_Data'
EXEC sp_rename 'Task_DOT_dep_DailySummary_Bettrans_20141129', 'DEL_Task_DOT_dep_DailySummary_Bettrans_20141129'
EXEC sp_rename 'Task_DOT_dep_DailySummary_Bettrans_lukas', 'DEL_Task_DOT_dep_DailySummary_Bettrans_lukas'
EXEC sp_rename 'Task_DOT_dep_DailySummary_Bettrans_patrick', 'DEL_Task_DOT_dep_DailySummary_Bettrans_patrick'
EXEC sp_rename 'Task_DOT_dep_DailySummary_viet', 'DEL_Task_DOT_dep_DailySummary_viet'
