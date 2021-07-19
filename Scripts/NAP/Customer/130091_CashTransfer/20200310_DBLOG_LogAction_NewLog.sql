USE bodb_CustomerLog
GO

/*
	Created: 20200310@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: Transfer Cash - Enhancement
		1. Update log action type from setting to status
		2. Insert new log action for master level
*/

UPDATE dbo.LogAction WITH (ROWLOCK)
SET ActionTypeID = 5
WHERE ActionID = 705

INSERT INTO dbo.LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT 706 AS ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,0 AS IsInternal,ActionNameVI,ActionNameCN
FROM dbo.LogAction WITH (NOLOCK)
WHERE ActionID = 705