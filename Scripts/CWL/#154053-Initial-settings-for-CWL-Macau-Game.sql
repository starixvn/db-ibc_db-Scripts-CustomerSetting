
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210512@Robert
	Task:	Initial settings for CWL - Add 5 games for Macau Games [154053]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210512@Robert:	Initial settings for CWL - Add 5 games for Macau Games [154053]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #154053 - CWL - Add 5 games for Macau Games*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 22, 
     @BetTypeID_Begin = 4081, 
     @BetTypeID_End = 4085, 
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

/*2. #154251 - CWL - Integrate Vgaming*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 66, 
     @BetTypeID_Begin = 3801, 
     @BetTypeID_End = 3897 , 
     @BettypeIds = '', 
     @GroupID = 47, 
     @GroupName = 'Vgaming - Normal Games', 
     @Level101 = -50000, 
     @Level102 = -100000, 
     @Level1 = 50000, 
     @Level2 = 100000, 
     @Level3 = 200000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 3801 ;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 66, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '3899', 
     @GroupID = 48, 
     @GroupName = 'Vgaming - Jackpot Prize', 
     @Level101 = 0, 
     @Level102 = 0, 
     @Level1 = 0, 
     @Level2 = 1, 
     @Level3 = 1, 
     @IsBlockedTransfer_DepositSite_Level3 = 0, 
     @RepresentativeBettype = 3801 ;

/*3. #154260 - CWL - Integrate AdvantPlay*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 67, 
     @BetTypeID_Begin = 7701, 
     @BetTypeID_End = 7711, 
     @BettypeIds = '', 
     @GroupID = 49, 
     @GroupName = 'AdvantPlay', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001 ;

/*4. #154622 - CWL - Pragmatic - Integrate 8 new games May 2021*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 4258, 
     @BetTypeID_End = 4265, 
     @BettypeIds = '', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001 ;

/*5. #154816 - CWL - CWL - Sport Lottery - Add New Game 'LOL Champions' - May 2021*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 63, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '3613', 
     @GroupID = 43, 
     @GroupName = 'Sports Lottery', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000,      
     @RepresentativeBettype = 3611;


