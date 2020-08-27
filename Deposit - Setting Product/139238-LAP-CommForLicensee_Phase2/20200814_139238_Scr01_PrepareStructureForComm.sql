/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/bodb_Licensee
*/
--Add new columns into LicenseeCustComm & LicenseeGroupComm
--deploy @DBCust/bodb_Licensee
USE bodb_licensee
GO
ALTER TABLE dbo.LicenseeCustComm ADD SexyGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD SpadeGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD KenoComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD LotteryComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD VSComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD VS2Comm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD TableGameComm DECIMAL(9,8)
-- will offer after phase 2.1
ALTER TABLE dbo.LicenseeCustComm ADD CardClubComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD SabaclubComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeCustComm ADD VirtualGamesComm DECIMAL(9,8)

GO
ALTER TABLE dbo.LicenseeGroupComm ADD SexyGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD SpadeGamingComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD KenoComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD LotteryComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD VSComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD VS2Comm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD TableGameComm DECIMAL(9,8)
-- will offer after phase 2.1
ALTER TABLE dbo.LicenseeGroupComm ADD CardClubComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD SabaclubComm DECIMAL(9,8)
ALTER TABLE dbo.LicenseeGroupComm ADD VirtualGamesComm DECIMAL(9,8)

GO
--add constraint default value for new columns
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_SexyGamingComm]  DEFAULT ((0)) FOR [SexyGamingComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_SpadeGamingComm]  DEFAULT ((0)) FOR [SpadeGamingComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_KenoComm]  DEFAULT ((0)) FOR [KenoComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_LotteryComm]  DEFAULT ((0)) FOR [LotteryComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_VSComm]  DEFAULT ((0)) FOR [VSComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_VS2Comm]  DEFAULT ((0)) FOR [VS2Comm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_TableGameComm]  DEFAULT ((0)) FOR [TableGameComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_CardClubComm]  DEFAULT ((0)) FOR [CardClubComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_SabaclubComm]  DEFAULT ((0)) FOR [SabaclubComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_VirtualGamesComm]  DEFAULT ((0)) FOR [VirtualGamesComm]

GO
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_SexyGamingComm]  DEFAULT ((0)) FOR [SexyGamingComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_SpadeGamingComm]  DEFAULT ((0)) FOR [SpadeGamingComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_KenoComm]  DEFAULT ((0)) FOR [KenoComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_LotteryComm]  DEFAULT ((0)) FOR [LotteryComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_VSComm]  DEFAULT ((0)) FOR [VSComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_VS2Comm]  DEFAULT ((0)) FOR [VS2Comm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_TableGameComm]  DEFAULT ((0)) FOR [TableGameComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_CardClubComm]  DEFAULT ((0)) FOR [CardClubComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_SabaclubComm]  DEFAULT ((0)) FOR [SabaclubComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_VirtualGamesComm]  DEFAULT ((0)) FOR [VirtualGamesComm]

