/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DB052
*/
--IF @@SERVERNAME NOT IN ('DB052','DB215','DB231') RETURN

USE bodb_EAS
GO
DROP PROCEDURE EAS_CustomerSelUserSearch_delete


USE bodb02
GO
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx_delete
DROP PROCEDURE Acc_Rpt_WinLossDaily_ComEx14_delete
DROP PROCEDURE Acc_CustomerUpdUserSearch_delete

DROP PROCEDURE Acc_CustomerSelGroupHeadlineByRefno_delete