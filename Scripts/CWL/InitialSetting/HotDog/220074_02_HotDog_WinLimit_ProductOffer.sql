/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250324@Lani
	Task: CWL - Hot Dog - Integrate New product [Redmine: #220074]
	Database: DBTXN-bodb02
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 95, 
	@RepresentativeBettype = 4001;    
GO
