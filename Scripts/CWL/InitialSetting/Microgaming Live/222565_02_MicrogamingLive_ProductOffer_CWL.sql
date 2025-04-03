/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250304@Lani
	Task: CWL - Hot Dog - Microgaming Live Product Integration [Redmine: #220074]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 107, 
	@RepresentativeBettype = 13900;    
GO
