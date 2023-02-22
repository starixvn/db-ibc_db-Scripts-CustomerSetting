/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/* 
	Created: 20220116@Elodie
	Task: Prepare for log status of Max Payout Per Match [#RM:179711]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 220039 AND 220045
DELETE FROM LogActionDetail WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 220039 AND 220045

DELETE 
FROM LogAction
WHERE ActionID BETWEEN 200000 AND 200010
	OR ActionID BETWEEN 220035 AND 220038 
	OR ActionID BETWEEN 240000 AND 240003

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 3, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionNameEN, SPName,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 4, 1, 220039,'Update Sportsbook Bet Setting for Super','Acc_CustomerUpd_BetSetting',N'更新超级总代理的体育博彩投注设置',N'更新超級總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับซุปเปอร์' UNION ALL
SELECT 4, 1, 220040,'Indirectly update Sportsbook Bet Setting for Super ','Acc_CustomerUpd_BetSetting',N'间接地更新超级总代理的体育博彩投注设置',N'間接地更新超級總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับซุปเปอร์' UNION ALL
SELECT 3, 1, 220041,'Update Sportsbook Bet Setting for Master','Acc_CustomerUpd_BetSetting',N'更新总代理的体育博彩投注设置',N'更新總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับมาสเตอร์' UNION ALL
SELECT 3, 1, 220042,'Indirectly update Sportsbook Bet Setting for Master','Acc_CustomerUpd_BetSetting',N'间接地更新总代理的体育博彩投注设置',N'間接地更新總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับมาสเตอร์' UNION ALL
SELECT 2, 1, 220043,'Update Sportsbook Bet Setting for Agent','Acc_CustomerUpd_BetSetting',N'更新代理的体育博彩投注设置',N'更新代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับเอเจ้น' UNION ALL
SELECT 2, 1, 220044,'Indirectly update Sportsbook Bet Setting for Agent','Acc_CustomerUpd_BetSetting',N'间接地更新代理的体育博彩投注设置',N'間接地更新代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับเอเจ้น' UNION ALL
SELECT 1, 1, 220045,'Update Sportsbook Bet Setting for Member','Acc_CustomerUpd_BetSetting',N'更新会员体的育博彩投注设置',N'更新會員的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับสมาชิก' 
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT CASE WHEN ActionID = 400 THEN 200000
			WHEN ActionID = 401 THEN 200001
			WHEN ActionID = 402 THEN 200002
			WHEN ActionID = 403 THEN 200003
			WHEN ActionID = 410 THEN 200004
			WHEN ActionID = 411 THEN 200005
			WHEN ActionID = 412 THEN 200006
			WHEN ActionID = 413 THEN 200007
			WHEN ActionID = 404 THEN 200008
			WHEN ActionID = 407 THEN 200009
			WHEN ActionID = 500 THEN 200010
			WHEN ActionID = 300 THEN 220035
			WHEN ActionID = 301 THEN 220036
			WHEN ActionID = 302 THEN 220037
			WHEN ActionID = 303 THEN 220038
			WHEN ActionID = 1100 THEN 240000
			WHEN ActionID = 1101 THEN 240001
			WHEN ActionID = 1102 THEN 240002
			WHEN ActionID = 1103 THEN 240003
			END,
	SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameEN,ActionNameTH,ActionNameEN,IsInternal,ActionNameVI
FROM LogAction t
WHERE ActionID BETWEEN 400 AND 403
	OR ActionID BETWEEN 410 AND 413 
	OR ActionID IN (404,407,500)
	OR ActionID BETWEEN 300 AND 303
	OR ActionID BETWEEN 1100 AND 1103

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 220039 AND 220045
SELECT * FROM LogActionDetail (NOLOCK) WHERE ActionID BETWEEN 220039 AND 220045

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID BETWEEN 400 AND 403
	OR ActionID BETWEEN 410 AND 413 
	OR ActionID IN (404,407,500)
	OR ActionID BETWEEN 300 AND 303
	OR ActionID BETWEEN 1100 AND 1103
	OR ActionID BETWEEN 200000 AND 200010
	OR ActionID BETWEEN 220035 AND 220038 
	OR ActionID BETWEEN 240000 AND 240003

