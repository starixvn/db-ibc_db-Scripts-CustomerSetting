/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20210730
	Task: Insert LogAction for MaxPayout
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, SPName, IsInternal, ActionTypeId, Level)
SELECT 220008, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetLimitUpd', 0, 3, 4 UNION ALL
SELECT 220009, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetLimitUpd', 0, 3, 3 UNION ALL
SELECT 220010, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_BetLimitUpd', 0, 3, 2 UNION ALL
SELECT 220011, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetLimitUpd', 0, 3, 4 UNION ALL
SELECT 220012, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetLimitUpd', 0, 3, 3 UNION ALL
SELECT 220013, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetLimitUpd', 0, 3, 2 UNION ALL
SELECT 220014, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetSettingUpd', 0, 3, 4 UNION ALL
SELECT 220015, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetSettingUpd', 0, 3, 3 UNION ALL
SELECT 220016, 'Indirectly update Other Product Bet Setting for the accounts', N'間接地更新賬號的其他產品的投註設置', N'间接地更新账号的其他产品的投注设置', N'อัปเดตการตั้งค่าการเดิมพันของผลิตภัณฑ์อื่น ๆ ของบัญชีโดยอ้อม', N'Cập nhật gián tiếp Giới Hạn Cược Sản Phẩm Khác cho các tài khoản', 'Acc_CustSetting_GameBetSettingUpd', 0, 3, 2 UNION ALL
SELECT 220017, 'Indirectly update RNG Keno Bet Setting for Super', N'間接地更新超級總代理快樂彩投注設置', N'间接地更新超级总代理快乐彩投注设置', N'อัปเดตการตั้งค่าเดิมพันของ คีโน โดยอ้อมสำหรับระดับซุปเปอร์', N'Cập nhật gián tiếp Giới Hạn Cược RNG Keno cho Super', 'Acc_CustomerUpdSuperKeno_MinMaxBet', 0, 3, 4 UNION ALL
SELECT 220018, 'Indirectly update RNG Keno Bet Setting for Master', N'間接地更新總代理快樂彩投注設置', N'间接地更新总代理快乐彩投注设置', N'อัปเดตการตั้งค่าเดิมพันของ คีโน โดยอ้อมสำหรับระดับมาสเตอร์', N'Cập nhật gián tiếp Giới Hạn Cược RNG Keno cho Master', 'Acc_CustomerUpdMasterKeno_MinMaxBet', 0, 3, 3 UNION ALL
SELECT 220019, 'Indirectly update RNG Keno Bet Setting for Agent', N'間接地更新代理快樂彩投注設置', N'间接地更新代理快乐彩投注设置', N'อัปเดตการตั้งค่าเดิมพันของ คีโน โดยอ้อมสำหรับระดับเอเจนต์', N'Cập nhật gián tiếp Giới Hạn Cược RNG Keno cho Agent', 'Acc_CustomerUpdAgentKeno_MinMaxBet', 0, 3, 2 

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