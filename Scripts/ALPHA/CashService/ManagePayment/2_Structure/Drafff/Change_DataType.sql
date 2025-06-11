/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/AgencyCashService
*/

ALTER TABLE dbo.CashBankConfig DROP CONSTRAINT PK_CashBankConfig;

ALTER TABLE dbo.CashBankConfig ALTER COLUMN BankId INT NOT NULL;

ALTER TABLE dbo.CashBankConfig 
ADD CONSTRAINT PK_CashBankConfig 
PRIMARY KEY CLUSTERED (SiteId ASC, BankId ASC)
WITH (
    PAD_INDEX = OFF, 
    STATISTICS_NORECOMPUTE = OFF, 
    IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS = ON, 
    ALLOW_PAGE_LOCKS = ON, 
    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
) 
ON [CashService];


ALTER TABLE dbo.CashAgentBankAccount
ALTER COLUMN AccountHolderName NVARCHAR(255) NOT NULL;

ALTER TABLE dbo.CashAgentBankAccount
ALTER COLUMN AccountHolderName 
    ADD MASKED WITH (FUNCTION = 'partial(0,"***",0)');