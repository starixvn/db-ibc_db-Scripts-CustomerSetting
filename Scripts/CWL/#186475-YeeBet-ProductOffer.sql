/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator:	20230523@Robert
	Task:	CWL - YeeBet - Integrate new Live Casino product [186475]
	Database:	DBTXN.bodb02
	
	Revisions:
		- 20230523@Robert:	CWL - YeeBet - Integrate new Live Casino product [186475]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- call sp này trên siteDB với DBTrans luôn nha
EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 76, 
	@RepresentativeBettype = 3151;    

