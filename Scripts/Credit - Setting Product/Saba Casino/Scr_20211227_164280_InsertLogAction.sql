/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220112@Eden
	Task: logAction forSaba Casino [#RedmineID:#164280]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 6

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60536,'Update Product Status of Saba Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60537,'Update Product Status of Saba Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65572,'Update Product Status of Saba Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65573,'Update Product Status of Saba Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65574,'Update Product Status of Saba Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65575,'Update Product Status of Saba Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70612,'Update Product Status of Saba Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70613,'Update Product Status of Saba Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70614,'Update Product Status of Saba Casino on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70615,'Update Product Status of Saba Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70616,'Update Product Status of Saba Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70617,'Update Product Status of Saba Casino on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75644,'Update Product Status of Saba Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75645,'Update Product Status of Saba Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75646,'Update Product Status of Saba Casino on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75647,'Update Product Status of Saba Casino on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75648,'Update Product Status of Saba Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75649,'Update Product Status of Saba Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75650,'Update Product Status of Saba Casino on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75651,'Update Product Status of Saba Casino on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

DELETE FROM LogAction  WHERE ActionID  IN (SELECT ActionID FROM @Log)
DELETE FROM LogActionDetail  WHERE ActionID  IN (SELECT ActionID FROM @Log)

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log

UPDATE a
SET a.ActionNameCH = b.ActionNameCH, a.ActionNameCS = b.ActionNameCS , a.ActionNameTH = b.ActionNameTH,a.ActionNameVI = b.ActionNameVI
FROM LogAction a
INNER JOIN LogAction b WITH(NOLOCK)  ON a.ActionTypeID = b.ActionTypeID AND b.ActionID = 384
WHERE a.ActionID = 395


SELECT * FROM LogAction WITH(NOLOCK) WHERE ActionID  IN (SELECT ActionID FROM @Log)
SELECT * FROM LogActionDetail WITH(NOLOCK) WHERE ActionID  IN (SELECT ActionID FROM @Log)
