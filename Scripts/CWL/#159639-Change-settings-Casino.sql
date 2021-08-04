
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210804@Robert
	Task:	Change settings for #159639 - CWL - Change limit setting for All Live Casino Products
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210804@Robert:	Change settings for #159639 - CWL - Change limit setting for All Live Casino Products
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. Allbet*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 21, 
	@GroupId = 9, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*2. Allbet*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 45, 
	@GroupId = 26, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*3. SA Gaming*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 39, 
	@GroupId = 25, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;


/*4. IBCBet Live Casino*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 46, 
	@GroupId = 30, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*5. ION*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 52, 
	@GroupId = 31, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*6. WM*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 51, 
	@GroupId = 35, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*7. BG*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 57, 
	@GroupId = 39, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*8. GDG*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 59, 
	@GroupId = 38, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

/*9. PP Live Casino*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 65, 
	@GroupId = 44, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000;

