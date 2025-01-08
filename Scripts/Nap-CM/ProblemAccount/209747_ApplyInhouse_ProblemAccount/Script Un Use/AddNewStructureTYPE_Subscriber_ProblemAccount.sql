/*<info serverAlias="IRS_DBG-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Rep Inhouse config Subscriber [Redmine: #209747]   
	DB: IRS_DBG-bodb02
	Table: ProblemAccount
*/

CREATE TYPE [dbo].[TVP_ReplProblemAccount] AS TABLE (
	[CustId] [INT] NOT NULL
	,[ProblemStatus] [BINARY](1) NOT NULL
	,[ReasonId] [TINYINT] NULL
	,[IsAbnormalMember] [BIT] NOT NULL
	,[Comment] [NVARCHAR](150) NULL
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