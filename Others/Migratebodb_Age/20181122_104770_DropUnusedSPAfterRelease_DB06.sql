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
