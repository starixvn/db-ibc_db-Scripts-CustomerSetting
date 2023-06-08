/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230524@Tacy
	Task: Create new table Acc_CustType [RedmineID: #188025]
		 https://nexdev.net/issues/188025 
	Database: DBCUST-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Acc_CustType](
	[CustID] [int] NOT NULL,
	[TypeID] [tinyint] NOT NULL, --1 ~ VIP; 2 ~ Suspcious; 3 ~ Problem
	[MarkedDate] [smalldatetime] NOT NULL,
	[Remark] [Nvarchar](2000) NULL
 CONSTRAINT [PK_Acc_CustType] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Acc_CustType] ADD  CONSTRAINT [DF_Acc_CustType_MarkedDate]  DEFAULT (GETDATE()) FOR [MarkedDate]
GO

CREATE NONCLUSTERED INDEX IX_Acc_CustType_TypeID ON [dbo].[Acc_CustType] ([TypeID]);   
GO 