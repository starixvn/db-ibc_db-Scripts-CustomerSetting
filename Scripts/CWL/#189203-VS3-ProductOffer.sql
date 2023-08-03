/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator:	20230803@Robert
	Task:	CWL - #189203 - CWL - LG Virtual Sports - Incorporate new product
	Database:	DBTXN.bodb02
	
	Revisions:
		- 20230803@Robert:	CWL - #189203 - CWL - LG Virtual Sports - Incorporate new product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- call sp này trên siteDB với DBTrans luôn nha
EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 77, 
	@RepresentativeBettype = 1201;    

