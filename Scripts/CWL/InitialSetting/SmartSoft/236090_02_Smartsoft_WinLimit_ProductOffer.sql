/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250815@July
	Task: CWL - Smartsoft Product Integration [Redmine: #236090]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 99, 
	@RepresentativeBettype = 4001;    
GO
SELECT * FROM  WinLimit_ProductOffer WITH (NOLOCK) WHERE ProductID = 99