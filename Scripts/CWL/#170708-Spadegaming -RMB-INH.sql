
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220415@Robert
	Task:	#170708 - CWL - Spadegaming - Incorporate 3 new games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220415@Robert:	#170708 - CWL - Spadegaming - Incorporate 3 new games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #170708 - CWL - Spadegaming - Incorporate 3 new games*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 36, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '4326,4385,4386', 
    @GroupID = 22, 
    @GroupName = 'SG - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001
    

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 36, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '4326,4385,4386', 
    @GroupID = 22, 
    @GroupName = 'SG - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'

/*2. 170452 - CWL - Macau Games - Incorporate 6 new games*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 22, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '4098,4099,5800,5801', 
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
    @BettypeIds = '4098,4099,5800,5801', 
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


--    select * from Winlimit_Group w where w.GroupName like '%Macau Games%'