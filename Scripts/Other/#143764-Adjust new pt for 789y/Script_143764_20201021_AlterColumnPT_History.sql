/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			ProductSettingDetail_history
			CustPTSetting3rd_Agent_history
			CustPTSetting3rd_Member_history
			CustPTGroupSetting3rd_Member_history 
    DB: DBTP/bodb_CustHistory
*/ 
USE bodb_CustHistory
GO

--DROP CONSTRAINT
ALTER TABLE ProductSettingDetail_history DROP CONSTRAINT DF_ProductSettingDetail_history_MaxPT

ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_SuperPT		
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_MasterPT	
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_AgentPT		
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_AutoSuperPT	
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_MinPT		
ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_history_MaxPT		

ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_history_SuperPT]		
ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_history_MasterPT]	
ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_history_AgentPT]		
ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_history_AutoMasterPT]	
ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_history_AutoSuperPT]

ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_SuperPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_MasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AgentPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AutoMasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AutoSuperPT]


GO
--ALTER COLUMN
ALTER TABLE ProductSettingDetail_history ALTER COLUMN MaxPT SMALLMONEY NULL

ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN MinPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Agent_history ALTER COLUMN MaxPT SMALLMONEY NOT NULL

ALTER TABLE CustPTSetting3rd_Member_history ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member_history ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member_history ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTSetting3rd_Member_history ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTSetting3rd_Member_history ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	


ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	

			
GO
--Add default 
ALTER TABLE ProductSettingDetail_history ADD CONSTRAINT DF_ProductSettingDetail_history_MaxPT DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_SuperPT			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_MasterPT		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_AgentPT			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_AutoSuperPT		DEFAULT (0) FOR AutoSuperPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_AutoMasterPT	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_MinPT			DEFAULT (0) FOR MinPT
ALTER TABLE CustPTSetting3rd_Agent_history ADD CONSTRAINT DF_CustPTSetting3rd_Agent_history_MaxPT			DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTSetting3rd_Member_history_SuperPT]			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTSetting3rd_Member_history_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTSetting3rd_Member_history_AgentPT]			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTSetting3rd_Member_history_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTSetting3rd_Member_history_AutoSuperPT]		DEFAULT (0) FOR AutoSuperPT

ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_SuperPT]		DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AgentPT]		DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_AutoSuperPT]	DEFAULT (0) FOR AutoSuperPT

