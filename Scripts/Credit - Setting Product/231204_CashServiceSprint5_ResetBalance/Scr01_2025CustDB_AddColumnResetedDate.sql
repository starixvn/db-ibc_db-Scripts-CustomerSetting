/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: DBCUST-CUSTDB
*/ 
USE [CustDB]
GO

ALTER TABLE dbo.CustWinLossLimit_Member ADD RestedDate DATETIME2(7) NULL;




