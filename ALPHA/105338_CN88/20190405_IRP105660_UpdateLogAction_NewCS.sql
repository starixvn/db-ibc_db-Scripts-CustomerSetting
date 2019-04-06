/*
	Created by: Elodie
	Date: 20190405
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameCN NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionNameCN, SPName, IsInternal, ActionTypeId, Level)
SELECT	1213, N'创建超级代理时设定信用额度', 'CS_CustomerIns_Com', 0, NULL, NULL UNION ALL
SELECT	1214, N'创建总代理时设定信用额度', 'CS_CustomerIns_SAg', 0, NULL, NULL UNION ALL
SELECT	1215, N'创建代理商时设定信用额度', 'CS_CustomerIns_MAg', 0, NULL, NULL UNION ALL
SELECT	1216, N'创建会员时设定信用额度', 'CS_CustomerIns_Ag', 0, NULL, NULL UNION ALL

SELECT	119997, N'添加超级代理的占成数', 'CS_CustomerIns_Com', 0, 1, NULL UNION ALL
SELECT	119998, N'添加总代理的占成数', 'CS_CustomerIns_SAg', 0, 1, NULL UNION ALL
SELECT	119999, N'添加代理商的占成数', 'CS_CustomerIns_MAg', 0, 1, NULL UNION ALL
SELECT	100000, N'更新超级代理的占成数', 'CS_CustSetting_PTSetting_Upd', 0, 1, 4 UNION ALL
SELECT	105000, N'更新总代理的占成数', 'CS_CustSetting_PTSetting_Upd', 0, 1, 3 UNION ALL
SELECT	110000, N'更新代理商的占成数', 'CS_CustSetting_PTSetting_Upd', 0, 1, 2 UNION ALL

SELECT	139996, N'添加超级代理的退水值', 'CS_CustomerIns_Com', 0, 2, NULL UNION ALL
SELECT	139997, N'添加总代理的退水值', 'CS_CustomerIns_SAg', 0, 2, NULL UNION ALL
SELECT	139998, N'添加代理商的退水值', 'CS_CustomerIns_MAg', 0, 2, NULL UNION ALL
SELECT	139999, N'Add Commission for Member', 'CS_CustomerIns_Ag', 0, 2, NULL UNION ALL
SELECT	120000, N'更新超级代理的退水设定', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 4 UNION ALL
SELECT	125000, N'更新总代理的退水设定', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 3 UNION ALL
SELECT	130000, N'更新代理商的退水设定', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 2 UNION ALL
SELECT	135000, N'更新会员的退水设定', 'CS_CustSetting_CommBetSetting_Upd', 0, 2, 1 UNION ALL

SELECT	149996, N'添加超级代理的限额', 'CS_CustomerIns_Com', 0, 3, NULL UNION ALL
SELECT	149997, N'添加总代理的限额', 'CS_CustomerIns_SAg', 0, 3, NULL UNION ALL
SELECT	149998, N'添加代理商的限额', 'CS_CustomerIns_MAg', 0, 3, NULL UNION ALL
SELECT	149999, N'添加会员的限额', 'CS_CustomerIns_Ag', 0, 3, NULL UNION ALL
SELECT	140000, N'更新超级代理的限额', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 4 UNION ALL
SELECT	145000, N'更新总代理的限额', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 3 UNION ALL
SELECT	150000, N'更新代理商的限额', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 2 UNION ALL
SELECT	155000, N'更新会员的限额', 'CS_CustSetting_CommBetSetting_Upd', 0, 3, 1 UNION ALL

SELECT	160000, N'为超级代理添加一般信息', 'CS_CustomerIns_Com', 0, 4, NULL UNION ALL
SELECT	160001, N'为总代理添加一般信息', 'CS_CustomerIns_SAg', 0, 4, NULL UNION ALL
SELECT	160002, N'为代理商添加一般信息', 'CS_CustomerIns_MAg', 0, 4, NULL UNION ALL
SELECT	160003, N'为会员添加一般信息', 'CS_CustomerIns_Ag', 0, 4, NULL UNION ALL
SELECT	160004, N'更新超级代理的一般信息', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 4 UNION ALL
SELECT	160005, N'更新总代理商的一般信息', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 3 UNION ALL
SELECT	160006, N'更新代理商的一般信息', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 2 UNION ALL
SELECT	160007, N'更新会员的一般信息', 'CS_CustSetting_GeneralInfo_Upd', 0, 4, 1 UNION ALL
SELECT	160008, N'添加主要额外占成数组', 'CS_CustomerIns_Com', 1, 4, NULL UNION ALL

SELECT	165000, N'为总代理创建帐户状态', 'CS_CustomerIns_SAg', 0, 5, NULL UNION ALL
SELECT	165001, N'为代理商创建帐户状态', 'CS_CustomerIns_MAg', 0, 5, NULL UNION ALL
SELECT	165002, N'为会员创建帐户状态', 'CS_CustomerIns_Ag', 0, 5, NULL

UPDATE l
SET l.ActionNameCN = t.ActionNameCN
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
