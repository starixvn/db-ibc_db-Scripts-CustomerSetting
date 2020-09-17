
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200901@Robert
	Task:	CWL - Macau Games - Add 10 new BluePrint games [139596]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200901@Robert:	CWL - Macau Games - Add 10 new BluePrint games [139596]
		- 20200901@Robert:	CWL - Spadegaming - Incorporate 10 new games [139717]
		- 20200901@Robert:	CWL - Pragmatic - Integrate 11 new games Aug 2020 [140579]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
/*139596 - CWL - Macau Games - Add 10 new BluePrint games*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 22, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4057,4058,4059,4061,4063,4073,4077,4078,4079,4080', 
     @GroupID = 10, 
     @GroupName = 'Macau Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;


/*#139717 - CWL - Spadegaming - Incorporate 10 new games*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 36, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4341,4342,4343,4344', 
     @GroupID = 22, 
     @GroupName = 'SG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*#140579 - CWL - Pragmatic - Integrate 11 new games Aug 2020*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4232,4233,4234,4235,4236,4237,4238,4239,4240,4241,4242', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

