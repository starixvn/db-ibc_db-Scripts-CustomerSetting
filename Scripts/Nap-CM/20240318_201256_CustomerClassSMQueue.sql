/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240320@Winfred
	DB: DBCUST/CustDB
	Task:  Create table call loop
	Revisions:
		- 20240320@Winfred:  CCMgt - Update SP to call loop for updating policies [RedmineID: #201256]
*/
DROP TABLE CustomerClassSMQueue
Go

CREATE TABLE [dbo].[CustomerClassSMQueue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PolicySites] [NVARCHAR](MAX) NOT NULL,
	[UserID] [INT] NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[IsOverwrite] [BIT]  NOT NULL,
	[IP] [NVARCHAR](50) NOT NULL,
	[ActionID] [BIT]  NOT NULL,
	[LastModifiedTime] [DATETIME] NULL,
	[BatchID] [TINYINT] NOT NULL,
	[Status] [TINYINT] NOT NULL,
	[ErrCode] [INT] NULL,
 CONSTRAINT [PK_CustomerClassSMQueue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSMQueue] ON [dbo].[CustomerClassSMQueue] 
(
	[LastModifiedTime] ASC,
	[Status] ASC,
	[BatchID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSMQueue_Status] ON [dbo].[CustomerClassSMQueue] 
(
	[Status] ASC , 
	[UserID] ASC ,
	[LastModifiedTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

--DROP INDEX [dbo].[CustomerClassSMQueue].[IX_CustomerClassSMQueue_Status]