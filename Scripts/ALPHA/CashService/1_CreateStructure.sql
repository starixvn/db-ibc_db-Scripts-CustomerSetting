/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
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
        BankName				NVARCHAR(255)			NOT NULL,
	  TransactionTypeID		VARCHAR(50)				NOT NULL,
	  DepositMode			TINYINT				NULL,
        RepUpdateTime			DATETIME2(7)			NULL
    ) ON [DATA];

    ALTER TABLE CashBank ADD CONSTRAINT [DF_CashBank_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashBank ADD CONSTRAINT [PK_CashBank] PRIMARY KEY CLUSTERED (BankID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

IF OBJECT_ID('CashTransTypeControl', 'U') IS NULL
BEGIN
    CREATE TABLE CashTransTypeControl (
        TransactionTypeID		TINYINT         NOT NULL,
        TransTypeDesc			NVARCHAR(50)    NOT NULL,
        TransactionType			TINYINT         NULL,
        RepUpdateTime			DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashTransTypeControl ADD CONSTRAINT [DF_CashTransTypeControl_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashTransTypeControl ADD CONSTRAINT [PK_CashTransTypeControl] PRIMARY KEY CLUSTERED (TransactionTypeID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashProvider table
IF OBJECT_ID('CashProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashProvider (
        ProviderID          INT             IDENTITY (1,1),
        ProviderName        NVARCHAR(100)   NOT NULL,        -- U2Pay or another provider
        ProviderStatus      BIT             NOT NULL,        -- Enabled, Disabled 
        CreateBy            INT             NOT NULL,
        CreateDate          DATETIME        NOT NULL,
        RepUpdateTime	    DATETIME2(7)	  NULL
    ) ON [DATA];

    ALTER TABLE CashProvider ADD CONSTRAINT [DF_CashProvider_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashProvider ADD CONSTRAINT [PK_CashProvider] PRIMARY KEY CLUSTERED (ProviderID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];

    ---- Add index on AgentID
    --CREATE NONCLUSTERED INDEX [IX_CashProvider_AgentID] ON CashProvider (AgentID ASC)
    --WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];
END;


-- Check and create CashPaymentMethod table
IF OBJECT_ID('CashPaymentMethod', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentMethod (
        PaymentMethodID         INT             IDENTITY(1,1),
        MethodName              NVARCHAR(100)   NOT NULL,		-- THAI QR, PromptPay, Bank Transfer
        RepUpdateTime		  DATETIME2(7)	NULL
    ) ON [DATA];

    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [DF_CashPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [PK_CashPaymentMethod] PRIMARY KEY CLUSTERED (PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashProviderFee table
IF OBJECT_ID('CashProviderFee', 'U') IS NULL
BEGIN
    CREATE TABLE CashProviderFee (
        ProviderID          INT             NOT NULL,
        PaymentMethodID     INT             NOT NULL,
        TransactionType     TINYINT	        NOT NULL,
        FeeRate             DECIMAL(9,2)    NOT NULL,        -- Fee rate in percentage
        RepUpdateTime	    DATETIME2(7)	  NULL,
     CONSTRAINT [PK_CashProviderFee] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC,
	[PaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE CashProviderFee ADD CONSTRAINT [DF_CashProviderFee_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;



-- Check and create CashPaymentConfig table
IF OBJECT_ID('CashPaymentConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentConfig (
        ProviderID		  INT			NOT NULL,
	  PaymentMethodID         INT             NOT NULL,
	  AgentID			  INT			NOT NULL,
        TransactionType         TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  APIKey			  VARCHAR(100)	NULL,
	  MerchantID		  VARCHAR(100)	NULL,
	  AppSecret			  VARCHAR(100)	NULL,
	  PaymentMethodStatus     TINYINT         NULL,			-- Processing, Completed, Fail, Under maintenance
        RepUpdateTime		  DATETIME2(7)	NULL,
     CONSTRAINT [PK_CashPaymentConfig] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC,
	[PaymentMethodID] ASC,
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE CashPaymentConfig ADD CONSTRAINT [DF_CashPaymentConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END;


-- Check and create CashPaymentLimit table
IF OBJECT_ID('CashPaymentLimit', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentLimit (
	  ProviderID			INT			NOT NULL,
	  AgentID				INT			NOT NULL,
        TransactionType			TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  MinAmountTrans			MONEY			NULL,
	  MaxAmountTrans			MONEY			NULL,
        RepUpdateTime			DATETIME2(7)	NULL,
     CONSTRAINT [PK_CashPaymentLimit] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC,
	[AgentID] ASC,
	[TransactionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE CashPaymentLimit ADD CONSTRAINT [DF_CashPaymentLimit_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;


-- Check and create CashPaymentProvider table
IF OBJECT_ID('CashPaymentProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProvider (
        PaymentProviderID	  INT			NOT NULL IDENTITY (1,1),
	  ProviderID              INT             NOT NULL,
        PaymentMethodID         INT             NOT NULL,
	  AgentID			  INT			NOT NULL,
        MinAmount               MONEY           NOT NULL,
        MaxAmount               MONEY           NOT NULL,
        PaymentMethodEnable     BIT             NOT NULL,	 -- Enabled, Disabled
        RequiresBank            BIT             NOT NULL,	 -- Whether a bank is required: 0 = Not required
        RepUpdateTime           DATETIME2(7)    NULL,
 CONSTRAINT [PK_CashPaymentProvider] PRIMARY KEY CLUSTERED 
(
	PaymentProviderID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
   
CREATE NONCLUSTERED INDEX [IX_CashPaymentProvider] ON CashPaymentProvider 
(
	ProviderID		ASC,
	PaymentMethodID	ASC,
	AgentID		ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];

ALTER TABLE CashPaymentProvider ADD CONSTRAINT [DF_CashPaymentProvider_RequiresBank]  DEFAULT (0)			FOR [RequiresBank];
ALTER TABLE CashPaymentProvider ADD CONSTRAINT [DF_CashPaymentProvider_RepUpdateTime] DEFAULT (sysdatetime())	FOR [RepUpdateTime];
END;


-- Check and create CashAccountLimit table
IF OBJECT_ID('CashAccountLimit', 'U') IS NULL
BEGIN
    CREATE TABLE CashAccountLimit (
        AgentID                 INT				NOT NULL,
        MinPerDeposit           MONEY			NOT NULL,
        MaxPerDeposit           MONEY			NOT NULL,
        MinPerWithdrawal        MONEY			NOT NULL,
        MaxPerWithdrawal        MONEY			NOT NULL,
        DailyWithdrawalCount    INT				NOT NULL,
        RepUpdateTime		  DATETIME2(7)		NULL
    ) ON [DATA];

    ALTER TABLE CashAccountLimit ADD CONSTRAINT [DF_CashAccountLimit_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashAccountLimit ADD CONSTRAINT [PK_CashAccountLimit] PRIMARY KEY CLUSTERED (AgentID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;


-- Check and create CashBankAccountAgent table
IF OBJECT_ID('CashBankAccountAgent', 'U') IS NULL
BEGIN
    
CREATE TABLE [dbo].[CashBankAccountAgent](
	BankAccountAgentID    INT             IDENTITY(1,1)   NOT NULL,
	BankID                INT                             NOT NULL,
	AgentID               INT                             NOT NULL,
	BankAccountStatus     BIT                             NOT NULL,
	AccountHolderName     NVARCHAR(255)                   NOT NULL,
	BankAccountNumber     VARCHAR(50)                     NOT NULL,
	AccountNickname       NVARCHAR(255)                   NULL,
	TransactionTypeID     VARCHAR(50)                     NOT NULL,
	DepositMatching	    SMALLINT                        NULL,
	PromptPayEnabled      BIT                             NOT NULL,
	CountryCode		    VARCHAR(50)				NULL,
	PromptPayMobile       VARCHAR(50)                     NULL,
	CreateDate            DATETIME                        NOT NULL,
	CreateBy              INT                             NOT NULL,
	RepUpdateTime	    DATETIME2(7)				NULL
 CONSTRAINT [PK_CashBankAccountAgent] PRIMARY KEY CLUSTERED 
(
	[BankAccountAgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

CREATE NONCLUSTERED INDEX [CIX_CashBankAccountAgent] ON [CashBankAccountAgent] ([BankID] ASC , [AgentID] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];


ALTER TABLE [dbo].[CashBankAccountAgent] ADD  CONSTRAINT [DF_CashBankAccountAgent_DMM] DEFAULT (NULL) FOR [DepositMatching]

ALTER TABLE [dbo].[CashBankAccountAgent] ADD  CONSTRAINT [DF_CashBankAccountAgent_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]

END;