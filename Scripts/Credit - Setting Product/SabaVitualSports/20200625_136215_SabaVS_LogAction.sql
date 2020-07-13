/*<info serverAlias=DBLOG-bodb_CustomerLog ></info>*/
/*
    Created: Winfred
    Date: 20200623
    Task: Manage ProductLaunchSiteCurrency / Can See : #131241
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO

DELETE FROM LogAction
WHERE ActionID IN (60528,60529,65556,65557,65558,65559,70584,70585,70586,70587,70588,70589,75612,75613,75614,75615,75616,75617,75618,75619)

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
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	60529
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'更新Saba Virtual Sports產品狀態於超級總代理'
	,N'更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super'
	,N'Update Product Status of Saba Virtual Sports on Super')
--Master	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65556
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin')

INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65557
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於總代理'
	,N'管理员更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin')
	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65558
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'更新Saba Virtual Sports產品狀態於超級總代理'
	,N'更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super'
	,N'Update Product Status of Saba Virtual Sports on Super')
		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	65559
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'更新Saba Virtual Sports產品狀態於總代理'
	,N'更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master'
	,N'Update Product Status of Saba Virtual Sports on Master')
-- Agent	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70584
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70585
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於總代理'
	,N'管理员更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70586
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於代理'
	,N'管理员更新Saba Virtual Sports产品状态于代理'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Agent bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70587
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'更新Saba Virtual Sports產品狀態於超級總代理'
	,N'更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super'
	,N'Update Product Status of Saba Virtual Sports on Super')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70588
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'更新Saba Virtual Sports產品狀態於總代理'
	,N'更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master'
	,N'Update Product Status of Saba Virtual Sports on Master')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	70589
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'更新Saba Virtual Sports產品狀態於代理'
	,N'更新Saba Virtual Sports产品状态于代理'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน เอเย่นต์'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Agent'
	,N'Update Product Status of Saba Virtual Sports on Agent')	

-- Member	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75612
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於超級總代理'
	,N'管理员更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Super by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75613
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於總代理'
	,N'管理员更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Master by Admin')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75614
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於代理'
	,N'管理员更新Saba Virtual Sports产品状态于代理'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน เอเย่นต์ โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Agent bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Agent by Admin')		
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75615
	,5
	,'Acc_Admin_DisableNewProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Member by Admin'
	,N'管理員更新Saba Virtual Sports產品狀態於會員'
	,N'管理员更新Saba Virtual Sports产品状态于会员'
	,N'Update Product Status of Saba Virtual Sports on Member by Admin'
	,N'Update Product Status of Saba Virtual Sports on Member by Admin'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน สมาชิก โดย แอดมิน'
	,N'Update Product Status of Saba Virtual Sports on Member by Admin'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Người chơi bởi Admin'
	,N'Update Product Status of Saba Virtual Sports on Member by Admin')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75616
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'更新Saba Virtual Sports產品狀態於超級總代理'
	,N'更新Saba Virtual Sports产品状态于超级总代理'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน ซุปเปอร์'
	,N'Update Product Status of Saba Virtual Sports on Super'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Super'
	,N'Update Product Status of Saba Virtual Sports on Super')	
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75617
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'更新Saba Virtual Sports產品狀態於總代理'
	,N'更新Saba Virtual Sports产品状态于总代理'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน มาสเตอร์'
	,N'Update Product Status of Saba Virtual Sports on Master'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Master'
	,N'Update Product Status of Saba Virtual Sports on Master')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75618
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'更新Saba Virtual Sports產品狀態於代理'
	,N'更新Saba Virtual Sports产品状态于代理'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน เอเย่นต์'
	,N'Update Product Status of Saba Virtual Sports on Agent'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Agent'
	,N'Update Product Status of Saba Virtual Sports on Agent')
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],[ActionNameEN],[ActionNameCH],[ActionNameCS],[ActionNameJP],[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
VALUES (
	75619
	,5
	,'Acc_CustSetting_DisableProductStatusUpd'
	,N'Update Product Status of Saba Virtual Sports on Member'
	,N'更新Saba Virtual Sports產品狀態於會員'
	,N'更新Saba Virtual Sports产品状态于会员'
	,N'Update Product Status of Saba Virtual Sports on Member'
	,N'Update Product Status of Saba Virtual Sports on Member'
	,N'อัปเดตสถานะโปรดัก Saba Virtual Sports บน สมาชิก'
	,N'Update Product Status of Saba Virtual Sports on Member'
	,NULL
	,0
	,N'Cập nhật trạng thái sản phẩm Saba Virtual Sports cho Người chơi'
	,N'Update Product Status of Saba Virtual Sports on Member')					