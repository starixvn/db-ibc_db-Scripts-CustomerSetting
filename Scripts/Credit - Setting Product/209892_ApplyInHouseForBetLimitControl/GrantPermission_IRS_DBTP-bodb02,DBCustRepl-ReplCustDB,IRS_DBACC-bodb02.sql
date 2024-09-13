/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240913@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBACC-bodb02
	
	Revisions:
		- 20240913@Johnson: Created [RedmineID: #209892]

	Example:			
*/
GRANT ALTER ON dbo.BetLimitControlType TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.BetRestriction_Setting TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.BetLimitControlTypeDetails TO [repl_ap];
GO


