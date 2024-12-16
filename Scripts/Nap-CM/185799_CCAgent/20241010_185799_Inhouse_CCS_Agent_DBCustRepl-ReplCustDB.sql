/*<info serverAlias="DBCustRepl-ReplCustDB "></info>*/
/*
	Created: 20241008@Winfred
	DB: DBCustRepl-ReplCustDB
	Task:  Customer Classification - Classify Agent
	Revisions:
		- 20241008@Winfred: [CTS] - Customer Classification - Classify Agent [RedmineID: #185799]
*/

--DROP TABLE [dbo].[CustomerClassSetting_Agent]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting_Agent]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSetting_Agent](
		[custid] [int] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[CustomerClass] [int] NULL,
		[CategoryID] [int] NULL,
		[ModifiedDate] [datetime] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
		[IsDeleted] [bit] NULL,
	 CONSTRAINT [PK_CustomerClassSetting_Agent] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC,
		[SportType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
	) ON [table_customer]
END
GO


IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting_Agent]') AND name = N'IX_CustomerClassSetting_Agent_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSetting_Agent_RepUpdateTime] ON [dbo].[CustomerClassSetting_Agent]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
