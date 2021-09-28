/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Delete column custinfo.DEL_maxpermatch164 [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of all publication
*/
USE [CustDB]
GO
ALTER TABLE custinfo DROP CONSTRAINT DF_CustInfo_maxpermatch164

ALTER TABLE custinfo DROP COLUMN DEL_maxpermatch164