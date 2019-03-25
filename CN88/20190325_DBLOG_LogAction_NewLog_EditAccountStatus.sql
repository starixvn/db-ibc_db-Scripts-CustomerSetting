USE [bodb_CustomerLog]
GO

/*
	Created: 20190325@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: Add new Log Action: Edit Account Status
*/

INSERT INTO dbo.LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal)
	VALUES (165004, 5, 'Age_CS_Customer_Status_Upd', 'Edit Account Status', 0)
GO

UPDATE dbo.LogAction WITH (ROWLOCK, UPDLOCK)
SET ActionNameCH = ActionNameEN
	,ActionNameCS = ActionNameEN
	,ActionNameJP = ActionNameEN
	,ActionNameIT = ActionNameEN
	,ActionNameTH = ActionNameEN
	,ActionNameKO = ActionNameEN
	,ActionNameVI = ActionNameEN
WHERE ActionID = 165004