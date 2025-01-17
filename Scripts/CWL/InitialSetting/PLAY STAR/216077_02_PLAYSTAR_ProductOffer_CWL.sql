/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241231@Virgil
	Task: CWL - PLAY STAR - Integrate new product [Redmine: #208024]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 91, 
	@RepresentativeBettype = 4001;    
GO
