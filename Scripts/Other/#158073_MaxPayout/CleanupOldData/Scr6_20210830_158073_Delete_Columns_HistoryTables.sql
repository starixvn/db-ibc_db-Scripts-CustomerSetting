/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20210830
	Task: Delete column minbet,maxbet (not used) of custsetting_history and custsetting3rd_history table [Redmine: #154048]   
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO
ALTER TABLE custinfo_history DROP CONSTRAINT DF_CustInfo_History_maxpermatch164

ALTER TABLE custsetting_history DROP COLUMN minbet
ALTER TABLE custsetting_history DROP COLUMN maxbet
ALTER TABLE custsetting3rd_history DROP COLUMN minbet
ALTER TABLE custsetting3rd_history DROP COLUMN maxbet
ALTER TABLE custinfo_history DROP COLUMN maxpermatch164