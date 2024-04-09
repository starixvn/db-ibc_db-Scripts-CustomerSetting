/*<info serverAlias="DBHIS-bodb_CustHistory"></info>*/
/*	
	Created: 20221207@Tacy
	Task: Drop unused columns on Custinfo_History
	Redmine: https://nexdev.net/issues/179132
	DB: DBHIS-bodb_CustHistory
*/
USE bodb_CustHistory
GO 

--DROP CONSTRAINT
ALTER TABLE dbo.Custinfo_History DROP CONSTRAINT [DF_custinfo_history_DisableColossusBet]
GO
ALTER TABLE dbo.Custinfo_History DROP CONSTRAINT [DF_custinfo_history_HideColossusBet]
GO


--DROP COLUMN
ALTER TABLE dbo.Custinfo_History DROP COLUMN DEL_DisableColossusBet
GO
ALTER TABLE dbo.Custinfo_History DROP COLUMN DEL_HideColossusBet
GO