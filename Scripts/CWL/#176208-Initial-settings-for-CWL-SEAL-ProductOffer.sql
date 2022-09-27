/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator:	20220927@Robert
	Task:	CWL - Microgaming RNG - Slot Games Integration [175849]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220927@Robert:	CWL - Microgaming RNG - Slot Games Integration [175849]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- call sp này trên siteDB với DBTrans luôn nha
EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 73, 
	@RepresentativeBettype = 8400;    

EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 72, 
	@RepresentativeBettype = 8900;

