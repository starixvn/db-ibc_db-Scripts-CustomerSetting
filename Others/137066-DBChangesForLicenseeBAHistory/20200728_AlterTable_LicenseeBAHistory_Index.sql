/*
	Created: 20200728@Eden
	Task: Add IX_tstamp index for [tstamp] column of [LicenseeBAHistory] table
	DB: DB061/bodb_Licensee
*/
USE [bodb_Licensee]
GO

CREATE NONCLUSTERED INDEX [IX_tstamp] ON [dbo].[LicenseeBAHistory]
(
	[tstamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BA_INDEX]
GO