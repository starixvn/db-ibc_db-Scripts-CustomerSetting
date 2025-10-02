/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250916@Dave	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250916@Dave: Created [RedmineID: #238689]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCustomerRemark] AS TABLE (
	[CustID] [INT] NOT NULL
	,[SuperRemark] [NVARCHAR](200) NULL
	,[MasterRemark] [NVARCHAR](200) NULL
	,[AgentRemark] [NVARCHAR](200) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerRemark] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




