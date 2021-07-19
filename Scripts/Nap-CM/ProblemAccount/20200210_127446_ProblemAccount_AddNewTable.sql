/*
	Created: 20200210@Elodie	
	Task: Prepare structure for problem account 
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

--DROP TABLE ProblemAccountReasonAction
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


