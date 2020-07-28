/*
	Created: 20200728@Eden
	Task: add [tstamp] column of [LicenseeBAHistory] table
	DB: DBCUST/bodb_Licensee ( and replication )
*/
USE [bodb_Licensee]
GO
ALTER TABLE [dbo].[LicenseeBAHistory] ADD [tstamp] [timestamp] NOT NULL
GO