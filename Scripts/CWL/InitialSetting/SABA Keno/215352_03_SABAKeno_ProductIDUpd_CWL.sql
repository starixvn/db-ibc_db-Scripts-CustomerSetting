/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20241216@Virgil
	Task: CWL - SABA Keno - Integrate New Product [Redmine: #214760]
	Database:	DBCUST/CustDB
	Description: Update ProductID 102
*/
USE CustDB
GO

DECLARE @OldProductID TINYINT = 82,
		@NewProductID TINYINT = 102,
		@Bettype SMALLINT = 12300;
		
DECLARE @GroupID TINYINT, @GroupName VARCHAR(200);	

SELECT @GroupName = ProductName
FROM dbo.Products p WITH (NOLOCK)
WHERE p.ProductID = @NewProductID

SELECT @GroupID = GroupID
FROM Winlimit_Group WITH (NOLOCK)
WHERE GroupName = @GroupName


-- // WinLimit_ProductSetting // --
IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductSetting WITH (NOLOCK)
	WHERE ProductID = @OldProductID 
		AND BettypeID = @Bettype
)
BEGIN
	UPDATE p 
	SET p.ProductID = @NewProductID,
		RepUpdateTime = SYSDATETIME()
	FROM WinLimit_ProductSetting p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @OldProductID 
		AND BettypeID = @Bettype
END

-- // WinLimit_ProductSettingDetail // --
IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
)
BEGIN
	UPDATE p 
	SET p.ProductID = @NewProductID,
		RepUpdateTime = SYSDATETIME()
	FROM WinLimit_ProductSettingDetail p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
END

-- // Winlimit_GameGroupSetting // --
IF EXISTS (
	SELECT TOP 1 1
	FROM Winlimit_GameGroupSetting WITH (NOLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
)
BEGIN
	UPDATE p 
	SET p.ProductID = @NewProductID,
		RepUpdateTime = SYSDATETIME()
	FROM Winlimit_GameGroupSetting p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
END

-- // Winlimit_ProductGlobalSetting // --
IF EXISTS (
	SELECT TOP 1 1
	FROM Winlimit_ProductGlobalSetting WITH (NOLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
)
BEGIN
	UPDATE p 
	SET p.ProductID = @NewProductID
	FROM Winlimit_ProductGlobalSetting p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @OldProductID 
		AND GroupID = @GroupID
END

