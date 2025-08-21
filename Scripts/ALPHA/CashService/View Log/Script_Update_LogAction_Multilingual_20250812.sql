/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" viewers=""></info>*/
/*
      Task:         Update multilingual action names for LogAction [#235266]
      DB:           DBLOG-bodb_CustomerLog
      Created:      20250812@Helios
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- Update multilingual action names for LogAction with existence check
DECLARE @ActionIDList TABLE (ActionID INT);
INSERT INTO @ActionIDList (ActionID)
VALUES (300001),(300002),(300003),(300004),(300005),(300007),(300008),(300009),(305002),(305003),(305004),(305005),(305006); 

-- Check Data
--SELECT ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameTH
--FROM LogAction
--WHERE ActionID IN (SELECT ActionID FROM @ActionIDList);


-- Only update rows that exist
UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET
    ActionNameEN = CASE ActionID
            WHEN 300001 THEN N'Update Daily Withdrawal Limit'
            WHEN 300002 THEN N'Update Deposit/Withdrawal Limit'
            WHEN 300003 THEN N'Add Agent Bank Account'
            WHEN 300004 THEN N'Update Agent Bank Account Info'
            WHEN 300005 THEN N'Remove Agent Bank Account'
            WHEN 300007 THEN N'Update Member Bank Account Info'
            WHEN 300008 THEN N'Add Member Bank Account'
            WHEN 300009 THEN N'Remove Member Bank Account'
            WHEN 305002 THEN N'Update Payment Method Info'
            WHEN 305003 THEN N'Update Payment Provider Status'
            WHEN 305004 THEN N'Update Payment Gateway Info'
            WHEN 305005 THEN N'Add Config Payment Gateway Info'
            WHEN 305006 THEN N'Update General Information'
        ELSE ActionNameEN END,
    ActionNameCH = CASE ActionID
            WHEN 300001 THEN N'更新每日提款限额'
            WHEN 300002 THEN N'更新存款/提款限额'
            WHEN 300003 THEN N'新增代理银行账户'
            WHEN 300004 THEN N'更新代理银行账户信息'
            WHEN 300005 THEN N'删除代理银行账户'
            WHEN 300007 THEN N'更新会员银行账户信息'
            WHEN 300008 THEN N'新增会员银行账户'
            WHEN 300009 THEN N'删除会员银行账户'
            WHEN 305002 THEN N'更新支付方式信息'
            WHEN 305003 THEN N'更新支付服务商状态'
            WHEN 305004 THEN N'更新支付网关信息'
            WHEN 305005 THEN N'新增配置支付网关信息'
            WHEN 305006 THEN N'更新一般信息'
        ELSE ActionNameCH END,
    ActionNameCS = CASE ActionID
            WHEN 300001 THEN N'更新每日提款限额'
            WHEN 300002 THEN N'更新存款/提款限额'
            WHEN 300003 THEN N'新增代理银行账户'
            WHEN 300004 THEN N'更新代理银行账户信息'
            WHEN 300005 THEN N'删除代理银行账户'
            WHEN 300007 THEN N'更新会员银行账户信息'
            WHEN 300008 THEN N'新增会员银行账户'
            WHEN 300009 THEN N'删除会员银行账户'
            WHEN 305002 THEN N'更新支付方式信息'
            WHEN 305003 THEN N'更新支付服务商状态'
            WHEN 305004 THEN N'更新支付网关信息'
            WHEN 305005 THEN N'新增配置支付网关信息'
            WHEN 305006 THEN N'更新一般信息'
        ELSE ActionNameCS END,
    ActionNameJP = CASE ActionID
            WHEN 300001 THEN N'日次出金限度の更新'
            WHEN 300002 THEN N'入出金限度の更新'
            WHEN 300003 THEN N'代理銀行口座の追加'
            WHEN 300004 THEN N'代理銀行口座情報の更新'
            WHEN 300005 THEN N'代理銀行口座の削除'
            WHEN 300007 THEN N'会員銀行口座情報の更新'
            WHEN 300008 THEN N'会員銀行口座の追加'
            WHEN 300009 THEN N'会員銀行口座の削除'
            WHEN 305002 THEN N'支払方法情報の更新'
            WHEN 305003 THEN N'支払プロバイダーのステータス更新'
            WHEN 305004 THEN N'決済ゲートウェイ情報の更新'
            WHEN 305005 THEN N'決済ゲートウェイ情報の追加・設定'
            WHEN 305006 THEN N'一般情報の更新'
        ELSE ActionNameJP END,
    ActionNameTH = CASE ActionID
            WHEN 300001 THEN N'อัปเดตวงเงินถอนรายวัน'
            WHEN 300002 THEN N'อัปเดตวงเงินฝาก/ถอน'
            WHEN 300003 THEN N'เพิ่มบัญชีธนาคารตัวแทน'
            WHEN 300004 THEN N'อัปเดตข้อมูลบัญชีธนาคารตัวแทน'
            WHEN 300005 THEN N'ลบบัญชีธนาคารตัวแทน'
            WHEN 300007 THEN N'อัปเดตข้อมูลบัญชีธนาคารสมาชิก'
            WHEN 300008 THEN N'เพิ่มบัญชีธนาคารสมาชิก'
            WHEN 300009 THEN N'ลบบัญชีธนาคารสมาชิก'
            WHEN 305002 THEN N'อัปเดตข้อมูลช่องทางการชำระเงิน'
            WHEN 305003 THEN N'อัปเดตสถานะผู้ให้บริการชำระเงิน'
            WHEN 305004 THEN N'อัปเดตข้อมูลเกตเวย์การชำระเงิน'
            WHEN 305005 THEN N'เพิ่ม/กำหนดค่าเกตเวย์การชำระเงิน'
            WHEN 305006 THEN N'อัปเดตข้อมูลทั่วไป'
        ELSE ActionNameTH END
WHERE ActionID IN (SELECT ActionID FROM @ActionIDList)
  AND EXISTS (SELECT 1 FROM LogAction WHERE ActionID = LogAction.ActionID);

-- Output result
SELECT ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameTH
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @ActionIDList);
