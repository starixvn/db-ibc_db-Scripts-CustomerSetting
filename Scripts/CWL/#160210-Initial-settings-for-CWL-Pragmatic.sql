/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210831@Robert
	Task:	Initial settings for CWL - Pragmatic Integration - [Redmine: #160210]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210831@Robert:	Initial settings  - [Redmine: #160210]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32, 
	@BetTypeID_Begin = 4266, 
	@BetTypeID_End = 4296, 
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

	
