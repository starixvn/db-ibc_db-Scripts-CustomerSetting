/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: IRS_DBTP-bodb02
*/ 
USE [bodb02]
GO

IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Member')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'CustWinLossLimit_Member'
END
GO

