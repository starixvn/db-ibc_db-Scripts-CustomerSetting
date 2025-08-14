/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
    Created: 20250812@Eden
    Task: Insert LogAction for CashService/Promotion/Transaction SPs
    Revision: 20250812@Eden: Alpha - Agency Cash Service - Sprint 8 [redmine: #235012]
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
    ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI, ActionNameCN
)
SELECT 310001, 104, N'Age_CashDeposit_ManualAdd', N'Add manual deposit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310003, 105, N'Age_CashWithdrawal_ManualAdd', N'Add manual withdrawal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310005, 104, N'API_CashDeposit_AddTransaction', N'Request deposit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310006, 105, N'API_CashWithdrawal_AddTransaction', N'Request withdrawal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310007, 104, N'API_CashDeposit_UpdateTransStatus', N'Payment Gateway - Update deposit transaction status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310008, 105, N'API_CashWithdrawal_UpdateTransStatus', N'Payment Gateway - Update withdrawal transaction status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310009, 100, N'API_CashDeposit_Payslip_Ins', N'Upload payslip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310010, 105, N'API_CashWithdrawal_UpdateTransStatus', N'API to revert status when payment gateway connection fails', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL
UNION ALL SELECT 310011, 100, N'API_CashTransaction_ProviderInfo_Upd', N'Payment Gateway - Update provider information', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310012, 105, N'Age_CashWithdrawal_UpdateTransStatus', N'Update deposit transaction status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310013, 104, N'Age_CashDeposit_UpdateTransStatus', N'Update withdrawal transaction status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310014, 104, N'Age_CashTransaction_RevertDeposit_Upd', N'Revert deposit transaction to pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310015, 105, N'Age_CashTransaction_RevertWithdrawal_Upd', N'Revert withdrawal transaction to pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310016, 104, N'Task_CashService_UpdateExpiredStatus', N'Expire deposit transaction', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 310017, 100, N'Task_CS_AccumCreditReturn_YesterdayLoss_Adjust', N'Adjust AccumCreditReturn of customers with yesterday loss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL
UNION ALL SELECT 315001, 103, N'Age_CashService_CashPromotionIns', N'Add new promotion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315002, 103, N'Age_CashService_CashPromotionUpd', N'Update promotion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315003, 103, N'Age_CashService_CashPromotionDel', N'Delete promotion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315004, 103, N'Age_CashService_CashPromotionStatusUpd', N'Update promotion status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315101, 103, N'Age_CashPromotion_ManualAddBonus', N'Add manual bonus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315102, 103, N'Age_CashPromotion_UpdateTransStatus', N'Update bonus transaction status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315103, 103, N'Age_CashPromotion_Reject_Multiple', N'Reject multiple pending bonus transactions', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL
UNION ALL SELECT 315104, 103, N'Task_CashPromotion_UpdateExpiredStatus', N'Expire bonus transaction', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL

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

SELECT * 
FROM LogAction lat WITH (NOLOCK) 
WHERE ActionID IN (
    310001,310003,310005,310006,310007,310008,310009,310010,310011,310012,310013,310014,310015,310016,310017,
    315001,315002,315003,315004,315101,315102,315103,315104
)
