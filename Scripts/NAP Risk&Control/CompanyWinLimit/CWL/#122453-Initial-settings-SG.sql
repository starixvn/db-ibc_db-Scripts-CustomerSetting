/*
	Creator:	20191022@Robert
	Task:	Initial settings for #122453 - CWL - Integrate Spadegaming product
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191022@Robert:	Initial settings for #122453 - CWL - Integrate Spadegaming product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 36
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4301,4302,4303,4304,4305,4306,4307,4308,4309,4310,4311,4312,4313,4314,4315,4316,4317,4318,4319,4320,4321,4322,4323,4324,4325,4326'
   , @RepresentativeBettype = 4001
   , @GroupID = 22
   , @GroupName = 'SG'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;