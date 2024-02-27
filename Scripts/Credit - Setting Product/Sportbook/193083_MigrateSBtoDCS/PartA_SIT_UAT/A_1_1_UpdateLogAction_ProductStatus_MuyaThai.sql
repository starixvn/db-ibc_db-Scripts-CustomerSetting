/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230913@Helios
	Task: Initial Data LogAction (Com , BetSetting)  [#193083] 
	DB: DBLOG/bodb_CustomerLog 
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE la.ActionID IN (60542 , 65584 , 65585 , 70630 , 70631 , 70632 , 75668 , 75669 ,75670 , 75671))
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
		 SELECT 60542 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 65584 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 65585 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 70630 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 70631 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 70632 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameCN   
	 UNION SELECT 75668 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Super by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Super by Admin'  AS ActionNameCN   
	 UNION SELECT 75669 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Master by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Master by Admin'  AS ActionNameCN   
	 UNION SELECT 75670 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Agent by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Agent by Admin'  AS ActionNameCN   
	 UNION SELECT 75671 AS ActionID , 5  AS ActionTypeID , N'Acc_Admin_DisableNewProductStatusUpd' AS SPName , N'Update Product Status of Sportsbook on Member by Admin'  AS ActionNameEN , N'Update Product Status of Sportsbook on Member by Admin' AS ActionNameCH , N'Update Product Status of Sportsbook on Member by Admin' AS ActionNameCS , N'Update Product Status of Sportsbook on Member by Admin'  AS ActionNameJP , N'NULL'  AS ActionNameIT, N'Update Product Status of Sportsbook on Member by Admin'  AS ActionNameTH, N'Update Product Status of Sportsbook on Member by Admin'  AS ActionNameKO , N'NULL' AS XsltContent , 0 AS IsInternal, N'Update Product Status of Sportsbook on Member by Admin' AS ActionNameVI, N'Update Product Status of Sportsbook on Member by Admin'  AS ActionNameCN   

		
	END

	IF NOT EXISTS (SELECT 1 FROM LogActionDetail la WITH (NOLOCK) WHERE la.ActionID IN (60542 , 65584 , 65585 , 70630 , 70631 , 70632 , 75668 , 75669 ,75670 , 75671))
	BEGIN
		INSERT INTO LogActionDetail 
		(
			ActionID
		    , ProductID
		    , Level
		)
			SELECT 60542 , 1 , 4  
		UNION SELECT 65584 , 1 , 4  
		UNION SELECT 65585 , 1 , 3  
		UNION SELECT 70630 , 1 , 4  
		UNION SELECT 70631 , 1 , 3  
		UNION SELECT 70632 , 1 , 2  
		UNION SELECT 75668 , 1 , 4  
		UNION SELECT 75669 , 1 , 3  
		UNION SELECT 75670 , 1 , 2  
		UNION SELECT 75671 , 1 , 1  
	END