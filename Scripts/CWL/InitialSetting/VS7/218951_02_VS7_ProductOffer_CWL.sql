/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250328@Lani
	Task: Risk & Control and CWL - Integrate Virtual Sports 7 (Kiron) [Redmine: #218951]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 106, 
	@RepresentativeBettype = 1201;    
GO
