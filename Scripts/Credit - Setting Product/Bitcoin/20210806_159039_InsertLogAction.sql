/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210806@Winfred
	Task: Prepare for log status of Bitcoin [#RedmineID:#159039]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 69

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60532,'Update Product Status of Bitcoin on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60533,'Update Product Status of Bitcoin on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65564,'Update Product Status of Bitcoin on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65565,'Update Product Status of Bitcoin on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65566,'Update Product Status of Bitcoin on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65567,'Update Product Status of Bitcoin on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70600,'Update Product Status of Bitcoin on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70601,'Update Product Status of Bitcoin on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70602,'Update Product Status of Bitcoin on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70603,'Update Product Status of Bitcoin on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70604,'Update Product Status of Bitcoin on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70605,'Update Product Status of Bitcoin on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75628,'Update Product Status of Bitcoin on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75629,'Update Product Status of Bitcoin on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75630,'Update Product Status of Bitcoin on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75631,'Update Product Status of Bitcoin on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75632,'Update Product Status of Bitcoin on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75633,'Update Product Status of Bitcoin on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75634,'Update Product Status of Bitcoin on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75635,'Update Product Status of Bitcoin on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

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