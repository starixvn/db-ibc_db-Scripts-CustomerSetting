/*<info serverAlias="DBBOF-bodb02,DBAGE-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20230906@Tacy
	Task: In-House
	DB: DB05x-bodb02, DBTP-bodb02
	
	Revisions:
		- 20230906@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 1,'Dep_CustBonusSharing',1,'RepUpdateTime',0,'CustID|FromDate','Repl_GetDep_CustBonusSharing','Repl_PutDep_CustBonusSharing',1000,10,60000