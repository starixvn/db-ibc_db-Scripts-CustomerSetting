/*<info serverAlias="IRS_DBSIC-CustDB"></info>*/
/*
	Created: 20250807@Eden
	Task: Create Table, TVP custSub [#RedmineID:#223896]
	DB: IRS_DBSIC-CustDB
*/
USE custdb
GO
--DROP TABLE [custSub]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[custSub](
	[subaccid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[custid] [int] NOT NULL,
	[username] [varchar](30) NULL,
	[userpwd] [varchar](40) NULL,
	[PageAccess] [varchar](50) NULL,
	[createdate] [datetime] NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[closed] [bit] NULL,
	[LoginCount] [tinyint] NOT NULL,
	[UserName2] [varchar](50) NULL,
	[NicknameLoginOnly] [bit] NULL,
	[IsAllDownline] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL
 CONSTRAINT [PK_custsub] PRIMARY KEY CLUSTERED 
(
	[subaccid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[custSub] ADD  CONSTRAINT [DF_custSub_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
GRANT ALTER ON [dbo].[custSub] TO [repl_ap]

-----CREATE TVP
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