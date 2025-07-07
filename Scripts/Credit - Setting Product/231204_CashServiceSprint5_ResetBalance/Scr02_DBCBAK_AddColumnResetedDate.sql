/*<info serverAlias="DBCBAK-CustDB_History"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: DBCBAK-CustDB_History
*/ 
USE [CustDB_History]
GO

ALTER TABLE dbo.CustWinLossLimit_Member_History ADD RestedDate DATETIME2(7) NULL;

