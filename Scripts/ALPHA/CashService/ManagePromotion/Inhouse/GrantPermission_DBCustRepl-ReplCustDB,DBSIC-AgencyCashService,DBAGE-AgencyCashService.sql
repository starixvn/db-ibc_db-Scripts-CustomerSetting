/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBSIC-AgencyCashService,IRS_DBAGE-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCustRepl-ReplCustDB,IRS_DBSIC-AgencyCashService,IRS_DBAGE-AgencyCashService
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
--grant permission for inhouse accounts

--run this script on DBAGE-AgencyCashService,DBSIC-AgencyCashService
CREATE USER [repl_ap] FOR LOGIN [repl_ap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO [repl_ap]
GO

--run this script on DBCustRepl-ReplCustDB,DBSIC-AgencyCashService,DBAGE-AgencyCashService
GRANT ALTER ON dbo.CashPromotion TO [repl_ap];
GO
/***************************************************************************/



