/*<info serverAlias="DBACC-bodb02,DBAGE-bodb02 "></info>*/
/*
	Created: 20241008@Winfred
	DB: DBACC/bodb02,DBACC/bodb02
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
	 CONSTRAINT [PK_CustomerClassSetting_Agent] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC,
		[SportType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
	) ON [table_customer]
END
GO
