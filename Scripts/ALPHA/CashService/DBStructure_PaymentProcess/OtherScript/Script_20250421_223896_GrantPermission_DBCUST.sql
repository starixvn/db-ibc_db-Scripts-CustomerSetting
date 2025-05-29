/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250527@Eden
	Task: Grant permission [#223896]  
	DB: DBCUST-AgencyCashService
*/
USE AgencyCashService
GO
GRANT SELECT ON dbo.CashAgentBankAccountLimit TO wsv_CashService;
GRANT SELECT ON dbo.CashAgentBankAccountLimit TO asv_CashService;
GRANT SELECT ON dbo.CashPaymentProviderInfo TO wsv_CashService;
GRANT SELECT ON dbo.CashPaymentProviderInfo TO asv_CashService;