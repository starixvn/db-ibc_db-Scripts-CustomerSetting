/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
    Created: 20250820@Eden
    Task: Insert LogAction for CashService/Promotion/Transaction SPs
    Revision: 20250812@Eden: Alpha - Agency Cash Service - Sprint 9 [redmine: #236435]
    DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DELETE lat WITH (ROWLOCK,UPDLOCK) 
FROM LogAction lat 
WHERE lat.ActionID IN (
    310001,310003,310005,310006,310007,310008,310009,310010,310011,310012,310013,310014,310015,310016,310017,
    315001,315002,315003,315004,315101,315102,315103,315104
)

DECLARE @LogAction TABLE (
    ActionID INT NOT NULL,
    ActionTypeID INT NULL,
    SPName VARCHAR(50) NULL,
    ActionNameEN NVARCHAR(256) NULL,
    ActionNameCH NVARCHAR(256) NULL,
    ActionNameCS NVARCHAR(256) NULL,
    ActionNameJP NVARCHAR(256) NULL,
    ActionNameIT NVARCHAR(256) NULL,
    ActionNameTH NVARCHAR(256) NULL,
    ActionNameKO NVARCHAR(256) NULL,
    XsltContent VARCHAR(MAX) NULL,
    IsInternal TINYINT NOT NULL,
    ActionNameVI NVARCHAR(256) NULL,
    ActionNameCN NVARCHAR(256) NULL
)

INSERT INTO @LogAction (
    ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCN, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI, ActionNameCS
)
		  SELECT 310001, 104, N'Age_CashDeposit_ManualAdd', N'Add manual deposit', N'添加手動存款', NULL, NULL, NULL, N'เพิ่มรายการธุรกรรมให้กับสมาชิกเมื่อมีการฝากเงิน', NULL, NULL, 0, NULL, N'添加手动存款'
UNION ALL SELECT 310003, 105, N'Age_CashWithdrawal_ManualAdd', N'Add manual withdrawal', N'添加手動提款', NULL, NULL, NULL, N'เพิ่มรายการธุรกรรมให้กับสมาชิกเมื่อมีการถอนเงิน', NULL, NULL, 0, NULL, N'添加手动提款'
UNION ALL SELECT 310005, 104, N'API_CashDeposit_AddTransaction', N'Request deposit', N'請求存款', NULL, NULL, NULL, N'เพิ่มรายการธุรกรรมให้กับสมาชิกเมื่อมีการฝากเงิน', NULL, NULL, 0, NULL, N'请求存款'
UNION ALL SELECT 310006, 105, N'API_CashWithdrawal_AddTransaction', N'Request withdrawal', N'請求提款', NULL, NULL, NULL, N'เพิ่มรายการธุรกรรมให้กับสมาชิกเมื่อมีการถอนเงิน', NULL, NULL, 0, NULL, N'请求提款'
UNION ALL SELECT 310007, 104, N'API_CashDeposit_UpdateTransStatus', N'Payment Gateway - Update deposit transaction status', N'支付網關 - 更新存款交易狀態', NULL, NULL, NULL, N'API สำหรับอัปเดตสถานะการฝากเงิน', NULL, NULL, 0, NULL, N'支付网关 - 更新存款交易状态'
UNION ALL SELECT 310008, 105, N'API_CashWithdrawal_UpdateTransStatus', N'Payment Gateway - Update withdrawal transaction status', N'支付網關 - 更新提款交易狀態', NULL, NULL, NULL, N'API สำหรับอัปเดตสถานะการถอนเงิน', NULL, NULL, 0, NULL, N'支付网关 - 更新提款交易状态'
UNION ALL SELECT 310009, 104, N'API_CashDeposit_Payslip_Ins', N'Upload payslip', N'上傳工資單', NULL, NULL, NULL, N'API สำหรับอัปเดตสลิปการชำระเงินเมื่อทำการฝากเงิน', NULL, NULL, 0, NULL, N'上传工资单'
UNION ALL SELECT 310010, 105, N'API_CashWithdrawal_UpdateTransStatus', N'API to revert status when payment gateway connection fails', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL
UNION ALL SELECT 310011, 100, N'API_CashTransaction_ProviderInfo_Upd', N'Payment Gateway - Update provider information', N'支付網關 - 更新供應商信息', NULL, NULL, NULL, N'API สำหรับอัปเดตข้อมูลผู้ให้บริการ', NULL, NULL, 0, NULL, N'支付网关 - 更新供应商信息'
UNION ALL SELECT 310012, 105, N'Age_CashWithdrawal_UpdateTransStatus', N'Update withdrawal transaction status', N'更新提款交易狀態', NULL, NULL, NULL, N'อัปเดตสถานะการฝากเงิน', NULL, NULL, 0, NULL, N'更新提款交易状态'
UNION ALL SELECT 310013, 104, N'Age_CashDeposit_UpdateTransStatus', N'Update deposit transaction status', N'更新存款交易狀態', NULL, NULL, NULL, N'อัปเดตสถานะการถอนเงิน', NULL, NULL, 0, NULL, N'更新存款交易状态'
UNION ALL SELECT 310014, 104, N'Age_CashTransaction_RevertDeposit_Upd', N'Revert deposit transaction to pending', N'將存款交易狀態恢複爲待處理', NULL, NULL, NULL, N'เปลี่ยนสถานะการฝากเงินกลับเป็น “รอดำเนินการ”', NULL, NULL, 0, NULL, N'将存款交易状态恢复为待处理'
UNION ALL SELECT 310015, 105, N'Age_CashTransaction_RevertWithdrawal_Upd', N'Revert withdrawal transaction to pending', N'將提款交易狀態恢複爲待處理', NULL, NULL, NULL, N'เปลี่ยนสถานะการถอนเงินกลับเป็น “รอดำเนินการ”', NULL, NULL, 0, NULL, N'将提款交易状态恢复为待处理'
UNION ALL SELECT 310016, 104, N'Task_CashService_UpdateExpiredStatus', N'Expire deposit transaction', N'存款交易已過期', NULL, NULL, NULL, N'บริการสำหรับอัปเดตรายการธุรกรรมที่หมดอายุ', NULL, NULL, 0, NULL, N'存款交易已过期'
UNION ALL SELECT 310017, 100, N'Task_CS_AccumCreditReturn_YesterdayLoss_Adjust', N'Adjust AccumCreditReturn of customers with yesterday loss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL
UNION ALL SELECT 315001, 103, N'Age_CashService_CashPromotionIns', N'Add new promotion', N'新增優惠活動', NULL, NULL, NULL, N'เพิ่มโปรโมชันใหม่', NULL, NULL, 0, NULL, N'新增优惠活动'
UNION ALL SELECT 315002, 103, N'Age_CashService_CashPromotionUpd', N'Update promotion', N'更新優惠活動', NULL, NULL, NULL, N'ลบโปรโมชัน', NULL, NULL, 0, NULL, N'更新优惠活动'
UNION ALL SELECT 315003, 103, N'Age_CashService_CashPromotionDel', N'Delete promotion', N'刪除優惠活動', NULL, NULL, NULL, N'อัปเดตสถานะโปรโมชัน', NULL, NULL, 0, NULL, N'删除优惠活动'
UNION ALL SELECT 315004, 103, N'Age_CashService_CashPromotionStatusUpd', N'Update promotion status', N'更新優惠活動狀態', NULL, NULL, NULL, N'อัปเดตสถานะโบนัสโปรโมชัน', NULL, NULL, 0, NULL, N'更新优惠活动状态'
UNION ALL SELECT 315101, 103, N'Age_CashPromotion_ManualAddBonus', N'Add manual bonus', N'新增手動獎金', NULL, NULL, NULL, N'เพิ่มโบนัสโปรโมชันด้วยตนเอง', NULL, NULL, 0, NULL, N'新增手动奖金'
UNION ALL SELECT 315102, 103, N'Age_CashPromotion_UpdateTransStatus', N'Update bonus transaction status', N'更新獎金交易狀態', NULL, NULL, NULL, N'อัปเดตสถานะโบนัสโปรโมชัน', NULL, NULL, 0, NULL, N'更新奖金交易状态'
UNION ALL SELECT 315103, 103, N'Age_CashPromotion_Reject_Multiple', N'Reject multiple pending bonus transactions', N'拒絶多個待處理獎金交易', NULL, NULL, NULL, N'ปฏิเสธโบนัสโปรโมชัน (หลายรายการ)', NULL, NULL, 0, NULL, N'拒绝多个待处理奖金交易'
UNION ALL SELECT 315104, 103, N'Task_CashPromotion_UpdateExpiredStatus', N'Expire bonus transaction', N'獎金交易已過期', NULL, NULL, NULL, N'อัปเดตโปรโมชันที่หมดอายุ', NULL, NULL, 0, NULL, N'奖金交易已过期'

INSERT INTO LogAction (
    ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI, ActionNameCN
)
SELECT 
    ActionID, ActionTypeID, SPName, ActionNameEN,
    ISNULL(ActionNameCH, ActionNameEN),
    ISNULL(ActionNameCS, ActionNameEN),
    ISNULL(ActionNameJP, ActionNameEN),
    ISNULL(ActionNameIT, ActionNameEN),
    ISNULL(ActionNameTH, ActionNameEN),
    ISNULL(ActionNameKO, ActionNameEN),
    XsltContent, IsInternal,
    ISNULL(ActionNameVI, ActionNameEN),
    ISNULL(ActionNameCN, ActionNameEN)
FROM @LogAction
WHERE ActionID IN (
    310001,310003,310005,310006,310007,310008,310009,310010,310011,310012,310013,310014,310015,310016,310017,
    315001,315002,315003,315004,315101,315102,315103,315104
)

SELECT  *
FROM LogAction lat WITH (NOLOCK) 
WHERE ActionID IN (
    310001,310003,310005,310006,310007,310008,310009,310010,310011,310012,310013,310014,310015,310016,310017,
    315001,315002,315003,315004,315101,315102,315103,315104
)