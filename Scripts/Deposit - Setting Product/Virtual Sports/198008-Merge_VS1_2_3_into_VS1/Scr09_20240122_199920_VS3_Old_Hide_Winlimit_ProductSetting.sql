/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20240122@Tacy
	Task: Hide VS3 (old) - [Winlimit_ProductSetting]
		Redmine: https://nexdev.net/issues/199920
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

UPDATE Winlimit_ProductSetting WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=2
WHERE ProductID=49
GO