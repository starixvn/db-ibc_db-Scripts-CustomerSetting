/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Rename column minbet,maxbet (not used) of custsetting and custsetting3rd table -- ROLLBACK[Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of all publication
*/
USE [CustDB]
GO
EXEC sp_rename 'custsetting.DEL_minbet','minbet', 'COLUMN'
EXEC sp_rename 'custsetting.DEL_maxbet','maxbet', 'COLUMN'

EXEC sp_rename 'custsetting3rd.DEL_minbet','minbet', 'COLUMN'
EXEC sp_rename 'custsetting3rd.DEL_maxbet','maxbet', 'COLUMN'
