
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200921@Robert
	Task:	Initial settings for CWL - CWL - Integrate WM Live Casino [131587]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200921@Robert:	Initial settings  - [Redmine: #131587]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#131587 - CWL - Integrate WM Live Casino*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 51, 
     @BetTypeID_Begin = 3401, 
     @BetTypeID_End = 3411, 
     @BettypeIds = '', 
     @GroupID = 35, 
     @GroupName = 'WM', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000,      
     @RepresentativeBettype = 3401;


/*#131606 - CWL - Integrate Joker Gaming*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 56, 
     @BetTypeID_Begin = 6401, 
     @BetTypeID_End = 6412, 
     @BettypeIds = '', 
     @GroupID = 36, 
     @GroupName = 'Joker', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;
	 
	 