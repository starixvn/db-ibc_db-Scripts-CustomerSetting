/*
	Created: 20200703@Eden
	Task: CustSettingAutoSuspend - Convert Binary Data for Esport [Redmine: #134978]
	DB: DBCUST/CustDB
*/
USE CustDB
DECLARE @SportType INT = 43
DECLARE @InitialBitMap VARBINARY(30) = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
DECLARE @ExtraBinary VARBINARY(10) = 0xFFFFFFFFFFFFFFFFFFFF

UPDATE t 
SET t.AutoSuspendLive = CONVERT(VARBINARY(20),t.AutoSuspendLive) + @ExtraBinary ,
	t.AutoSuspendNonLive = CONVERT(VARBINARY(20),t.AutoSuspendNonLive) + @ExtraBinary 
FROM CustSettingAutoSuspend t WITH(ROWLOCK, UPDLOCK)
WHERE t.SportType = @SportType

DELETE 
FROM CustSettingAutoSuspend WITH(ROWLOCK, UPDLOCK)
WHERE  AutoSuspendLive = @InitialBitMap
	AND AutoSuspendNonLive = @InitialBitMap
	AND SportType = @SportType