/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241216@Virgil
	Task: CWL - SABA Keno - Integrate New Product [Redmine: #214760]
	Database:	DBTXN/bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 102, 
	@RepresentativeBettype = 4601;    
GO