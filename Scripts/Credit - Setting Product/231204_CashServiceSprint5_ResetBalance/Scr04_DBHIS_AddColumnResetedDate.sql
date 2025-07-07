/*<info serverAlias="DBHIS-bodb_CustHistoryy"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: DBHIS-bodb_CustHistory
*/ 
USE [bodb_CustHistory]
GO

ALTER TABLE dbo.CustWinLossLimit_Member_History ADD RestedDate DATETIME2(7) NULL;

