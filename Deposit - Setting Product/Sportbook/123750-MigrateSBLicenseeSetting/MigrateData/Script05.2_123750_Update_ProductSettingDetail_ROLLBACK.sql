/*
	Created: Eden
	Date: 20191212
	Task: Update ProductSettingDetail SB,NG,Keno DCS - ROLLBACK [Redmine:#123750]	
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------

USE CustDB

--> SB
UPDATE  a
SET a.SettingStatus = 1
FROM DSB_ProductSettingDetail a WITH(ROWLOCK, UPDLOCK)
	INNER JOIN DSB_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
WHERE b.ProductID = 1

--> NG, Keno
UPDATE a
SET a.SettingStatus = 1
FROM Dep_ProductSettingDetail a WITH(ROWLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
WHERE b.ProductID IN (3,8)