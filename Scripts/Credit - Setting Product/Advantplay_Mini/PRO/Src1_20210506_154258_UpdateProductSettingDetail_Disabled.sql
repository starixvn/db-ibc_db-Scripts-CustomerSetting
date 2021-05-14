/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task: Update SettingStatus = 2 (DISABLED) for AdvantPlay [Redmine: 154258]
	DB: DBCUST/CustDB
	P/s : Step 1 Hide product AdvantPlay
*/ 
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 7701,@SportType = 172

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 