/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240702@Tacy
	Task: CWL - Non Sports Report - FastSpin - Integrate New Product [Redmine: #205746]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 87, 
	@RepresentativeBettype = 4001;    
GO