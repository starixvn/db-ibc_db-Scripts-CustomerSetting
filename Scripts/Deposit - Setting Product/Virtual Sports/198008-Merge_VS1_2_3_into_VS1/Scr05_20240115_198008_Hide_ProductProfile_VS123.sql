/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240115 
	Task: Hide old VS1, VS2, VS3 (new & old) setting [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

UPDATE psd 
SET psd.SettingStatus=2
FROM Dep_ProductSetting ps WITH (NOLOCK)
INNER JOIN Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK) ON ps.ProductSettingID=psd.ProductSettingID
WHERE ps.ProductID in (5,27,77,49) AND ps.ProductSettingID NOT BETWEEN 182 AND 185
GO