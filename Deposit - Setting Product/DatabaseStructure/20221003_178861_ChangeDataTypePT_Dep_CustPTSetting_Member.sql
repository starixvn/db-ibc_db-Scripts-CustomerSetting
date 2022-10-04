/*
	Created: 20221004Elodie
	Task: Change PT Datatype
	
	DB: DBTP/bodb_CustHistory
	
	Dep_CustPTSetting_Agent: 0 ROWS ; Dep_CustPTSetting_Member: 15881 ROWS; Dep_CustPTGroupSetting_Member: 80553 ROWS
*/
USE bodb_CustHistory
GO

-- Step 1: Drop default constraints ---------
ALTER TABLE Dep_CustPTSetting_Member_history
DROP CONSTRAINT DF__Dep_CustP__Super__3493CFA7

ALTER TABLE Dep_CustPTSetting_Member_history
DROP CONSTRAINT DF__Dep_CustP__Maste__3587F3E0

ALTER TABLE Dep_CustPTSetting_Member_history
DROP CONSTRAINT DF__Dep_CustP__Agent__367C1819

GO
-- Step 2: change datatype ---------
ALTER TABLE Dep_CustPTSetting_Member_history
ALTER COLUMN SuperPT SMALLMONEY 

ALTER TABLE Dep_CustPTSetting_Member_history
ALTER COLUMN MasterPT SMALLMONEY 

ALTER TABLE Dep_CustPTSetting_Member_history
ALTER COLUMN AgentPT SMALLMONEY 

GO
-- Step 3: Add default constraints ---------
ALTER TABLE Dep_CustPTSetting_Member_history
ADD CONSTRAINT DF_Dep_CustPTSetting_Member_history_SuperPT DEFAULT 0 FOR SuperPT

ALTER TABLE Dep_CustPTSetting_Member_history
ADD CONSTRAINT DF_Dep_CustPTSetting_Member_history_MasterPT DEFAULT 0 FOR MasterPT

ALTER TABLE Dep_CustPTSetting_Member_history
ADD CONSTRAINT DF_Dep_CustPTSetting_Member_history_AgentPT DEFAULT 0 FOR AgentPT


