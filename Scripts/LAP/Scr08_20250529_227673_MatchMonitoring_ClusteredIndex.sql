/*<info serverAlias="DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee"></info>*/
/*
	Created: 20250529@Tacy
	Task: Alter Clustered Index [#RedmineID:#227673]
	DB: DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee

	Table:
		LicenseeMatchMonitoring
*/
USE bodb_Licensee
GO

ALTER TABLE LicenseeMatchMonitoring
DROP CONSTRAINT PK_LicenseeMatchMonitoring;


ALTER TABLE LicenseeMatchMonitoring
ADD CONSTRAINT PK_LicenseeMatchMonitoring 
PRIMARY KEY CLUSTERED (MonitoringID ASC);
