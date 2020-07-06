/*
	Created: Helen
	Date: 2020-07-03
	Task: Insert profile for licensee when offer comm AB,Macau,PP, Fishing World
	DB: DBCUST/CustDB
*/
-- Remove Allbet comm setting
USE CustDB
GO
DELETE Dep_ProductSetting 
WHERE productid = 21 AND ProductSettingID = 18 AND SettingType = 9
GO
DELETE Dep_ProductSettingDetail
WHERE productSettingID = 18
GO
DELETE Dep_LicenseeProductSetting
WHERE ProductSettingID = 18
GO