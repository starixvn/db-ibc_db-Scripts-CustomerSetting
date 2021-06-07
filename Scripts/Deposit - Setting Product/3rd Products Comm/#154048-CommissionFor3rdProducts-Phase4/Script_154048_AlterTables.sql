/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: Eden@20210602
	Task: Add new columns into LicenseeCustComm & LicenseeGroupComm [Redmine: #154048]   
	DB: DBCUST/bodb_Licensee
*/

USE bodb_licensee
GO
--WMCasino,Big Gaming,Joker,GDG,Sports Lottery,Habanero
ALTER TABLE dbo.LicenseeCustComm ADD WMCasinoComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_WMCasinoComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeCustComm ADD BigGamingComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_BigGamingComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeCustComm ADD JokerComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_JokerComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeCustComm ADD GDGComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_GDGComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeCustComm ADD SportsLotteryComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_SportsLotteryComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeCustComm ADD HabaneroComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeCustComm_HabaneroComm]  DEFAULT ((0))

GO
ALTER TABLE dbo.LicenseeGroupComm ADD WMCasinoComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_WMCasinoComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeGroupComm ADD BigGamingComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_BigGamingComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeGroupComm ADD JokerComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_JokerComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeGroupComm ADD GDGComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_GDGComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeGroupComm ADD SportsLotteryComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_SportsLotteryComm]  DEFAULT ((0))
ALTER TABLE dbo.LicenseeGroupComm ADD HabaneroComm DECIMAL(9,8) NULL CONSTRAINT [DF_LicenseeGroupComm_HabaneroComm]  DEFAULT ((0))
GO 
