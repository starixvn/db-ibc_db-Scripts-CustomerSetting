/*<info serverAlias="DBSPARE-bodb_Licensee,DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20230807@Tacy
	Task: Database structure for YeeBet, MG-RnG commission for LAP [redmine: #192203]
	DB: DBSPARE/bodb_Licensee,DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO

ALTER TABLE LicenseeCustComm ADD YeeBetComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_YeeBetComm] DEFAULT ((0)) FOR [YeeBetComm]
GO
ALTER TABLE LicenseeCustComm ADD MgRNGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_MgRNGComm] DEFAULT ((0)) FOR [MgRNGComm]
GO

ALTER TABLE LicenseeGroupComm ADD YeeBetComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_YeeBetComm] DEFAULT ((0)) FOR [YeeBetComm]
GO
ALTER TABLE LicenseeGroupComm ADD MgRNGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_MgRNGComm] DEFAULT ((0)) FOR [MgRNGComm]
GO