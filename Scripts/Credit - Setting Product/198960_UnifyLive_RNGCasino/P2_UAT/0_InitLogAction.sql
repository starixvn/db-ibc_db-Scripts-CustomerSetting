/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Log Action  [#198960] 
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO
	-- Initial data Log Action: ProductStatus
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID IN (60541,60540,65582,65580,70627,70624,75660,75664,75661,65581,70625,65583,75665,70628,70626,70629,75666,75662,75663,75667) )
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
		 SELECT 60541 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Super by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 60540 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status for Super'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status for Super'  AS ActionNameJP , N'Update Other Products Product Status for Super'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status for Super'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status for Super'  AS ActionNameCN   
	 UNION SELECT 65582 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Super by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 65580 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super'  AS ActionNameJP , N'Update Other Products Product Status on Super'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super'  AS ActionNameCN   
	 UNION SELECT 70627 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Super by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 70624 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super'  AS ActionNameJP , N'Update Other Products Product Status on Super'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super'  AS ActionNameCN   
	 UNION SELECT 75660 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Super by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 75664 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Super'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Super'  AS ActionNameJP , N'Update Other Products Product Status on Super'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Super'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Super'  AS ActionNameCN   
	 UNION SELECT 75661 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Master by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 65581 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master'  AS ActionNameJP , N'Update Other Products Product Status on Master'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master'  AS ActionNameCN   
	 UNION SELECT 70625 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master'  AS ActionNameJP , N'Update Other Products Product Status on Master'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master'  AS ActionNameCN   
	 UNION SELECT 65583 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Master by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master by Admin'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 75665 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master'  AS ActionNameJP , N'Update Other Products Product Status on Master'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master'  AS ActionNameCN   
	 UNION SELECT 70628 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Master by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Master by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Master by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Master by Admin'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 70626 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Agent'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Agent'  AS ActionNameJP , N'Update Other Products Product Status on Agent'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Agent'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Agent'  AS ActionNameCN   
	 UNION SELECT 70629 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Agent by Admin'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Agent by Admin'  AS ActionNameCN   
	 UNION SELECT 75666 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Agent'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Agent'  AS ActionNameJP , N'Update Other Products Product Status on Agent'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Agent'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Agent'  AS ActionNameCN   
	 UNION SELECT 75662 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Agent by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Agent by Admin'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Agent by Admin'  AS ActionNameCN   
	 UNION SELECT 75663 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Member by Admin'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Member by Admin'  AS ActionNameJP , N'Update Other Products Product Status on Member by Admin'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Member by Admin'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Member by Admin'  AS ActionNameCN   
	 UNION SELECT 75667 AS ActionID , 5  AS ActionTypeID , N'Acc_CustSetting_DisableProductStatus_160_Upd' AS SPName , N'Update Other Products Product Status on Member'  AS ActionNameEN , N'更新Other Products產品狀態於超級總代理' AS ActionNameCH , N'更新Other Products产品状态于超级总代理' AS ActionNameCS , N'Update Other Products Product Status on Member'  AS ActionNameJP , N'Update Other Products Product Status on Member'  AS ActionNameIT, N'อัปเดตสถานะโปรดัก Other Products บน ซุปเปอร์'  AS ActionNameTH, N'Update Other Products Product Status on Member'  AS ActionNameKO , N'' AS XsltContent , 0 AS IsInternal, N'Cập nhật trạng thái sản phẩm Other Products cho Super' AS ActionNameVI, N'Update Other Products Product Status on Member'  AS ActionNameCN   
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
	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID IN (525,528,529,534,524,526,531,533,523,527,530,532) )
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
				CASE 
					 WHEN ActionID = 513 THEN   525 
					 WHEN ActionID = 516 THEN   528 
					 WHEN ActionID = 517 THEN   529 
					 WHEN ActionID = 522 THEN   534 
					 WHEN ActionID = 512 THEN   524 
					 WHEN ActionID = 514 THEN   526 
					 WHEN ActionID = 519 THEN   531 
					 WHEN ActionID = 521 THEN   533 
					 WHEN ActionID = 511 THEN   523 
					 WHEN ActionID = 515 THEN   527 
					 WHEN ActionID = 518 THEN   530 
					 WHEN ActionID = 520 THEN   532 
				END ActionID
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
		FROM LogAction la WITH (NOLOCK)
		WHERE la.SPName IN (
					 'Acc_CustSetting_AgentPTOnMember_153_MultiUpd', 
					 'Acc_CustSetting_AgentPTOnMember_153_Upd', 
					 'Acc_CustSetting_AgentPT_153_Upd', 
					 'Acc_CustSetting_AgentMinPT_153_Upd', 
					 'Acc_CustSetting_MasterPT_153_Upd', 
					 'Acc_CustSetting_MasterPTOnMember_153_MultiUpd', 
					 'Acc_CustSetting_MasterPTOnMember_153_Upd', 
					 'Acc_CustSetting_MasterMinPT_153_Upd', 
					 'Acc_CustSetting_SuperPT_153_Upd', 
					 'Acc_CustSetting_SuperPTOnMember_153_MultiUpd', 
					 'Acc_CustSetting_SuperPTOnMember_153_Upd', 
					 'Acc_CustSetting_SuperMinPT_153_Upd' )

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


