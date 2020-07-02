/*<info serverAlias=DBLOG-bodb_CustomerLog ></info>*/
/*
    Created: Winfred
    Date: 20200623
    Task: Manage ProductLaunchSiteCurrency / Can See : #131241
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO
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
	60528
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	60529
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'更新Saba Virtual Sport產品狀態於超級總代理'
	,N'更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super'
	,N'Update Product Status of Saba Virtual Sport on Super')
--Master	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65556
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin')

INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65557
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於總代理'
	,N'管理员更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65558
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'更新Saba Virtual Sport產品狀態於超級總代理'
	,N'更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super'
	,N'Update Product Status of Saba Virtual Sport on Super')
		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65559
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'更新Saba Virtual Sport產品狀態於總代理'
	,N'更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master'
	,N'Update Product Status of Saba Virtual Sport on Master')
-- Agent	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70584
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70585
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於總代理'
	,N'管理员更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70586
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於代理'
	,N'管理员更新Saba Virtual Sport产品状态于代理'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Agent bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70587
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'更新Saba Virtual Sport產品狀態於超級總代理'
	,N'更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super'
	,N'Update Product Status of Saba Virtual Sport on Super')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70588
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'更新Saba Virtual Sport產品狀態於總代理'
	,N'更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master'
	,N'Update Product Status of Saba Virtual Sport on Master')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70589
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'更新Saba Virtual Sport產品狀態於代理'
	,N'更新Saba Virtual Sport产品状态于代理'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน เอเย่นต์'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Agent'
	,N'Update Product Status of Saba Virtual Sport on Agent')	

-- Member	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75612
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Super by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75613
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於總代理'
	,N'管理员更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Master by Admin')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75614
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於代理'
	,N'管理员更新Saba Virtual Sport产品状态于代理'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Agent bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Agent by Admin')		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75615
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Member by Admin'
	,N'管理員更新Saba Virtual Sport產品狀態於會員'
	,N'管理员更新Saba Virtual Sport产品状态于会员'
	,N'Update Product Status of Saba Virtual Sport on Member by Admin'
	,N'Update Product Status of Saba Virtual Sport on Member by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน สมาชิก โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sport on Member by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Người chơi bởi Admin'
	,N'Update Product Status of Saba Virtual Sport on Member by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75616
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'更新Saba Virtual Sport產品狀態於超級總代理'
	,N'更新Saba Virtual Sport产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sport on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Super'
	,N'Update Product Status of Saba Virtual Sport on Super')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75617
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'更新Saba Virtual Sport產品狀態於總代理'
	,N'更新Saba Virtual Sport产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sport on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Master'
	,N'Update Product Status of Saba Virtual Sport on Master')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75618
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'更新Saba Virtual Sport產品狀態於代理'
	,N'更新Saba Virtual Sport产品状态于代理'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน เอเย่นต์'
	,N'Update Product Status of Saba Virtual Sport on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Agent'
	,N'Update Product Status of Saba Virtual Sport on Agent')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75619
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sport on Member'
	,N'更新Saba Virtual Sport產品狀態於會員'
	,N'更新Saba Virtual Sport产品状态于会员'
	,N'Update Product Status of Saba Virtual Sport on Member'
	,N'Update Product Status of Saba Virtual Sport on Member'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sport บน สมาชิก'
	,N'Update Product Status of Saba Virtual Sport on Member'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sport cho Người chơi'
	,N'Update Product Status of Saba Virtual Sport on Member')					