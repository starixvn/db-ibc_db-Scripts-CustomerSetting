/*
	Created: 20181122@Elodie
	Task: Rename unused SP
	DB: DB053
*/

IF @@SERVERNAME NOT IN ('DB053','DB215\SQLSERVER2008R2','DB231\SQLSERVER2008R2') RETURN

USE bodb02
GO

EXEC sp_rename 'Acc_Rpt_WinLossDetail_ComEx', 'DEL_Acc_Rpt_WinLossDetail_ComEx'
EXEC sp_rename 'Acc_CustomerSelGroupHeadlineByRefno', 'DEL_Acc_CustomerSelGroupHeadlineByRefno'

EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'DEL_Acc_Rpt_WinLossDaily_ComEx14'


