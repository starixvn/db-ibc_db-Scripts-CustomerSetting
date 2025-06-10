/*<info serverAlias="DBLIC-bodb_Licensee,DBBOF-bodb_Licensee"></info>*/
/*
	Created: 20250520@Tacy
	Task: Drop unused SPs [#RedmineID:#227673]
	DB: DBLIC-bodb_Licensee,DBBOF-bodb_Licensee
*/
USE bodb_Licensee
GO

DROP PROCEDURE IF EXISTS	Lrf_LicenseeMatchMonitoring_Check
GO

DROP PROCEDURE IF EXISTS	Lrf_LicenseeMatchMonitoring_Ins
GO

DROP PROCEDURE IF EXISTS    Lrf_LicenseeMatchMonitoring_Upd
GO

DROP PROCEDURE IF EXISTS    Lrf_LicenseeMatchMonitoringSetting_Check
GO

DROP PROCEDURE IF EXISTS    Lrf_LicenseeMatchMonitoringSetting_Ins
GO

DROP PROCEDURE IF EXISTS    Lrf_LicenseeMatchMonitoringSetting_Upd
GO

DROP PROCEDURE IF EXISTS    Lrf_LicenseeMatchMonitoringSetting_Del
GO

IF @@SERVERNAME IN ('DB054','DB055')
BEGIN
	USE bodb_CustomerLog

	DROP PROCEDURE IF EXISTS    Lrf_UserLog_LicenseeSetting_Sel
END
GO