/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20231204@Tacy
	Task: CWL - Non Sports Report - Live22 - Integrate New Product [Redmine: #195092]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 79, 
	@RepresentativeBettype = 7601;    
GO