/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Rename column minbet,maxbet (not used) of custsetting and custsetting3rd table [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/
USE [CustDB]
GO
EXEC sp_rename 'custsetting.minbet','DEL_minbet', 'COLUMN'
EXEC sp_rename 'custsetting.maxbet','DEL_maxbet', 'COLUMN'

EXEC sp_rename 'custsetting3rd.minbet','DEL_minbet', 'COLUMN'
EXEC sp_rename 'custsetting3rd.maxbet','DEL_maxbet', 'COLUMN'