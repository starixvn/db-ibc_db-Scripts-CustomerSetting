/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250603@July
	Task: NAP Risk & Control - ClotPlay Product Integration [Redmine: #228950]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 109, 
	@RepresentativeBettype = 4001;    
GO