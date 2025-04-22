/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/CustDB
*/

-- Check and create CashBank table
IF OBJECT_ID('CashBank', 'U') IS NULL
BEGIN
    CREATE TABLE CashBank (
        BankID				INT					IDENTITY(1,1),
        BankName				VARCHAR(255)			NOT NULL,
	  TransactionType			TINYINT				NULL    ,	-- flags: 0 = none, 1 = deposit, 2 = withdraw, 3 = both (NULL = unspecified)
	  TransactionMethod		TINYINT				NULL    ,	-- flags: 0 = none, 1 = automatic, 2 = manual, 3 = both (NULL = unspecified)
        RepUpdateTime			DATETIME2(7)			NULL
    ) ON [DATA];

    ALTER TABLE CashBank ADD CONSTRAINT [DF_CashBank_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashBank ADD CONSTRAINT [PK_CashBank] PRIMARY KEY CLUSTERED (BankID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashBankAccountAgent table
IF OBJECT_ID('CashBankAccountAgent', 'U') IS NULL
BEGIN
    
CREATE TABLE [dbo].[CashBankAccountAgent](
	[BankAccountAgentID] [int] IDENTITY(1,1) NOT NULL,
	[BankID] [int] NOT NULL,
	[AgentID] [int] NOT NULL,
	[BankAccountStatus] [bit] NOT NULL,
	[AccountHolderName] [nvarchar](255) NOT NULL,
	[BankAccountNumber] [varchar](50) NOT NULL,
	[AccountNickname] [varchar](255) NULL,
	[DepositType] [tinyint] NOT NULL,
	[DepositMatchingMode] [smallint] NULL,
	[WithdrawalType] [tinyint] NOT NULL,
	[PromptPayEnabled] [bit] NOT NULL,
	[PromptPayMobile] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CashBankAccountAgent] PRIMARY KEY CLUSTERED 
(
	[BankAccountAgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE [dbo].[CashBankAccountAgent] ADD  DEFAULT (NULL) FOR [DepositMatchingMode]

ALTER TABLE [dbo].[CashBankAccountAgent] ADD  CONSTRAINT [DF_CashBankAccountAgent_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END;

-- Check and create CashTransLimit table
IF OBJECT_ID('CashTransLimit', 'U') IS NULL
BEGIN
    CREATE TABLE CashTransLimit (
        AgentID                 INT         NOT NULL,
        MinPerDeposit           MONEY       NOT NULL,
        MaxPerDeposit           MONEY       NOT NULL,
        MinPerWithdrawal        MONEY       NOT NULL,
        MaxPerWithdrawal        MONEY       NOT NULL,
        DailyWithdrawalCount    INT         NOT NULL,
        RepUpdateTime           DATETIME2(7) NULL
    ) ON [DATA];

    ALTER TABLE CashTransLimit ADD CONSTRAINT [DF_CashTransLimit_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashTransLimit ADD CONSTRAINT [PK_CashTransLimit] PRIMARY KEY CLUSTERED (AgentID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

/* Provider >> Payment Method */

-- Check and create CashProvider table
IF OBJECT_ID('CashProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashProvider (
        ProviderID          INT             IDENTITY (1,1),
        AgentID             INT             NOT NULL,
        ProviderName        NVARCHAR(100)   NOT NULL,        -- U2Pay or another provider
        ProviderStatus      BIT             NOT NULL,        -- Enabled, Disabled
        CreateBy            INT             NOT NULL,
        CreateDate          DATETIME        NOT NULL,
        RepUpdateTime       DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashProvider ADD CONSTRAINT [DF_CashProvider_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashProvider ADD CONSTRAINT [PK_CashProvider] PRIMARY KEY CLUSTERED (ProviderID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];

    -- Add index on AgentID
    CREATE NONCLUSTERED INDEX [IX_CashProvider_AgentID] ON CashProvider (AgentID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];
END;

-- Check and create CashProviderFee table
IF OBJECT_ID('CashProviderFee', 'U') IS NULL
BEGIN
    CREATE TABLE CashProviderFee (
        ProviderID          INT             NOT NULL,
        PaymentMethodID     INT             NOT NULL,
        TransactionType     TINYINT	        NOT NULL,
        FeeRate             DECIMAL(9,2)    NOT NULL,        -- Fee rate in percentage
        RepUpdateTime       DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashProviderFee ADD CONSTRAINT [DF_CashProviderFee_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashProviderFee ADD CONSTRAINT [PK_CashProviderFee] PRIMARY KEY CLUSTERED (ProviderID ASC , PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashPaymentMethod table
IF OBJECT_ID('CashPaymentMethod', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentMethod (
        PaymentMethodID         INT             IDENTITY(1,1),
        MethodName              NVARCHAR(100)   NOT NULL,		-- THAI QR, PromptPay, Bank Transfer
	  TransactionType         TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  APIKey			  VARCHAR(100)	NULL,
	  MerchantID		  VARCHAR(100)	NULL,
	  AppSecret			  VARCHAR(100)	NULL,
	  PaymentMethodStatus     TINYINT         NULL,			-- Processing, Completed, Fail, Under maintenance
        RepUpdateTime           DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [DF_CashPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [PK_CashPaymentMethod] PRIMARY KEY CLUSTERED (PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashPaymentProvider table
IF OBJECT_ID('CashPaymentProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProvider (
        ProviderID              INT             NOT NULL,
        PaymentMethodID         INT             NOT NULL,
        MinAmount               MONEY           NOT NULL,
        MaxAmount               MONEY           NOT NULL,
        PaymentMethodEnable     BIT             NOT NULL,			 -- Enabled, Disabled
        RequiresBank            BIT             NOT NULL DEFAULT (0),	 -- Whether a bank is required: 0 = Not required
        RepUpdateTime           DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [DF_CashPaymentProvider_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [PK_CashPaymentProvider] PRIMARY KEY CLUSTERED (ProviderID ASC , PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashTransTypeControl table
IF OBJECT_ID('CashTransTypeControl', 'U') IS NULL
BEGIN
    CREATE TABLE CashTransTypeControl (
        TransactionType			  TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  MinAmountTrans			  MONEY		NULL,
	  MaxAmountTrans			  MONEY		NULL,
        RepUpdateTime			  DATETIME2(7)    NULL
    ) ON [DATA];
END;