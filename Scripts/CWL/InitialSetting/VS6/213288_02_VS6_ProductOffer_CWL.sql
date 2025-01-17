/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241105@Virgil
	Task: CWL - Virtual Sports 6 - Integrate new product [Redmine: #213013]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 71, 
	@RepresentativeBettype = 1201;    
GO
