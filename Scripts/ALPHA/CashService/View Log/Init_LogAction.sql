/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250804@Helios
	Task: View Log - Initial New Log Action - [Redmine: #233474] 
	DB: DBLOG-bodb_CustomerLog
*/


IF NOT EXISTS (SELECT TOP 1 1 FROM LogAction lat WITH (NOLOCK) WHERE lat.ActionTypeID IN (100,101,102))
BEGIN
	INSERT INTO LogAction (
	    ActionID,
	    ActionTypeID,
	    SPName,
	    ActionNameEN,
	    ActionNameCH,
	    ActionNameCS,
	    ActionNameJP,
	    ActionNameIT,
	    ActionNameTH,
	    ActionNameKO,
	    XsltContent,
	    IsInternal,
	    ActionNameVI,
	    ActionNameCN
	)
	VALUES
	(300001, 100, N'Age_CashService_AgentBankAccountLimit_Upd', N'Update Daily Withdrawal Limit', N'更新每日提款限额', N'更新每日提款限额', N'日次出金限度の更新', NULL, N'อัปเดตวงเงินถอนรายวัน', N'일일 출금 한도 업데이트', NULL, 0, NULL, N'更新每日提款限额'),
	(300002, 100, N'Age_CashService_AgentBankAccountLimit_Upd', N'Edit Deposit/Withdrawal Limit', N'编辑存款/提款限额', N'编辑存款/提款限额', N'入出金限度の編集', NULL, N'แก้ไขวงเงินฝาก/ถอน', N'입출금 한도 수정', NULL, 0, NULL, N'编辑存款/提款限额'),
	(300003, 101, N'Age_CashService_BankAccountAgent_Ins', N'Add Agent Bank Account', N'新增代理银行账户', N'新增代理银行账户', NULL, NULL, N'เพิ่มบัญชีธนาคารตัวแทน', NULL, NULL, 0, NULL, NULL),
	(300004, 101, N'Age_CashService_BankAccountAgent_Upd', N'Update Agent Bank Account Info', N'更新代理银行账户信息', N'更新代理银行账户信息', NULL, NULL, N'อัปเดตข้อมูลบัญชีธนาคารตัวแทน', NULL, NULL, 0, NULL, NULL),
	(300005, 101, N'Age_CashService_BankAccountAgent_Del', N'Remove Agent Bank Account', N'删除代理银行账户', N'删除代理银行账户', NULL, NULL, N'ลบบัญชีธนาคารตัวแทน', NULL, NULL, 0, NULL, NULL),
	(300007, 101, N'Acc_CustomerUpdBankAccount_CashMember', N'Update Member Bank Account Info', N'更新会员银行账户信息', N'更新会员银行账户信息', NULL, NULL, N'อัปเดตข้อมูลบัญชีธนาคารสมาชิก', NULL, NULL, 0, NULL, NULL),
	(300008, 101, N'Acc_CustomerInsBankAccount_CashMember', N'Add Member Bank Account', N'新增会员银行账户', N'新增会员银行账户', NULL, NULL, N'เพิ่มบัญชีธนาคารสมาชิก', NULL, NULL, 0, NULL, NULL),
	(300009, 101, N'Acc_CustomerDelBankAccount_CashMember', N'Remove Member Bank Account', N'删除会员银行账户', N'删除会员银行账户', NULL, NULL, N'ลบบัญชีธนาคารสมาชิก', NULL, NULL, 0, NULL, NULL),
	(305002, 102, N'Age_CashService_PaymentMethod_Upd', N'Update Payment Method Info', N'更新支付方式信息', N'更新支付方式信息', NULL, NULL, N'อัปเดตข้อมูลช่องทางการชำระเงิน', NULL, NULL, 0, NULL, NULL),
	(305003, 102, N'Age_CashService_PaymentProviderStatus_Upd', N'Update Payment Provider Status', N'更新支付服务商状态', N'更新支付服务商状态', NULL, NULL, N'อัปเดตสถานะผู้ให้บริการชำระเงิน', NULL, NULL, 0, NULL, NULL),
	(305004, 102, N'Age_CashService_PaymentMethod_Config', N'Config Payment Method Info', N'配置支付方式信息', N'配置支付方式信息', NULL, NULL, N'กำหนดค่าข้อมูลช่องทางการชำระเงิน', NULL, NULL, 0, NULL, NULL),
	(305005, 102, N'Age_CashService_PaymentMethod_Config', N'Config Payment Method Info', N'配置支付方式信息', N'配置支付方式信息', NULL, NULL, N'กำหนดค่าข้อมูลช่องทางการชำระเงิน', NULL, NULL, 0, NULL, NULL),
	(305006, 100, N'Age_CashService_GeneralSetting_Upd', N'Update General Information', N'更新一般信息', N'更新一般信息', N'一般情報の更新', NULL, N'อัปเดตข้อมูลทั่วไป', N'일반 정보 업데이트', NULL, 0, NULL, N'更新一般信息');
END

