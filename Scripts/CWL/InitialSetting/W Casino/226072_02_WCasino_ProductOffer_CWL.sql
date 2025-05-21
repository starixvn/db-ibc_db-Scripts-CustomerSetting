/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250508@Lani
	Task: CWL - W Casino - Integrate new product [Redmine: #226072]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 98, 
	@RepresentativeBettype = 12000;    
GO
