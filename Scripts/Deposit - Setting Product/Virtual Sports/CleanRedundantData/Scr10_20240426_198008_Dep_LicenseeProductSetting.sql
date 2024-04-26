/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Tacy@20240426
	Task: Deposit - Clean VS1, VS2, VS3 - Dep_LicenseeProductSetting - [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
----------------------------------------------------------------------------------------------
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT)

-----------------------------------------------------------------------------------------------
INSERT INTO #Dep_ProductSettingDetail(ProductSettingID,SettingType, SportType, BetType)
SELECT psd.ProductSettingID, SettingType, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID IN (5,27,77,49) 
	AND ps.ProductSettingID NOT BETWEEN 182 AND 185 --New VS setting

DELETE cs
FROM Dep_LicenseeProductSetting  cs WITH (ROWLOCK) 
	CROSS APPLY (SELECT TOP 1 ProductSettingID
					FROM #Dep_ProductSettingDetail s 
					WHERE cs.ProductSettingID=s.ProductSettingID) T
GO