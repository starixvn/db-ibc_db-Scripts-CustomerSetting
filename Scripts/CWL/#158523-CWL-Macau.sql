
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20210726@Robert
	Task:	CWL - Macau Games - Add new VoidBridge and BluePrint games July 2021 [158523]
	Database:	DBCUST.CustDB
	
	Revisions:
		- CWL - Macau Games - Add new VoidBridge and BluePrint games July 2021 [158523]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
/*158523 - CWL - Macau Games - Add new VoidBridge and BluePrint games July 2021*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 22, 
     @BetTypeID_Begin = 4086, 
     @BetTypeID_End = 4090, 
     @BettypeIds = '', 
     @GroupID = 10, 
     @GroupName = 'Macau Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*#158746 - CWL - Arcadia Gaming Mini Game - add new game Dragon Tiger - Aug 2021*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 1912, 
     @BetTypeID_End = 1920, 
     @BettypeIds = '', 
     @GroupID = 21, 
     @GroupName = 'Arcadia Gaming', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*#158707 - CWL - AdvantPlay - Incorporate 2 new games King of Glory & Bubble Dragon*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 67, 
     @BetTypeID_Begin = 7711, 
     @BetTypeID_End = 7722, 
     @BettypeIds = '', 
     @GroupID = 49, 
     @GroupName = 'AdvantPlay', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

	