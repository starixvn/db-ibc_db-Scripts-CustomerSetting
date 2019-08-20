
/*
	Created: 20190820@Johnson
	DB: DBLOG.bodb_CustomerLog
	Task: Add new Log Action: move group customer cn88
*/

INSERT INTO dbo.LogAction (ActionID, ActionTypeID, SPName, ActionNameEN,ActionNameCH ,ActionNameCS,ActionNameIT,ActionNameTH,ActionNameKO,IsInternal)
	VALUES (160013, 4, 'CS_CustomerUserGroup_Upd', 'Change user group', 'Change user group', 'Change user group', 'Change user group', 'Change user group', 'Change user group', 0)
GO
