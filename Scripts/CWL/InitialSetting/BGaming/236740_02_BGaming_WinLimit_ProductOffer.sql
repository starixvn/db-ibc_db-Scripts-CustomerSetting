/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250828@July
	Task: CWL - BGaming Product Integration [Redmine: #237195]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 114, 
	@RepresentativeBettype = 4001;    
GO
SELECT ProductID, BetType, IsActive_SMA, IsActive_Company FROM  WinLimit_ProductOffer WITH (NOLOCK) WHERE ProductID = 114
