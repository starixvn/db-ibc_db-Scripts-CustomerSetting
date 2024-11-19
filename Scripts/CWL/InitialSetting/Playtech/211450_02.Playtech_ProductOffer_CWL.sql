/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240930@Virgil
	Task: CWL - Playtech - Integrate New Product [Redmine: #210558]
	Database:	DBTXN/bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 100, 
	@RepresentativeBettype = 4001;    
GO