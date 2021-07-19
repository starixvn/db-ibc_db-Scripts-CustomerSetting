/*
	Creator: 20200710@Eden
	Task: Delete redurant Data VRCustSetting - Redmine: #134978
	DB: CustDB@DBCUST
*/
--------step 1 : Run at DBCUST/CUSTDB------------------------
USE CUSTDB
GO
-- Prepare LevelID
DECLARE @SportLevel INT 
SELECT @SportLevel = LevelID 
FROM VRSettingHierarchy WITH(NOLOCK)
WHERE SportType = 2 AND VRLeagueGroupID = -1 AND BetType = -1

--Delete VRCustSetting
WHILE (1=1)
BEGIN
	DELETE TOP (5000) [VRCustSetting] WITH(ROWLOCK) WHERE LevelID >= @SportLevel AND CustID <> 0

	IF @@ROWCOUNT < 5000
		BREAK

	WAITFOR DELAY '00:00:00.100'
END
