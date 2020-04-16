/*
	Created: Johnson
	Date: 20200411
	Task: structure when offer Allbet,Macau,PP,GD,AG comm for licensees
	DB: DBCUST/bodb_Licensee
*/

--Add new columns into LicenseeCustComm & LicenseeGroupComm
--deploy @DBCust/bodb_Licensee
USE bodb_licensee
GO
ALTER TABLE dbo.LicenseeCustComm ADD MacauComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeCustComm ADD PPComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeCustComm ADD GDComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeCustComm ADD AGComm DECIMAL(9,8) 

ALTER TABLE dbo.LicenseeGroupComm ADD MacauComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeGroupComm ADD PPComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeGroupComm ADD GDComm DECIMAL(9,8) 
ALTER TABLE dbo.LicenseeGroupComm ADD AGComm DECIMAL(9,8) 
GO

--add constraint default value for new columns
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_AllbetComm]  DEFAULT ((0)) FOR [AllbetComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_MacauComm]  DEFAULT ((0)) FOR [MacauComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_PPComm]  DEFAULT ((0)) FOR [PPComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_GDComm]  DEFAULT ((0)) FOR [GDComm]
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_AGComm]  DEFAULT ((0)) FOR [AGComm]

ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_AllbetComm]  DEFAULT ((0)) FOR [AllbetComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_MacauComm]  DEFAULT ((0)) FOR [MacauComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_PPComm]  DEFAULT ((0)) FOR [PPComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_GDComm]  DEFAULT ((0)) FOR [GDComm]
ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_AGComm]  DEFAULT ((0)) FOR [AGComm]
GO
