/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241220@Tacy	
	Task: In-House
	DB: IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241220@Tacy: Created [RedmineID: #215807]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplDep_CustSabaInfo] AS TABLE (
	[CustID] [INT] NOT NULL
	,[CustType] [TINYINT] NOT NULL
	,[SabaID] [BIGINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT] NOT NULL
	,[_FetchedTime] [DATETIME2](7) NULL
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_CustSabaInfo] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




