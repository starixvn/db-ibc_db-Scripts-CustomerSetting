/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Create ACCOUNT & GRANT PERMISSION [vnPioneers]  [223896]  
	DB: DBCUST/AgencyCashService
*/

USE AgencyCashService

CREATE LOGIN [vnPioneers] WITH PASSWORD = '';
GO
CREATE USER [vnPioneers] FOR LOGIN [vnPioneers] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT CONNECT TO [vnPioneers]
GO
GRANT UNMASK TO [vnPioneers];
GO

-- Script: Check and get structure of all tables in CashService
-- CashPaymentProvider
IF OBJECT_ID('CashPaymentProvider', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProvider] TO [vnPioneers]
    PRINT '01. Granted permissions on CashPaymentProvider to vnPioneers'
END

-- CashPaymentMethod
IF OBJECT_ID('CashPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentMethod] TO [vnPioneers]
    PRINT '02. Granted permissions on CashPaymentMethod to vnPioneers'
END

-- CashPaymentProviderInfo
IF OBJECT_ID('CashPaymentProviderInfo', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProviderInfo] TO [vnPioneers]
    PRINT '03. Granted permissions on CashPaymentProviderInfo to vnPioneers'
END

-- CashAgentProviderConfig
IF OBJECT_ID('CashAgentProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentProviderConfig] TO [vnPioneers]
    PRINT '04. Granted permissions on CashAgentProviderConfig to vnPioneers'
END

-- CashProviderConfig
IF OBJECT_ID('CashProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashProviderConfig] TO [vnPioneers]
    PRINT '05. Granted permissions on CashProviderConfig to vnPioneers'
END

-- CashPaymentProviderAPIConfig
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProviderAPIConfig] TO [vnPioneers]
    PRINT '06. Granted permissions on CashPaymentProviderAPIConfig to vnPioneers'
END

-- CashAgentPaymentMethod
IF OBJECT_ID('CashAgentPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentPaymentMethod] TO [vnPioneers]
    PRINT '07. Granted permissions on CashAgentPaymentMethod to vnPioneers'
END

-- CashSiteConfig
IF OBJECT_ID('CashSiteConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashSiteConfig] TO [vnPioneers]
    PRINT '08. Granted permissions on CashSiteConfig to vnPioneers'
END

-- CashBankConfig
IF OBJECT_ID('CashBankConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashBankConfig] TO [vnPioneers]
    PRINT '09. Granted permissions on CashBankConfig to vnPioneers'
END

-- CashBankList
IF OBJECT_ID('CashBankList', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashBankList] TO [vnPioneers]
    PRINT '10. Granted permissions on CashBankList to vnPioneers'
END

-- CashAgentBankAccountLimit
IF OBJECT_ID('CashAgentBankAccountLimit', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentBankAccountLimit] TO [vnPioneers]
    PRINT '11. Granted permissions on CashAgentBankAccountLimit to vnPioneers'
END

-- CashAgentBankAccount
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentBankAccount] TO [vnPioneers]
    PRINT '12. Granted permissions on CashAgentBankAccount to vnPioneers'
END

-- CashMemberBankAccount
IF OBJECT_ID('CashMemberBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashMemberBankAccount] TO [vnPioneers]
    PRINT '13. Granted permissions on CashMemberBankAccount to vnPioneers'
END

-- CashAgentManagement
IF OBJECT_ID('CashAgentManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentManagement] TO [vnPioneers]
    PRINT '14. Granted permissions on CashAgentManagement to vnPioneers'
END

-- CashDomainManagement
IF OBJECT_ID('CashDomainManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashDomainManagement] TO [vnPioneers]
    PRINT '15. Granted permissions on CashDomainManagement to vnPioneers'
END


