/*
	Created: 20210222@Johnson
	Task: database structure for problem account [redmine:#149477]
	DB: DBCUST/CustDB
*/

CREATE TABLE [dbo].[ProblemAccountLimitDownline](
	[CustID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UserID] [int] NULL,
CONSTRAINT PK_ProblemAccountLimitDownline PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]

GO
