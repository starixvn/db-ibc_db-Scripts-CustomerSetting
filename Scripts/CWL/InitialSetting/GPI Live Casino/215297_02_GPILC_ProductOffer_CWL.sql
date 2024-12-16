/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241216@Virgil
	Task: CWL - GPI Live Casino - Integrate new product [Redmine: #213974]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 90, 
	@RepresentativeBettype = 11500;    
GO
