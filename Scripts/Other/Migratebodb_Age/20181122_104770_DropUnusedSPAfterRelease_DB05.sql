/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB05
*/
IF @@SERVERNAME NOT IN ('DB05','DB215','DB231') RETURN

USE bodb02
GO
DROP PROCEDURE Acc_CustGroupAddByUsername_delete
DROP PROCEDURE Acc_CustGroupDel_delete
DROP PROCEDURE Acc_CustGroupSel_delete
DROP PROCEDURE Acc_CustGroupSelGroup_delete
DROP PROCEDURE Acc_CustomerUpdUserSearch_delete
DROP PROCEDURE Acc_CustomerSelByUserName_delete
DROP PROCEDURE Acc_CustomerSelSAgList_delete
DROP PROCEDURE Acc_CustomerSelSAg_delete
DROP PROCEDURE Acc_Rpt_WinLossDetail_ComEx_delete
DROP PROCEDURE Acc_CustomerSelUserSearch_delete
DROP PROCEDURE Acc_CustGroupIns_delete
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx14_delete
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx_delete

