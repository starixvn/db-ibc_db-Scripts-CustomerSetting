/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			CustPTGroupSetting3rd_Member_history 
    DB: DBTP/bodb_CustHistory
*/ 
USE bodb_CustHistory
GO

--DROP CONSTRAINT
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	
ALTER TABLE CustPTGroupSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]

GO
--ALTER COLUMN
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN SuperPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN MasterPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AgentPT SMALLMONEY NOT NULL			
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AutoSuperPT SMALLMONEY NOT NULL		
ALTER TABLE CustPTGroupSetting3rd_Member_history ALTER COLUMN AutoMasterPT SMALLMONEY NOT NULL	

			
GO
--Add default 
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]			DEFAULT (0) FOR SuperPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]		DEFAULT (0) FOR MasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]			DEFAULT (0) FOR AgentPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	DEFAULT (0) FOR AutoMasterPT
ALTER TABLE CustPTGroupSetting3rd_Member_history ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]		DEFAULT (0) FOR AutoSuperPT

