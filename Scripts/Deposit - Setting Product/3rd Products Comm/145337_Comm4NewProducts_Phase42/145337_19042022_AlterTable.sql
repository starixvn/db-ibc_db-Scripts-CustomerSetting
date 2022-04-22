/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20220419@Winfred
	Task: Database structure for Creative Gaming, VS3 , AdvantPlay and AdvantPlay Mini  commission for LAP  [Redmine: #145337]  
	DB: DBCUST/bodb_Licensee
*/

USE bodb_Licensee
GO

ALTER TABLE LicenseeCustComm ADD CGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_CGComm] DEFAULT ((0)) FOR [CGComm]
ALTER TABLE LicenseeCustComm ADD AdvantComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_AdvantComm] DEFAULT ((0)) FOR [AdvantComm]
ALTER TABLE LicenseeCustComm ADD AdvantMiniComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_AdvantMiniComm] DEFAULT ((0)) FOR [AdvantMiniComm]
ALTER TABLE LicenseeCustComm ADD VS3Comm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_VS3Comm] DEFAULT ((0)) FOR [VS3Comm]
GO

ALTER TABLE LicenseeGroupComm ADD CGComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_CGComm] DEFAULT ((0)) FOR [CGComm]
ALTER TABLE LicenseeGroupComm ADD AdvantComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_AdvantComm] DEFAULT ((0)) FOR [AdvantComm]
ALTER TABLE LicenseeGroupComm ADD AdvantMiniComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_AdvantMiniComm] DEFAULT ((0)) FOR [AdvantMiniComm]
ALTER TABLE LicenseeGroupComm ADD VS3Comm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_VS3Comm] DEFAULT ((0)) FOR [VS3Comm]
GO