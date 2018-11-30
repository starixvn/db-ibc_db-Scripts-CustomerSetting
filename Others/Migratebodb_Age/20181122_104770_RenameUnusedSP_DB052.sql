/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB052
*/
--IF @@SERVERNAME NOT IN ('DB052','DB215','DB231') RETURN

USE bodb_EAS
GO
EXEC sp_rename 'EAS_CustomerSelUserSearch', 'DEL_EAS_CustomerSelUserSearch'


USE bodb02
GO
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx', 'DEL_Acc_Rpt_WinLossDaily_ComEx'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'DEL_Acc_Rpt_WinLossDaily_ComEx14'
EXEC sp_rename 'Acc_CustomerUpdUserSearch', 'DEL_Acc_CustomerUpdUserSearch'

EXEC sp_rename 'Acc_CustomerSelGroupHeadlineByRefno', 'DEL_Acc_CustomerSelGroupHeadlineByRefno'