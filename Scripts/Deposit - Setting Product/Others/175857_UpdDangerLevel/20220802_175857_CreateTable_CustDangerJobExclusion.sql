/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220802@Tacy
	Task: Create table to store Customers belong to Customer Class 8,9,10,131 [RedmineID: #175857]
	DB: DBCust/CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustDangerJobExclusion](
	[CustID] [int] NOT NULL,
	[SportType] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL
	CONSTRAINT [PK_CustDangerJobExclusion] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX IX_CreateDate ON CustDangerJobExclusion(CreateDate)
GO
