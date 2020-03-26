/*
	Created: 20200321@Elodie
	Task: Prepare for log status of Saba.club [#RM:130636]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 42

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60524,'Update Product Status of Saba.club on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60525,'Update Product Status of Saba.club on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65548,'Update Product Status of Saba.club on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65549,'Update Product Status of Saba.club on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65550,'Update Product Status of Saba.club on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65551,'Update Product Status of Saba.club on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70572,'Update Product Status of Saba.club on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70573,'Update Product Status of Saba.club on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70574,'Update Product Status of Saba.club on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70575,'Update Product Status of Saba.club on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70576,'Update Product Status of Saba.club on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70577,'Update Product Status of Saba.club on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75596,'Update Product Status of Saba.club on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75597,'Update Product Status of Saba.club on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75598,'Update Product Status of Saba.club on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75599,'Update Product Status of Saba.club on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75600,'Update Product Status of Saba.club on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75601,'Update Product Status of Saba.club on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75602,'Update Product Status of Saba.club on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75603,'Update Product Status of Saba.club on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log
