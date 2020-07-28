/*
	Created: 20200728@Eden
	Task: Insert IgnoredCust
	DB: DBCUST/bodb_Licensee ( and replication )
*/
USE [bodb_Licensee]
GO
ALTER TABLE [dbo].[LicenseeBAHistory] ADD [tstamp] [timestamp] NOT NULL
GO