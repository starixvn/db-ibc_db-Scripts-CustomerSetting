/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB06
*/

IF @@SERVERNAME NOT IN ('DB06','DB234','DB232') RETURN

USE bodb02
GO
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx14_delete
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx_delete

DROP PROCEDURE _DEL_Task_Insert_ExtraPT_Setting
DROP PROCEDURE _DEL_Acc_CustomerUpdUserSearch
DROP PROCEDURE _DEL_Acc_CustomerSelUserSearch
