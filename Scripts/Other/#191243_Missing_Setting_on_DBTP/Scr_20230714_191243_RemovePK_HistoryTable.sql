/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20230714
	Task: Remove Primary Key on History table, add Cluster index [Redmine: #191243]   
	DB: DBTP-bodb02
*/
-----------------Disable Trigger--------------------
USE bodb02
GO
DISABLE TRIGGER Dep_CustBetSettingGame_Agent_update ON Dep_CustBetSettingGame_Agent  
GO  
DISABLE TRIGGER Dep_CustBetSettingGame_Member_update ON Dep_CustBetSettingGame_Member  
GO  
DISABLE TRIGGER Dep_CustBetSettingGameGroup_Member_update ON Dep_CustBetSettingGameGroup_Member  
GO  
DISABLE TRIGGER CustBetSetting_Member_Insert_update ON CustBetSetting_Member  
GO  
DISABLE TRIGGER CustBetSetting_Agent_Insert_update ON CustBetSetting_Agent  
GO  
DISABLE TRIGGER CustLimitPTSetting_update ON CustLimitPTSetting  
GO  
-----------------Remove PK, Add Cluster index for History table--------------------
USE bodb_CustHistory
GO
ALTER TABLE CustBetSetting_Agent_History DROP CONSTRAINT PK_CustBetSetting_Agent_History;   
GO
CREATE CLUSTERED INDEX IX_CustBetSetting_Agent_History ON CustBetSetting_Agent_History(UpdateTime ASC, CustID ASC)
GO

ALTER TABLE CustBetSetting_Member_History DROP CONSTRAINT PK_CustBetSetting_Member_History;   
GO  
CREATE CLUSTERED INDEX IX_CustBetSetting_Member_History ON CustBetSetting_Member_History(UpdateTime ASC, CustID ASC)
GO

ALTER TABLE Dep_CustBetSettingGame_Agent_History DROP CONSTRAINT PK_Dep_CustBetSettingGame_Agent_History;   
GO
CREATE CLUSTERED INDEX IX_Dep_CustBetSettingGame_Agent_History ON Dep_CustBetSettingGame_Agent_History(UpdateTime ASC, CustID ASC)
GO

ALTER TABLE Dep_CustBetSettingGame_Member_History DROP CONSTRAINT PK_Dep_CustBetSettingGame_Member_History;   
GO  
CREATE CLUSTERED INDEX IX_Dep_CustBetSettingGame_Member_History ON Dep_CustBetSettingGame_Member_History(UpdateTime ASC, CustID ASC)
GO

ALTER TABLE Dep_CustBetSettingGameGroup_Member_History DROP CONSTRAINT PK_Dep_CustBetSettingGameGroup_Member_History;   
GO  
CREATE CLUSTERED INDEX IX_Dep_CustBetSettingGameGroup_Member_History ON Dep_CustBetSettingGameGroup_Member_History(UpdateTime ASC, AgentID ASC)
GO

ALTER TABLE CustLimitPTSetting_History DROP CONSTRAINT PK_CustLimitPTSetting_History;   
GO 
CREATE CLUSTERED INDEX IX_CustLimitPTSetting_History ON CustLimitPTSetting_History(UpdateTime ASC, CustID ASC)
GO
-----------------Enable Trigger--------------------
USE bodb02
GO
ENABLE TRIGGER Dep_CustBetSettingGame_Agent_update ON Dep_CustBetSettingGame_Agent  
GO  
ENABLE TRIGGER Dep_CustBetSettingGame_Member_update ON Dep_CustBetSettingGame_Member  
GO  
ENABLE TRIGGER Dep_CustBetSettingGameGroup_Member_update ON Dep_CustBetSettingGameGroup_Member  
GO  
ENABLE TRIGGER CustBetSetting_Member_Insert_update ON CustBetSetting_Member  
GO  
ENABLE TRIGGER CustBetSetting_Agent_Insert_update ON CustBetSetting_Agent  
GO  
ENABLE TRIGGER CustLimitPTSetting_update ON CustLimitPTSetting  
GO  