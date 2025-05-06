/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Grant Permission [223896]  
	DB: DBCUST/AgencyCashService
*/

-- Script: Check and get structure of all tables in CashService

-- CashPaymentProvider
IF OBJECT_ID('CashPaymentProvider', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProvider] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProvider] TO [wsv_CashService]
    PRINT '01. Granted permissions on CashPaymentProvider to asv_CashService, wsv_CashService'
END

-- CashPaymentMethod
IF OBJECT_ID('CashPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentMethod] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentMethod] TO [wsv_CashService]
    PRINT '02. Granted permissions on CashPaymentMethod to asv_CashService, wsv_CashService'
END

-- CashPaymentProviderInfo
IF OBJECT_ID('CashPaymentProviderInfo', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProviderInfo] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProviderInfo] TO [wsv_CashService]
    PRINT '03. Granted permissions on CashPaymentProviderInfo to asv_CashService, wsv_CashService'
END

-- CashAgentProviderConfig
IF OBJECT_ID('CashAgentProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashAgentProviderConfig] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashAgentProviderConfig] TO [wsv_CashService]
    PRINT '04. Granted permissions on CashAgentProviderConfig to asv_CashService, wsv_CashService'
END

-- CashProviderConfig
IF OBJECT_ID('CashProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashProviderConfig] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashProviderConfig] TO [wsv_CashService]
    PRINT '05. Granted permissions on CashProviderConfig to asv_CashService, wsv_CashService'
END

-- CashPaymentProviderAPIConfig
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProviderAPIConfig] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashPaymentProviderAPIConfig] TO [wsv_CashService]
    PRINT '06. Granted permissions on CashPaymentProviderAPIConfig to asv_CashService, wsv_CashService'
END

-- CashAgentPaymentMethod
IF OBJECT_ID('CashAgentPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashAgentPaymentMethod] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashAgentPaymentMethod] TO [wsv_CashService]
    PRINT '07. Granted permissions on CashAgentPaymentMethod to asv_CashService, wsv_CashService'
END

-- CashSiteConfig
IF OBJECT_ID('CashSiteConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashSiteConfig] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashSiteConfig] TO [wsv_CashService]
    PRINT '08. Granted permissions on CashSiteConfig to asv_CashService, wsv_CashService'
END

-- CashBankConfig
IF OBJECT_ID('CashBankConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashBankConfig] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashBankConfig] TO [wsv_CashService]
    PRINT '09. Granted permissions on CashBankConfig to asv_CashService, wsv_CashService'
END

-- CashBankList
IF OBJECT_ID('CashBankList', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashBankList] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashBankList] TO [wsv_CashService]
    PRINT '10. Granted permissions on CashBankList to asv_CashService, wsv_CashService'
END

-- CashAgentBankAccountLimit
IF OBJECT_ID('CashAgentBankAccountLimit', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashAgentBankAccountLimit] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashAgentBankAccountLimit] TO [wsv_CashService]
    PRINT '11. Granted permissions on CashAgentBankAccountLimit to asv_CashService, wsv_CashService'
END

-- CashAgentBankAccount
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashAgentBankAccount] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashAgentBankAccount] TO [wsv_CashService]
    PRINT '12. Granted permissions on CashAgentBankAccount to asv_CashService, wsv_CashService'
END

-- CashMemberBankAccount
IF OBJECT_ID('CashMemberBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashMemberBankAccount] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashMemberBankAccount] TO [wsv_CashService]
    PRINT '13. Granted permissions on CashMemberBankAccount to asv_CashService, wsv_CashService'
END

-- CashAgentManagement
IF OBJECT_ID('CashAgentManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashAgentManagement] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashAgentManagement] TO [wsv_CashService]
    PRINT '14. Granted permissions on CashAgentManagement to asv_CashService, wsv_CashService'
END

-- CashDomainManagement
IF OBJECT_ID('CashDomainManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT, INSERT, UPDATE ON [CashDomainManagement] TO [asv_CashService]
    GRANT SELECT, INSERT, UPDATE ON [CashDomainManagement] TO [wsv_CashService]
    PRINT '15. Granted permissions on CashDomainManagement to asv_CashService, wsv_CashService'
END

-- Grant Mask - UnMask

GRANT UNMASK TO asv_CashService;
GRANT UNMASK TO wsv_CashService;