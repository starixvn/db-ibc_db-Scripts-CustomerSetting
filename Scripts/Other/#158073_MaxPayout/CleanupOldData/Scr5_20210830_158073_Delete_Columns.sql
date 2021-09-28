/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Delete column minbet,maxbet (not used) of custsetting and custsetting3rd table [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of all publication
*/
USE [CustDB]
GO
ALTER TABLE custsetting DROP CONSTRAINT DF_custSetting_minbet
ALTER TABLE custsetting DROP CONSTRAINT DF_custSetting_maxbet
ALTER TABLE custsetting3rd DROP CONSTRAINT DF_custSetting3rd_minbet
ALTER TABLE custsetting3rd DROP CONSTRAINT DF_custSetting3rd_maxbet
ALTER TABLE custinfo DROP CONSTRAINT DF_CustInfo_maxpermatch164

ALTER TABLE custsetting DROP COLUMN DEL_minbet
ALTER TABLE custsetting DROP COLUMN DEL_maxbet
ALTER TABLE custsetting3rd DROP COLUMN DEL_minbet
ALTER TABLE custsetting3rd DROP COLUMN DEL_maxbet
