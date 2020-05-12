/*
	Created: 20191223@Eden
	Task: Prepare for log status of Virtual Games [#RM:122743]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, 38, 60520,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 38, 60521,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, 38, 65540,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 65541,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 38, 65542,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 65543,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, 38, 70560,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 70561,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 38, 70562,'Update Product Status of Virtual Games on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 38, 70563,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 70564,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 38, 70565,'Update Product Status of Virtual Games on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, 38, 75580,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 75581,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 38, 75582,'Update Product Status of Virtual Games on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 38, 75583,'Update Product Status of Virtual Games on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 38, 75584,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 38, 75585,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 38, 75586,'Update Product Status of Virtual Games on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 38, 75587,'Update Product Status of Virtual Games on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log