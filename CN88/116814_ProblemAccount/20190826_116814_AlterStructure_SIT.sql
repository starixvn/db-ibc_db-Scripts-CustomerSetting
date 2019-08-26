/*
	Created: 20190826@Elodie	
	Task: alter structure for problem account 
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

DELETE FROM CS_ProblemAccount
GO

ALTER TABLE CS_ProblemAccount DROP COLUMN IsReducedBetLimit
ALTER TABLE CS_ProblemAccount ADD IsAbnormalMember BIT NOT NULL 

CREATE NONCLUSTERED INDEX IX_CS_ProblemAccount_CreatedDate ON CS_ProblemAccount (CreatedDate)