/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator:	202301109@Robert
	Task:	#195888 - CWL - Risk and Control - WE Live Casino - Integrate new product
	Database:	DBTXN.bodb02
	
	Revisions:
		- 202301109@Robert:	#195888 - CWL - Risk and Control - WE Live Casino - Integrate new product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- call sp này trên siteDB với DBTrans luôn nha
EXEC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID = 80, 
	@RepresentativeBettype = 10300;    

