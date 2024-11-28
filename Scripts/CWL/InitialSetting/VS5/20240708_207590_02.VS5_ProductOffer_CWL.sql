/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240708@Tacy
	Task: CWL - Non Sports Report - VS5 - Integrate New Product [Redmine: #207590]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 88, 
	@RepresentativeBettype = 1201;    
GO
