/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20211216@Johnson
	Task: add log action for Cash Out
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

DELETE FROM LogAction WITH(ROWLOCK) 
WHERE ActionID IN (60534
					,60535
					,65568
					,65569
					,65570
					,65571
					,70606
					,70607
					,70608
					,70609
					,70610
					,70611					
					,75636
					,75637
					,75638
					,75639
					,75640
					,75641
					,75642
					,75643)

--Super
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],
	[ActionNameEN],
	[ActionNameCH],
	[ActionNameCS],
	[ActionNameJP],
	[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	60534
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'管理員更新Cash Out產品狀態於超級總代理'
	,N'管理员更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super bởi Admin'
	,N'Update Product Status of Cash Out on Super by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	60535
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Super'
	,N'更新Cash Out產品狀態於超級總代理'
	,N'更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super'
	,N'Update Product Status of Cash Out on Super'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์'
	,N'Update Product Status of Cash Out on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super'
	,N'Update Product Status of Cash Out on Super')
	
--Master	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65568
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'管理員更新Cash Out產品狀態於超級總代理'
	,N'管理员更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super bởi Admin'
	,N'Update Product Status of Cash Out on Super by Admin')

INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65569
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'管理員更新Cash Out產品狀態於總代理'
	,N'管理员更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master bởi Admin'
	,N'Update Product Status of Cash Out on Master by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65570
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Super'
	,N'更新Cash Out產品狀態於超級總代理'
	,N'更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super'
	,N'Update Product Status of Cash Out on Super'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์'
	,N'Update Product Status of Cash Out on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super'
	,N'Update Product Status of Cash Out on Super')
		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65571
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Master'
	,N'更新Cash Out產品狀態於總代理'
	,N'更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master'
	,N'Update Product Status of Cash Out on Master'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์'
	,N'Update Product Status of Cash Out on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master'
	,N'Update Product Status of Cash Out on Master')
	
-- Agent	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70606
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'管理員更新Cash Out產品狀態於超級總代理'
	,N'管理员更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super bởi Admin'
	,N'Update Product Status of Cash Out on Super by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70607
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'管理員更新Cash Out產品狀態於總代理'
	,N'管理员更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master bởi Admin'
	,N'Update Product Status of Cash Out on Master by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70608
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'管理員更新Cash Out產品狀態於代理'
	,N'管理员更新Cash Out产品状态于代理'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Agent bởi Admin'
	,N'Update Product Status of Cash Out on Agent by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70609
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Super'
	,N'更新Cash Out產品狀態於超級總代理'
	,N'更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super'
	,N'Update Product Status of Cash Out on Super'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์'
	,N'Update Product Status of Cash Out on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super'
	,N'Update Product Status of Cash Out on Super')	
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70610
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Master'
	,N'更新Cash Out產品狀態於總代理'
	,N'更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master'
	,N'Update Product Status of Cash Out on Master'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์'
	,N'Update Product Status of Cash Out on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master'
	,N'Update Product Status of Cash Out on Master')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70611
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Agent'
	,N'更新Cash Out產品狀態於代理'
	,N'更新Cash Out产品状态于代理'
	,N'Update Product Status of Cash Out on Agent'
	,N'Update Product Status of Cash Out on Agent'
	,N'อัปเดตสถานะโปรดัก Cash Out บน เอเย่นต์'
	,N'Update Product Status of Cash Out on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Agent'
	,N'Update Product Status of Cash Out on Agent')	

-- Member	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75636
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'管理員更新Cash Out產品狀態於超級總代理'
	,N'管理员更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'Update Product Status of Cash Out on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super bởi Admin'
	,N'Update Product Status of Cash Out on Super by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75637
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'管理員更新Cash Out產品狀態於總代理'
	,N'管理员更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'Update Product Status of Cash Out on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master bởi Admin'
	,N'Update Product Status of Cash Out on Master by Admin')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75638
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'管理員更新Cash Out產品狀態於代理'
	,N'管理员更新Cash Out产品状态于代理'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Cash Out on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Agent bởi Admin'
	,N'Update Product Status of Cash Out on Agent by Admin')		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75639
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Cash Out on Member by Admin'
	,N'管理員更新Cash Out產品狀態於會員'
	,N'管理员更新Cash Out产品状态于会员'
	,N'Update Product Status of Cash Out on Member by Admin'
	,N'Update Product Status of Cash Out on Member by Admin'
	,N'อัปเดตสถานะโปรดัก Cash Out บน สมาชิก โดย แอดมิน'
	,N'Update Product Status of Cash Out on Member by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Người chơi bởi Admin'
	,N'Update Product Status of Cash Out on Member by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75640
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Super'
	,N'更新Cash Out產品狀態於超級總代理'
	,N'更新Cash Out产品状态于超级总代理'
	,N'Update Product Status of Cash Out on Super'
	,N'Update Product Status of Cash Out on Super'
	,N'อัปเดตสถานะโปรดัก Cash Out บน ซุปเปอร์'
	,N'Update Product Status of Cash Out on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Super'
	,N'Update Product Status of Cash Out on Super')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75641
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Master'
	,N'更新Cash Out產品狀態於總代理'
	,N'更新Cash Out产品状态于总代理'
	,N'Update Product Status of Cash Out on Master'
	,N'Update Product Status of Cash Out on Master'
	,N'อัปเดตสถานะโปรดัก Cash Out บน มาสเตอร์'
	,N'Update Product Status of Cash Out on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Master'
	,N'Update Product Status of Cash Out on Master')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75642
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Agent'
	,N'更新Cash Out產品狀態於代理'
	,N'更新Cash Out产品状态于代理'
	,N'Update Product Status of Cash Out on Agent'
	,N'Update Product Status of Cash Out on Agent'
	,N'อัปเดตสถานะโปรดัก Cash Out บน เอเย่นต์'
	,N'Update Product Status of Cash Out on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Agent'
	,N'Update Product Status of Cash Out on Agent')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75643
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Cash Out on Member'
	,N'更新Cash Out產品狀態於會員'
	,N'更新Cash Out产品状态于会员'
	,N'Update Product Status of Cash Out on Member'
	,N'Update Product Status of Cash Out on Member'
	,N'อัปเดตสถานะโปรดัก Cash Out บน สมาชิก'
	,N'Update Product Status of Cash Out on Member'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Cash Out cho Người chơi'
	,N'Update Product Status of Cash Out on Member')					
GO

;WITH T AS (
	SELECT 60534 as ActionID, 25 as ProductID, 4 as Level
	UNION SELECT 60535, 25, 4
	UNION SELECT 65568, 25, 4
	UNION SELECT 65569, 25, 3
	UNION SELECT 65570, 25, 4
	UNION SELECT 65571, 25, 3
	UNION SELECT 70606, 25, 4
	UNION SELECT 70607, 25, 3
	UNION SELECT 70608, 25, 2
	UNION SELECT 70609, 25, 4
	UNION SELECT 70610, 25, 3
	UNION SELECT 70611, 25, 2	
	UNION SELECT 75636, 25, 4
	UNION SELECT 75637, 25, 3
	UNION SELECT 75638, 25, 2
	UNION SELECT 75639, 25, 1
	UNION SELECT 75640, 25, 4
	UNION SELECT 75641, 25, 3
	UNION SELECT 75642, 25, 2
	UNION SELECT 75643, 25, 1
)
INSERT INTO [dbo].[LogActionDetail]([ActionID],[ProductID],[Level])
SELECT [ActionID],		[ProductID],	[Level]
FROM T
	