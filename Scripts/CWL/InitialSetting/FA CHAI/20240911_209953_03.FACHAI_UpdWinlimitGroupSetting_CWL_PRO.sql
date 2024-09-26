/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240911@Virgil
	Task: CWL - FA CHAI - Integrate Promotion [Redmine: #209953]
	Database:	DBCUST-CustDB
*/

DECLARE @ProductId TINYINT = 89,
		@BettypeID SMALLINT = 11399,
		@GroupName VARCHAR(200) = 'FA CHAI',
		@GroupID INT = 74;

DELETE FROM Winlimit_Group
WHERE GroupID = @GroupID

UPDATE X 
SET GroupName = 'FA CHAI - Normal Games'
FROM Winlimit_ProductGlobalSetting X WITH(ROWLOCK,UPDLOCK)
WHERE ProductId = @ProductId 
	AND GroupName = @GroupName


DELETE FROM Winlimit_ProductGlobalSetting 
WHERE ProductId = @ProductId 
	AND BetTypeID = @BettypeID
	AND GroupID = @GroupID

DELETE FROM WinLimit_ProductSettingDetail 
WHERE ProductId = @ProductId 
	AND GroupID = @GroupID