/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Rename column custinfo.maxpermatch164 table -- ROLLBACK[Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of all publication
*/
USE [CustDB]
GO
EXEC sp_rename 'custinfo.DEL_maxpermatch164','maxpermatch164', 'COLUMN'