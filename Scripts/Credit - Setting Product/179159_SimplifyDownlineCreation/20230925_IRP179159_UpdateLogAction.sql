/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230925@Johnson
	Task: update log action
	DB: DBLOG/bodb_CustomerLog
*/
DELETE LogAction  WHERE ActionID IN (1197,1198,1199,1223,1224,1225,95090,95091,95094)

;WITH T AS (
	SELECT 95090 ActionID, 601 Old_ActionID, 'Acc_LiteMode_CustomerInsMember_SAg' SPName
	UNION SELECT 1223, 1210, 'Acc_LiteMode_CustomerInsMember_SAg'
	UNION SELECT 1197, 1101, 'Acc_LiteMode_CustomerInsMember_SAg'
	UNION SELECT 95091, 602, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 1224, 1209, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 1198, 1102, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 95094, 603, 'Acc_LiteMode_CustomerInsMember_Ag'
	UNION SELECT 1225, 1207, 'Acc_LiteMode_CustomerInsMember_Ag'
	UNION SELECT 1199, 1103, 'Acc_LiteMode_CustomerInsMember_Ag'
)
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT t.ActionID,ActionTypeID,t.SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,NULL,0,ActionNameVI,ActionNameCN
FROM LogAction l
	INNER JOIN T on l.ActionID = t.Old_ActionID
	
	
/*
UPDATE LogAction 
SET ActionNameTH = N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับมาสเตอร์'
WHERE ActionID = 95088
*/

/*
DELETE LogAction WHERE ActionID IN (475,476,477,480,481,482,483,484,485,95088,95092,95095)

;WITH T AS (
	SELECT 475 as ActionID, 1 ActionTypeID, 'Acc_LiteMode_CustSetting_CustPTTemplateIns' SPName, 'Add Position Taking Template for Super' ActionNameEN, 0 IsInternal, N'เพิ่มเทมเพลตค่าแบ่งสู้สำหรับซุปเปอร์' ActionNameTH, N'Thêm Mẫu Position Taking cho Super' ActionNameVI, N'添加占成数模板给超级' ActionNameCS, N'添加佔成數模板給超級' ActionNameCH 
	UNION SELECT 476, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update Position Taking Template for Super', 0, N'อัปเดตเทมเพลตค่าแบ่งสู้สำหรับซุปเปอร์', N'Cập nhật Mẫu Position Taking cho Super', N'更新超级占成数模板', N'更新超級佔成數模板'
	UNION SELECT 477, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete Position Taking Template for Super', 0, N'ลบเทมเพลตค่าแบ่งสู้สำหรับซุปเปอร์', N'Xóa Mẫu Position Taking cho Super', N'删除超级占成数模板', N'刪除超級佔成數模板'
	
	UNION SELECT 480, 1 , 'Acc_LiteMode_CustSetting_CustPTTemplateIns', 'Add Position Taking Template for Master', 0, N'เพิ่มเทมเพลตค่าแบ่งสู้สำหรับมาสเตอร์', N'Thêm Mẫu Position Taking cho Master', N'添加占成数模板给总代理', N'添加佔成數模板給總代理'
	UNION SELECT 481, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update Position Taking Template for Master', 0, N'อัปเดตเทมเพลตค่าแบ่งสู้สำหรับมาสเตอร์', N'Cập nhật Mẫu Position Taking cho Master', N'更新总代理占成数模板', N'更新總代理佔成數模板'
	UNION SELECT 482, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete Position Taking Template for Master', 0, N'ลบเทมเพลตค่าแบ่งสู้สำหรับมาสเตอร์', N'Xóa Mẫu Position Taking cho Master', N'删除总代理占成数模板', N'刪除總代理佔成數模板'
	
	UNION SELECT 483, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateIns', 'Add Position Taking Template for Agent', 0, N'เพิ่มเทมเพลตค่าแบ่งสู้สำหรับเอเย่นต์', N'Thêm Mẫu Position Taking cho Agent', N'添加占成数模板给代理', N'添加佔成數模板給代理'
	UNION SELECT 484, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update Position Taking Template for Agent', 0, N'อัปเดตเทมเพลตค่าแบ่งสู้สำหรับเอเย่นต์', N'Cập nhật Mẫu Position Taking cho Agent', N'更新代理占成数模板', N'更新代理佔成數模板'
	UNION SELECT 485, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete Position Taking Template for Agent', 0, N'ลบเทมเพลตค่าแบ่งสู้สำหรับเอเย่นต์', N'Xóa Mẫu Position Taking cho Agent', N'删除代理占成数模板', N'刪除代理佔成數模板'
	
	UNION SELECT 95088,4,'Acc_LiteMode_CustomerInsMember_SAg','Add all products settings for Master', 0, N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับ Master', N'Thêm tất cả cài đặt sản phẩm cho Master', N'添加所有产品设置给总代理', N'添加所有產品設置給總代理'	
	UNION SELECT 95092,4,'Acc_LiteMode_CustomerInsMember_MAg','Add all products settings for Agent', 0, N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับเอเย่นต์', N'Thêm tất cả cài đặt sản phẩm cho Agent', N'添加所有产品设置给代理', N'添加所有產品設置給代理'
	UNION SELECT 95095,4,'Acc_LiteMode_CustomerInsMember_Ag','Add all products settings for Member', 0, N'เพิ่มการตั้งค่าผลิตภัณฑ์ทั้งหมดสำหรับสมาชิก', N'Thêm tất cả cài đặt sản phẩm cho Member', N'添加所有产品设置给会员', N'添加所有產品設置給會員' 	
)
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameEN,ActionNameEN,ActionNameTH,ActionNameEN,NULL,0,ActionNameVI,ActionNameEN
FROM T
GO
*/

/*
DELETE LogAction WHERE ActionID IN (95089,95093,95096)

;WITH T AS (	
	SELECT 95089 ActionID,4 ActionTypeID,'Acc_LiteMode_CustomerInsMember_SAg' SPName,'Snapshot - Product Settings for master' ActionNameEN,1 IsInternal
	UNION SELECT 95093,4,'Acc_LiteMode_CustomerInsMember_MAg','Snapshot - Product Setting for agent',1
	UNION SELECT 95096,4,'Acc_LiteMode_CustomerInsMember_Ag','Snapshot - Product Setting for member',1
)
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,NULL,0,ActionNameEN,ActionNameEN
FROM T
GO
*/