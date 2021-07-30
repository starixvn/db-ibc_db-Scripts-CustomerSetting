/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210628@Tina
	Task : All Sites - Lock account & indirect close account
		   Create table for backup data
	DB: DBCUST-CustDB
	Original:

	Revisions:  
	- 20210628@Tina: First commit [Redmine:#148600]

	Parameter explanation:
*/
USE [CustDB]
GO

IF NOT EXISTS(SELECT * FROM sys.tables t WHERE t.Name = 'Cust_BackupStatus')
BEGIN

	CREATE TABLE Cust_BackupStatus (
		[CustID] [int] PRIMARY KEY CLUSTERED NOT NULL,
		[reject] [bit] NULL,
		[closed] [bit] NULL
	)
END

IF NOT EXISTS(SELECT * FROM sys.tables t WHERE t.Name = 'CustLoginInfo_BackupCloseReason')
BEGIN

	CREATE TABLE CustLoginInfo_BackupCloseReason (
		[CustID] [int] PRIMARY KEY CLUSTERED NOT NULL,
		[ClosedReason] [tinyint] NULL
	)
END

IF NOT EXISTS(SELECT * FROM sys.tables t WHERE t.Name = 'CustLoginInfoMember_BackupCloseReason')
BEGIN

	CREATE TABLE CustLoginInfoMember_BackupCloseReason (
		[CustID] [int] PRIMARY KEY CLUSTERED NOT NULL,
		[ClosedReason] [tinyint] NULL
	)
END