/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210324
	Task: Update SettingStatus = 2 (DISABLED) for Creative Gaming [Redmine: 146016]
	DB: DBCUST/CustDB
	P/s : Step 1 Hide product Creative Gaming
*/ 
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 7301,@SportType = 167

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 