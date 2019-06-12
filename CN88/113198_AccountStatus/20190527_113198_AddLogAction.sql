/*
	Created by: Elodie
	Date: 20190524
	Task: Insert LogAction for login process of CN88
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	165004, 'Update Account Status', 'CS_CustomerStatusUpd', 0, 5, NULL UNION ALL
SELECT	165003, 'Add account status for SMA', 'CS_CustomerIns_Com', 0, 5, NULL UNION ALL
SELECT	165005, 'Add account status for MA', 'CS_CustomerIns_SAg', 0, 5, NULL UNION ALL
SELECT	165006, 'Add account status for Agent', 'CS_CustomerIns_MAg', 0, 5, NULL UNION ALL
SELECT	165007, 'Add account status for Member', 'CS_CustomerIns_Ag', 0, 5, NULL UNION ALL
SELECT	941, 'Failed providing Security Code of Sub-Account', 'CS_CustomerUpdSecurityCodeStatus_Sub', 0, 4, NULL UNION ALL
SELECT	942, 'Sub account is locked due to failed security code validations', 'CS_CustomerUpdSecurityCodeStatus_Sub', 0, 4, NULL UNION ALL
SELECT	943, 'Failed providing Security Code of customer', 'CS_CustomerUpdSecurityCodeStatus', 0, 4, NULL UNION ALL
SELECT	944, 'Account is locked due to failed security code validations', 'CS_CustomerUpdSecurityCodeStatus', 0, 4, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
