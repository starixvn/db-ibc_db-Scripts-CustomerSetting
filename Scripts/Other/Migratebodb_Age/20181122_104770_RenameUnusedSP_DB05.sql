/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB05
*/
IF @@SERVERNAME NOT IN ('DB05','DB215','DB231') RETURN

USE bodb02
GO
EXEC sp_rename 'Acc_CustGroupAddByUsername', 'Acc_CustGroupAddByUsername_delete'
EXEC sp_rename 'Acc_CustGroupDel', 'Acc_CustGroupDel_delete'
EXEC sp_rename 'Acc_CustGroupSel', 'Acc_CustGroupSel_delete'
EXEC sp_rename 'Acc_CustGroupSelGroup', 'Acc_CustGroupSelGroup_delete'
EXEC sp_rename 'Acc_CustomerUpdUserSearch', 'Acc_CustomerUpdUserSearch_delete'
EXEC sp_rename 'Acc_CustomerSelByUserName', 'Acc_CustomerSelByUserName_delete'
EXEC sp_rename 'Acc_CustomerSelSAgList', 'Acc_CustomerSelSAgList_delete'
EXEC sp_rename 'Acc_CustomerSelSAg', 'Acc_CustomerSelSAg_delete'
EXEC sp_rename 'Acc_Rpt_WinLossDetail_ComEx', 'Acc_Rpt_WinLossDetail_ComEx_delete'
EXEC sp_rename 'Acc_CustomerSelUserSearch', 'Acc_CustomerSelUserSearch_delete'
EXEC sp_rename 'Acc_CustGroupIns', 'Acc_CustGroupIns_delete'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'Acc_Rpt_WinLossDaily_ComEx14_delete'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx', 'Acc_Rpt_WinLossDaily_ComEx_delete'