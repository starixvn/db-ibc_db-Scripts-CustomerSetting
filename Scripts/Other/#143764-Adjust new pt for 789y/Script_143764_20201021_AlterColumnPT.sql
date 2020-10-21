/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			ProductSettingDetail
			CustPTSetting3rd_Agent
			CustPTSetting3rd_Member
			CustPTGroupSetting3rd_Member 
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--DROP CONSTRAINT
ALTER TABLE ProductSettingDetail DROP CONSTRAINT DF_ProductSettingDetail_MaxPT

ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT	
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT		
ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT		

ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]		
ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]	
ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]		
ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	
ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]

ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]


GO
--ALTER COLUMN
ALTER TABLE ProductSettingDetail ALTER COLUMN MaxPT SMALLMONEY NULL

ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN MinPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent ALTER COLUMN MaxPT SMALLMONEY NOT NULL

ALTER TABLE CustPTSetting3rd_Member ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	


ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	

			
GO
--Add default 
ALTER TABLE ProductSettingDetail ADD CONSTRAINT DF_ProductSettingDetail_MaxPT DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT		DEFAULT (0) FOR AutoSuperPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT			DEFAULT (0) FOR MinPT
ALTER TABLE CustPTSetting3rd_Agent ADD CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT			DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTSetting3rd_Member ADD CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Member ADD CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Member ADD CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Member ADD CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Member ADD CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]		DEFAULT (0) FOR AutoSuperPT

ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]	DEFAULT (0) FOR AutoSuperPT

