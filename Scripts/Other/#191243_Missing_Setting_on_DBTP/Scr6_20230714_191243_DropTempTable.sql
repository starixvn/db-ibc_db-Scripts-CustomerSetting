/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20230714
	Task: Drop temp table [Redmine: #191243] 
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO
	
DROP TABLE CustBetSetting_Agent_History_Tmp
DROP TABLE CustBetSetting_Member_History_Tmp
DROP TABLE Dep_CustBetSettingGame_Agent_History_Tmp
DROP TABLE Dep_CustBetSettingGameGroup_Member_History_Tmp
DROP TABLE Dep_CustBetSettingGame_Member_History_Tmp