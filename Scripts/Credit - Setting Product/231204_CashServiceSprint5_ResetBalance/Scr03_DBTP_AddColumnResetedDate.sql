/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: IRS_DBTP-bodb02
*/ 
USE [bodb02]
GO

ALTER TABLE dbo.CustWinLossLimit_Member ADD RestedDate DATETIME2(7) NULL;

