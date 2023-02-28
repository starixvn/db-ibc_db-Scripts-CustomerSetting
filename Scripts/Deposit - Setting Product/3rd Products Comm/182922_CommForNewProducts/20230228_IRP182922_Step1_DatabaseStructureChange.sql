/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20230228@Johnson
	Task: Database structure for Max Game, FGG, Jili commission for LAP [redmine: #182922]
	DB: DBCUST/bodb_Licensee
*/
USE bodb_Licensee
GO

ALTER TABLE LicenseeCustComm ADD MaxGameComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_MaxGameComm] DEFAULT ((0)) FOR [MaxGameComm]
GO
ALTER TABLE LicenseeCustComm ADD FGGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_FGGComm] DEFAULT ((0)) FOR [FGGComm]
GO
ALTER TABLE LicenseeCustComm ADD JiliComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_JiliComm] DEFAULT ((0)) FOR [JiliComm]
GO

ALTER TABLE LicenseeGroupComm ADD MaxGameComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_MaxGameComm] DEFAULT ((0)) FOR [MaxGameComm]
GO
ALTER TABLE LicenseeGroupComm ADD FGGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_FGGComm] DEFAULT ((0)) FOR [FGGComm]
GO
ALTER TABLE LicenseeGroupComm ADD JiliComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_JiliComm] DEFAULT ((0)) FOR [JiliComm]
GO