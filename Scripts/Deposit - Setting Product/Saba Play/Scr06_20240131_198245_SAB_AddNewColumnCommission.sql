/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240131@Tacy
	Task: Database structure for Saba Play commission for LAP [redmine: #198245]
	DB: DBSPARE/bodb_Licensee,DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO

ALTER TABLE LicenseeCustComm ADD SABComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_SABComm] DEFAULT ((0)) FOR [SABComm]
GO

ALTER TABLE LicenseeGroupComm ADD SABComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_SABComm] DEFAULT ((0)) FOR [SABComm]
GO