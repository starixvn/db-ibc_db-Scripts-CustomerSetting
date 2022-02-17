
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220215@Robert
	Task:	Change settings for #168493 - CWL - Change limit setting for some products
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220215@Robert:	Change settings for #168493 - CWL - Change limit setting for some products
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. 6: OneRNG Casino, Group: RNG Casino - Normal Games*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 6, 
	@GroupId = 3, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*. 22: Macau Games*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 22, 
	@GroupId = 10, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*3. 32: PP - Pragmatic, Group: PP - Normal Games*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 32, 
	@GroupId = 16, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';
	
/*4. 42: Saba.club, Group: Saba.club - Normal Games*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 42, 
	@GroupId = 28, 
	@Level101 = -50000, 
	@Level102 = -100000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*5. 66: Vgaming, Group: Vgaming - Normal Games*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 66, 
	@GroupId = 47, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';
	
/*6. 36: SG - Spadegaming, Group: SG*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 36, 
	@GroupId = 22, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*7. 61:Habanero*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 61, 
	@GroupId = 42, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*8. 56: Joker */
EXEC NAP_CWL_Update_Settings
	@ProductId = 56, 
	@GroupId = 36, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*9. 55: PG Soft*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 55, 
	@GroupId = 34, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*10. 62: CG */
EXEC NAP_CWL_Update_Settings
	@ProductId = 62, 
	@GroupId = 46, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*11. 67: AdvantPlay */
EXEC NAP_CWL_Update_Settings
	@ProductId = 67, 
	@GroupId = 49, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*12. 68: AdvantPlay Mini*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 68, 
	@GroupId = 50, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*13. 34: Arcadia Gaming */
EXEC NAP_CWL_Update_Settings
	@ProductId = 34, 
	@GroupId = 21, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*14. 60: MaxGame*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 60, 
	@GroupId = 40, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*15. 38: Virtual games */
EXEC NAP_CWL_Update_Settings
	@ProductId = 38, 
	@GroupId = 24, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';

/*16. 50: Funky Games*/
EXEC NAP_CWL_Update_Settings
	@ProductId = 50, 
	@GroupId = 32, 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000,
	@Currency = 'INH,RMB';


	