/*
	Created: Max
	Date: 20200511
	Task: structure when offer Fishing World comm for licensees
	DB: DBCUST/bodb_Licensee
*/

--Add new columns into LicenseeCustComm & LicenseeGroupComm
--deploy @DBCust/bodb_Licensee
USE bodb_licensee
GO
ALTER TABLE dbo.LicenseeCustComm ADD FWComm DECIMAL(9,8) 

ALTER TABLE dbo.LicenseeGroupComm ADD FWComm DECIMAL(9,8) 
GO

--add constraint default value for new columns
ALTER TABLE LicenseeCustComm ADD  CONSTRAINT [DF_LicenseeCustComm_FWComm]  DEFAULT ((0)) FOR [FWComm]

ALTER TABLE LicenseeGroupComm ADD  CONSTRAINT [DF_LicenseeGroupComm_FWComm]  DEFAULT ((0)) FOR [FWComm]
GO
