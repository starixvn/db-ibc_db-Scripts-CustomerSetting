/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Create ACCOUNT & GRANT PERMISSION [vnPioneers]  [223896]   
	DB: DBLOG-bodb_CustomerLog
*/

USE bodb_CustomerLog

CREATE LOGIN [vnPioneers] WITH PASSWORD = '';
GO
CREATE USER [vnPioneers] FOR LOGIN [vnPioneers] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT CONNECT TO [vnPioneers]
GO
GRANT UNMASK TO [vnPioneers];
GO

-- Cash_UserLog_RunSP
IF OBJECT_ID('Cash_UserLog_RunSP', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [Cash_UserLog_RunSP] TO [vnPioneers]
    PRINT '01. Granted permissions on Cash_UserLog_RunSP to vnPioneers'
END
