/*<info serverAlias="IRS_DBG-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBG-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #212684]

	Example:			
*/
GRANT ALTER ON dbo.custSub TO [repl_ap];
GO
/***************************************************************************/
GRANT ALTER ON dbo.Customer TO [repl_ap];
GO
/***************************************************************************/




