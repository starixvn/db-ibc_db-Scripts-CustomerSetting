/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240815@Tacy
	Task: CWL - Non Sports Report - GPI - Integrate New Product [Redmine: #207172]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 48, 
	@RepresentativeBettype = 4001;    
GO