/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20230714
	Task: Remove Primary Key on History table, add Cluster index [Redmine: #191243]   
	DB: DBTP-bodb_CustHistory
*/
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

