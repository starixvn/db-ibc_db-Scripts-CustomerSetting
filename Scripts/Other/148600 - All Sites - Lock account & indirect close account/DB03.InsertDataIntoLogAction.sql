/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210413@Tina
	Task: All Sites - Lock account & indirect close account [redmine: #148600]
	DB: DBLOG.bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

--Insert LogAction for Locked
IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 1182)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 1182 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdLocked' SPName, 'Unlock Access' ActionNameEN, 0 IsInternal, 
		N'解锁访问' ActionNameCS, N'解鎖訪問' ActionNameCH, N'ปลดล็อกการเข้าถึง' ActionNameTH
END

UPDATE LogAction WITH (ROWLOCK) SET ActionNameEN = 'Unlock Access',
									ActionNameCH = N'解鎖訪問',
									ActionNameCS = N'解锁访问',
									ActionNameTH = N'ปลดล็อกการเข้าถึง' 
WHERE ActionID = 1182

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 948)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 948 ActionID, 4 ActionTypeID, 'Age_CustomerPwdUpd2' SPName, 'This account is locked due to 5 failed password attempts.' ActionNameEN, 0 IsInternal, 
		N'由于输入密码错误长达五次，账号已被鎖。' ActionNameCS, N'由於輸入密碼錯誤長達五次，賬號已被鎖。' ActionNameCH, N'บัญชีนี้ถูกล็อคเนื่องจากใส่รหัสผ่านไม่ถูกต้อง 5 ครั้ง' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 949)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 949 ActionID, 4 ActionTypeID, 'Age_CustSubPwdUpd2' SPName, 'Sub account is closed due to 5 failed password attempts.' ActionNameEN, 0 IsInternal, 
		N'由于输入密码错误长达五次，子账号已被鎖。' ActionNameCS, N'由於輸入密碼錯誤長達五次，子賬號已被鎖。' ActionNameCH, N'บัญชีย่อยนี้ถูกล็อคเนื่องจากใส่รหัสผ่านไม่ถูกต้อง 5 ครั้ง' ActionNameTH
END 

UPDATE LogAction WITH (ROWLOCK) SET ActionNameEN = 'Sub account is closed due to 5 failed password attempts.',
									ActionNameCH = N'由於輸入錯誤密碼長達5次子賬號已被關閉。',
									ActionNameCS = N'由于输入错误密码长达5次子账号已被关闭。',
									ActionNameTH = N'บัญชีย่อยถูกปิดเนื่องจากล้มเหลวในการป้อนรหัสผ่าน 5 ครั้ง' 
WHERE ActionID = 949

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 950)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 950 ActionID, 4 ActionTypeID, 'Age_LoginVerifyDownline' SPName, 'Sub account is closed due to 5 failed password attempts.' ActionNameEN, 0 IsInternal, 
		N'由于输入错误密码长达5次子账号已被关闭。' ActionNameCS, N'由於輸入錯誤密碼長達5次子賬號已被關閉。' ActionNameCH, N'บัญชีย่อยถูกปิดเนื่องจากล้มเหลวในการป้อนรหัสผ่าน 5 ครั้ง' ActionNameTH
END 
 
--Insert LogAction for Closed
IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 65020)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 65020 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Super.' ActionNameEN, 0 IsInternal, 
		N'更新超级总代理的关闭状态。' ActionNameCS, N'更新超級總代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของซุปเปอร์' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 70029)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 70029 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Super.' ActionNameEN, 0 IsInternal, 
		N'更新超级总代理的关闭状态。' ActionNameCS, N'更新超級總代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของซุปเปอร์' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 70030)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 70030 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Master.' ActionNameEN, 0 IsInternal, 
		N'更新总代理的关闭状态。' ActionNameCS, N'更新總代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของมาสเตอร์' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 75039)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 75039 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Super.' ActionNameEN, 0 IsInternal, 
		N'更新超级总代理的关闭状态。' ActionNameCS, N'更新超級總代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของซุปเปอร์' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 75040)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 75040 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Master.' ActionNameEN, 0 IsInternal, 
		N'更新总代理的关闭状态。' ActionNameCS, N'更新總代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของมาสเตอร์' ActionNameTH
END

IF NOT EXISTS (SELECT 1 FROM LogAction LA WITH (NOLOCK) WHERE LA.ActionID = 75041)
BEGIN
	INSERT INTO LogAction (ActionID, ActionTypeID, SPName, ActionNameEN, IsInternal, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 75041 ActionID, 5 ActionTypeID, 'Acc_CustomerUpdClosed' SPName, 'Update Closed status on Agent.' ActionNameEN, 0 IsInternal, 
		N'更新代理的关闭状态。' ActionNameCS, N'更新代理的關閉狀態。' ActionNameCH, N'อัพเดตสถานะการปิดของเอเจนต์' ActionNameTH
END