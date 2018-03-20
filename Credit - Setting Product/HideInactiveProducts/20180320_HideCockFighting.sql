/*	
	Created: 20170320@Winnie
	Task: Hide cock fighting
	Redmine: https://redmine.nexcel.vn/issues/86086
	DB: DBCUST/CUSTDB
*/

UPDATE ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
SET SettingStatus=2 WHERE ProductID=19