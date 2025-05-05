/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/CustDB
*/

--*************************Payment Gateway*************************

-- Check and create CashPaymentProvider table
IF OBJECT_ID('CashPaymentProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProvider (
        ProviderID             SMALLINT        IDENTITY (1,1),
        ProviderName           NVARCHAR(100)   NOT NULL,        -- U2Pay or another provider
        ProviderStatus         BIT             NOT NULL,        -- Enabled, Disabled 
        CreateBy               INT             NOT NULL,
        CreateDate             DATETIME        NOT NULL,
        RepUpdateTime          DATETIME2(7)    NULL
    ) ON [DATA];

    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [DF_CashPaymentProvider_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [PK_CashPaymentProvider] PRIMARY KEY CLUSTERED (ProviderID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashPaymentMethod table
IF OBJECT_ID('CashPaymentMethod', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentMethod (
        PaymentMethodID         SMALLINT        IDENTITY(1,1),
        MethodName              NVARCHAR(100)   NOT NULL,		-- THAI QR, PromptPay, Bank Transfer
        RepUpdateTime		  DATETIME2(7)	NULL
    ) ON [DATA];

    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [DF_CashPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [PK_CashPaymentMethod] PRIMARY KEY CLUSTERED (PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashPaymentProviderInfo table
IF OBJECT_ID('CashPaymentProviderInfo', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProviderInfo (
        ProviderID          SMALLINT         NOT NULL,
        PaymentMethodID     SMALLINT         NOT NULL,
        TransactionType     TINYINT	         NOT NULL,
        FeeRate             DECIMAL(9,2)     NOT NULL,        -- Fee rate in percentage
        MinAmountTrans      MONEY            NULL,
        MaxAmountTrans      MONEY            NULL,
        RepUpdateTime	    DATETIME2(7)	   NULL,
     CONSTRAINT [PK_CashPaymentProviderInfo] PRIMARY KEY CLUSTERED 
(
	[ProviderID]	ASC,
	[PaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE CashPaymentProviderInfo ADD CONSTRAINT [DF_CashPaymentProviderInfo_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;

-- Check and create CashPaymentProviderAPIConfig table
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProviderAPIConfig (
	  AgentID			  INT			NOT NULL,
	  ProviderID		  SMALLINT		NOT NULL,
	  PaymentMethodID         SMALLINT        NOT NULL,
        TransactionType         TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  APIKey			  VARCHAR(100)	NULL,
	  MerchantID		  VARCHAR(100)	NULL,
	  AppSecret			  VARCHAR(100)	NULL,
	  PaymentMethodStatus     TINYINT         NULL,			-- Processing, Completed, Fail, Under maintenance
        RepUpdateTime		  DATETIME2(7)	NULL,
     CONSTRAINT [PK_CashPaymentProviderAPIConfig] PRIMARY KEY CLUSTERED 
(
	[AgentID]			ASC,
	[ProviderID]		ASC,
	[PaymentMethodID]		ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

ALTER TABLE CashPaymentProviderAPIConfig ADD CONSTRAINT [DF_CashPaymentProviderAPIConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END;

-- Check and create CashAgentPaymentMethod table
IF OBJECT_ID('CashAgentPaymentMethod', 'U') IS NULL
BEGIN
    CREATE TABLE CashAgentPaymentMethod (
        PaymentProviderID	  INT       	IDENTITY (1,1),
        ProviderID              SMALLINT        NOT NULL,
        PaymentMethodID         SMALLINT        NOT NULL,
        AgentID			  INT			NOT NULL,
        MinAmount               MONEY           NOT NULL,
        MaxAmount               MONEY           NOT NULL,
        PaymentMethodEnable     BIT             NOT NULL,	 -- Enabled, Disabled
        RequiresBank            BIT             NOT NULL,	 -- Whether a bank is required: 0 = Not required
        RepUpdateTime           DATETIME2(7)    NULL,
 CONSTRAINT [PK_CashAgentPaymentMethod] PRIMARY KEY CLUSTERED 
(
    PaymentMethodID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
   
CREATE NONCLUSTERED INDEX [IX_CashAgentPaymentMethod] ON CashAgentPaymentMethod 
(
    ProviderID		ASC,
    PaymentMethodID	ASC,
    AgentID			ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];

ALTER TABLE CashAgentPaymentMethod ADD CONSTRAINT [DF_CashAgentPaymentMethod_RequiresBank]  DEFAULT (0)			FOR [RequiresBank];
ALTER TABLE CashAgentPaymentMethod ADD CONSTRAINT [DF_CashAgentPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime())	FOR [RepUpdateTime];



--*************************Payment Gateway*************************

-- Check and create CashBankList table
IF OBJECT_ID('CashBankList', 'U') IS NULL
BEGIN
    CREATE TABLE CashBankList (
        BankID              INT                 IDENTITY(1,1),
	  BankCode		    VARCHAR(10)		NOT NULL,
        BankName            NVARCHAR(255)       NOT NULL,
        TransTypeList       VARCHAR(10)         NOT NULL,
        DepositMode         VARCHAR(40)         NULL,
        Country             VARCHAR(3)          NULL,
        RepUpdateTime       DATETIME2(7)        NULL
    ) ON [DATA];

    ALTER TABLE CashBankList ADD CONSTRAINT [DF_CashBankList_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashBankList ADD CONSTRAINT [PK_CashBankList] PRIMARY KEY CLUSTERED (BankID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;

-- Check and create CashAgentBankAccountLimit table
IF OBJECT_ID('CashAgentBankAccountLimit', 'U') IS NULL
BEGIN
    CREATE TABLE CashAgentBankAccountLimit (
        AgentID                 INT				NOT NULL,
        MinPerDeposit           MONEY			NOT NULL,
        MaxPerDeposit           MONEY			NOT NULL,
        MinPerWithdrawal        MONEY			NOT NULL,
        MaxPerWithdrawal        MONEY			NOT NULL,
        RepUpdateTime		  DATETIME2(7)		NULL
    ) ON [DATA];

    ALTER TABLE CashAgentBankAccountLimit ADD CONSTRAINT [DF_CashAgentBankAccountLimit_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashAgentBankAccountLimit ADD CONSTRAINT [PK_CashAgentBankAccountLimit] PRIMARY KEY CLUSTERED (AgentID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA];
END;


-- Check and create CashAgentBankAccount table
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NULL  
BEGIN
    
CREATE TABLE [dbo].[CashAgentBankAccount](
    AgentBankAccountID    INT					    IDENTITY(1,1),
    BankID                INT                             NOT NULL,
    AgentID               INT                             NOT NULL,
    BankAccountStatus     BIT                             NOT NULL,
    AccountHolderName     VARCHAR(100)                    NOT NULL,
    BankAccountNumber     VARCHAR(100)                    NOT NULL,
    AccountNickname       NVARCHAR(255)                   NULL,
    TransTypeList         VARCHAR(10)                     NOT NULL,
    DepositMatching	  VARCHAR(40)                     NULL,
    PromptPayEnabled      BIT                             NOT NULL,
    PromptPayMobile       VARCHAR(50)                     NULL,
    CreateDate            DATETIME                        NOT NULL,
    CreateBy              INT                             NOT NULL,
    RepUpdateTime	        DATETIME2(7)			    NULL
 CONSTRAINT [PK_CashAgentBankAccount] PRIMARY KEY CLUSTERED 
(
    [AgentBankAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]

CREATE NONCLUSTERED INDEX [CIX_CashAgentBankAccount] ON [CashAgentBankAccount] ([BankID] ASC , [AgentID] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];


ALTER TABLE [dbo].[CashAgentBankAccount] ADD  CONSTRAINT [DF_CashAgentBankAccount_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END;
