/*
	Created: Elodie
	Date: 2019-05-10
	Task: Adjuest cwl settings
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

UPDATE wl
SET wl.IsBlockedTransfer = 1
FROM WinLimit_ProductSettingDetail wl WITH (NOLOCK) 
	INNER JOIN Site s WITH (NOLOCK) ON wl.SiteID = s.siteid
	INNER join Winlimit_ProductGlobalSetting g WITH (NOLOCK) ON g.ProductID = wl.ProductID and g.GroupID = wl.GroupID
WHERE wl.LevelID = 3 AND wl.IsBlockedTransfer = 0
	AND s.isLicensee = 1
	AND g.blockedTransferLvl3 = 1