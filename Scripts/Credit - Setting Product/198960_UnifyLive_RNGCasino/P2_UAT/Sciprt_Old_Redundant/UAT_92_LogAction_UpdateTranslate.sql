/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Log Action  [#198960] 
	DB: DBLOG/bodb_CustomerLog
*/


SELECT lad.Level , la.ActionNameEN , la.ActionNameCH , la.ActionNameCS , la.ActionNameTH , la.ActionNameJP , la.ActionNameIT , la.ActionNameKO , la.ActionNameCN , la.ActionNameVI
--UPDATE la
--	SET
--		la.ActionNameEN = CASE 
--						WHEN lad.Level = 1 THEN N'Update Other Products’ Status for Member'
--						WHEN lad.Level = 2 THEN N'Update Other Products’ Status for Agent'
--						WHEN lad.Level = 3 THEN N'Update Other Products’ Status for Master'
--						WHEN lad.Level = 4 THEN N'Update Other Products’ Status for Super'
--					END,
--		la.ActionNameCH = CASE 
--						WHEN lad.Level = 1 THEN N'更新會員其他產品的狀態'
--						WHEN lad.Level = 2 THEN N'更新代理其他產品的狀態'
--						WHEN lad.Level = 3 THEN N'更新總代理其他產品的狀態'
--						WHEN lad.Level = 4 THEN N'更新超級總代理其他產品的狀態'
--					END,
--		la.ActionNameCS = CASE 
--						WHEN lad.Level = 1 THEN N'更新会员其他产品的状态'
--						WHEN lad.Level = 2 THEN N'更新代理其他产品的状态'
--						WHEN lad.Level = 3 THEN N'更新总代理其他产品的状态'
--						WHEN lad.Level = 4 THEN N'更新超级总代理其他产品的状态'
--					END,
--		la.ActionNameTH = CASE 
--						WHEN lad.Level = 1 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก'
--						WHEN lad.Level = 2 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์'
--						WHEN lad.Level = 3 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์'
--						WHEN lad.Level = 4 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์'
--					END,
--		la.ActionNameJP = la.ActionNameEN,
--		la.ActionNameIT = la.ActionNameEN,
--		la.ActionNameKO = la.ActionNameEN,
--		la.ActionNameCN = la.ActionNameEN,
--		la.ActionNameVI = CASE 
--						WHEN lad.Level = 1 THEN N'Cập nhật Trạng Thái Sản Phẩm Khác cho Member'
--						WHEN lad.Level = 2 THEN N'Cập nhật Trạng Thái Sản Phẩm Khác cho Agent'
--						WHEN lad.Level = 3 THEN N'Cập nhật Trạng Thái Sản Phẩm Khác cho Master'
--						WHEN lad.Level = 4 THEN N'Cập nhật Trạng Thái Sản Phẩm Khác cho Super'
--					END

FROM LogAction la WITH (NOLOCK) 
INNER JOIN LogActionDetail lad WITH (NOLOCK) ON la.ActionID = lad.ActionID
WHERE  la.SPName = 'Acc_CustSetting_DisableProductStatus_160_Upd'


SELECT lad.Level , la.ActionNameEN , la.ActionNameCH , la.ActionNameCS , la.ActionNameTH , la.ActionNameJP , la.ActionNameIT , la.ActionNameKO , la.ActionNameCN , la.ActionNameVI
--UPDATE la
--	SET
--		la.ActionNameEN = CASE 
--						WHEN lad.Level = 1 THEN N'Update Other Products Product Status on Member by Admin'
--						WHEN lad.Level = 2 THEN N'Update Other Products Product Status on Agent by Admin'
--						WHEN lad.Level = 3 THEN N'Update Other Products Product Status on Master by Admin'
--						WHEN lad.Level = 4 THEN N'Update Other Products Product Status on Super by Admin'
--					END,
--		la.ActionNameCH = CASE 
--						WHEN lad.Level = 1 THEN N'管理員更新會員其他產品的狀態'
--						WHEN lad.Level = 2 THEN N'管理員更新代理其他產品的狀態'
--						WHEN lad.Level = 3 THEN N'管理員更新總代理其他產品的狀態'
--						WHEN lad.Level = 4 THEN N'管理員更新超級總代理其他產品的狀態'
--					END,
--		la.ActionNameCS = CASE 
--						WHEN lad.Level = 1 THEN N'管理员更新会员其他产品的状态'
--						WHEN lad.Level = 2 THEN N'管理员更新代理其他产品的状态'
--						WHEN lad.Level = 3 THEN N'管理员更新总代理其他产品的状态'
--						WHEN lad.Level = 4 THEN N'管理员更新超级总代理其他产品的状态'
--					END,
--		la.ActionNameTH = CASE 
--						WHEN lad.Level = 1 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก โดยผู้ดูแลระบบ'
--						WHEN lad.Level = 2 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์ โดยผู้ดูแลระบบ'
--						WHEN lad.Level = 3 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์ โดยผู้ดูแลระบบ'
--						WHEN lad.Level = 4 THEN N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์ โดยผู้ดูแลระบบ'
--					END,
--		la.ActionNameJP = la.ActionNameEN,
--		la.ActionNameIT = la.ActionNameEN,
--		la.ActionNameKO = la.ActionNameEN,
--		la.ActionNameCN = la.ActionNameEN,
--		la.ActionNameVI = CASE 
--						WHEN lad.Level = 1 THEN N'Cập nhật Trạng thái Sản phẩm khác cho Member bởi Admin'
--						WHEN lad.Level = 2 THEN N'Cập nhật Trạng thái Sản phẩm khác cho Agent bởi Admin'
--						WHEN lad.Level = 3 THEN N'Cập nhật Trạng thái Sản phẩm khác cho Master bởi Admin'
--						WHEN lad.Level = 4 THEN N'Cập nhật Trạng thái Sản phẩm khác cho Super bởi Admin'
--					END
FROM LogAction la WITH (NOLOCK) 
INNER JOIN LogActionDetail lad WITH (NOLOCK) ON la.ActionID = lad.ActionID
WHERE  la.SPName = 'Acc_Admin_DisableNewProductStatus_160_Upd'


SELECT la.ActionNameEN , la.ActionNameCH , la.ActionNameCS , la.ActionNameTH , la.ActionNameJP , la.ActionNameIT , la.ActionNameKO , la.ActionNameCN , la.ActionNameVI
--UPDATE la
--	SET
--		la.ActionNameCH = CASE 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Agent'		THEN N'更新代理其他產品的最低占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Agent'			THEN N'更新代理其他產品的占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Member'			THEN N'更新會員其他產品的占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Master'		THEN N'更新總代理其他產品的最低占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Master'			THEN N'更新總代理其他產品的佔成數' 
--						 WHEN la.ActionNameEN = N'Update Master''s Other Products Position Taking for Member'	THEN N'更新總代理旗下會員其他產品的占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Super'		THEN N'更新超級總代理其他產品的最低占成數' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Super'			THEN N'更新超級總代理其他產品的占成數' 
--						 WHEN la.ActionNameEN = N'Update Super''s Other Products Position Taking for Member'	THEN N'更新超級總代理旗下會員其他產品的占成數' 
--					END,
--		la.ActionNameCS = CASE 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Agent'		THEN N'更新代理其他产品的最低占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Agent'			THEN N'更新代理其他产品的占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Member'			THEN N'更新会员其他产品的占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Master'		THEN N'更新总代理其他产品的最低占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Master'			THEN N'更新总代理其他产品的占成数' 
--						 WHEN la.ActionNameEN = N'Update Master''s Other Products Position Taking for Member'	THEN N'更新总代理旗下会员其他产品的占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Super'		THEN N'更新超级总代理其他产品最低占成数' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Super'			THEN N'更新超级总代理其他产品的占成数' 
--						 WHEN la.ActionNameEN = N'Update Super''s Other Products Position Taking for Member'	THEN N'更新超级总代理旗下会员其他产品的占成数' 

--					END,
--		la.ActionNameTH = CASE 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Agent'		THEN N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Agent'			THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Member'			THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Master'		THEN N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Master'			THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์' 
--						 WHEN la.ActionNameEN = N'Update Master''s Other Products Position Taking for Member'	THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของมาสเตอร์ สำหรับสมาชิก' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Super'		THEN N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Super'			THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์' 
--						 WHEN la.ActionNameEN = N'Update Super''s Other Products Position Taking for Member'	THEN N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของซุปเปอร์ สำหรับสมาชิก' 

--					END,
--		la.ActionNameVI = CASE 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Agent'		THEN N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Agent' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Agent'			THEN N'Cập nhật Position Taking Sản Phẩm Khác cho Agent' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Member'			THEN N'Cập nhật Position Taking Sản Phẩm Khác cho Member' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Master'		THEN N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Master' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Master'			THEN N'Cập nhật Position Taking Sản Phẩm Khác cho Master' 
--						 WHEN la.ActionNameEN = N'Update Master''s Other Products Position Taking for Member'	THEN N'Cập nhật Position Taking Sản Phẩm Khác của Master cho Member' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Super'		THEN N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Super' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Super'			THEN N'Cập nhật Position Taking Sản Phẩm Khác cho Super' 
--						 WHEN la.ActionNameEN = N'Update Super''s Other Products Position Taking for Member'	THEN N'Cập nhật Position Taking Sản Phẩm Khác của Super cho Member' 
--					END,
--		la.ActionNameEN = CASE 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Agent'		THEN N'Update Other Products’ Min Position Taking for Agent' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Agent'			THEN N'Update Other Products’ Position Taking for Agent' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Member'			THEN N'Update Other Products’ Position Taking for Member' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Master'		THEN N'Update Other Products’ Min Position Taking for Master' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Master'			THEN N'Update Other Products’ Position Taking for Master' 
--						 WHEN la.ActionNameEN = N'Update Master''s Other Products Position Taking for Member'	THEN N'Update Master''s Other Products’ Position Taking for Member' 
--						 WHEN la.ActionNameEN = N'Update Other Products Min Position Taking for Super'		THEN N'Update Other Products’ Min Position Taking for Super' 
--						 WHEN la.ActionNameEN = N'Update Other Products Position Taking for Super'			THEN N'Update Other Products’ Position Taking for Super' 
--						 WHEN la.ActionNameEN = N'Update Super''s Other Products Position Taking for Member'	THEN N'Update Super''s Other Products’ Position Taking for Member' 
--					END,
--		la.ActionNameJP = la.ActionNameEN,
--		la.ActionNameIT = la.ActionNameEN,
--		la.ActionNameKO = la.ActionNameEN,
--		la.ActionNameCN = la.ActionNameEN

FROM LogAction la WITH (NOLOCK) 
WHERE  la.ActionID IN (525,528,529,534,524,526,531,533,523,527,530,532)
