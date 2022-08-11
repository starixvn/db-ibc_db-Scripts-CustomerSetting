/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*	
	Created: 20220811@Eden
	Task: Drop unsused Columns history
	Redmine: https://nexdev.net/issues/167898
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO
ALTER TABLE custsetting_history DROP COLUMN minbet
ALTER TABLE custsetting_history DROP COLUMN maxbet

ALTER TABLE custsetting3rd_history DROP COLUMN minbet
ALTER TABLE custsetting3rd_history DROP COLUMN maxbet


