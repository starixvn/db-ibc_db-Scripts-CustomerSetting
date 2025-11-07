/*<info serverAlias="DBCUST-AgencyCashService" executers="" viewers=""></info>*/
/*
      Task:         initial data Bank support by Provider U2Pay [#236435]
      DB:           DBCUST-AgencyCashService
      Created:      20250826@Helios
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE 
    @ProviderID SMALLINT,
    @ErrMsg NVARCHAR(4000) = N'';

-- Get ProviderID for U2Pay
SELECT @ProviderID = ProviderID
FROM dbo.CashPaymentProvider WITH (NOLOCK)
WHERE ProviderName = N'U2Pay';

IF @ProviderID IS NULL
BEGIN
    SET @ErrMsg = N'Error: Provider U2Pay does not exist.';
    RAISERROR(@ErrMsg, 16, 1);
    RETURN;

END;

-- Step 2: Check existence of required BankCodes and collect BankIDs
DECLARE @BankCodeList TABLE (BankCode VARCHAR(10));
INSERT INTO @BankCodeList (BankCode)
VALUES ('UOB'),('TCRB'),('LHB'),('KNK'),('KKR'),('IBT'),('BOA'),('SCB'),('KTB'),('GSB'),('CIMBT'),('BBL'),('BAAC'),('BOC'),('CITI'),('GHB'),('SCBT'),('SMBC'),('TISCO'),('TTB');

-- Find missing BankCodes
IF EXISTS (
    SELECT 1
    FROM @BankCodeList b
    LEFT JOIN dbo.CashBankList c ON b.BankCode = c.BankCode
    WHERE c.BankCode IS NULL
)
BEGIN
    DECLARE @MissingCodes NVARCHAR(4000);
    SELECT @MissingCodes = STRING_AGG(b.BankCode, ', ')
    FROM @BankCodeList b
    LEFT JOIN dbo.CashBankList c ON b.BankCode = c.BankCode
    WHERE c.BankCode IS NULL;
    SET @ErrMsg = N'Error: The following BankCodes do not exist in CashBankList: ' + @MissingCodes;
    RAISERROR(@ErrMsg, 16, 1);
    RETURN;
END;

-- Collect BankIDs for valid BankCodes
DECLARE @BankIDList TABLE (BankID INT, BankCode VARCHAR(10));
INSERT INTO @BankIDList (BankID, BankCode)
SELECT c.BankID, c.BankCode
FROM dbo.CashBankList c WITH (NOLOCK)
INNER JOIN @BankCodeList b ON c.BankCode = b.BankCode;

-- Insert mapping for ProviderID (U2Pay) and collected BankIDs if not already exists
IF NOT EXISTS (
    SELECT 1
    FROM dbo.CashProviderBankConfig c WITH (NOLOCK)
    WHERE c.ProviderID = @ProviderID
)
BEGIN
    INSERT INTO dbo.CashProviderBankConfig
    (
        ProviderID,
        BankID,
        IsActive,
        RepUpdateTime
    )
    SELECT 
        @ProviderID              AS ProviderID,
        b.BankID                 AS BankID,
        1                        AS IsActive,
        [dbo].[f_GetDateTime2]() AS RepUpdateTime
    FROM @BankIDList b
END
