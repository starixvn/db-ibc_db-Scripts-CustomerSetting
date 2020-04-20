/*
	Date: 20200420
	Created: Eden
	Task: Update Setting Status for Saba.Club - Deposit [#132698]
	DB: DBCUST/CUSTDB
*/

-----------------------------------------------------------------
/*
SELECT * 
FROM Dep_ProductSetting d (NOLOCK)
INNER JOIN Dep_ProductSettingDetail dp (NOLOCK) ON d.ProductSettingID = dp.ProductSettingID
WHERE Sporttype = 200
*/
DECLARE @Sporttype INT = 200

UPDATE dp
SET dp.SettingStatus = 0 
FROM Dep_ProductSettingDetail dp WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = @Sporttype