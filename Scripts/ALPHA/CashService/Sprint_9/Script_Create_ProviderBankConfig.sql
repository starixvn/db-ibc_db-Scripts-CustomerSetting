/*<info serverAlias="DBCUST-AgencyCashService" executers="" viewers=""></info>*/
/*
      Task:         Create table to map ProviderID and BankID [#236430]
      DB:           DBCUST-AgencyCashService 
      Created:      20250822@Helios
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- Check and create CashProviderBankConfig table
IF OBJECT_ID('dbo.CashProviderBankConfig', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CashProviderBankConfig
    (
        ProviderID      SMALLINT    NOT NULL,
        BankID          INT         NOT NULL,
        IsActive        BIT         NOT NULL,
        RepUpdateTime   DATETIME2   NULL
    ) ON [CashService];

    ALTER TABLE dbo.CashProviderBankConfig ADD CONSTRAINT DF_CashProviderBankConfig_IsActive DEFAULT (1) FOR [IsActive];
    ALTER TABLE dbo.CashProviderBankConfig ADD CONSTRAINT DF_CashProviderBankConfig_RepUpdateTime DEFAULT (SYSDATETIME()) FOR [RepUpdateTime];
    ALTER TABLE dbo.CashProviderBankConfig ADD CONSTRAINT PK_CashProviderBankConfig PRIMARY KEY CLUSTERED (ProviderID ASC, BankID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];

    CREATE NONCLUSTERED INDEX IX_CashProviderBankConfig_RepUpdateTime
        ON dbo.CashProviderBankConfig (RepUpdateTime);
END;
