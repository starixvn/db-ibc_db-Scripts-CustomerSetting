/*
	Created: Johnson
	Date: 2019-12-06
	Task: delete profile setting for sport 18C of NG2	
	DB: DBCUST/CUSTDB
*/

DELETE ProductSettingDetail WITH(UPDLOCK,ROWLOCK) 
WHERE SportType = 216


DELETE ProductBetSetting  WITH(UPDLOCK,ROWLOCK)
WHERE Sporttype = 216

