/*
	Created: 20200311@Tiara
	Task: Prepare for log status of SA Gaming [#Redmine: 128058]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, 41, 60522,'Update Product Status of Live Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 41, 60523,'Update Product Status of Live Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, 41, 65544,'Update Product Status of Live Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 65545,'Update Product Status of Live Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 41, 65546,'Update Product Status of Live Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 65547,'Update Product Status of Live Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, 41, 70566,'Update Product Status of Live Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 70567,'Update Product Status of Live Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 41, 70568,'Update Product Status of Live Casino on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 41, 70569,'Update Product Status of Live Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 70570,'Update Product Status of Live Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 41, 70571,'Update Product Status of Live Casino on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, 41, 75588,'Update Product Status of Live Casino on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 75589,'Update Product Status of Live Casino on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 41, 75590,'Update Product Status of Live Casino on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 41, 75591,'Update Product Status of Live Casino on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, 41, 75592,'Update Product Status of Live Casino on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, 41, 75593,'Update Product Status of Live Casino on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, 41, 75594,'Update Product Status of Live Casino on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, 41, 75595,'Update Product Status of Live Casino on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log
