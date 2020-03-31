/*
	Created: 20200321@Elodie
	Task: Prepare for log status of Saba.club [#RM:130636]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 44

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60526,'Update Product Status of RNG Lottery on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60527,'Update Product Status of RNG Lottery on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65552,'Update Product Status of RNG Lottery on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65553,'Update Product Status of RNG Lottery on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65554,'Update Product Status of RNG Lottery on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65555,'Update Product Status of RNG Lottery on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70578,'Update Product Status of RNG Lottery on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70579,'Update Product Status of RNG Lottery on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70580,'Update Product Status of RNG Lottery on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70581,'Update Product Status of RNG Lottery on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70582,'Update Product Status of RNG Lottery on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70583,'Update Product Status of RNG Lottery on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75604,'Update Product Status of RNG Lottery on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75605,'Update Product Status of RNG Lottery on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75606,'Update Product Status of RNG Lottery on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75607,'Update Product Status of RNG Lottery on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75608,'Update Product Status of RNG Lottery on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75609,'Update Product Status of RNG Lottery on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75610,'Update Product Status of RNG Lottery on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75611,'Update Product Status of RNG Lottery on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

--DELETE l 
--FROM LogAction l 
--	INNER JOIN @Log ld ON l.ActionID = ld.ActionID 

--DELETE ld
--FROM LogActionDetail ld 
--	INNER JOIN @Log l ON l.ActionID = ld.ActionID 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log

SELECT * 
FROM LogAction l 
	INNER JOIN LogActionDetail ld ON l.ActionID = ld.ActionID 
WHERE ld.ProductID = 44

SELECT *
FROM LogActionDetail ld 
WHERE ld.ProductID = 44


