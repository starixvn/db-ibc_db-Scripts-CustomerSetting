/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240916@Tacy	
	Task: In-House
	DB: IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20240916@Tacy: Created [RedmineID: #209807]

	Example:			
*/
--WhiteLabelInfo
CREATE TYPE [dbo].[TVP_ReplWhiteLabelInfo] AS TABLE (
	[CustID] [INT] NOT NULL
	,[WhiteLabel] [CHAR](16) NOT NULL
	,[LaunchedDate] [SMALLDATETIME] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT] NOT NULL
	,[_FetchedTime] [DATETIME2](7) NULL
) 
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplWhiteLabelInfo] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/

--WhiteLabelSetting
IF @@SERVERNAME NOT IN ('SITDB06', 'DB061', 'DB062')
BEGIN
	CREATE TYPE [dbo].[TVP_ReplWhiteLabelSetting] AS TABLE (
		[GroupID] [INT] NULL
		,[CustID] [INT] NOT NULL
		,[HeadlineRate] [SMALLMONEY] NOT NULL
		,[SuperRate] [SMALLMONEY] NOT NULL
		,[MasterRate] [SMALLMONEY] NOT NULL
		,[AgentRate] [SMALLMONEY] NOT NULL
		,[FromDate] [DATETIME] NOT NULL
		,[ToDate] [DATETIME] NOT NULL
		,[Remark] [VARCHAR](1000) NULL
		,[RepUpdateTime] [DATETIME2](7) NOT NULL
		,[isDeleted] [BIT] NOT NULL
		,[_FetchedTime] [DATETIME2](7) NULL
	)
	
	GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplWhiteLabelSetting] TO [repl_ap] AS [dbo]
END
/***************************************************************************/
