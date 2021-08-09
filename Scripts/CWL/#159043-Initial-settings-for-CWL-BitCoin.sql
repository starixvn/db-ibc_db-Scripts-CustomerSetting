
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210809@Robert
	Task:	Initial settings for CWL - CWL - Integrate Bitcoin product #159043
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210809@Robert:	Initial settings for CWL - CWL - Integrate Bitcoin product #159043
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 69, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '7901', 
     @GroupID = 51, 
     @GroupName = 'Bitcoin', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 7901,
     @IsBlockedTransfer_DepositSite_Level3 = 0 

	
	