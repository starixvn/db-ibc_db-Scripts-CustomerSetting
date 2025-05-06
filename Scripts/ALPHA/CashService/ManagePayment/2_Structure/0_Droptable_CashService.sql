/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/AgencyCashService
*/

--*************************Payment Gateway*************************
IF OBJECT_ID('CashPaymentProvider', 'U') IS NOT NULL DROP TABLE CashPaymentProvider;
IF OBJECT_ID('CashPaymentMethod', 'U') IS NOT NULL DROP TABLE CashPaymentMethod;
IF OBJECT_ID('CashPaymentProviderInfo', 'U') IS NOT NULL DROP TABLE CashPaymentProviderInfo;
IF OBJECT_ID('CashAgentProviderConfig', 'U') IS NOT NULL DROP TABLE CashAgentProviderConfig;
IF OBJECT_ID('CashProviderConfig', 'U') IS NOT NULL DROP TABLE CashProviderConfig;
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NOT NULL DROP TABLE CashPaymentProviderAPIConfig;
IF OBJECT_ID('CashAgentPaymentMethod', 'U') IS NOT NULL DROP TABLE CashAgentPaymentMethod;
IF OBJECT_ID('CashSiteConfig', 'U') IS NOT NULL DROP TABLE CashSiteConfig;
IF OBJECT_ID('CashBankConfig', 'U') IS NOT NULL DROP TABLE CashBankConfig;
IF OBJECT_ID('CashBankList', 'U') IS NOT NULL DROP TABLE CashBankList;
IF OBJECT_ID('CashAgentBankAccountLimit', 'U') IS NOT NULL DROP TABLE CashAgentBankAccountLimit;
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NOT NULL DROP TABLE CashAgentBankAccount;
IF OBJECT_ID('CashMemberBankAccount', 'U') IS NOT NULL DROP TABLE CashMemberBankAccount;
IF OBJECT_ID('CashAgentManagement', 'U') IS NOT NULL DROP TABLE CashAgentManagement;
IF OBJECT_ID('CashDomainManagement', 'U') IS NOT NULL DROP TABLE CashDomainManagement;