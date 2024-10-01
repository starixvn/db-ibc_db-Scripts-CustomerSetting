/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240912@Virgil
	Task: CWL - ON Casino - Integrate New Product [Redmine: #210027]
	Database:	DBTXN/bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 96, 
	@RepresentativeBettype = 11850;    
GO