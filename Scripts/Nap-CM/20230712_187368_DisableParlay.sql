/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230712@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class - Enhance for CC [187368]
*/
-- Disable Parlay data
--===================================================================================
ALTER TABLE dbo.CustomerClassRule ADD DisableParlay BIT NULL CONSTRAINT [DF_CustomerClassRule_DisableParlay] DEFAULT ((0))
GO
ALTER TABLE dbo.CustomerClassRule_UAT ADD DisableParlay BIT NULL CONSTRAINT [DF_CustomerClassRule_UAT_DisableParlay] DEFAULT ((0))
GO
ALTER TABLE dbo.CustomerClassRule ALTER COLUMN EnableParlay BIT NULL
GO
UPDATE a
SET a.DisableParlay = 0
FROM CustomerClassRule a WITH(ROWLOCK)
GO
