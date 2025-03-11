/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBACC-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail
		PlayCurrencySetting
*/
GRANT ALTER ON dbo.StakeLevel TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.PlayCurrencySetting TO [repl_ap];
GO
/***************************************************************************/


