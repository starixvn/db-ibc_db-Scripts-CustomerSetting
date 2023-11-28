/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231116@Johnson
	Task: Seal Entertainment - Incorporate to Licensee Sites [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0
WHERE ProductSettingID IN (159,160)