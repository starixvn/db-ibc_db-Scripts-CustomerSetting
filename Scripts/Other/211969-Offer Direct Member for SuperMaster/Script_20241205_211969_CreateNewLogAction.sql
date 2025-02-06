/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20241205@Eden
	Task: Create log action [#RedmineID:#211969]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 
DELETE 
FROM LogAction WITH(ROWLOCK,UPDLOCK) 
WHERE ActionID IN (	
					 1226,169000,264000,264001 -- Create new
					,257,258 -- Update SB Comm
					,200011,200012,200013,200014,200015,200016 -- Update PT
				)

----Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, ActionNameVI NVARCHAR(256)
		, SPName VARCHAR(50)
		, ActionTypeID INT
		, IsInternal BIT
	)

INSERT INTO @Log (ActionID, SPName, ActionNameEN,ActionNameCH,ActionNameCS,ActionNameTH,ActionNameVI,ActionTypeID,IsInternal)
SELECT 1226	 ,'Acc_CustomerInsMember_DirectMember','Set credit for new direct member',N'為新直系會員設定信用額度',N'为新直系会员设定信用额度',N'กำหนดเครดิตสำหรับสมาชิกโดยตรงรายใหม่',N'Thiết lập hạn mức tín dụng cho Member trực tiếp mới',NULL,0 UNION ALL
SELECT 169000,'Acc_CustomerInsMember_DirectMember','Initialize statuses for direct member',N'初始化直系會員的狀態',N'初始化直系会员的状态',N'กำหนดสถานะเริ่มต้นสำหรับสมาชิกโดยตรง',N'Khởi tạo các trạng thái cho Member trực tiếp',5,0 UNION ALL
SELECT 264000,'Acc_CustomerInsMember_DirectMember','Enter general info for direct member',N'輸入直系會員的一般資訊',N'输入直系会员的一般资讯',N'ป้อนข้อมูลทั่วไปของสมาชิกโดยตรง',N'Nhập thông tin chung cho Member trực tiếp',4,0 UNION ALL
SELECT 264001,'Acc_CustomerInsMember_DirectMember','Set up all product settings for direct member',N'為直系會員配置所有產品的設置',N'为直系会员配置所有产品的设置',N'ตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับสมาชิกโดยตรง',N'Thiết lập toàn bộ cài đặt sản phẩm cho Member trực tiếp',4,0 UNION ALL
--Update comm
SELECT 257,'Acc_CustSetting_Discount150Upd','Update Sportsbook Commission for member',N'更新體育博彩會員傭金',N'更新体育博彩会员佣金',N'อัพเดทคอมมิชั่นในสปอร์ตบุ๊กสำหรับสมาชิก',N'Cập nhật giá trị hoa hồng của Sportbook cho Member',2,0 UNION ALL
SELECT 258,'Acc_CustSetting_Discount150Upd','Update Sportsbook Commission for member',N'更新體育博彩會員傭金',N'更新体育博彩会员佣金',N'อัพเดทคอมมิชั่นในสปอร์ตบุ๊กสำหรับสมาชิก',N'Cập nhật giá trị hoa hồng của Sportbook cho Member',2,0 UNION ALL
--Update PT
SELECT 200011,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Sportsbook Position Taking for Member',N'更新超級總代理旗下會員的體育博彩占成數',N'更新超级总代理旗下会员的体育博彩占成数',N'อัปเดตค่าแบ่งสู้กีฬาของซุปเปอร์สำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook của Super cho Member',1,0 UNION ALL
SELECT 200012,'Acc_CustSetting_MasterPTOnMember_153_Upd','Update Master''s Sportsbook Position Taking for Member',N'更新總代理旗下會員的體育博彩占成數',N'更新总代理旗下会员的体育博彩占成数',N'อัปเดตค่าแบ่งสู้กีฬาของมาสเตอร์สำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook của Master cho Member',1,0 UNION ALL
SELECT 200013,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Sportsbook Position Taking for Member',N'更新超級總代理旗下會員的體育博彩占成數',N'更新超级总代理旗下会员的体育博彩占成数',N'อัปเดตค่าแบ่งสู้กีฬาของซุปเปอร์สำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook của Super cho Member',1,0 UNION ALL
SELECT 200014,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Other Products’ Position Taking for Member',N'更新超級總代理旗下會員其他產品的占成數',N'更新超级总代理旗下会员其他产品的占成数',N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของซุปเปอร์ สำหรับสมาชิก',N'Cập nhật Position Taking Sản Phẩm Khác của Super cho Member',1,0 UNION ALL
SELECT 200015,'Acc_CustSetting_MasterPTOnMember_153_Upd','Update Master''s Other Products’ Position Taking for Member',N'更新總代理旗下會員其他產品的占成數',N'更新总代理旗下会员其他产品的占成数',N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของมาสเตอร์ สำหรับสมาชิก',N'Cập nhật Position Taking Sản Phẩm Khác của Master cho Member',1,0 UNION ALL
SELECT 200016,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Other Products’ Position Taking for Member',N'更新超級總代理旗下會員其他產品的占成數',N'更新超级总代理旗下会员其他产品的占成数',N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของซุปเปอร์ สำหรับสมาชิก',N'Cập nhật Position Taking Sản Phẩm Khác của Super cho Member',1,0

INSERT INTO dbo.LogAction (ActionID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,ActionNameVI,ActionNameIT,ActionNameCN,ActionTypeID,IsInternal)
SELECT ActionID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN,ActionNameVI,ActionNameEN, ActionNameEN,ActionTypeID,IsInternal
FROM @Log

SELECT * 
FROM LogAction WITH(NOLOCK)  
WHERE ActionID IN (	
					169000,264000,264001,1226 -- Create new
					,257,258 -- Update SB Comm
					,200011,200012,200013,200014,200015,200016 -- Update PT
				)
GO
