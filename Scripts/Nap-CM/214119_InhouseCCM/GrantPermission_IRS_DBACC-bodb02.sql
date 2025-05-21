/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250211@Winfred	
	DB: IRS_DBACC-bodb02
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]

	Example:			
*/
GRANT ALTER ON dbo.CustomerClassPolicyManagement TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.CustomerClassRule TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.CustomerClassSpread TO [repl_ap];
GO
/***************************************************************************/