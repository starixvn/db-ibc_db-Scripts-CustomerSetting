/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210324
	Task: Update SettingStatus = 0 (ENABLE) for Creative Gaming [Redmine: 146016]
	DB: DBCUST/CustDB
	P/s : Step 9 Show product Creative Gaming
*/ 
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 7301,@SportType = 167

UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
