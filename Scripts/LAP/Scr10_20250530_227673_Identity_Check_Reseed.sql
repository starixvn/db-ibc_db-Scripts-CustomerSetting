/*<info serverAlias="DBLIC-bodb_Licensee,DBBOF-bodb_Licensee"></info>*/
/*
	Created: 20250530@Tacy
	Task: Check CurrentIdentity value and reseed [#RedmineID:#227673]
	DB: DBLIC-bodb_Licensee,DBBOF-bodb_Licensee

	Tables:
		LicenseeMatchMonitoring
		LicenseeMatchMonitoringSetting
*/
USE bodb_Licensee
GO

/*
*** Please help run this query on DBCUST-bodb_Licensee:

	SELECT IDENT_CURRENT('LicenseeMatchMonitoring') AS MonitoringID;
	SELECT IDENT_CURRENT('LicenseeMatchMonitoringSetting') AS SettingID;

*/

DECLARE @MonitoringID	INT = xxx	-- SELECT IDENT_CURRENT('LicenseeMatchMonitoring') 
		, @SettingID	INT = yyy	-- SELECT IDENT_CURRENT('LicenseeMatchMonitoringSetting') 

DBCC CHECKIDENT ('LicenseeMatchMonitoring', RESEED, @MonitoringID);

DBCC CHECKIDENT ('LicenseeMatchMonitoringSetting', RESEED, @SettingID);
