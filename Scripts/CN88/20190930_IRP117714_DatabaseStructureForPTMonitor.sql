/*
	Created: 20190930@Johnson
	Task: add new column for PT monitoring cn88 [redmine:#117714]
	DB: DBCUST/CustDB
*/

ALTER TABLE CustAgent ADD IsMonitorPT BIT NULL

ALTER TABLE CustAgent ADD CONSTRAINT [DF_CustAgent_IsMonitorPT] DEFAULT 0 FOR  IsMonitorPT


