
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20211224@Robert
	Task:	Initial settings for CWL - Pragmatic - Add 20 new games [165395]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20211224@Robert:	Initial settings for CWL - Pragmatic - Add 20 new games [165395]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. Initial settings for CWL - Pragmatic - Add 20 new games [165395]*/


EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 4292, 
     @BetTypeID_End = 4296, 
     @BettypeIds = '', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 6701 , 
     @BetTypeID_End = 6715, 
     @BettypeIds = '', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*2. #166343 - CWL - Macau Games - Add 7 new games and re-enable 11 buy bonus games*/	
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 22, 
     @BetTypeID_Begin = 0 , 
     @BetTypeID_End = 0, 
     @BettypeIds = '4056,4062,4066,4076,4091,4093,4096', 
     @GroupID = 10, 
     @GroupName = 'Macau Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*3. #166133 - CWL - Arcadia Gaming - incorporate new mini game: Blackjack*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 0 , 
     @BetTypeID_End = 0, 
     @BettypeIds = '1913', 
     @GroupID = 21, 
     @GroupName = 'Arcadia Gaming', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;


	select * from Winlimit_Group where GroupName like '%Arcadia%'