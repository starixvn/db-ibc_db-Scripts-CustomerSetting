/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231107
	Task: WE Live Casino - Implement customer setting - Initial setting [Redmine: #195886]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT,
		@Bettype SMALLINT
SELECT @Sporttype = 228,
		@Bettype = 10300

UPDATE psd WITH (ROWLOCK, UPDLOCK)
SET psd.SettingStatus = 0
FROM Dep_ProductSettingDetail psd
WHERE SportType = @Sporttype AND BetType = @Bettype
