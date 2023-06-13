
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20230523@Robert
	Task:	#186475 - CWL - YeeBet - Integrate new Live Casino product
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20230523@Robert:	#186475 - CWL - YeeBet - Integrate new Live Casino product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/



EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 76, 
	@BetTypeID_Begin = 3151, 
	@BetTypeID_End = 3152, 
	@BettypeIds = '', 
	@GroupID = 60, 
	@GroupName = 'YeeBet', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 3151;
    
    select * from Winlimit_Group