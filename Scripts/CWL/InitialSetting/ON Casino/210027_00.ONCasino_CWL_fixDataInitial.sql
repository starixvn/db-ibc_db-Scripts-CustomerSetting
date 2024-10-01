/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240926@Virgil
	Task: CWL - ON Casino - fixSPInitialize [Redmine: #210027]
	Database:	DBCUST-CustDB
*/

DECLARE @ProductId TINYINT = 96,
		@BettypeID SMALLINT = 11850,
		@GroupName VARCHAR(200),
		@GroupID TINYINT;

SELECT @GroupName = ProductName
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

SELECT @GroupID = GroupID
FROM Winlimit_Group
WHERE GroupName = @GroupName


DELETE FROM Winlimit_Group
WHERE GroupID = @GroupID

DELETE FROM Winlimit_ProductGlobalSetting 
WHERE ProductId = @ProductId 
	AND BetTypeID = @BettypeID
	AND GroupID = @GroupID

DELETE FROM WinLimit_ProductSettingDetail 
WHERE ProductId = @ProductId 
	AND GroupID = @GroupID
