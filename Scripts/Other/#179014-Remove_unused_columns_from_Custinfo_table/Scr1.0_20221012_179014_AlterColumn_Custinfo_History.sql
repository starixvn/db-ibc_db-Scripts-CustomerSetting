/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20221012@Eden
	Task: Alter column custinfo_history [#179014] 
	DB: DBTP/bodb_CustHistory
*/

ALTER TABLE custinfo_history ALTER COLUMN DisableCasino BIT NULL;
ALTER TABLE custinfo_history ALTER COLUMN SyncCasino BIT NULL;