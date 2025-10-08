/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20251008@July
	Task: CWL - GEMINI Product Integration [Redmine: #240191]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 115, 
	@RepresentativeBettype = 4001;    
GO

SELECT ProductID, BetType, IsActive_SMA, IsActive_Company 
FROM  WinLimit_ProductOffer WITH (NOLOCK) WHERE ProductID = 115