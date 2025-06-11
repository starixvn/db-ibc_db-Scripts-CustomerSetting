/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Init LogAction Cash Service status [223896]   
	DB: DBLOG-bodb_CustomerLog
*/

IF NOT EXISTS (SELECT TOP 1 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID = 70633)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI, ActionNameCN) VALUES
	(70633, 5, 'Age_CashService_CustServiceTypeUpdate', N'Update Cash Service status on Agent.', N'Update Cash Service status on Agent.', N'Update Cash Service status on Agent.', NULL, NULL, N'อัปเดตสถานะบริการเงินสดบนตัวแทน', NULL, NULL, 0, NULL, NULL)
END

IF EXISTS (SELECT TOP 1 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID = 75046)
BEGIN
	DELETE la FROM LogAction la WITH (ROWLOCK) WHERE la.ActionID = 75046
END

--SELECT * FROM LogAction WHERE ActionID IN (70633,75046)