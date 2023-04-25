/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221003@Johnson
	Task: Update status = ON for Cricket & Saba Cricket [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

UPDATE [Dep_ProductSettingDetail]
SET SettingStatus = 0
WHERE ProductSettingID  IN (154,155)
        