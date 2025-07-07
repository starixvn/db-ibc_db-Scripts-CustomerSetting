/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: DBCUST-CUSTDB
*/ 
USE [CUSTDB]
GO
/**     KL    **/
IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'CustWinLossLimit_Member'
END
GO

