/*<info serverAlias="DBLIC-bodb_LicenseeReport"></info>*/
/*
	Created: 20250529@Tacy
	Task: Grant SELECT permission (Redmine: #227673)
	DB: DBLIC.bodb_LicenseeReport
*/
USE bodb_LicenseeReport
GO

--grant select permission
GRANT SELECT ON dbo.LicenseeMatchMonitoring_History TO [wsv_lap];
GO