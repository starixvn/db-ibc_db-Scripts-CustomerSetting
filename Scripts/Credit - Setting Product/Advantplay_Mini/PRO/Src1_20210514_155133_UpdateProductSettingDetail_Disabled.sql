/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task: Update SettingStatus = 2 (DISABLED) for AdvantPlay Mini [Redmine: 155133]
	DB: DBCUST/CustDB
	P/s : Step 1 Hide product AdvantPlay Mini
*/ 
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 7801,@SportType = 174

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 