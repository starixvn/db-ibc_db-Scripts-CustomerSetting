
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20230214@Robert
	Task:	#182862 - CWL - Jili - Incorporate new product
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20230214@Robert:	#182862 - CWL - Jili - Incorporate new product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #182862 - CWL - Jili - Incorporate new product*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 75, 
	@BetTypeID_Begin = 5100, 
	@BetTypeID_End = 5159, 
	@BettypeIds = '', 
	@GroupID = 58, 
	@GroupName = 'Jili', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1, 
	@RepresentativeBettype = 4001;
    

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 75, 
	@BetTypeID_Begin = 5100, 
	@BetTypeID_End = 5159, 
	@BettypeIds = '', 
	@GroupID = 58, 
	@GroupName = 'Jili', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1, 
	@RepresentativeBettype = 4001, 
	@Currency = 'INH,RMB';

/*2. CWL - Spadegaming - Integrate Promotion Prize [183471]*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 36, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '4598', 
	@GroupID = 59, 
	@GroupName = 'SG - Promotion Prize', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 1, 
	@Level2 = 0, 
	@Level3 = 0, 
	@IsBlockedTransfer_DepositSite_Level3 = 1, 
	@RepresentativeBettype = 4001;

