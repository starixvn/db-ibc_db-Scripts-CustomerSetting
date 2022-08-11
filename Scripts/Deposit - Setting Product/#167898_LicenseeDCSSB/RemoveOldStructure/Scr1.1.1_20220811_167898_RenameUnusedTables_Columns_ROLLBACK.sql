/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20220811@Eden
	Task: Rename unsused tables and columns - ROLLBACK
	Redmine: https://nexdev.net/issues/167898
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/

--Rename unused Tables
EXEC sp_rename 'DEL_CustWinLimit','CustWinLimit'
EXEC sp_rename 'DEL_Dep_CustSetting','Dep_CustSetting'
EXEC sp_rename 'DEL_Dep_CustSetting3rd','Dep_CustSetting3rd'
EXEC sp_rename 'DEL_Dep_CustBetLimitGameType_Special','Dep_CustBetLimitGameType_Special'
GO
--Rename unused Columns
EXEC sp_rename 'CustSetting.DEL_minbet','minbet', 'COLUMN'
EXEC sp_rename 'CustSetting.DEL_maxbet','maxbet', 'COLUMN'

EXEC sp_rename 'custsetting3rd.DEL_minbet','minbet', 'COLUMN'
EXEC sp_rename 'custsetting3rd.DEL_maxbet','maxbet', 'COLUMN'
GO