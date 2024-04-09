/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240322@Tacy
	Task: CWL - Non Sports Report - Yolo Play - Integrate New Product [Redmine: #199192]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 84, 
	@RepresentativeBettype = 4001;    
GO