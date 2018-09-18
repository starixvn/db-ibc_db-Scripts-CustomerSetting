/*
	Created: 20180918@Winnie
	Task: Prepare for log status of SportsBook2
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, 16, 60518,'Update Product Status of Sportsbook 2 on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 16, 60519,'Update Product Status of Sportsbook 2 on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, 16, 65536,'Update Product Status of Sportsbook 2 on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 65537,'Update Product Status of Sportsbook 2 on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 16, 65538,'Update Product Status of Sportsbook 2 on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 65539,'Update Product Status of Sportsbook 2 on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, 16, 70554,'Update Product Status of Sportsbook 2 on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 70555,'Update Product Status of Sportsbook 2 on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 16, 70556,'Update Product Status of Sportsbook 2 on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 16, 70557,'Update Product Status of Sportsbook 2 on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 70558,'Update Product Status of Sportsbook 2 on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 16, 70559,'Update Product Status of Sportsbook 2 on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, 16, 75572,'Update Product Status of Sportsbook 2 on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 75573,'Update Product Status of Sportsbook 2 on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 16, 75574,'Update Product Status of Sportsbook 2 on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 16, 75575,'Update Product Status of Sportsbook 2 on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 16, 75576,'Update Product Status of Sportsbook 2 on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 16, 75577,'Update Product Status of Sportsbook 2 on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 16, 75578,'Update Product Status of Sportsbook 2 on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 16, 75579,'Update Product Status of Sportsbook 2 on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log