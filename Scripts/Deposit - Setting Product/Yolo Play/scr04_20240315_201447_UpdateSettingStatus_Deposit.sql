/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240315 
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT 	@Sporttype = 189,
		@Bettype = 3650

UPDATE psd
SET psd.SettingStatus = 0
FROM Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype