/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB052
*/
--IF @@SERVERNAME NOT IN ('DB052','DB215','DB231') RETURN

USE bodb_EAS
GO
EXEC sp_rename 'EAS_CustomerSelUserSearch', 'EAS_CustomerSelUserSearch_delete'


USE bodb02
GO
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx', 'Acc_Rpt_WinLossDaily_ComEx_delete'
EXEC sp_rename 'Acc_Rpt_WinLossDaily_ComEx14', 'Acc_Rpt_WinLossDaily_ComEx14_delete'
EXEC sp_rename 'Acc_CustomerUpdUserSearch', 'Acc_CustomerUpdUserSearch_delete'

EXEC sp_rename 'Acc_CustomerSelGroupHeadlineByRefno', 'Acc_CustomerSelGroupHeadlineByRefno_delete'