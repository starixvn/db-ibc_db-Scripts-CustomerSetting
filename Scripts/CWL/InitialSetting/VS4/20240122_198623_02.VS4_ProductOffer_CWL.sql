/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240122@Tacy
	Task: CWL - Non Sports Report - VS4 - Integrate New Product [Redmine: #198623]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 83, 
	@RepresentativeBettype = 1201;    
GO