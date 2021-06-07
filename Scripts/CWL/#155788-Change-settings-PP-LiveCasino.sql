/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210525@Robert
	Task:	Add missing CWL setting for PP Live Casino, MaxGame #155788

	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210525@Robert:	Add missing CWL setting for PP Live Casino, MaxGame #155788
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. MaxGame*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 65, 
     @BetTypeID_Begin = 3710, 
     @BetTypeID_End = 3723, 
     @BettypeIds = '', 
     @GroupID = 44, 
     @GroupName = 'PP Live Casino', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 3701;


 /*2. Live Casino*/

 EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 60, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '5404', 
     @RepresentativeBettype = 4001, 
     @GroupID = 40, 
     @GroupName = 'Max Game', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1;   

	 



 