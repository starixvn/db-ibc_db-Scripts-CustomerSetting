/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: Hide Bet Limit - VGaming & Virtual Games product
		https://nexdev.net/issues/205654
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
USE CustDB
GO

--Dep_ProductSettingDetail
UPDATE psd
SET SettingStatus=2
FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE SettingType IN (7,8) AND SettingStatus <> 2
AND SportType IN (171,245)
GO