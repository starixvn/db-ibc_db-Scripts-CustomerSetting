/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Winfred
	Date: 20230625
	Task: Correct data of BA member RedmineID:#194433
	DB: DBCUST/CustDB
*/

	USE CustDB
	GO

	UPDATE dca 
	SET dca.IsGroupedPT = 1
	FROM Dep_CustSettingMode dca WITH (ROWLOCK, UPDLOCK)
	WHERE CustID = 98202855 

	DELETE cg
	FROM DEP_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
	WHERE CustID = 98202855

    
