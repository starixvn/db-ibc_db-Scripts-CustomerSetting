/*
	Created: 20190917@Johnson
	Task: set settingstatus = 0 for lottery
	DB: DBCUST/CUSTDB
*/

update Dep_ProductSettingDetail WITH(UPDLOCK,ROWLOCK)
set SettingStatus = 0
where SportType=  220