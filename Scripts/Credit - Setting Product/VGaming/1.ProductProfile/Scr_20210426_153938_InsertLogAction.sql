/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210426@Eden
	Task: Prepare for log status of VGaming [#RM:153938]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 66

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60530,'Update Product Status of VGaming on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60531,'Update Product Status of VGaming on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65560,'Update Product Status of VGaming on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65561,'Update Product Status of VGaming on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65562,'Update Product Status of VGaming on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65563,'Update Product Status of VGaming on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70590,'Update Product Status of VGaming on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70591,'Update Product Status of VGaming on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70592,'Update Product Status of VGaming on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70593,'Update Product Status of VGaming on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70594,'Update Product Status of VGaming on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70595,'Update Product Status of VGaming on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75620,'Update Product Status of VGaming on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75621,'Update Product Status of VGaming on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75622,'Update Product Status of VGaming on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75623,'Update Product Status of VGaming on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75624,'Update Product Status of VGaming on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75625,'Update Product Status of VGaming on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75626,'Update Product Status of VGaming on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75627,'Update Product Status of VGaming on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log

SELECT * FROM LogAction WHERE ActionID  IN (SELECT ActionID FROM @Log)
SELECT * FROM LogActionDetail WHERE ActionID  IN (SELECT ActionID FROM @Log)