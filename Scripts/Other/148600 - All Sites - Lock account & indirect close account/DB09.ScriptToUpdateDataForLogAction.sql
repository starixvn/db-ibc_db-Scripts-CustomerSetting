/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210413@Tina
	Task: All Sites - Lock account & indirect close account [redmine: #148600]
	DB: DBLOG.bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO
UPDATE LogAction WITH (ROWLOCK) SET ActionNameEN = 'Account was locked due to 6 failed security code attempts.',
									ActionNameCH = N'由於輸入錯誤密碼長達6次賬號已被鎖',
									ActionNameCS = N'由于输入错误密码长达6次账号已被锁',
									ActionNameTH = N'บัญชีถูกล็อคเนื่องจากการพยายามป้อนรหัสความปลอดภัยล้มเหลว 6 ครั้ง' 
WHERE ActionID = 918

UPDATE LogAction WITH (ROWLOCK) SET ActionNameEN = N'Account is locked due to 5 failed login attempts.',
									ActionNameCH = N'由於登入驗證失敗長達五次，賬號已被鎖。',
									ActionNameCS = N'由于登入验证失败长达五次，账号已被鎖。',
									ActionNameTH = N'บัญชีถูกล็อคเนื่องจากเข้าสู่ระบบไม่สำเร็จ 5 ครั้ง'
WHERE ActionID IN (906, 908, 910, 911, 947, 946)

UPDATE LogAction WITH (ROWLOCK) SET ActionNameEN = N'Account is locked due to 6 failed OTP authentication attempts.',
									ActionNameCH = N'由於OTP驗證失敗長達六次，賬號已被鎖。',
									ActionNameCS = N'由于OTP验证失败长达六次，账号已被鎖。',
									ActionNameTH = N'บัญชีถูกล็อคเนื่องจากกรอกรหัส OTP ไม่ถูกต้อง 6 ครั้ง'
WHERE ActionID IN (931)