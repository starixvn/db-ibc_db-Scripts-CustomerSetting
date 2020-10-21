/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			ProductSettingDetail_old
			CustPTSetting3rd_Agent_old
			CustPTSetting3rd_Member_old
			CustPTGroupSetting3rd_Member_old 
    DB: DBARCCUST/bodb_Customer
*/ 
USE bodb_Customer
GO

--DROP CONSTRAINT
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_SuperPT		
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_MasterPT	
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_AgentPT		
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_AutoSuperPT	
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_MinPT		
ALTER TABLE CustPTSetting3rd_Agent_old DROP CONSTRAINT DF_CustPTSetting3rd_Agent_old_MaxPT		

ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTSetting3rd_Member_old_SuperPT]		
ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTSetting3rd_Member_old_MasterPT]	
ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTSetting3rd_Member_old_AgentPT]		
ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTSetting3rd_Member_old_AutoMasterPT]	
ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTSetting3rd_Member_old_AutoSuperPT]

ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_SuperPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_MasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AgentPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AutoMasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AutoSuperPT]


GO
--ALTER COLUMN
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MinPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MaxPT SMALLMONEY NOT NULL

ALTER TABLE CustPTSetting3rd_Member_old ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member_old ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member_old ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member_old ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member_old ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	


ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	

			
GO
--Add default 
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_SuperPT			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_MasterPT		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_AgentPT			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_AutoSuperPT		DEFAULT (0) FOR AutoSuperPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_AutoMasterPT	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_MinPT			DEFAULT (0) FOR MinPT
ALTER TABLE CustPTSetting3rd_Agent_old ADD CONSTRAINT DF_CustPTSetting3rd_Agent_old_MaxPT			DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTSetting3rd_Member_old_SuperPT]			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTSetting3rd_Member_old_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTSetting3rd_Member_old_AgentPT]			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTSetting3rd_Member_old_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTSetting3rd_Member_old_AutoSuperPT]		DEFAULT (0) FOR AutoSuperPT

ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_SuperPT]		DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AgentPT]		DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_old_AutoSuperPT]	DEFAULT (0) FOR AutoSuperPT

