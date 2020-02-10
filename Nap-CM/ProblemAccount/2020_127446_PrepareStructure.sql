/*
	Created: 20190805@Elodie	
	Task: Prepare structure for problem account 
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

--DROP TABLE ProblemAccount

CREATE TABLE ProblemAccount
(
	CustId				INT NOT NULL,
	ProblemStatus		BINARY(1) NOT NULL,
	ReasonId			TINYINT NULL,
	IsAbnormalMember	BIT NOT NULL,
	Comment				NVARCHAR(300) NULL,
	MaxBet				MONEY NULL,
	MaxPerEvent			MONEY NULL,
	CreatedDate			DATETIME NOT NULL,
	IsReviewed			BIT NOT NULL,
	Informed1By			INT NULL,
	Informed2By			INT NULL
CONSTRAINT [PK_ProblemAccount] PRIMARY KEY CLUSTERED 
(
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

ALTER TABLE [dbo].ProblemAccount ADD CONSTRAINT [DF_ProblemAccount_CreatedDate]  DEFAULT (getdate()) FOR CreatedDate
GO

CREATE NONCLUSTERED INDEX IX_ProblemAccount_CreatedDate ON ProblemAccount (CreatedDate)

GO

ALTER TABLE dbo.ProblemAccountReason ADD IsCN88 BIT NOT NULL CONSTRAINT [DF_ProblemAccountReason_IsCN88] DEFAULT ((0))
ALTER TABLE dbo.ProblemAccountReason ADD IsCredit BIT NOT NULL CONSTRAINT [DF_ProblemAccountReason_IsCredit] DEFAULT ((0))
ALTER TABLE dbo.ProblemAccountReason ADD IsLicensee BIT NOT NULL CONSTRAINT [DF_ProblemAccountReason_IsLicensee] DEFAULT ((0))
 
UPDATE ProblemAccountReason
SET IsCredit = 1,
	IsLicensee = 1,
	IsCN88 = 1