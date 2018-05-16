/*
	Created: Winnie
	Task: Create new table for default odd group [Redmine:#90965]
	DB: DBCUST/CustDB, Replicate to DB06 for MNL
	Date: 20180222
*/ 
USE [CustDB]
GO

CREATE TABLE dbo.Dep_DefaultOddGroup(
	AgentID		INT			NOT NULL,
	Ugroup		VARCHAR(3)  NOT NULL,
	UpdatedDate DATETIME	NOT NULL,
	UserId		INT			NOT NULL,
	IsActive	BIT			NOT NULL
 CONSTRAINT [PK_Dep_DefaultOddGroup] PRIMARY KEY CLUSTERED 
(
	AgentID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [DATA]
) ON [DATA]

GO
