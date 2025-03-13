/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250313@Gina
	Task: CWL - Funky Games - Integrate New product [Redmine: #218182]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 104, 
	@RepresentativeBettype = 4001;    
GO
