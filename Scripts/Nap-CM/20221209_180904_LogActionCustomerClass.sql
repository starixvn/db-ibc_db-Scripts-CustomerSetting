/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20221209@Winfred
	Task: 20221209@Winfred:  Create table Build Customer Class Management [RedmineID: #180904]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31901, 'Update rule customer class', 'NAP_LM_CustomerClassRuleUpd', 1, NULL, NULL UNION ALL
SELECT	31902, 'Insert rule customer class', 'NAP_LM_CustomerClassRuleIns', 1, NULL, NULL UNION ALL
SELECT	31903, 'Insert policy customer class', 'NAP_LM_CustomerClassPolicyIns', 1, NULL, NULL UNION ALL
SELECT	31904, 'Update policy customer class', 'NAP_LM_CustomerClassPolicyUpd', 1, NULL, NULL UNION ALL
SELECT	31905, 'Insert / Update site policy customer class', 'NAP_LM_CustomerClassPolicySiteIns', 1, NULL, NULL UNION ALL
SELECT	31906, 'Enabled rule customer class', 'NAP_LM_CustomerClassRuleEnable', 1, NULL, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)