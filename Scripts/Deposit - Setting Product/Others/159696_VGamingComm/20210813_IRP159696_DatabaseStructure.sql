/*
	Created: 20210813@Johnson
	Task: Database structure for VGaming commission for LAP
	DB: DBLIC/bodb_Licensee
*/

USE bodb_Licensee
GO

ALTER TABLE LicenseeCustComm ADD VGamingComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeCustComm_VGamingComm] DEFAULT ((0)) FOR [VGamingComm]
GO


ALTER TABLE LicenseeGroupComm ADD VGamingComm DECIMAL(9,8) NULL, CONSTRAINT [DF_LicenseeGroupComm_VGamingComm] DEFAULT ((0)) FOR [VGamingComm]
GO