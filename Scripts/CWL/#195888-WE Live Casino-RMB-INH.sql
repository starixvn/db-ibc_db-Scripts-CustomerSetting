
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	202301109@Robert
	Task:	#195888 - CWL - Risk and Control - WE Live Casino - Integrate new product
	Database:	DBCUST.CustDB
	
	Revisions:
		- 202301109@Robert:	#195888 - CWL - Risk and Control - WE Live Casino - Integrate new product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- For Deposit
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 80, 
	@BetTypeID_Begin = 10300, 
	@BetTypeID_End = 10311, 
	@BettypeIds = '', 
	@GroupID = 63, 
	@GroupName = 'WE Live Casino', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000, 
	@IsDeposit = 1, 
	@RepresentativeBettype = 10300;

-- For Credit
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 80, 
	@BetTypeID_Begin = 10300, 
	@BetTypeID_End = 10311, 
	@BettypeIds = '', 
	@GroupID = 63, 
	@GroupName = 'WE Live Casino', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000, 
	@IsDeposit = 0, 
	@RepresentativeBettype = 10300;