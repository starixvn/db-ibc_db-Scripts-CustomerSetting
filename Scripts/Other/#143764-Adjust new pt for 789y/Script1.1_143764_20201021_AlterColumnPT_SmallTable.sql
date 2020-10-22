/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			ProductSettingDetail
			CustPTGroupSetting3rd_Member 
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
--DROP CONSTRAINT
ALTER TABLE ProductSettingDetail DROP CONSTRAINT DF_ProductSettingDetail_MaxPT

ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]
GO
--ALTER COLUMN
ALTER TABLE ProductSettingDetail ALTER COLUMN MaxPT SMALLMONEY NULL

ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL				
GO
--Add default 
ALTER TABLE ProductSettingDetail ADD CONSTRAINT DF_ProductSettingDetail_MaxPT DEFAULT (90) FOR MaxPT

ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTGroupSetting3rd_Member ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]	DEFAULT (0) FOR AutoSuperPT
GO

