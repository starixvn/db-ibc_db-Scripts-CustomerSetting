/*
	Creator:	20181025@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [103704]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20181025@Robert:	Initial settings  - [Redmine: #103704]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '4123,4124,4125,4126,4127,4128,4129,4130,4131,4132,4133,4134,4135,4136,4137,4138,4139,4140,4141,4142,4143,4144,4145,4146,4147,4148,4149,4150,4151,4152,4153,4154,4155,4156,4157,4158,4159,4160,4161,4162,4163,4164,4165,4166,4167,4168,4169,4170,4171,4172,4173,4174',
	@GroupID = 16, 
	@GroupName = 'PP', 
	@Level101 = -10000, 
	@Level102 = -30000, 
	@Level1 = 10000, 
	@Level2 = 30000, 
	@Level3 = 100000,
	@IsBlockedTransfer_DepositSite_Level3 = 1; 
	


	