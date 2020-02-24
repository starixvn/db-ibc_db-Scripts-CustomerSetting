/*
	Created: 20200210@Elodie	
	Task: Prepare structure for problem account for SIT
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE CustDB
GO

ALTER TABLE dbo.ProblemAccount ADD ActionId TINYINT NULL

--Create on DBCUST and DB06
CREATE TABLE ProblemAccountAction
(
	ActionID		TINYINT NOT NULL,
	ActionName		VARCHAR(100) NOT NULL,
	IsActive		BIT
CONSTRAINT [PK_ProblemAccountAction] PRIMARY KEY CLUSTERED 
(
	ActionID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

--Create on DBCUST and DB06
CREATE TABLE ProblemAccountReasonAction
(
	ActionID		TINYINT NOT NULL,
	ReasonID		TINYINT NOT NULL,
CONSTRAINT [PK_ProblemAccountReasonAction] PRIMARY KEY CLUSTERED 
(
	ActionID ASC,
	ReasonID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
