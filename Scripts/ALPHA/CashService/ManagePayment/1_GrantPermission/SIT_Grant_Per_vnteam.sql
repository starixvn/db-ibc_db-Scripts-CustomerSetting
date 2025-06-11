/*<info serverAlias="DBCUST-AgencyCashService,DBTP-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Grant Permission [223896]  
	DB: DBCUST/AgencyCashService , DBTP/AgencyCashService
*/

-- Script: Check and get structure of all tables in CashService
-- CashPaymentProvider
IF OBJECT_ID('CashPaymentProvider', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProvider] TO [vnteam]
    PRINT '01. Granted permissions on CashPaymentProvider to vnteam'
END

-- CashPaymentMethod
IF OBJECT_ID('CashPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentMethod] TO [vnteam]
    PRINT '02. Granted permissions on CashPaymentMethod to vnteam'
END

-- CashPaymentProviderInfo
IF OBJECT_ID('CashPaymentProviderInfo', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProviderInfo] TO [vnteam]
    PRINT '03. Granted permissions on CashPaymentProviderInfo to vnteam'
END

-- CashAgentProviderConfig
IF OBJECT_ID('CashAgentProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentProviderConfig] TO [vnteam]
    PRINT '04. Granted permissions on CashAgentProviderConfig to vnteam'
END

-- CashProviderConfig
IF OBJECT_ID('CashProviderConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashProviderConfig] TO [vnteam]
    PRINT '05. Granted permissions on CashProviderConfig to vnteam'
END

-- CashPaymentProviderAPIConfig
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashPaymentProviderAPIConfig] TO [vnteam]
    PRINT '06. Granted permissions on CashPaymentProviderAPIConfig to vnteam'
END

-- CashAgentPaymentMethod
IF OBJECT_ID('CashAgentPaymentMethod', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentPaymentMethod] TO [vnteam]
    PRINT '07. Granted permissions on CashAgentPaymentMethod to vnteam'
END

-- CashSiteConfig
IF OBJECT_ID('CashSiteConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashSiteConfig] TO [vnteam]
    PRINT '08. Granted permissions on CashSiteConfig to vnteam'
END

-- CashBankConfig
IF OBJECT_ID('CashBankConfig', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashBankConfig] TO [vnteam]
    PRINT '09. Granted permissions on CashBankConfig to vnteam'
END

-- CashBankList
IF OBJECT_ID('CashBankList', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashBankList] TO [vnteam]
    PRINT '10. Granted permissions on CashBankList to vnteam'
END

-- CashAgentBankAccountLimit
IF OBJECT_ID('CashAgentBankAccountLimit', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentBankAccountLimit] TO [vnteam]
    PRINT '11. Granted permissions on CashAgentBankAccountLimit to vnteam'
END

-- CashAgentBankAccount
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentBankAccount] TO [vnteam]
    PRINT '12. Granted permissions on CashAgentBankAccount to vnteam'
END

-- CashMemberBankAccount
IF OBJECT_ID('CashMemberBankAccount', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashMemberBankAccount] TO [vnteam]
    PRINT '13. Granted permissions on CashMemberBankAccount to vnteam'
END

-- CashAgentManagement
IF OBJECT_ID('CashAgentManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashAgentManagement] TO [vnteam]
    PRINT '14. Granted permissions on CashAgentManagement to vnteam'
END

-- CashDomainManagement
IF OBJECT_ID('CashDomainManagement', 'U') IS NOT NULL 
BEGIN
    GRANT SELECT ON [CashDomainManagement] TO [vnteam]
    PRINT '15. Granted permissions on CashDomainManagement to vnteam'
END