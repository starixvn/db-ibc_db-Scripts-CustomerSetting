/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator:	20230217@Robert
	Task:	CWL - Jili [182862]
	Database:	DBTXN.bodb02
	
	Revisions:
		- 20230217@Robert:	Jili [182862]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- call sp này trên siteDB với DBTrans luôn nha
EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 75, 
	@RepresentativeBettype = 4001;    

