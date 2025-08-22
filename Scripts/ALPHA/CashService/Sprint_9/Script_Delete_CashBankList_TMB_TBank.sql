/*<info serverAlias="DBCUST-AgencyCashService" executers="" viewers=""></info>*/
/*
      Task:         Delete CashBankList records with BankCode IN ('TMB','TBank') [#236430]
      DB:           DBCUST-AgencyCashService
      Created:      20250825@Helios
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- 1. Validation: Check if records exist 
IF NOT EXISTS (
    SELECT TOP 2 2
    FROM dbo.CashBankList WITH (NOLOCK)
    WHERE BankCode IN ('TMB','TBank')
)
BEGIN
    PRINT 'No records found in CashBankList with BankCode IN (''TMB'',''TBank'').';
    RETURN;
END;

-- 2. Delete records
DELETE FROM dbo.CashBankList WITH (ROWLOCK)
WHERE BankCode IN ('TMB','TBank');

-- 3. Output result
PRINT 'Deleted records in CashBankList with BankCode IN (''TMB'',''TBank'').';
