/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240702@Tacy
	Task: CWL - Non Sports Report - FA CHAI - Integrate New Product [Redmine: #206634]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 89, 
	@RepresentativeBettype = 4001;    
GO