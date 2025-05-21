/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20250422@July	
	Task: CWL - Playtech Live- Integrate New Product [Redmine: #224582]
	Database:	DBTXN-bodb02
*/
/*
	Full range: [15600 - 15799]
	Jackpot Prize: 15799
*/
USE bodb02
GO

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 101, 
	@RepresentativeBettype = 15600;    
GO