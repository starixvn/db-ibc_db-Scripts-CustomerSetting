
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220705@Robert
	Task:	#173668 - CWL - CWL - Macau Games - Incorporate 6 new games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220705@Robert:	#173668 - CWL - Macau Games - Incorporate 6 new games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #173668 - CWL - Macau Games - Incorporate 6 new games*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 22, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '4067,5802,5803,5804,5806', 
    @GroupID = 10, 
    @GroupName = 'Macau Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001
    

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 22, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '4067,5802,5803,5804,5806', 
    @GroupID = 10, 
    @GroupName = 'Macau Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'

/*2. #174006 - CWL - Pragmatic - Incorporate 20 New Games*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 32, 
    @BetTypeID_Begin = 6737, 
    @BetTypeID_End = 6756, 
    @BettypeIds = '', 
    @GroupID = 16, 
    @GroupName = 'PP - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001
    

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 32, 
    @BetTypeID_Begin = 6737, 
    @BetTypeID_End = 6756, 
    @BettypeIds = '', 
    @GroupID = 16, 
    @GroupName = 'PP - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'


--    select * from Winlimit_Group w where w.GroupName like '%PP %'