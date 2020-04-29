
/*
	Creator:	20200429@Robert
	Task:	Initial settings CWL - Integrate 5 new Spadegaming games [#133241]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200429@Robert:	Initial settings CWL - Integrate 5 new Spadegaming games [#133241]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 36, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '4302,4305,4337,4338,4339', 
     @GroupID = 22, 
     @GroupName = 'SG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;