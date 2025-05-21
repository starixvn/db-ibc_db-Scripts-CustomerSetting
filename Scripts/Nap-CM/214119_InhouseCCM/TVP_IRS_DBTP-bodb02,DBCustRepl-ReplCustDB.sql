/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250211@Winfred	
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCustomerClassPolicyManagement] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[PolicyTitle] [VARCHAR](500) NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassPolicyManagement] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassPolicyManagement_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[PolicyTitle] [VARCHAR](500) NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassPolicyManagement_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassPolicyRule] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[RuleID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassPolicyRule] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassPolicyRule_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[RuleID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassPolicyRule_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassRule] AS TABLE (
	[RuleID] [INT] NOT NULL
	,[CustomerClass] [SMALLINT] NOT NULL
	,[RuleTitle] [VARCHAR](500) NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[IsLive] [TINYINT] NOT NULL
	,[DiffBalanceRatio] [DECIMAL](9,2) NULL
	,[BetDelay] [DECIMAL](9,2) NULL
	,[NextBetInterval] [SMALLINT] NULL
	,[SuperBetInterval] [SMALLINT] NULL
	,[SiteBetInterval] [SMALLINT] NULL
	,[MinBet] [INT] NULL
	,[MaxBet] [INT] NULL
	,[MaxPerMatch] [INT] NULL
	,[RepeatedBets] [TINYINT] NULL
	,[SeizeBetTicket] [TINYINT] NULL
	,[PeakHourSpreadAdjustment] [SMALLINT] NULL
	,[AgentBetInterval] [SMALLINT] NULL
	,[Enable] [BIT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[DisableParlay] [BIT] NULL
	,[CustomerClassDetail] [SMALLINT] NULL
	,[TopPriority] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassRule] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassRule_UAT] AS TABLE (
	[RuleID] [INT] NOT NULL
	,[CustomerClass] [SMALLINT] NOT NULL
	,[RuleTitle] [VARCHAR](500) NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[IsLive] [TINYINT] NOT NULL
	,[DiffBalanceRatio] [DECIMAL](9,2) NULL
	,[BetDelay] [DECIMAL](9,2) NULL
	,[NextBetInterval] [SMALLINT] NULL
	,[SuperBetInterval] [SMALLINT] NULL
	,[SiteBetInterval] [SMALLINT] NULL
	,[MinBet] [INT] NULL
	,[MaxBet] [INT] NULL
	,[MaxPerMatch] [INT] NULL
	,[RepeatedBets] [TINYINT] NULL
	,[SeizeBetTicket] [TINYINT] NULL
	,[EnableParlay] [BIT] NULL
	,[PeakHourSpreadAdjustment] [SMALLINT] NULL
	,[AgentBetInterval] [SMALLINT] NULL
	,[Enable] [BIT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[DisableParlay] [BIT] NULL
	,[CustomerClassDetail] [SMALLINT] NULL
	,[TopPriority] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassRule_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassRuleLeagueGroup] AS TABLE (
	[RuleID] [INT] NOT NULL
	,[LeagueGroupID] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassRuleLeagueGroup] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassRuleLeagueGroup_UAT] AS TABLE (
	[RuleID] [INT] NOT NULL
	,[LeagueGroupID] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassRuleLeagueGroup_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSetting] AS TABLE (
	[custid] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[CustomerClass] [SMALLINT] NULL
	,[ModifiedDate] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSiteManagement] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[Site] [NVARCHAR](50) NOT NULL
	,[Currency] [INT] NOT NULL
	,[Platform] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSiteManagement] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSiteManagement_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[Site] [NVARCHAR](50) NOT NULL
	,[Currency] [TINYINT] NOT NULL
	,[Platform] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSiteManagement_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpread] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[PolicyTitle] [VARCHAR](500) NOT NULL
	,[Spread] [DECIMAL](4,2) NULL
	,[Enable] [BIT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[IsLive] [TINYINT] NULL
	,[Type] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpread] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpread_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[PolicyTitle] [VARCHAR](500) NOT NULL
	,[Spread] [DECIMAL](4,2) NULL
	,[Enable] [BIT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[IsLive] [TINYINT] NULL
	,[Type] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpread_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadClass] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[CustomerClass] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadClass] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadClass_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[CustomerClass] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadClass_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadDetail] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[Platform] [TINYINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadDetail] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadDetail_UAT] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[Platform] [TINYINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadDetail_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplVRMemberBigStake] AS TABLE (
	[CustID] [INT] NOT NULL
	,[Type] [TINYINT] NOT NULL
	,[FirstBetDate] [DATE] NULL
	,[Status] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplVRMemberBigStake] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSMQueue] AS TABLE (
	[ID] [INT] NOT NULL
	,[PolicySites] [NVARCHAR](MAX) NOT NULL
	,[UserID] [INT] NULL
	,[IsTest] [TINYINT] NOT NULL
	,[IsOverwrite] [BIT] NOT NULL
	,[IP] [NVARCHAR](50) NOT NULL
	,[ActionID] [BIT] NOT NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[BatchID] [TINYINT] NOT NULL
	,[Status] [TINYINT] NOT NULL
	,[ErrCode] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSMQueue] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




