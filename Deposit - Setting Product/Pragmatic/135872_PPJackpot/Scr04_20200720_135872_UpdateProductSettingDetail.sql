/*
	Date: 20200720
	Created: Elodie
	Task: Update Setting Status for PP Jackpot - Deposit [#135872]
	DB: DBCUST/CUSTDB
*/

-----------------------------------------------------------------
/*
SELECT * 
FROM Dep_ProductSetting d (NOLOCK)
INNER JOIN Dep_ProductSettingDetail dp (NOLOCK) ON d.ProductSettingID = dp.ProductSettingID
WHERE Sporttype = 200
*/
DECLARE @Sporttype INT = 248

UPDATE dp
SET dp.SettingStatus = 0 
FROM Dep_ProductSettingDetail dp WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = @Sporttype