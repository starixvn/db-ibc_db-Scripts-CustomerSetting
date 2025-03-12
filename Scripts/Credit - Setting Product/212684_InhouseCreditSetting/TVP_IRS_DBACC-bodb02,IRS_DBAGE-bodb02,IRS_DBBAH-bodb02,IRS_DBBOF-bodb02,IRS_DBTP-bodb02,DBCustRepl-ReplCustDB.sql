/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250117@Johnson	
	Task: In-House
	DB: IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250117@Johnson: Created [RedmineID: #212684]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCustAgent] AS TABLE (
	[custid] [INT] NOT NULL
	,[MaxCredit] [MONEY] NOT NULL
	,[IsInternal] [BIT] NOT NULL
	,[TransferOption] [TINYINT] NULL
	,[LimitPerIP] [TINYINT] NOT NULL
	,[SelectedBetting] [BIT] NOT NULL
	,[NicknameLoginOnly] [BIT] NULL
	,[site] [VARCHAR](10) NULL
	,[creationRemark] [NVARCHAR](300) NULL
	,[IsMonitorPT] [BIT] NULL
	,[IsSynced] [BINARY](2) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustAgent] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustMaster] AS TABLE (
	[custid] [INT] NOT NULL
	,[DisableAutoMPT] [BIT] NOT NULL
	,[IsInternal] [BIT] NOT NULL
	,[TransferOption] [TINYINT] NULL
	,[LimitPerIP] [TINYINT] NOT NULL
	,[SelectedBetting] [BIT] NOT NULL
	,[NicknameLoginOnly] [BIT] NULL
	,[creationRemark] [NVARCHAR](300) NULL
	,[IsAllDayBalTransfer] [BIT] NULL
	,[IsSynced] [BINARY](2) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustMaster] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplcustSub] AS TABLE (
	[subaccid] [INT] NOT NULL
	,[custid] [INT] NOT NULL
	,[username] [VARCHAR](30) NULL
	,[userpwd] [VARCHAR](40) NULL
	,[PageAccess] [VARCHAR](50) NULL
	,[createdate] [DATETIME] NULL
	,[firstname] [NVARCHAR](50) NULL
	,[lastname] [NVARCHAR](50) NULL
	,[closed] [BIT] NULL
	,[LoginCount] [TINYINT] NOT NULL
	,[UserName2] [VARCHAR](50) NULL
	,[NicknameLoginOnly] [BIT] NULL
	,[IsAllDownline] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplcustSub] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustSuper] AS TABLE (
	[custid] [INT] NOT NULL
	,[AutoIBCPositionTaking_Tote] [SMALLMONEY] NOT NULL
	,[AutoIBCPositionTaking_Fixed] [SMALLMONEY] NOT NULL
	,[IsInternal] [BIT] NOT NULL
	,[TransferOption] [TINYINT] NULL
	,[LimitPerIP] [TINYINT] NOT NULL
	,[SelectedBetting] [BIT] NOT NULL
	,[AutoIBCPT151_AU] [SMALLMONEY] NOT NULL
	,[AutoIBCPT152_UK] [SMALLMONEY] NOT NULL
	,[AutoIBCPT152_AU] [SMALLMONEY] NOT NULL
	,[AutoIBCPT153_AU] [SMALLMONEY] NOT NULL
	,[NicknameLoginOnly] [BIT] NULL
	,[creationRemark] [NVARCHAR](300) NULL	
	,[IsMyanmarOdds] [BIT] NULL
	,[IsAllDayBalTransfer] [BIT] NULL
	,[MaxMember] [INT] NULL
	,[MaxMemberRemark] [NVARCHAR](300) NULL
	,[UplineId] [INT] NULL
	,[CurrencyModifier] [SMALLMONEY] NOT NULL
	,[IsAutoEnableADBMaster] [BIT] NOT NULL
	,[SiteDBGroupID] [SMALLINT] NOT NULL
	,[IsSynced] [BINARY](2) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustSuper] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustProductStatus] AS TABLE (
	[CustID] [INT] NOT NULL
	,[bitmapHasSynced] [BINARY](32) NOT NULL
	,[bitmapIsHidden] [BINARY](32) NOT NULL
	,[bitmapIsDisabled] [BINARY](32) NOT NULL
	,[SuspendInfo] [TINYINT] NULL
	,[Locked] [TINYINT] NULL
	,[CloseInfo] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustProductStatus] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




