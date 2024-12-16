/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241114@Winfred	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20241114@Winfred: Created [RedmineID: #185799]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSetting_Agent] AS TABLE (
	[custid] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[CustomerClass] [INT] NULL
	,[CategoryID] [INT] NULL
	,[ModifiedDate] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSetting_Agent] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




