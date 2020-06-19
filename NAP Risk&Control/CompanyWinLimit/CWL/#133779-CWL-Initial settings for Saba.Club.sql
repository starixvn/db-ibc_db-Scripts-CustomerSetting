
/*
	Creator:	20200507@Robert
	Task:	Initial settings CWL - Integrate 5 new Spadegaming games [#133779]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200507@Robert:	Initial settings CWL - CWL - Saba.Club add full bettype range to CWL [#133779]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 42, 
     @BetTypeID_Begin = 1611, 
     @BetTypeID_End = 1699, 
     @BettypeIDs = '', 
     @GroupID = 28, 
     @GroupName = 'Saba.club', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 1611;
