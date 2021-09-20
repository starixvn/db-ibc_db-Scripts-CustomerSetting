﻿/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/* 
	Created: 20210802@Eden
	Task: Prepare for log status of Max Payout Per Match [#RM:158073]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 220020 AND 220026
DELETE FROM LogActionDetail WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 220020 AND 220026
--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 3, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionNameEN, SPName,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 4, 1, 220020,'Update Sportsbook Bet Setting for Super','Acc_CustomerUpd_BetSetting',N'更新超级总代理的体育博彩投注设置',N'更新超級總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับซุปเปอร์' UNION ALL
SELECT 4, 1, 220021,'Indirectly update Sportsbook Bet Setting for Super ','Acc_CustomerUpd_BetSetting',N'间接地更新超级总代理的体育博彩投注设置',N'間接地更新超級總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับซุปเปอร์' UNION ALL
SELECT 3, 1, 220022,'Update Sportsbook Bet Setting for Master','Acc_CustomerUpd_BetSetting',N'更新总代理的体育博彩投注设置',N'更新總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับมาสเตอร์' UNION ALL
SELECT 3, 1, 220023,'Indirectly update Sportsbook Bet Setting for Master','Acc_CustomerUpd_BetSetting',N'间接地更新总代理的体育博彩投注设置',N'間接地更新總代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับมาสเตอร์' UNION ALL
SELECT 2, 1, 220024,'Update Sportsbook Bet Setting for Agent','Acc_CustomerUpd_BetSetting',N'更新代理的体育博彩投注设置',N'更新代理的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับเอเจ้น' UNION ALL
SELECT 2, 1, 220025,'Indirectly update Sportsbook Bet Setting for Agent','Acc_CustomerUpd_BetSetting',N'间接地更新代理的体育博彩投注设置',N'間接地更新代理的體育博彩投注設置',N'อัปเดตการตั้งค่าเดิมพันกีฬาทางอ้อมสำหรับเอเจ้น' UNION ALL
SELECT 1, 1, 220026,'Update Sportsbook Bet Setting for Member','Acc_CustomerUpd_BetSetting',N'更新会员体的育博彩投注设置',N'更新會員的體育博彩投注設置',N'อัปเดตการตั้งค่าการเดิมพันกีฬาสำหรับสมาชิก' 
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 220020 AND 220026
SELECT * FROM LogActionDetail (NOLOCK) WHERE ActionID BETWEEN 220020 AND 220026
