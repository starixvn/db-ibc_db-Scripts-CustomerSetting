
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20230623@Robert
	Task:	CWL - PG Soft - Integrate Promotion Prize [188772]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20230623@Robert:	CWL - PG Soft - Integrate Promotion Prize [188772]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 55, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '6300', 
	@GroupID = 61, 
	@GroupName = 'PG Soft - Promotion Prize', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 1000, 
	@Level2 = 0, 
	@Level3 = 0, 
	@RepresentativeBettype = 4001, 
	@Currency = '', 
	@IsBlockedTransfer_DepositSite_Level3 = 1; 
    	  
