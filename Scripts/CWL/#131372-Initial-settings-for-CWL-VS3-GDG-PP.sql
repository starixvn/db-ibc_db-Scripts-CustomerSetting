
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20201210@Robert
	Task:	Initial settings for CWL - VS3-GDG-PP [131372, 144102, 146806]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20201210@Robert:	Initial settings  - VS3-GDG-PP [131372, 144102, 146806]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/


/*#131372 -CWL - Integrate Leap Gaming Virtual Sports */
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 49, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '5301', 
     @GroupID = 37, 
     @GroupName = 'Virtual Sports 3', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000,      
     @RepresentativeBettype = 5301 ;


/*#144102 -CWL - Integrate Gold Diamond Gaming*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 59, 
     @BetTypeID_Begin = 5701, 
     @BetTypeID_End = 5704, 
     @BettypeIds = '', 
     @GroupID = 38, 
     @GroupName = 'GDG', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000,      
     @RepresentativeBettype = 5701 ;

/*#146806 CWL - Pragmatic - Integrate 14 new games Dec 2020*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 4244, 
     @BetTypeID_End = 4257, 
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

select * from Winlimit_Group