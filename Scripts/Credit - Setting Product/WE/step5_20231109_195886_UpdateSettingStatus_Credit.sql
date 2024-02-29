/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231109
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype	SMALLINT	= 228,
		@Bettype	SMALLINT	= 10300

UPDATE psp 
SET psp.CreationStatus = 0, psp.SettingStatus = 0
FROM ProductSettingProfile psp WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype

UPDATE psd
SET psd.SettingStatus = 0
FROM ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype