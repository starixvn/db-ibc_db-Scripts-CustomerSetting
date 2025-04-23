/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250423@Lani
	Task: CWL - RichGaming - Integrate New product [Redmine: #224307]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 108, 
	@RepresentativeBettype = 4001;    
GO
