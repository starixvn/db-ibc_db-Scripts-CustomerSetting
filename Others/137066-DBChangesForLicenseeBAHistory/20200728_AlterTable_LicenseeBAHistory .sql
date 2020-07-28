/*
	Created: 20200728@Eden
	Task: add [tstamp] column of [LicenseeBAHistory] table
	DB: DBCUST/bodb_Licensee ( and replication )
*/
--Step 1 : Add on DBCUST
USE [bodb_Licensee]
GO
ALTER TABLE [dbo].[LicenseeBAHistory] ADD [tstamp] [timestamp] NOT NULL
GO

--Step 2 : Add on all Replication servers
USE [bodb_Licensee]
GO
ALTER TABLE [dbo].[LicenseeBAHistory] ADD [tstamp] [Binary](8) NOT NULL
GO
