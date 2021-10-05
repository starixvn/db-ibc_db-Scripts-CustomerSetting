/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20210928
	Task: Insert LogAction for MaxPayout
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, SPName, IsInternal, ActionTypeId, Level)
SELECT 220027, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetSettingUpd', 0, 3, 4 UNION ALL
SELECT 220028, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetSettingUpd', 0, 3, 3 UNION ALL
SELECT 220029, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetSettingUpd', 0, 3, 2

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)
DELETE FROM LogActionDetail WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameEN,ActionNameTH,ActionNameEN,IsInternal,ActionNameVI
FROM @tmpAction t

INSERT INTO LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, NULL, Level
FROM @tmpAction t

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO