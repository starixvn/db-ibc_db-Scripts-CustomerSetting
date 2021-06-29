
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210629@Robert
	Task:	Initial settings for CWL - PG Soft - Add 7 new games Jun 2021 [156684]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210607@Robert:	Initial settings for CWL - MaxGame - Add new 32 games [155516]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 55, 
     @BetTypeID_Begin = 6071, 
     @BetTypeID_End = 6077, 
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

	