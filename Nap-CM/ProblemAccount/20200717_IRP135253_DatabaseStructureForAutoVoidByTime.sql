/*
	Created: 20200717@Johnson
	Task: add new column to support auto void winning by time for problem accounts
	DB: DBCUST/CUSTDB
*/

ALTER TABLE ProblemAccount ADD VoidTime VARCHAR(50)
GO

ALTER TABLE ProblemAccount ADD LimitAmount MONEY