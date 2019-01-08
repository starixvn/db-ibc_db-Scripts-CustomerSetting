/*
	Created by: Elodie
	Date: 20181212
	Task: Insert LogAction for new credit site
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT	1213, 'Set Credit when Super''s created', 'CS_CustomerIns_Com', 0, NULL UNION ALL
SELECT	1214, 'Set Credit when Master''s created', 'CS_CustomerIns_SAg', 0, NULL UNION ALL
SELECT	1215, 'Set Credit when Agent''s created', 'CS_CustomerIns_MAg', 0, NULL UNION ALL
SELECT	1216, 'Set Credit when Member''s created', 'CS_CustomerIns_Ag', 0, NULL UNION ALL

SELECT	100000, 'Add Position Taking for super', 'CS_CustomerIns_Com', 0, 1 UNION ALL
SELECT	100001, 'Add Position Taking for master', 'CS_CustomerIns_SAg', 0, 1 UNION ALL
SELECT	100002, 'Add Position Taking for agent', 'CS_CustomerIns_MAg', 0, 1 UNION ALL
SELECT	100003, 'Update Position Taking for super', 'CS_CustSetting_PTSetting_Upd', 0, 1 UNION ALL
SELECT	100004, 'Update Position Taking for master', 'CS_CustSetting_PTSetting_Upd', 0, 1 UNION ALL
SELECT	100005, 'Update Position Taking for agent', 'CS_CustSetting_PTSetting_Upd', 0, 1 UNION ALL

SELECT	100200, 'Add Commission for super', 'CS_CustomerIns_Com', 0, 2 UNION ALL
SELECT	100201, 'Add Commission for master', 'CS_CustomerIns_SAg', 0, 2 UNION ALL
SELECT	100202, 'Add Commission for agent', 'CS_CustomerIns_MAg', 0, 2 UNION ALL
SELECT	100203, 'Add Commission for member', 'CS_CustomerIns_Ag', 0, 2 UNION ALL
SELECT	100204, 'Update Commission for super', 'CS_CustSetting_CommBetSetting_Upd', 0, 2 UNION ALL
SELECT	100205, 'Update Commission for master', 'CS_CustSetting_CommBetSetting_Upd', 0, 2 UNION ALL
SELECT	100206, 'Update Commission for agent', 'CS_CustSetting_CommBetSetting_Upd', 0, 2 UNION ALL
SELECT	100207, 'Update Commission for member', 'CS_CustSetting_CommBetSetting_Upd', 0, 2 UNION ALL

SELECT	100300, 'Add Bet Limit for super', 'CS_CustomerIns_Com', 0, 3 UNION ALL
SELECT	100301, 'Add Bet Limit for master', 'CS_CustomerIns_SAg', 0, 3 UNION ALL
SELECT	100302, 'Add Bet Limit for agent', 'CS_CustomerIns_MAg', 0, 3 UNION ALL
SELECT	100303, 'Add Bet Limit for member', 'CS_CustomerIns_Ag', 0, 3 UNION ALL
SELECT	100304, 'Update Bet Limit for super', 'CS_CustSetting_CommBetSetting_Upd', 0, 3 UNION ALL
SELECT	100305, 'Update Bet Limit for master', 'CS_CustSetting_CommBetSetting_Upd', 0, 3 UNION ALL
SELECT	100306, 'Update Bet Limit for agent', 'CS_CustSetting_CommBetSetting_Upd', 0, 3 UNION ALL
SELECT	100307, 'Update Bet Limit for member', 'CS_CustSetting_CommBetSetting_Upd', 0, 3 UNION ALL

SELECT	100400, 'Add general information for super', 'CS_CustomerIns_Com', 0, 4 UNION ALL
SELECT	100401, 'Add general information for master', 'CS_CustomerIns_SAg', 0, 4 UNION ALL
SELECT	100402, 'Add general information for agent', 'CS_CustomerIns_MAg', 0, 4 UNION ALL
SELECT	100403, 'Add general information for member', 'CS_CustomerIns_Ag', 0, 4 UNION ALL
SELECT	100404, 'Update general information for super', 'CS_CustSetting_GeneralInfo_Upd', 0, 4 UNION ALL
SELECT	100405, 'Update general information for master', 'CS_CustSetting_GeneralInfo_Upd', 0, 4 UNION ALL
SELECT	100406, 'Update general information for agent', 'CS_CustSetting_GeneralInfo_Upd', 0, 4 UNION ALL
SELECT	100407, 'Update general information for member', 'CS_CustSetting_GeneralInfo_Upd', 0, 4 UNION ALL

SELECT	100500, 'Create Account Status for super', 'CS_CustomerIns_Com', 0, 5 UNION ALL
SELECT	100501, 'Create Account Status for master', 'CS_CustomerIns_SAg', 0, 5 UNION ALL
SELECT	100502, 'Create Account Status for agent', 'CS_CustomerIns_MAg', 0, 5 UNION ALL
SELECT	100503, 'Create Account Status for member', 'CS_CustomerIns_Ag', 0, 5 UNION ALL
SELECT	100504, 'Edit Account Status', 'CS_CustSetting_GeneralInfo_Upd', 0, 5 


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--DELETE dbo.LogAction WHERE ActionID = 100003