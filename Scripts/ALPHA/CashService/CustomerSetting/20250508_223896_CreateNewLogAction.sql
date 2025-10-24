/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250508@Elodie
	Task: Create log action [#RedmineID:#224778]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 
DELETE 
FROM LogAction WITH(ROWLOCK,UPDLOCK) 
WHERE ActionID IN (	
					 169001,264002,264003 -- Create new
					 ,169002,264004,264005 -- Register new
					,853 -- Update SMA WinLimit
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

INSERT INTO @Log (ActionID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, ActionTypeID, IsInternal)
VALUES 
(169001, 'Acc_CustomerInsMember_CashMember', 'Add the initial statuses for cash member', 
 N'添加現金會員的初始化狀態', N'为现金会员添加初始化状态', 
 N'เพิ่มสถานะเริ่มต้นสำหรับสมาชิกเงินสด', 
 N'Thêm các trạng thái khởi tạo cho Member tiền mặt',5,0),

(264002, 'Acc_CustomerInsMember_CashMember', 'Add the general information for cash member', 
 N'添加現金會員的一般資訊', N'添加现金会员的一般信息', 
 N'เพิ่มข้อมูลทั่วไปสำหรับสมาชิกเงินสด', 
 N'Thêm thông tin chung cho Member tiền mặt',4,0),

(264003, 'Acc_CustomerInsMember_CashMember', 'Add all products settings for cash member', 
 N'添加現金會員的所有產品設定', N'添加现金会员的所有产品设置', 
 N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับสมาชิกเงินสด', 
 N'Thêm tất cả cài đặt sản phẩm cho Member tiền mặt',4,0),

(853, 'Acc_CustSetting_WinLimit_161_Upd', 'Update Other Products Member Win Limit for customers', 
 N'更新其他產品會員贏利上限', N'更新其他产品会员盈利上限', 
 N'ปรับปรุงขีดจำกัดยอดได้ของโปรดักส์อื่นๆของสมาชิกสำหรับลูกค้า', 
 N'Cập nhật Giới Hạn Tiền Member Thắng của người dùng trên Sản Phẩm Khác',NULL,0),

 (169002, 'API_CustomerInsMember_CashMember', 'Add the initial statuses for cash member', 
 N'添加現金會員的初始化狀態', N'为现金会员添加初始化状态', 
 N'เพิ่มสถานะเริ่มต้นสำหรับสมาชิกเงินสด', 
 N'Thêm các trạng thái khởi tạo cho Member tiền mặt',5,0),

(264004, 'API_CustomerInsMember_CashMember', 'Add the general information for cash member', 
 N'添加現金會員的一般資訊', N'添加现金会员的一般信息', 
 N'เพิ่มข้อมูลทั่วไปสำหรับสมาชิกเงินสด', 
 N'Thêm thông tin chung cho Member tiền mặt',4,0),

(264005, 'API_CustomerInsMember_CashMember', 'Add all products settings for cash member', 
 N'添加現金會員的所有產品設定', N'添加现金会员的所有产品设置', 
 N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับสมาชิกเงินสด', 
 N'Thêm tất cả cài đặt sản phẩm cho Member tiền mặt',4,0)


INSERT INTO dbo.LogAction (ActionID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,ActionNameVI,ActionNameIT,ActionNameCN,ActionTypeID,IsInternal)
SELECT ActionID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN,ActionNameVI,ActionNameEN, ActionNameEN,ActionTypeID,IsInternal
FROM @Log


GO


