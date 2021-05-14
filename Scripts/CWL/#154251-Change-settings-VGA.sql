/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210514@Robert
	Task:	Change settings for #154251 - CWL - VGA
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210514@Robert:	Change settings for #154251 - CWL - VGA
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #154251 - CWL - Integrate Vgaming*/
EXEC NAP_CWL_Update_Settings 
	@ProductId = 66
   , @GroupId = 47
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000;

EXEC NAP_CWL_Update_Settings 
	@ProductId = 66
   , @GroupId = 48
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 1
   , @Level3 = 0;

/*2. #155136 - NAP Risk & Control Reports - Integrate AdvantPlay Mini*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 68, 
     @BetTypeID_Begin = 7801, 
     @BetTypeID_End = 7810, 
     @BettypeIds = '', 
     @GroupID = 50, 
     @GroupName = 'AdvantPlay Mini', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001 ;


select * from Winlimit_Group