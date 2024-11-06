/*<info serverAlias="IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #212684]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplcustInfo] AS TABLE (
	[username] [NVARCHAR](50) NULL
	,[custid] [INT] NOT NULL
	,[currency] [INT] NULL
	,[roleid] [TINYINT] NULL
	,[srecommend] [INT] NULL
	,[mrecommend] [INT] NULL
	,[recommend] [INT] NULL
	,[dangercust] [BIT] NULL
	,[autosuspend] [BIT] NULL
	,[reject] [BIT] NULL
	,[credit] [MONEY] NULL
	,[closed] [BIT] NULL
	,[MatchLimit] [SMALLMONEY] NOT NULL
	,[VirtualMultiplier] [SMALLMONEY] NOT NULL
	,[Enabled] [BIT] NOT NULL
	,[danger] [TINYINT] NOT NULL
	,[danger2] [TINYINT] NOT NULL
	,[danger3] [TINYINT] NOT NULL
	,[DisableOutright] [BIT] NOT NULL
	,[Abnormal] [TINYINT] NOT NULL
	,[DoubleCommLosing] [BIT] NOT NULL
	,[autosuspend2] [BIT] NULL
	,[DisableEsports] [BIT] NULL
	,[DisableSuperLive] [BIT] NULL
	,[DisableColossusBet] [BIT] NULL
	,[HideColossusBet] [BIT] NULL
	,[LockUpd] [BIT] NULL
	,[BonusWalletFlag] [BIT] NULL
	,[CreditUpdatedDate] [SMALLDATETIME] NULL
	,[DangerLevel] [BIGINT] NULL
	,[CustomerClass] [SMALLINT] NULL
	,[Danger4] [TINYINT] NULL
	,[Danger5] [TINYINT] NULL
	,[CCSoccer] [SMALLINT] NULL
	,[CCBasketball] [SMALLINT] NULL
	,[CCEsports] [SMALLINT] NULL
	,[CCOtherSports] [SMALLINT] NULL
	,[CCNonSports] [SMALLINT] NULL
	,[autosuspend3] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplcustInfo] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomer] AS TABLE (
	[custid] [INT] NOT NULL
	,[firstname] [NVARCHAR](50) NULL
	,[lastname] [NVARCHAR](50) NULL
	,[address] [NVARCHAR](80) NULL
	,[postal] [NVARCHAR](50) NULL
	,[city] [NVARCHAR](50) NULL
	,[state] [NVARCHAR](50) NULL
	,[country] [NVARCHAR](50) NULL
	,[phone] [NVARCHAR](50) NULL
	,[mobilephone] [NVARCHAR](50) NULL
	,[fax] [NVARCHAR](50) NULL
	,[email] [NVARCHAR](50) NULL
	,[birthday] [SMALLDATETIME] NULL
	,[refcode1] [NVARCHAR](50) NULL
	,[refcode2] [NVARCHAR](50) NULL
	,[remark] [NVARCHAR](50) NULL
	,[creatdate] [SMALLDATETIME] NULL
	,[creator] [INT] NOT NULL
	,[username] [VARCHAR](30) NOT NULL
	,[currency] [TINYINT] NULL
	,[userpwd] [VARCHAR](40) NULL
	,[lastlogged] [SMALLDATETIME] NULL
	,[pwdexpiry] [DATETIME] NULL
	,[roleid] [TINYINT] NULL
	,[mrecommend] [INT] NULL
	,[recommend] [INT] NULL
	,[ugroup] [VARCHAR](3) NULL
	,[logincount] [TINYINT] NULL
	,[on_sessionid] [INT] NULL
	,[site] [VARCHAR](10) NULL
	,[iplogin] [NVARCHAR](20) NULL
	,[important] [BIT] NULL
	,[srecommend] [INT] NULL
	,[username2] [VARCHAR](50) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomer] TO [repl_ap] AS [dbo]
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




