/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240229 
	Task: Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBCUST/CustDB
*/

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT @ProductID = 78,
		@Sporttype = 216,
		@Bettype = 10000

UPDATE psd
SET psd.SettingStatus = 0
FROM Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype