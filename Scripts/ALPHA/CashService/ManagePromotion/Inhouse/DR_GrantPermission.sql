/*<info serverAlias="DBCUST-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCUST-AgencyCashService
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
CREATE USER [repl_ap] FOR LOGIN [repl_ap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO [repl_ap]
GO

GRANT ALTER ON dbo.CashPromotion TO [repl_ap];
GO
/***************************************************************************/



