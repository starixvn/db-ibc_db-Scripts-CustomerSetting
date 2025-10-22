/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBAGE-bodb02"></info>*/
/*
	Created: 20251021@Johnson
	Task: Enhancement - TO Monitor Control By League [Redmine:#236824]	
	DB: DBCUST/CustDB
*/

UPDATE RepInfo WITH(ROWLOCK)
SET active = 1
where name = 'TOControl_GlobalSetting'