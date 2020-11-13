/*
	Created: Helen
	Date: 20201111
	Task: LAP - Offer commission to 3rd party products - Phase 3 - [Redmine: #145012]   
	DB: DBCUST/bodb_Licensee
*/
--Add new columns into LicenseeCustComm & LicenseeGroupComm
--deploy @DBCust/bodb_Licensee
USE bodb_licensee
GO
--VirtualGamesComm: exist
--SabaclubComm:exist
ALTER TABLE dbo.LicenseeCustComm ADD SAGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD PGSoftComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD ArcadiaGamingComm DECIMAL(9,8)

GO
ALTER TABLE dbo.LicenseeGroupComm ADD SAGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD PGSoftComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD ArcadiaGamingComm DECIMAL(9,8)

GO
--add constraint default value for new columns
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_SAGamingComm]  DEFAULT ((0)) FOR [SAGamingComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_PGSoftComm]  DEFAULT ((0)) FOR [PGSoftComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_ArcadiaGamingComm]  DEFAULT ((0)) FOR [ArcadiaGamingComm]
GO
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_SAGamingComm]  DEFAULT ((0)) FOR [SAGamingComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_PGSoftComm]  DEFAULT ((0)) FOR [PGSoftComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_ArcadiaGamingComm]  DEFAULT ((0)) FOR [ArcadiaGamingComm]

GO 
ALTER TABLE dbo.LicenseeCustComm
DROP CONSTRAINT DF_LicenseeCustComm_CardClubComm

ALTER TABLE LicenseeGroupComm
DROP CONSTRAINT DF_LicenseeGroupComm_CardClubComm

ALTER TABLE dbo.LicenseeCustComm
DROP COLUMN CardClubComm

ALTER TABLE LicenseeGroupComm
DROP COLUMN CardClubComm
