/*
	Created by: Winnie
	Date: 2017-12-29
	Task: Update profiler setting data for Exchange Product - [Redmine: #66797]
*/ 

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	


UPDATE Dep_ProductSetting WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=19
WHERE ProductSettingID=20

UPDATE Dep_ProductSetting WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=20
WHERE ProductSettingID=21


UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=19
WHERE ProductSettingID=20

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=20
WHERE ProductSettingID=21