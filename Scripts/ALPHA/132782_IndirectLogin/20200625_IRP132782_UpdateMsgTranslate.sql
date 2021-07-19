/*
	Created: 20200625@Johnson
	Task : update MsgError & LogAction for indirect login account [redmine:#132782]
*/


--Step 1: update MsgError @DBCUST/CustDB
WITH t AS (
SELECT 	40052 as id,N'账户无效或不是您的下线。' as cs, N'賬戶無效或不是您的下線。' as ct, N'บัญชีไม่ถูกต้องหรือไม่ใช่ดาวน์ไลน์ของคุณ' as TH, N'Tài khoản không hợp lệ hoặc không phải là tuyến dưới của bạn.' as vi
UNION SELECT 40053,N'您不能间接登录会员账户。',N'您不能間接登錄會員賬戶。',N'คุณไม่สามารถเข้าสู่บัญชีสมาชิกทางอ้อม', N'Bạn không thể đăng nhập gián tiếp vào tài khoản Member'
UNION SELECT 40054,N'该账户已被连接。',N'該賬戶已被連接。',N'เชื่อมต่อบัญชีแล้ว',N'Tài khoản đã được liên kết.'
UNION SELECT 60036,N'此账户已关闭或已禁用，请开启它，再次重试。', N'此賬戶已關閉或已禁用，請開啟它，再次重試。', N'บัญชีนี้ถูกปิดหรือปิดการใช้งานโปรดเปิดและลองอีกครั้ง', N'Tài khoản này đã bị đóng hoặc vô hiệu hóa, vui lòng mở lên và thử lại.'
UNION SELECT 80011,N'密码错误',N'密碼錯誤', N'รหัสผ่านผิด', N'Mật khẩu không chính xác.'
)
UPDATE msg
SET [MsgNameCT] = ct
    ,[MsgNameCS] = cs
	,[MsgNameTH] = th
	,[MsgNameVI] = vi
FROM MsgError msg WITH(UPDLOCK,ROWLOCK)
	INNER JOIN t ON msg.MsgID = t.id
GO
	
--Step 2: update logaction
--run at @DBLOG/bodb_CustomerLog
WITH t AS (	
SELECT 95019 as ID,N'间接连接登录账户' as cs, N'間接連接登錄賬戶' as ct, N'เชื่อมต่อบัญชีเข้าสู่ระบบทางอ้อม' as TH, N'Liên Kết Tài Khoản Gián Tiếp' as VI
UNION SELECT 95020, N'间接断开登录账户', N'間接斷開登錄賬戶', N'ตัดการเชื่อมต่อบัญชีเข้าสู่ระบบทางอ้อม', N'Huỷ Liên Kết Tài Khoản Gián Tiếp'
UNION SELECT 95021,N'验证密码', N'驗證密碼', N'ยืนยันรหัสผ่าน', N'Xác nhận mật khẩu'
UNION SELECT 95022,N'验证密码', N'驗證密碼', N'ยืนยันรหัสผ่าน', N'Xác nhận mật khẩu'
UNION SELECT 1335,N'通过代理网间接登录',N'通過代理網間接登錄',N'เข้าสู่ระบบทางอ้อมผ่านทางเว็บไซต์ตัวแทน',N'Đăng nhập gián tiếp qua trang web Đại Lý'
UNION SELECT 1336,N'通过代理网间接登录',N'通過代理網間接登錄',N'เข้าสู่ระบบทางอ้อมผ่านทางเว็บไซต์ตัวแทน',N'Đăng nhập gián tiếp qua trang web Đại Lý'
UNION SELECT 1337,N'通过代理网间接登录',N'通過代理網間接登錄',N'เข้าสู่ระบบทางอ้อมผ่านทางเว็บไซต์ตัวแทน',N'Đăng nhập gián tiếp qua trang web Đại Lý'
)	
UPDATE l
SET [ActionNameCH] = CT
	,[ActionNameCS] = CS
	,[ActionNameTH] = TH
    ,[ActionNameVI] = VI
FROM LogAction l WITH(UPDLOCK,ROWLOCK)
	INNER JOIN t ON l.ActionID = t.ID
	
UPDATE LogAction 
SET [ActionNameEN] = 'Indirect Login via Agent Site'  
   ,[ActionNameJP] = 'Indirect Login via Agent Site'  
   ,[ActionNameIT] = 'Indirect Login via Agent Site'    
   ,[ActionNameKO] = 'Indirect Login via Agent Site'  
   ,[ActionNameCN] = 'Indirect Login via Agent Site'  
WHERE ActionID IN (1335,1336,1337)	