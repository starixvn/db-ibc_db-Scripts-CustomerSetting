/*<info serverAlias="DBBOF-bodb_Licensee"></info>*/
/*
	Created: 20250529@Tacy
	Task: Grant SELECT permission (Redmine: #227673)
	DB: DBBOF-bodb_Licensee
*/
USE bodb_Licensee
GO

--grant select permission
GRANT SELECT ON dbo.LicenseeCust TO [wsv_lap];
GO