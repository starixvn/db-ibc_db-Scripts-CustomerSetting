/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240924@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Allow licensees to bypass any restrict rules [188589]
*/
-- Disable Parlay data
--===================================================================================
ALTER TABLE dbo.CustomerClassRule ADD TopPriority BIT NULL CONSTRAINT [DF_CustomerClassRule_TopPriority] DEFAULT ((0))
GO
ALTER TABLE dbo.CustomerClassRule_UAT ADD TopPriority BIT NULL CONSTRAINT [DF_CustomerClassRule_UAT_TopPriority] DEFAULT ((0))
GO
UPDATE a
SET a.TopPriority = 0
FROM CustomerClassRule a WITH(ROWLOCK)
GO