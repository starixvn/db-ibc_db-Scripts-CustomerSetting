/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20200617@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [135163]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200617@Robert:	Initial settings  - [Redmine: #135163]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
/*1. Task:	Initial settings for CWL - Add new PP games into CWL system [135163]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 4218, 
     @BetTypeID_End = 4227, 
     @BettypeIds = '', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*2. Task:	Initial settings for CWL - Add new PP games into CWL system [135763]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 36, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4340', 
     @GroupID = 22, 
     @GroupName = 'SG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;