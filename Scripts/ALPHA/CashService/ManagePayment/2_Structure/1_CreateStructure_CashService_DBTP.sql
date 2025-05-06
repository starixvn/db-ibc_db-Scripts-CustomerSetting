/*<info serverAlias="DBTP-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/AgencyCashService
*/

--*************************Payment Gateway*************************

-- Check and create CashPaymentProvider table
IF OBJECT_ID('CashPaymentProvider', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProvider (
        ProviderID             SMALLINT        IDENTITY (1,1),
        ProviderName           NVARCHAR(100)   NOT NULL,        -- U2Pay or another provider
        RepUpdateTime          DATETIME2(7)    NULL
    ) ON [CashService];

    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [DF_CashPaymentProvider_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentProvider ADD CONSTRAINT [PK_CashPaymentProvider] PRIMARY KEY CLUSTERED (ProviderID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;

-- Check and create CashPaymentMethod table
IF OBJECT_ID('CashPaymentMethod', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentMethod (
        PaymentMethodID         SMALLINT        IDENTITY(1,1),
        MethodName              NVARCHAR(100)   NOT NULL,		-- THAI QR, PromptPay, Bank Transfer
        RepUpdateTime		  DATETIME2(7)	NULL
    ) ON [CashService];

    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [DF_CashPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashPaymentMethod ADD CONSTRAINT [PK_CashPaymentMethod] PRIMARY KEY CLUSTERED (PaymentMethodID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]

ALTER TABLE CashPaymentProviderInfo ADD CONSTRAINT [DF_CashPaymentProviderInfo_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;

-- Check and create CashAgentProviderConfig table
IF OBJECT_ID('CashAgentProviderConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashAgentProviderConfig (
        AgentID		    INT			NOT NULL,
	  ProviderID          SMALLINT		NOT NULL,
	  ProviderStatus      BIT			NOT NULL,        -- Enabled, Disabled
	  ChannelContact	    NVARCHAR(500)		NULL,
        RepUpdateTime	    DATETIME2(7)		NULL,
     CONSTRAINT [PK_CashAgentProviderConfig] PRIMARY KEY CLUSTERED 
(
	[AgentID]		ASC,
	[ProviderID]	ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]

ALTER TABLE CashAgentProviderConfig ADD CONSTRAINT [DF_CashAgentProviderConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;


-- Check and create CashProviderConfig table
IF OBJECT_ID('CashProviderConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashProviderConfig (
        SiteID		    INT			NOT NULL,
	  ProviderID          SMALLINT		NOT NULL,
        RepUpdateTime	    DATETIME2(7)		NULL,
     CONSTRAINT [PK_CashProviderConfig] PRIMARY KEY CLUSTERED 
(
	[SiteID]		ASC,
	[ProviderID]	ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]

ALTER TABLE CashProviderConfig ADD CONSTRAINT [DF_CashProviderConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
END;



-- Check and create CashPaymentProviderAPIConfig table 
IF OBJECT_ID('CashPaymentProviderAPIConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashPaymentProviderAPIConfig (
	  AgentID			  INT			NOT NULL,
	  ProviderID		  SMALLINT		NOT NULL,
	  PaymentMethodID         SMALLINT        NOT NULL,
        TransactionType         TINYINT		NOT NULL,         -- Deposit, Withdrawal
	  APIConfig			  VARCHAR(500)	MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	  PaymentMethodStatus     TINYINT         NULL,			-- Processing, Completed, Fail, Under maintenance
        RepUpdateTime		  DATETIME2(7)	NULL,
     CONSTRAINT [PK_CashPaymentProviderAPIConfig] PRIMARY KEY CLUSTERED 
(
	[AgentID]			ASC,
	[ProviderID]		ASC,
	[PaymentMethodID]		ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]

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
	  TransactionType       TINYINT		NOT NULL,    -- Deposit, Withdrawal
        MinAmount               MONEY           NOT NULL,
        MaxAmount               MONEY           NOT NULL,
        PaymentMethodEnable     BIT             NOT NULL,	 -- Enabled, Disabled
        --RequiresBank            BIT             NOT NULL,	 -- Whether a bank is required: 0 = Not required
        RepUpdateTime           DATETIME2(7)    NULL,
 CONSTRAINT [PK_CashAgentPaymentMethod] PRIMARY KEY CLUSTERED 
(
    PaymentProviderID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]
   
CREATE NONCLUSTERED INDEX [IX_CashAgentPaymentMethod] ON CashAgentPaymentMethod 
(
    ProviderID		ASC,
    PaymentMethodID	ASC,
    AgentID			ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CashService];

--ALTER TABLE CashAgentPaymentMethod ADD CONSTRAINT [DF_CashAgentPaymentMethod_RequiresBank]  DEFAULT (0)			FOR [RequiresBank];
ALTER TABLE CashAgentPaymentMethod ADD CONSTRAINT [DF_CashAgentPaymentMethod_RepUpdateTime] DEFAULT (sysdatetime())	FOR [RepUpdateTime];
END;


--*************************Site - Bank Config*************************

-- Check and create CashSiteConfig table
IF OBJECT_ID('CashSiteConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashSiteConfig (
        SiteId                INT             NOT NULL,        -- PK, new table
        CountryCode           VARCHAR(3)      NOT NULL,        -- Country code
        RepUpdateTime         DATETIME2(7)    NULL             
    ) ON [CashService];

    ALTER TABLE CashSiteConfig ADD CONSTRAINT [DF_CashSiteConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashSiteConfig ADD CONSTRAINT [PK_CashSiteConfig] PRIMARY KEY CLUSTERED (SiteId ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;

-- Check and create CashBankConfig table
IF OBJECT_ID('CashBankConfig', 'U') IS NULL
BEGIN
    CREATE TABLE CashBankConfig (
        SiteId                INT             NOT NULL,        
        BankId                INT		    NOT NULL,       
        RepUpdateTime         DATETIME2(7)    NULL             
    ) ON [CashService];

    ALTER TABLE CashBankConfig ADD CONSTRAINT [DF_CashBankConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashBankConfig ADD CONSTRAINT [PK_CashBankConfig] PRIMARY KEY CLUSTERED (SiteId ASC , BankId ASC)   
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;

-- Check and create CashBankList table
IF OBJECT_ID('CashBankList', 'U') IS NULL
BEGIN
    CREATE TABLE CashBankList (
        BankID              INT                 IDENTITY(1,1),
	  BankCode		    VARCHAR(10)		NULL,
        BankName            NVARCHAR(255)       NOT NULL,
        TransTypeList       VARCHAR(10)         NOT NULL,
        DepositMode         VARCHAR(60)         NULL,
        RepUpdateTime       DATETIME2(7)        NULL
    ) ON [CashService];

    ALTER TABLE CashBankList ADD CONSTRAINT [DF_CashBankList_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashBankList ADD CONSTRAINT [PK_CashBankList] PRIMARY KEY CLUSTERED (BankID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
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
    ) ON [CashService];

    ALTER TABLE CashAgentBankAccountLimit ADD CONSTRAINT [DF_CashAgentBankAccountLimit_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashAgentBankAccountLimit ADD CONSTRAINT [PK_CashAgentBankAccountLimit] PRIMARY KEY CLUSTERED (AgentID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;


-- Check and create CashAgentBankAccount table
IF OBJECT_ID('CashAgentBankAccount', 'U') IS NULL  
BEGIN
    
CREATE TABLE [dbo].[CashAgentBankAccount](
    AgentBankAccountID    INT					    IDENTITY(1,1),
    BankID                INT                             NOT NULL,
    AgentID               INT                             NOT NULL,
    BankAccountStatus     BIT                             NOT NULL,
    AccountHolderName     NVARCHAR(255)                   MASKED WITH (FUNCTION = 'partial(0,"***",0)') NOT NULL,
    BankAccountNumber     VARCHAR(100)                    MASKED WITH (FUNCTION = 'partial(0,"***",4)') NOT NULL,
    AccountNickname       NVARCHAR(255)                   NULL,
    TransTypeList         VARCHAR(10)                     NOT NULL,
    DepositMatching	  SMALLINT                        NULL,
    PromptPayEnabled      BIT                             NOT NULL,
    PromptPayMobile       VARCHAR(50)                     MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
    IsActive		  BIT                             NOT NULL,
    CreateDate            DATETIME                        NOT NULL,
    CreateBy              INT					    NOT NULL,
    RepUpdateTime	        DATETIME2(7)			    NULL
 CONSTRAINT [PK_CashAgentBankAccount] PRIMARY KEY CLUSTERED 
(
    [AgentBankAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]

CREATE NONCLUSTERED INDEX [CIX_CashAgentBankAccount] ON [CashAgentBankAccount] ([AgentID] ASC , [BankID] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CashService];


ALTER TABLE [dbo].[CashAgentBankAccount] ADD  CONSTRAINT [DF_CashAgentBankAccount_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END;


-- Check and create CashMemberBankAccount table
IF OBJECT_ID('CashMemberBankAccount', 'U') IS NULL
BEGIN
    CREATE TABLE CashMemberBankAccount (
        BankAccountMemberID   INT             NOT NULL IDENTITY (1,1),		-- PK, identity
        CustId                INT             NOT NULL,				-- Cluster index
        BankId                INT             NULL,					-- Bank ID
        AccountNumber         VARCHAR(100)    MASKED WITH (FUNCTION = 'partial(0,"***",4)') NULL,					-- Encrypt value
        BankAccountAgentID    INT             NULL,					-- Bank account agent ID
        RepUpdateTime         DATETIME2(7)    NULL                    
    ) ON [CashService];

    ALTER TABLE CashMemberBankAccount ADD CONSTRAINT [DF_CashMemberBankAccount_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashMemberBankAccount ADD CONSTRAINT [PK_CashMemberBankAccount] PRIMARY KEY CLUSTERED (BankAccountMemberID ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
     
    CREATE NONCLUSTERED INDEX [CIX_CashMemberBankAccount] ON [CashMemberBankAccount] ([CustID] ASC , [BankId] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CashService];

    CREATE NONCLUSTERED INDEX [CIX_BankAccountAgentID] ON [CashMemberBankAccount] ([BankAccountAgentID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CashService];

END;




--*************************member site managed*************************

-- Check and create CashAgentManagement table
IF OBJECT_ID('CashAgentManagement', 'U') IS NULL
BEGIN
    CREATE TABLE CashAgentManagement (
        AgentId                INT             NOT NULL,        -- PK, new table
        SettingInfo            TINYINT         NOT NULL,        -- bit 1: Allow member to register, bit 2: Allow member to deposit
        Mobile                 VARCHAR(50)     MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,         
        Contact                NVARCHAR(200)   MASKED WITH (FUNCTION = 'partial(0,"***",0)') NOT NULL,        -- JSON structure, Encrypt value
        Announcement           NVARCHAR(500)   NULL,            
        DailyWithdrawalCount   SMALLINT        NOT NULL,        -- Daily withdrawal count
        RepUpdateTime          DATETIME2(7)    NULL             
    ) ON [CashService];

    ALTER TABLE CashAgentManagement ADD CONSTRAINT [DF_CashAgentManagement_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashAgentManagement ADD CONSTRAINT [PK_CashAgentManagement] PRIMARY KEY CLUSTERED (AgentId ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;

-- Check and create CashDomainManagement table
IF OBJECT_ID('CashDomainManagement', 'U') IS NULL
BEGIN
    CREATE TABLE CashDomainManagement (
        AgentId              INT             NOT NULL,        -- PK, new table
        DomainId             INT             NOT NULL,        -- Domain ID
        SubDomainPrefix      VARCHAR(50)     NOT NULL,        -- Subdomain prefix
        RepUpdateTime        DATETIME2(7)    NULL             
    ) ON [CashService];

    ALTER TABLE CashDomainManagement ADD CONSTRAINT [DF_CashDomainManagement_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashDomainManagement ADD CONSTRAINT [PK_CashDomainManagement] PRIMARY KEY CLUSTERED (AgentId ASC, DomainId ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;

/*

ALTER TABLE dbo.CashAgentPaymentMethod DROP CONSTRAINT PK_CashAgentPaymentMethod;
ALTER TABLE dbo.CashAgentPaymentMethod
ADD CONSTRAINT PK_CashAgentPaymentMethod 
PRIMARY KEY CLUSTERED (
    PaymentProviderID ASC
)
WITH (
    PAD_INDEX = OFF, 
    STATISTICS_NORECOMPUTE = OFF, 
    IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS = ON, 
    ALLOW_PAGE_LOCKS = ON, 
    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
) 
ON [CashService];


*/