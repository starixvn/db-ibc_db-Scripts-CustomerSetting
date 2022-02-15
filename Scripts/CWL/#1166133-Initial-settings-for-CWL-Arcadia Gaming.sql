
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20220110@Robert
	Task:	Initial settings for CWL - #166133 - CWL - Arcadia Gaming - incorporate new mini game: Blackjack
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220110@Robert:	#166133 - CWL - Arcadia Gaming - incorporate new mini game: Blackjack
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. Initial settings for - #166133 - CWL - Arcadia Gaming - incorporate new mini game: Blackjack*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 1913 , 
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


/*2. Initial settings for - #167044 - CWL - AdvantPlay - Incorporate 6 new games*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 67, 
     @BetTypeID_Begin = 7717 , 
     @BetTypeID_End = 7742, 
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


-- select * from Winlimit_Group where GroupName like '%AdvantPlay%'