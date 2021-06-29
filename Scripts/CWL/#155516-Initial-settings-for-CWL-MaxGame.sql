
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210607@Robert
	Task:	Initial settings for CWL - MaxGame - Add new 32 games [155516]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210607@Robert:	Initial settings for CWL - MaxGame - Add new 32 games [155516]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 60, 
     @BetTypeID_Begin = 5411, 
     @BetTypeID_End = 5419, 
     @BettypeIDs = '5405,5408,5420,5421,5441,5442', 
     @GroupID = 40, 
     @GroupName = 'MaxGame', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 60, 
     @BetTypeID_Begin = 5422, 
     @BetTypeID_End = 5440, 
     @BettypeIDs = '', 
     @GroupID = 40, 
     @GroupName = 'MaxGame', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 60, 
     @BetTypeID_Begin = 5443, 
     @BetTypeID_End = 5455, 
     @BettypeIDs = '', 
     @GroupID = 40, 
     @GroupName = 'MaxGame', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;


