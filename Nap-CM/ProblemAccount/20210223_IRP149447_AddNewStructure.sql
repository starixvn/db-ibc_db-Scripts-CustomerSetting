/*
	Created: 20210222@Johnson
	Task: database structure for problem account [redmine:#149447]
	DB: DBCUST/CustDB
*/

--add new columns isCredit & isDeposit
ALTER TABLE ProblemAccountAction ADD isCredit BIT 
GO
ALTER TABLE ProblemAccountAction ADD constraint DF_ProblemAccountAction_isCredit DEFAULT 0 FOR isCredit
GO

ALTER TABLE ProblemAccountAction ADD isDeposit BIT 
GO
ALTER TABLE ProblemAccountAction ADD CONSTRAINT DF_ProblemAccountAction_isDeposit DEFAULT 0 FOR isDeposit
GO
