/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DBLIC/bodb_LicenseeReport
*/
IF @@SERVERNAME NOT IN ('DB052','DB215','DB231') RETURN

USE bodb_LicenseeReport
GO
EXEC sp_rename 'GEN_rptBetting_ColossusBets_support', 'DEL_GEN_rptBetting_ColossusBets_support'

