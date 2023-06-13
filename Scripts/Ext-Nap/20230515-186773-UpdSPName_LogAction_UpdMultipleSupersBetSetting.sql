/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230515@Tacy
	Task: Update SPName on table LogAction on PRO [redmine:#186773]
		https://nexdev.net/issues/186773
	DB: DBLOG.bodb_CustomerLog
*/
--LogAction
UPDATE LogAction WITH (ROWLOCK)
SET SPName='Acc_CustomerUpd_BetSetting'
WHERE ActionID IN (220035,220036)