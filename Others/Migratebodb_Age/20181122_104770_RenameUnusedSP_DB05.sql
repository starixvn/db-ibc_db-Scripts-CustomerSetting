/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB05
*/
IF @@SERVERNAME NOT IN ('DB05','DB215','DB231') RETURN

USE bodb02
GO
EXEC sp_rename 'Acc_CustGroupAddByUsername', 'DEL_Acc_CustGroupAddByUsername'
EXEC sp_rename 'Acc_CustGroupDel', 'DEL_Acc_CustGroupDel'
EXEC sp_rename 'Acc_CustGroupSel', 'DEL_Acc_CustGroupSel'
EXEC sp_rename 'Acc_CustGroupSelGroup', 'DEL_Acc_CustGroupSelGroup'
EXEC sp_rename 'Acc_CustomerUpdUserSearch', 'DEL_Acc_CustomerUpdUserSearch'
EXEC sp_rename 'Acc_CustomerSelByUserName', 'DEL_Acc_CustomerSelByUserName'
EXEC sp_rename 'Acc_CustomerSelSAgList', 'DEL_Acc_CustomerSelSAgList'
EXEC sp_rename 'Acc_CustomerSelSAg', 'DEL_Acc_CustomerSelSAg'
EXEC sp_rename 'Acc_Rpt_WinLossDetail_ComEx', 'DEL_Acc_Rpt_WinLossDetail_ComEx'
EXEC sp_rename 'Acc_CustomerSelUserSearch', 'DEL_Acc_CustomerSelUserSearch'
EXEC sp_rename 'Acc_CustGroupIns', 'DEL_Acc_CustGroupIns'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'DEL_Acc_Rpt_WinLossDaily_ComEx14'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx', 'DEL_Acc_Rpt_WinLossDaily_ComEx'