/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Log Action  [#198960] 
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO
	-- Initial data Log Action: ProductStatus
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID IN (60540,60541,65580,65581,65582,65583,70624,70625,70626,70627,70628,70629,75660,75661,75662,75663,75664,75665,75666,75667) )
	BEGIN
		
	-- LogAction:
		INSERT INTO LogAction 
		(
			ActionID
		    , ActionTypeID
		    , SPName
		    , ActionNameEN
		    , ActionNameCH
		    , ActionNameCS
		    , ActionNameJP
		    , ActionNameIT
		    , ActionNameTH
		    , ActionNameKO
		    , XsltContent
		    , IsInternal
		    , ActionNameVI
		    , ActionNameCN
		)
		VALUES
			(60540, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Super', N'更新超級總代理其他產品的狀態', N'更新超级总代理其他产品的状态', N'Update Other Products’ Status for Super', N'Update Other Products’ Status for Super', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products’ Status for Super', 'NULL', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Super', N'Update Other Products’ Status for Super'),
			(60541, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Super by Admin', N'管理員更新超級總代理其他產品的狀態', N'管理员更新超级总代理其他产品的状态', N'Update Other Products Product Status on Super by Admin', N'Update Other Products Product Status on Super by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Super by Admin', 'NULL', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Super bởi Admin', N'Update Other Products Product Status on Super by Admin'),
			(65580, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Super', N'更新超級總代理其他產品的狀態', N'更新超级总代理其他产品的状态', N'Update Other Products’ Status for Super', N'Update Other Products’ Status for Super', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products’ Status for Super', 'NULL', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Super', N'Update Other Products’ Status for Super'),
			(65581, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Master', N'更新總代理其他產品的狀態', N'更新总代理其他产品的状态', N'Update Other Products’ Status for Master', N'Update Other Products’ Status for Master', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์', N'Update Other Products’ Status for Master', 'NULL', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Master', N'Update Other Products’ Status for Master'),
			(65582, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Super by Admin', N'管理員更新超級總代理其他產品的狀態', N'管理员更新超级总代理其他产品的状态', N'Update Other Products Product Status on Super by Admin', N'Update Other Products Product Status on Super by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Super by Admin', 'NULL', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Super bởi Admin', N'Update Other Products Product Status on Super by Admin'),
			(65583, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Master by Admin', N'管理員更新總代理其他產品的狀態', N'管理员更新总代理其他产品的状态', N'Update Other Products Product Status on Master by Admin', N'Update Other Products Product Status on Master by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Master by Admin', '', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Master bởi Admin', N'Update Other Products Product Status on Master by Admin'),
			(70624, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Super', N'更新超級總代理其他產品的狀態', N'更新超级总代理其他产品的状态', N'Update Other Products’ Status for Super', N'Update Other Products’ Status for Super', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products’ Status for Super', 'NULL', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Super', N'Update Other Products’ Status for Super'),
			(70625, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Master', N'更新總代理其他產品的狀態', N'更新总代理其他产品的状态', N'Update Other Products’ Status for Master', N'Update Other Products’ Status for Master', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์', N'Update Other Products’ Status for Master', '', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Master', N'Update Other Products’ Status for Master'),
			(70626, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Agent', N'更新代理其他產品的狀態', N'更新代理其他产品的状态', N'Update Other Products’ Status for Agent', N'Update Other Products’ Status for Agent', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์', N'Update Other Products’ Status for Agent', '', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Agent', N'Update Other Products’ Status for Agent'),
			(70627, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Super by Admin', N'管理員更新超級總代理其他產品的狀態', N'管理员更新超级总代理其他产品的状态', N'Update Other Products Product Status on Super by Admin', N'Update Other Products Product Status on Super by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Super by Admin', 'NULL', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Super bởi Admin', N'Update Other Products Product Status on Super by Admin'),
			(70628, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Master by Admin', N'管理員更新總代理其他產品的狀態', N'管理员更新总代理其他产品的状态', N'Update Other Products Product Status on Master by Admin', N'Update Other Products Product Status on Master by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Master by Admin', '', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Master bởi Admin', N'Update Other Products Product Status on Master by Admin'),
			(70629, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Agent by Admin', N'管理員更新代理其他產品的狀態', N'管理员更新代理其他产品的状态', N'Update Other Products Product Status on Agent by Admin', N'Update Other Products Product Status on Agent by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Agent by Admin', '', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Agent bởi Admin', N'Update Other Products Product Status on Agent by Admin'),
			(75660, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Super by Admin', N'管理員更新超級總代理其他產品的狀態', N'管理员更新超级总代理其他产品的状态', N'Update Other Products Product Status on Super by Admin', N'Update Other Products Product Status on Super by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Super by Admin', 'NULL', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Super bởi Admin', N'Update Other Products Product Status on Super by Admin'),
			(75661, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Master by Admin', N'管理員更新總代理其他產品的狀態', N'管理员更新总代理其他产品的状态', N'Update Other Products Product Status on Master by Admin', N'Update Other Products Product Status on Master by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Master by Admin', 'NULL', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Master bởi Admin', N'Update Other Products Product Status on Master by Admin'),
			(75662, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Agent by Admin', N'管理員更新代理其他產品的狀態', N'管理员更新代理其他产品的状态', N'Update Other Products Product Status on Agent by Admin', N'Update Other Products Product Status on Agent by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์ โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Agent by Admin', '', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Agent bởi Admin', N'Update Other Products Product Status on Agent by Admin'),
			(75663, 5, 'Acc_Admin_DisableNewProductStatus_160_Upd', N'Update Other Products Product Status on Member by Admin', N'管理員更新會員其他產品的狀態', N'管理员更新会员其他产品的状态', N'Update Other Products Product Status on Member by Admin', N'Update Other Products Product Status on Member by Admin', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก โดยผู้ดูแลระบบ', N'Update Other Products Product Status on Member by Admin', '', 0, N'Cập nhật Trạng thái Sản phẩm khác cho Member bởi Admin', N'Update Other Products Product Status on Member by Admin'),
			(75664, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Super', N'更新超級總代理其他產品的狀態', N'更新超级总代理其他产品的状态', N'Update Other Products’ Status for Super', N'Update Other Products’ Status for Super', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products’ Status for Super', 'NULL', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Super', N'Update Other Products’ Status for Super'),
			(75665, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Master', N'更新總代理其他產品的狀態', N'更新总代理其他产品的状态', N'Update Other Products’ Status for Master', N'Update Other Products’ Status for Master', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์', N'Update Other Products’ Status for Master', '', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Master', N'Update Other Products’ Status for Master'),
			(75666, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Agent', N'更新代理其他產品的狀態', N'更新代理其他产品的状态', N'Update Other Products’ Status for Agent', N'Update Other Products’ Status for Agent', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์', N'Update Other Products’ Status for Agent', '', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Agent', N'Update Other Products’ Status for Agent'),
			(75667, 5, 'Acc_CustSetting_DisableProductStatus_160_Upd', N'Update Other Products’ Status for Member', N'更新會員其他產品的狀態', N'更新会员其他产品的状态', N'Update Other Products’ Status for Member', N'Update Other Products’ Status for Member', N'อัปเดตสถานะผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก', N'Update Other Products’ Status for Member', '', 0, N'Cập nhật Trạng Thái Sản Phẩm Khác cho Member', N'Update Other Products’ Status for Member')
	
	END	

	IF NOT EXISTS (SELECT 1 FROM LogActionDetail la WITH (NOLOCK) WHERE la.ActionID IN (60541,60540,65582,65580,70627,70624,75660,75664,75661,65581,70625,65583,75665,70628,70626,70629,75666,75662,75663,75667) )
	BEGIN
		-- LogActionDetail:
		INSERT INTO LogActionDetail 
			(
				ActionID
			    , ProductID
			    , Level
			)
			SELECT 60541 , 41 , 4  
		UNION SELECT 60540 , 41 , 4  
		UNION SELECT 65582 , 41 , 4  
		UNION SELECT 65580 , 41 , 4  
		UNION SELECT 70627 , 41 , 4  
		UNION SELECT 70624 , 41 , 4  
		UNION SELECT 75660 , 41 , 4  
		UNION SELECT 75664 , 41 , 4  
		UNION SELECT 75661 , 41 , 3  
		UNION SELECT 65581 , 41 , 3  
		UNION SELECT 70625 , 41 , 3  
		UNION SELECT 65583 , 41 , 3  
		UNION SELECT 75665 , 41 , 3  
		UNION SELECT 70628 , 41 , 3  
		UNION SELECT 70626 , 41 , 2  
		UNION SELECT 70629 , 41 , 2  
		UNION SELECT 75666 , 41 , 2  
		UNION SELECT 75662 , 41 , 2  
		UNION SELECT 75663 , 41 , 1  
		UNION SELECT 75667 , 41 , 1  
	END

	-- Initial data Log Action: Discount
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID = 255 )
	BEGIN
		
			INSERT INTO LogAction 
		(
			ActionID
		    , ActionTypeID
		    , SPName
		    , ActionNameEN
		    , ActionNameCH
		    , ActionNameCS
		    , ActionNameJP
		    , ActionNameIT
		    , ActionNameTH
		    , ActionNameKO
		    , XsltContent
		    , IsInternal
		    , ActionNameVI
		    , ActionNameCN
		)
		SELECT 
			255 AS ActionID
		    , ActionTypeID
		    , 'Acc_CustSetting_Discount_156_Upd' AS SPName
		    , ActionNameEN
		    , ActionNameCH
		    , ActionNameCS
		    , ActionNameJP
		    , ActionNameIT
		    , ActionNameTH
		    , ActionNameKO
		    , XsltContent
		    , IsInternal
		    , ActionNameVI
		    , ActionNameCN
		FROM LogAction la WITH (NOLOCK) WHERE la.ActionID = 237
	END


	-- Initial data Log Action: PT
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID IN (523,524,525,526,527,528,529,530,531,532,533,534) )
	BEGIN
		INSERT INTO LogAction 
		(
			ActionID
		    , ActionTypeID
		    , SPName
		    , ActionNameEN
		    , ActionNameCH
		    , ActionNameCS
		    , ActionNameJP
		    , ActionNameIT
		    , ActionNameTH
		    , ActionNameKO
		    , XsltContent
		    , IsInternal
		    , ActionNameVI
		    , ActionNameCN
		)
		VALUES
			(523, 1, 'Acc_CustSetting_SuperPT_153_Upd', N'Update Other Products’ Position Taking for Super', N'更新超級總代理其他產品的占成數', N'更新超级总代理其他产品的占成数', N'Update Other Products Position Taking for Super', N'Update Other Products Position Taking for Super', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products Position Taking for Super', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác cho Super', N'Update Other Products Position Taking for Super'),
			(524, 1, 'Acc_CustSetting_MasterPT_153_Upd', N'Update Other Products’ Position Taking for Master', N'更新總代理其他產品的佔成數', N'更新总代理其他产品的占成数', N'Update Other Products Position Taking for Master', N'Update Other Products Position Taking for Master', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์', N'Update Other Products Position Taking for Master', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác cho Master', N'Update Other Products Position Taking for Master'),
			(525, 1, 'Acc_CustSetting_AgentPTOnMember_153_MultiUpd', N'Update Other Products’ Position Taking for Member', N'更新會員其他產品的占成數', N'更新会员其他产品的占成数', N'Update Other Products Position Taking for Member', N'Update Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก', N'Update Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác cho Member', N'Update Other Products Position Taking for Member'),
			(526, 1, 'Acc_CustSetting_MasterPTOnMember_153_MultiUpd', N'Update Master''s Other Products’ Position Taking for Member', N'更新總代理旗下會員其他產品的占成數', N'更新总代理旗下会员其他产品的占成数', N'Update Master''s Other Products Position Taking for Member', N'Update Master''s Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของมาสเตอร์ สำหรับสมาชิก', N'Update Master''s Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác của Master cho Member', N'Update Master''s Other Products Position Taking for Member'),
			(527, 1, 'Acc_CustSetting_SuperPTOnMember_153_MultiUpd', N'Update Super''s Other Products’ Position Taking for Member', N'更新超級總代理旗下會員其他產品的占成數', N'更新超级总代理旗下会员其他产品的占成数', N'Update Super''s Other Products Position Taking for Member', N'Update Super''s Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของซุปเปอร์ สำหรับสมาชิก', N'Update Super''s Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác của Super cho Member', N'Update Super''s Other Products Position Taking for Member'),
			(528, 1, 'Acc_CustSetting_AgentPTOnMember_153_Upd', N'Update Other Products’ Position Taking for Member', N'更新會員其他產品的占成數', N'更新会员其他产品的占成数', N'Update Other Products Position Taking for Member', N'Update Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับสมาชิก', N'Update Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác cho Member', N'Update Other Products Position Taking for Member'),
			(529, 1, 'Acc_CustSetting_AgentPT_153_Upd', N'Update Other Products’ Position Taking for Agent', N'更新代理其他產品的占成數', N'更新代理其他产品的占成数', N'Update Other Products Position Taking for Agent', N'Update Other Products Position Taking for Agent', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์', N'Update Other Products Position Taking for Agent', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác cho Agent', N'Update Other Products Position Taking for Agent'),
			(530, 1, 'Acc_CustSetting_SuperPTOnMember_153_Upd', N'Update Super''s Other Products’ Position Taking for Member', N'更新超級總代理旗下會員其他產品的占成數', N'更新超级总代理旗下会员其他产品的占成数', N'Update Super''s Other Products Position Taking for Member', N'Update Super''s Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของซุปเปอร์ สำหรับสมาชิก', N'Update Super''s Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác của Super cho Member', N'Update Super''s Other Products Position Taking for Member'),
			(531, 1, 'Acc_CustSetting_MasterPTOnMember_153_Upd', N'Update Master''s Other Products’ Position Taking for Member', N'更新總代理旗下會員其他產品的占成數', N'更新总代理旗下会员其他产品的占成数', N'Update Master''s Other Products Position Taking for Member', N'Update Master''s Other Products Position Taking for Member', N'อัปเดตค่าแบ่งสู้ของผลิตภัณฑ์อื่น ๆ ของมาสเตอร์ สำหรับสมาชิก', N'Update Master''s Other Products Position Taking for Member', NULL, 0, N'Cập nhật Position Taking Sản Phẩm Khác của Master cho Member', N'Update Master''s Other Products Position Taking for Member'),
			(532, 1, 'Acc_CustSetting_SuperMinPT_153_Upd', N'Update Other Products’ Min Position Taking for Super', N'更新超級總代理其他產品的最低占成數', N'更新超级总代理其他产品最低占成数', N'Update Other Products Min Position Taking for Super', N'Update Other Products Min Position Taking for Super', N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับซุปเปอร์', N'Update Other Products Min Position Taking for Super', NULL, 0, N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Super', N'Update Other Products Min Position Taking for Super'),
			(533, 1, 'Acc_CustSetting_MasterMinPT_153_Upd', N'Update Other Products’ Min Position Taking for Master', N'更新總代理其他產品的最低占成數', N'更新总代理其他产品的最低占成数', N'Update Other Products Min Position Taking for Master', N'Update Other Products Min Position Taking for Master', N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับมาสเตอร์', N'Update Other Products Min Position Taking for Master', NULL, 0, N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Master', N'Update Other Products Min Position Taking for Master'),
			(534, 1, 'Acc_CustSetting_AgentMinPT_153_Upd', N'Update Other Products’ Min Position Taking for Agent', N'更新代理其他產品的最低占成數', N'更新代理其他产品的最低占成数', N'Update Other Products Min Position Taking for Agent', N'Update Other Products Min Position Taking for Agent', N'อัปเดตค่าแบ่งสู้ขั้นต่ำของผลิตภัณฑ์อื่น ๆ สำหรับเอเย่นต์', N'Update Other Products Min Position Taking for Agent', NULL, 0, N'Cập nhật Position Taking Nhỏ Nhất của Sản Phẩm Khác cho Agent', N'Update Other Products Min Position Taking for Agent')

	END

	-- Initial data Log Action: WinLossLimit
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID = 852 )
	BEGIN
		INSERT INTO LogAction 
			(
				ActionID
			    , ActionTypeID
			    , SPName
			    , ActionNameEN
			    , ActionNameCH
			    , ActionNameCS
			    , ActionNameJP
			    , ActionNameIT
			    , ActionNameTH
			    , ActionNameKO
			    , XsltContent
			    , IsInternal
			    , ActionNameVI
			    , ActionNameCN
			)
		SELECT	852
			    , ActionTypeID
			    , 'Acc_CustSetting_WinLossLimit_155_Upd'
			    , ActionNameEN
			    , ActionNameCH
			    , ActionNameCS
			    , ActionNameJP
			    , ActionNameIT
			    , ActionNameTH
			    , ActionNameKO
			    , XsltContent
			    , IsInternal
			    , ActionNameVI
			    , ActionNameCN
		FROM LogAction la WITH (NOLOCK)
		WHERE la.SPName ='Acc_CustSetting_WinLossLimitUpd' AND la.ActionID = 850
	END

	---Init Log Action : Stake level
	DELETE
	FROM LogAction WITH(ROWLOCK,UPDLOCK)
	WHERE ActionID IN (220050) -- Stake Level

	INSERT INTO LogAction (
		 ActionID
		,ActionTypeID
		,SPName
		,ActionNameEN
		,ActionNameCH
		,ActionNameCS
		,ActionNameJP
		,ActionNameIT
		,ActionNameTH
		,ActionNameKO
		,XsltContent
		,IsInternal
		,ActionNameVI
		,ActionNameCN
	)
	SELECT ActionID = CASE WHEN ActionID = 391 THEN 220050 END
		,ActionTypeID
		,SPName = CASE WHEN ActionID = 391 THEN 'Acc_CustSetting_StakeLevel_158_Upd' END
		,ActionNameEN
		,ActionNameCH
		,ActionNameCS
		,ActionNameJP
		,ActionNameIT
		,ActionNameTH
		,ActionNameKO
		,XsltContent
		,IsInternal
		,ActionNameVI
		,ActionNameCN
	FROM LogAction WITH(NOLOCK)
	WHERE ActionID IN(391)

	SELECT * 
	FROM LogAction WITH(NOLOCK) 
	WHERE ActionID IN (220050) -- Stake Level


