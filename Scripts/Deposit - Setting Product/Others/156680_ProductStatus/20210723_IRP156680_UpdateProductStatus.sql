/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210723
	Task: update Dep_ProductSettingDetail
	DB: DBCust/CustDB
*/

update Dep_ProductSettingDetail WITH(UPDLOCK)
set SettingStatus = 0
where ProductSettingID in (56,58,29,31)		
