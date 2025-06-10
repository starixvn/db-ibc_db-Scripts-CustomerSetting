/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250603@July
	Task: NAP Risk & Control - AI Gaming  Product Integration [Redmine: #228958]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 110, 
	@RepresentativeBettype = 4001;    
GO