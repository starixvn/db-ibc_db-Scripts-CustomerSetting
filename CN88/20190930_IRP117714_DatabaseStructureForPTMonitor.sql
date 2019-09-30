/*
	Created: 20190930@Johnson
	Task: add new column for PT monitoring cn88 [redmine:#117714]
	DB: DBCUST/CustDB
*/

ALTER TABLE CustAgent ADD IsMonitorPT BIT DEFAULT 0