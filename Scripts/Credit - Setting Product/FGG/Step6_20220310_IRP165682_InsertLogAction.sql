/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220310@Johnson
	Task: Prepare for log status of Virtual Games [#RedmineID:#165682]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 5, @IsInternal BIT = 0, @ProductId TINYINT = 64

INSERT INTO @Log (Level, ProductID, ActionID, ActionName, SPName)
SELECT 4, @ProductId, 60538,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 60539,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-----------------------------
SELECT 4, @ProductId, 65576,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65577,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 65578,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 65579,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

-------------------
SELECT 4, @ProductId, 70618,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70619,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70620,'Update Product Status of Virtual Games on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 70621,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 70622,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 70623,'Update Product Status of Virtual Games on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL

---------------------
SELECT 4, @ProductId, 75652,'Update Product Status of Virtual Games on Super by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75653,'Update Product Status of Virtual Games on Master by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75654,'Update Product Status of Virtual Games on Agent by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75655,'Update Product Status of Virtual Games on Member by Admin','Acc_Admin_DisableNewProductStatusUpd' UNION ALL
SELECT 4, @ProductId, 75656,'Update Product Status of Virtual Games on Super','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 3, @ProductId, 75657,'Update Product Status of Virtual Games on Master','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 2, @ProductId, 75658,'Update Product Status of Virtual Games on Agent','Acc_CustSetting_DisableNewProductStatusUpd' UNION ALL
SELECT 1, @ProductId, 75659,'Update Product Status of Virtual Games on Member','Acc_CustSetting_DisableNewProductStatusUpd' 

DELETE FROM LogAction  WHERE ActionID  IN (SELECT ActionID FROM @Log)
DELETE FROM LogActionDetail  WHERE ActionID  IN (SELECT ActionID FROM @Log)

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN,ActionNameIT)
SELECT ActionID, SPName, @ActionTypeID, ActionName, ActionName, ActionName, ActionName, ActionName, ActionName, @IsInternal, ActionName, ActionName, ActionName
FROM @Log

--update translate by old virtual games product
;WITH T AS (
	SELECT 60520 as VGID, 60538 as VGID_New
	UNION ALL SELECT 60521, 60539
	UNION ALL SELECT 65540, 65576
	UNION ALL SELECT 65541, 65577
	UNION ALL SELECT 65542, 65578
	UNION ALL SELECT 65543, 65579
	
	-------------------
	UNION ALL SELECT 70560, 70618
	UNION ALL SELECT 70561, 70619
	UNION ALL SELECT 70562, 70620
	UNION ALL SELECT 70563, 70621
	UNION ALL SELECT 70564, 70622
	UNION ALL SELECT 70565, 70623
	
    ---------------------
    UNION ALL SELECT 75580, 75652
    UNION ALL SELECT 75581, 75653
    UNION ALL SELECT 75582, 75654
    UNION ALL SELECT 75583, 75655
    UNION ALL SELECT 75584, 75656
    UNION ALL SELECT 75585, 75657
    UNION ALL SELECT 75586, 75658
    UNION ALL SELECT 75587, 75659
)
UPDATE l
SET l.ActionNameCH = ISNULL(l2.ActionNameCH,l.ActionNameCH),
	l.ActionNameCS = ISNULL(l2.ActionNameCS,l.ActionNameCS),
	l.ActionNameJP = ISNULL(l2.ActionNameJP,l.ActionNameJP),
	l.ActionNameTH = ISNULL(l2.ActionNameTH,l.ActionNameTH),
	l.ActionNameKO = ISNULL(l2.ActionNameKO,l.ActionNameKO),
	l.ActionNameVI = ISNULL(l2.ActionNameVI,l.ActionNameVI),
	l.ActionNameCN = ISNULL(l2.ActionNameCN,l.ActionNameCN),
	l.ActionNameIT = ISNULL(l2.ActionNameIT,l.ActionNameIT)
FROM LogAction l WITH(ROWLOCK)
	INNER JOIN T ON l.ActionID = VGID_New
	INNER JOIN LogAction l2 ON l2.ActionID = VGID


INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log


SELECT * FROM LogAction WITH(NOLOCK) WHERE ActionID  IN (SELECT ActionID FROM @Log)
SELECT * FROM LogActionDetail WITH(NOLOCK) WHERE ActionID  IN (SELECT ActionID FROM @Log)