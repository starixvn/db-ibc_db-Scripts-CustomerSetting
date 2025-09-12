/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20250826@July
	Task: NAP Risk & Control - OFA Live Product Integration [Redmine: #236740]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 113, 
	@RepresentativeBettype = 12250;    
GO
SELECT * FROM WinLimit_ProductOffer WITH (NOLOCK) WHERE ProductID = 113
