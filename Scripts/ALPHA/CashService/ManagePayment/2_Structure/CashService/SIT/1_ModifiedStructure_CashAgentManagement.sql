/*<info serverAlias="DBCUST-AgencyCashService,DBTP-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios 
	Task: Alpha - Agency Cash Service - SIT - Modified Structure [223896]  
	DB: DBCUST/AgencyCashService
*/

IF OBJECT_ID('CashAgentManagement', 'U') IS NOT NULL DROP TABLE CashAgentManagement;

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
	  StartTime			 DATETIME	     NULL,
	  TrialEndTime		 DATETIME	     NULL,
        RepUpdateTime          DATETIME2(7)    NULL             
    ) ON [CashService];

    ALTER TABLE CashAgentManagement ADD CONSTRAINT [DF_CashAgentManagement_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
    ALTER TABLE CashAgentManagement ADD CONSTRAINT [PK_CashAgentManagement] PRIMARY KEY CLUSTERED (AgentId ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService];
END;


