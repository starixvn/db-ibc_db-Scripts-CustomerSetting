/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240710@Tacy
	Task: CWL - Non Sports Report - Nextspin - Integrate New Product [Redmine: #199987]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 85, 
	@RepresentativeBettype = 4001;    
GO