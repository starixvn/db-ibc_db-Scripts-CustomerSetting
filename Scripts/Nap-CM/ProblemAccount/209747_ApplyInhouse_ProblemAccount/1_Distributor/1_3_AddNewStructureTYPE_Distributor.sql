/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Create new structure TYPE Distributor [Redmine: #209747]   
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02
	Table Related:
		ProblemAccount
		ProblemAccountAction
         	ProblemAccountClassification
         	ProblemAccountLimitDownline
         	ProblemAccountReason
*/
CREATE TYPE [dbo].[TVP_ReplProblemAccount] AS TABLE (
	[CustId] [INT] NOT NULL
	,[ProblemStatus] [BINARY](1) NOT NULL
	,[ReasonId] [TINYINT] NULL
	,[IsAbnormalMember] [BIT] NOT NULL
	,[Comment] [NVARCHAR](300) NULL
	,[MaxBet] [MONEY] NULL
	,[MaxPerEvent] [MONEY] NULL
	,[CreatedDate] [DATETIME] NOT NULL
	,[IsReviewed] [BIT] NOT NULL
	,[Informed1By] [INT] NULL
	,[Informed2By] [INT] NULL
	,[ActionId] [TINYINT] NULL
	,[isMarkVoid] [BIT] NULL
	,[Matchid1] [INT] NULL
	,[Matchid2] [INT] NULL
	,[SubIssueTypeId] [TINYINT] NULL
	,[VoidTime] [VARCHAR](50) NULL
	,[LimitAmount] [MONEY] NULL
	,[Creator] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProblemAccount] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/

CREATE TYPE [dbo].[TVP_ReplProblemAccountAction] AS TABLE (
	[ActionID] [TINYINT] NOT NULL
	,[ActionName] [VARCHAR](100) NOT NULL
	,[IsActive] [BIT] NULL
	,[SubIssueTypeId] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProblemAccountAction] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProblemAccountClassification] AS TABLE (
	[custid] [INT] NOT NULL
	,[IsReviewed] [BIT] NULL
	,[ModifiedDate] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProblemAccountClassification] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProblemAccountLimitDownline] AS TABLE (
	[custid] [INT] NOT NULL
	,[CreatedDate] [DATETIME] NULL
	,[UserID] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProblemAccountLimitDownline] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProblemAccountReason] AS TABLE (
	[ReasonID] [TINYINT] NOT NULL
	,[ReasonName] [VARCHAR](100) NOT NULL
	,[IsCN88] [BIT] NOT NULL
	,[IsCredit] [BIT] NOT NULL
	,[IsLicensee] [BIT] NOT NULL
	,[ReasonNameCS] [NVARCHAR](100) NULL
	,[ReasonGroupID] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProblemAccountReason] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/



