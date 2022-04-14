
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220416@Robert
	Task:	#169421 - CWL- Virtual Games - Incorporate 6 new games of Mine & Tower scheme
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220414@Robert:	#169421 - CWL- Virtual Games - Incorporate 6 new games of Mine & Tower scheme
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 38, 
    @BetTypeID_Begin = 4605, 
    @BetTypeID_End = 4610, 
    @BettypeIds = '', 
    @GroupID = 24, 
    @GroupName = 'Virtual Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4601
    

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 38, 
    @BetTypeID_Begin = 4605, 
    @BetTypeID_End = 4610, 
    @BettypeIds = '', 
    @GroupID = 24, 
    @GroupName = 'Virtual Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4601,
    @Currency = 'INH,RMB'


    