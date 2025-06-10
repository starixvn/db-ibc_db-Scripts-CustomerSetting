/*<info serverAlias="DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee"></info>*/
/*
	Created: 20250604@Tacy
	Task: Cleanup data - new tables for LAP - Match Monitoring Center [#RedmineID:#227673]
	DB: DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee

	Tables:
		LicenseeMatchMonitoring
		LicenseeMatchMonitoringSetting
		LicenseeMatchMonitoringSetting_Detail
*/
USE bodb_Licensee
GO

DELETE FROM LicenseeMatchMonitoring WITH (ROWLOCK)
GO

DELETE FROM LicenseeMatchMonitoringSetting WITH (ROWLOCK)
GO

DELETE FROM LicenseeMatchMonitoringSetting_Detail WITH (ROWLOCK)
GO