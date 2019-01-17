/*
	Created by: Elodie
	Date: 20181212
	Task: Insert LogAction for new credit site
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO
DECLARE @ProductID TINYINT = 1
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	1213, 'Set Credit when Super''s created', 'CS_CustomerIns_Com', 0, NULL, NULL UNION ALL
SELECT	1214, 'Set Credit when Master''s created', 'CS_CustomerIns_SAg', 0, NULL, NULL UNION ALL
SELECT	1215, 'Set Credit when Agent''s created', 'CS_CustomerIns_MAg', 0, NULL, NULL UNION ALL
SELECT	1216, 'Set Credit when Member''s created', 'CS_CustomerIns_Ag', 0, NULL, NULL UNION ALL

SELECT	119997, 'Add Position Taking for super', 'CS_CustomerIns_Com', 0, 1, NULL UNION ALL
SELECT	119998, 'Add Position Taking for master', 'CS_CustomerIns_SAg', 0, 1, NULL UNION ALL
SELECT	119999, 'Add Position Taking for agent', 'CS_CustomerIns_MAg', 0, 1, NULL UNION ALL
SELECT	100000, 'Update Position Taking for super', 'CS_CustSetting_PTSetting_Upd', 0, 1, 4 UNION ALL
SELECT	105000, 'Update Position Taking for master', 'CS_CustSetting_PTSetting_Upd', 0, 1, 3 UNION ALL
SELECT	110000, 'Update Position Taking for agent', 'CS_CustSetting_PTSetting_Upd', 0, 1, 2 UNION ALL

SELECT	139996, 'Add Commission for super', 'CS_CustomerIns_Com', 0, 2, NULL UNION ALL
SELECT	139997, 'Add Commission for master', 'CS_CustomerIns_SAg', 0, 2, NULL UNION ALL
SELECT	139998, 'Add Commission for agent', 'CS_CustomerIns_MAg', 0, 2, NULL UNION ALL
SELECT	139999, 'Add Commission for member', 'CS_CustomerIns_Ag', 0, 2, NULL UNION ALL
SELECT	120000, 'Update Commission for super', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 4 UNION ALL
SELECT	125000, 'Update Commission for master', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 3 UNION ALL
SELECT	130000, 'Update Commission for agent', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 2 UNION ALL
SELECT	135000, 'Update Commission for member', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 1 UNION ALL

SELECT	149996, 'Add Bet Limit for super', 'CS_CustomerIns_Com', 0, 3, NULL UNION ALL
SELECT	149997, 'Add Bet Limit for master', 'CS_CustomerIns_SAg', 0, 3, NULL UNION ALL
SELECT	149998, 'Add Bet Limit for agent', 'CS_CustomerIns_MAg', 0, 3, NULL UNION ALL
SELECT	149999, 'Add Bet Limit for member', 'CS_CustomerIns_Ag', 0, 3, NULL UNION ALL
SELECT	140000, 'Update Bet Limit for super', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 4 UNION ALL
SELECT	145000, 'Update Bet Limit for master', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 3 UNION ALL
SELECT	150000, 'Update Bet Limit for agent', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 2 UNION ALL
SELECT	155000, 'Update Bet Limit for member', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 1 UNION ALL

SELECT	160000, 'Add general information for super', 'CS_CustomerIns_Com', 0, 4, NULL UNION ALL
SELECT	160001, 'Add general information for master', 'CS_CustomerIns_SAg', 0, 4, NULL UNION ALL
SELECT	160002, 'Add general information for agent', 'CS_CustomerIns_MAg', 0, 4, NULL UNION ALL
SELECT	160003, 'Add general information for member', 'CS_CustomerIns_Ag', 0, 4, NULL UNION ALL
SELECT	160004, 'Update general information for super', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 4 UNION ALL
SELECT	160005, 'Update general information for master', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 3 UNION ALL
SELECT	160006, 'Update general information for agent', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 2 UNION ALL
SELECT	160007, 'Update general information for member', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 1 UNION ALL

SELECT	165000, 'Create Account Status for master', 'CS_CustomerIns_SAg', 0, 5, NULL UNION ALL
SELECT	165001, 'Create Account Status for agent', 'CS_CustomerIns_MAg', 0, 5, NULL UNION ALL
SELECT	165002, 'Create Account Status for member', 'CS_CustomerIns_Ag', 0, 5, NULL

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, @ProductID, Level
FROM @tmpAction
WHERE SPName IN ('CS_CustSetting_CommBetSetting_Upd', 'CS_CustSetting_PTSetting_Upd')

--DELETE dbo.LogAction WHERE ActionID >= 100000
--DELETE dbo.LogActionDetail WHERE ActionID >= 100000

--SELECT * FROM dbo.LogAction WHERE ActionID > 100000