/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231204@Luke
	Task: NAP - Virtual rate - Enhance VR [Redmine: #194939]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Update ActionID: 840, 841, 842
DECLARE @Log AS TABLE(
	ActionID INT
	,ActionNameEN NVARCHAR(256)
	,SPName VARCHAR(50)
)

INSERT INTO @Log(ActionID, ActionNameEN, SPName)
SELECT 840, 'Update Virtual Rate Lock Status for downlines - Soccer', 'Acc_CustomerUpdVirtualMultiplier'
UNION ALL
SELECT 841, 'Update Virtual Rate Lock Status for downlines - Basketball', 'Acc_CustomerUpdVirtualMultiplier'
UNION ALL
SELECT 842, 'Update Virtual Rate Lock Status for downlines - Other Sports', 'Acc_CustomerUpdVirtualMultiplier'

UPDATE la
SET la.ActionNameEN = l.ActionNameEN
	,la.ActionNameCH = l.ActionNameEN
	,la.ActionNameCS = l.ActionNameEN
	,la.ActionNameJP = l.ActionNameEN
	,la.ActionNameIT = l.ActionNameEN
	,la.ActionnameTH = l.ActionNameEN
	,la.ActionNameKO = l.ActionNameEN
	,la.ActionNameVI = l.ActionNameEN
	,la.ActionNameCN = l.ActionNameEN
FROM LogAction la WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @Log l ON la.ActionID = l.ActionID
