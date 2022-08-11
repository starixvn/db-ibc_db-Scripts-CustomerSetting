/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20220811@Eden
	Task: Rename unsused tables and columns
	Redmine: https://nexdev.net/issues/167898
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
--Rename unused Tables
EXEC sp_rename 'CustWinLimit','DEL_CustWinLimit'
EXEC sp_rename 'Dep_CustSetting','DEL_Dep_CustSetting'
EXEC sp_rename 'Dep_CustSetting3rd','DEL_Dep_CustSetting3rd'
EXEC sp_rename 'Dep_CustBetLimitGameType_Special','DEL_Dep_CustBetLimitGameType_Special'
GO
--Rename unused Columns
EXEC sp_rename 'CustSetting.minbet','DEL_minbet', 'COLUMN'
EXEC sp_rename 'CustSetting.maxbet','DEL_maxbet', 'COLUMN'

EXEC sp_rename 'custsetting3rd.minbet','DEL_minbet', 'COLUMN'
EXEC sp_rename 'custsetting3rd.maxbet','DEL_maxbet', 'COLUMN'
GO