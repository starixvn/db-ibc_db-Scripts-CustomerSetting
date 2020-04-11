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

--Add new table LicenseeCustComm_History
ALTER DATABASE bodb_Licensee  
ADD FILEGROUP LicenseeCustComm_History_table  
GO  

ALTER DATABASE bodb_Licensee   
ADD FILE   
(  
    NAME = LicenseeCustComm_History_table_01,  
    FILENAME = 'D:\DB233\IBC_DB\bodb_Licensee\LicenseeCustComm_History_table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
) TO FILEGROUP LicenseeCustComm_History_table
GO


CREATE TABLE [dbo].[LicenseeCustComm_History](	
	CustID INT NOT NULL,
	UpdatedTime DATETIME NOT NULL,
	ProductID INT NOT NULL,
	Comm DECIMAL(9,8) NULL
) ON [LicenseeCustComm_History_table]
GO
 
CREATE CLUSTERED INDEX [CIX_LicenseeCustComm_History] ON [dbo].[LicenseeCustComm_History] 
(
	[UpdatedTime] DESC,
	[CustId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [LicenseeCustComm_History_table]
GO

ALTER TABLE [dbo].[LicenseeCustComm_History] ADD  CONSTRAINT [DF_LicenseeCustComm_History_UpdatedTime]  DEFAULT (getdate()) FOR [UpdatedTime]
GO
