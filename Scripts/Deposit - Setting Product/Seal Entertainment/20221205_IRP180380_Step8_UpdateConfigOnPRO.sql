/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221205
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0
WHERE ProductSettingID IN (159,160,161)