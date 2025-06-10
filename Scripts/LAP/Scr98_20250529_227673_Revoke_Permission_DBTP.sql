/*<info serverAlias="DBACC-bodb_Licensee,DBTP-bodb_Licensee"></info>*/
/*
	Created: 20250529@Tacy
	Task: Revoke SELECT permission (Redmine: #227673)
	DB: DBACC-bodb_Licensee,DBTP-bodb_Licensee
*/
USE bodb_Licensee
GO

REVOKE SELECT ON dbo.LicenseeMatchMonitoring FROM [wsv_lap];
REVOKE SELECT ON dbo.LicenseeMatchMonitoringRule FROM [wsv_lap];
REVOKE SELECT ON dbo.LicenseeMatchMonitoringSetting FROM [wsv_lap];
REVOKE SELECT ON dbo.LicenseeMatchMonitoringSetting_Detail FROM [wsv_lap];