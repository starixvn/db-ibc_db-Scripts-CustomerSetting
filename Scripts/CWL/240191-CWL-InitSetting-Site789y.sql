/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20251016@July
	Task:	CWL - Add init currency setting cho site 789y [Redmine: #240191]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20251016@July:	CWL - Add init currency setting cho site 789y [Redmine: #240191]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
--ONLY SIT
USE CustDB
GO
DECLARE @ProductID INT, @SiteId INT
DECLARE @ProductIds VARCHAR(MAX) = '6,21,22,28,32,34,36,38,39,42,45,46,50,51,52,56,57,60,61,62,63,65,66,67,68,69,70,72,73,75'
--26: Lucky3 (Removed)
DECLARE @SiteIds VARCHAR(MAX) = '1046,1047,1048,1045' --SiteLabel = '789y'

DECLARE @tmp_SiteIds TABLE (SiteId INT, IsFinish BIT DEFAULT(0))
INSERT INTO @tmp_SiteIds (SiteId)
SELECT value
FROM STRING_SPLIT(@SiteIds, ',')
WHERE value <> ''

DECLARE @tmp_ProductId_Loss TABLE (ProductId INT, IsFinish BIT DEFAULT(0))
INSERT INTO @tmp_ProductId_Loss (ProductId)
SELECT value
FROM STRING_SPLIT(@ProductIds, ',')
WHERE value <> ''

WHILE (1=1)
BEGIN
		UPDATE @tmp_SiteIds SET IsFinish = 0

		UPDATE TOP (1) @tmp_ProductId_Loss
		SET	 IsFinish =1 
			,@ProductID = ProductId
		WHERE IsFinish = 0
    
		IF @@ROWCOUNT = 0 BREAK;
		
		WHILE (1=1)
		BEGIN
			UPDATE TOP (1) @tmp_SiteIds
			SET	 IsFinish =1 
				,@SiteId = SiteId
			WHERE IsFinish = 0
    
			IF @@ROWCOUNT = 0 BREAK;
		
			INSERT INTO WinLimit_ProductSettingDetail(ProductID
												, GroupID
												, ExchangeID
												, SiteID
												, LevelID
												, IsBlockedPlaceBet
												, IsBlockedTransfer
												, IsSuspendedAccount
												, MaxWinLimit_RM
												, MaxWinLimit
												, RepUpdateTime)
			SELECT ProductID
				 , GroupID
				 , ExchangeID
				 , @SiteId AS SiteID
				 , LevelID
				 , IsBlockedPlaceBet
				 , IsBlockedTransfer
				 , IsSuspendedAccount
				 , MaxWinLimit_RM
				 , MaxWinLimit
				 , dbo.f_GetDateTime2() 
			FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
			WHERE ProductId = @ProductID AND SiteID = 3 --789y (Old)
		END
END
GO
DELETE FROM dbo.WinLimit_ProductSettingDetail WHERE SiteID = 3 --789y (Old)


