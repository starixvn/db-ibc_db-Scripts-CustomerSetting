/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20221207@Tacy
	Task: Drop unused columns on Custinfo
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

--DROP CONSTRAINT
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custinfo_DisableColossusBet
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custinfo_HideColossusBet
GO


--DROP COLUMN
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableColossusBet
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_HideColossusBet
GO