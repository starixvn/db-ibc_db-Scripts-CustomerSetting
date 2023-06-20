/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 19/06/2023
	Task: Allbet - Remove duplicated bet limit range 5000-100,000 on Lucky88 [Redmine:#189910]	
	DB: DBCUST/CustDB 
*/


	DELETE ds
	FROM Dep_StakeLevel ds WITH (ROWLOCK, UPDLOCK)
	WHERE StakeLevelID = 471 
	AND ResourceId = 145