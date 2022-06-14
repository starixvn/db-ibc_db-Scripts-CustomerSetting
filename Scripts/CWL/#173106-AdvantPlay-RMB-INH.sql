
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220614@Robert
	Task:	#173106 - CWL - AdvantPlay - Incorporate 3 new games 7723 -> 7725

	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220614@Robert:	#173106 - CWL - AdvantPlay - Incorporate 3 new games 7723 -> 7725
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/



EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 67, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '7723,7724,7725', 
    @GroupID = 49, 
    @GroupName = 'AdvantPlay', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001
    

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 67, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '7723,7724,7725', 
    @GroupID = 49, 
    @GroupName = 'AdvantPlay', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'


--    select * from Winlimit_Group w where w.GroupName like '%AdvantPlay%'