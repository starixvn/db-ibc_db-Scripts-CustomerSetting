
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200818@Robert
	Task:	Initial settings for CWL - CWL - Integrate PG Soft Product [137766]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200818@Robert:	Initial settings  - [Redmine: #137766]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/


EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 55, 
     @BetTypeID_Begin = 6001, 
     @BetTypeID_End = 6020, 
     @BettypeIds = '', 
     @GroupID = 34, 
     @GroupName = 'PG Soft', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @RepresentativeBettype = 4001,
	 @IsBlockedTransfer_DepositSite_Level3 = 1 

	 