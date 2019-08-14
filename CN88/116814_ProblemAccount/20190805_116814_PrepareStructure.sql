/*
	Created: 20190805@Elodie	
	Task: Prepare structure for problem account 
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

DROP TABLE ProblemAccountReason
DROP TABLE CS_ProblemAccount

CREATE TABLE ProblemAccountReason
(
	ReasonID		TINYINT NOT NULL,
	ReasonName		VARCHAR(100) NOT NULL
CONSTRAINT [PK_ProblemAccountReason] PRIMARY KEY CLUSTERED 
(
	ReasonID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE CS_ProblemAccount
(
	CustId				INT NOT NULL,
	ProblemStatus		BINARY(1) NOT NULL,
	ReasonId			TINYINT NULL,
	Comment				NVARCHAR(300) NULL,
	IsReducedBetLimit	BIT NOT NULL,
	MaxBet				MONEY NULL,
	MaxPerEvent			MONEY NULL,
	CreatedDate			DATETIME NOT NULL,
	IsReviewed			BIT NOT NULL
CONSTRAINT [PK_CS_ProblemAccount] PRIMARY KEY CLUSTERED 
(
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

ALTER TABLE [dbo].CS_ProblemAccount ADD  CONSTRAINT [DF_CS_ProblemAccount_CreatedDate]  DEFAULT (getdate()) FOR CreatedDate
GO