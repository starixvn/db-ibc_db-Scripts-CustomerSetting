/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250220@Virgil
	Task: CWL - ASKMESLOT  - Integrate new product [Redmine: #216978]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 103, 
	@RepresentativeBettype = 4001;    
GO
