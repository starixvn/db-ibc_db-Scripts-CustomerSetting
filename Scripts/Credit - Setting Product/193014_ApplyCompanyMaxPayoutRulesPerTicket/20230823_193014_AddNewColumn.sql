/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230823
    Task: Alter table WinLimit_CustGameMonitoring_History add column TransID [Redmine: #193014]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE WinLimit_CustGameMonitoring_History ADD 
	TransID BIGINT NULL
GO

ALTER TABLE WinLimit_CustGameMonitoring_History ALTER COLUMN 
	TotalWinAmt MONEY NULL
GO