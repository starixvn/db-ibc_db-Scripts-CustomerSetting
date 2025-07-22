/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250722@July
	Task: NAP Risk & Control - ODIN GAMING Product Integration [Redmine: #219225]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 105, 
	@RepresentativeBettype = 4001;    
GO

SELECT * FROM dbo.WinLimit_ProductOffer WITH(NOLOCK) WHERE ProductID = 105