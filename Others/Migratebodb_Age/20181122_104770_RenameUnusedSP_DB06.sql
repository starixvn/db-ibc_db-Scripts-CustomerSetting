/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB06
*/

IF @@SERVERNAME NOT IN ('DB06','DB234','DB232') RETURN

USE bodb02
GO
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'DEL_Acc_Rpt_WinLossDaily_ComEx14'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx', 'DEL_Acc_Rpt_WinLossDaily_ComEx'
