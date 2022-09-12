/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Eden@20220912
	Task: Insert missing data: Dep_LicenseeProductSetting [Redmine:#177703]		
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductSettingID1 INT, @ProductSettingID2 INT

SELECT @ProductSettingID1 = CASE WHEN d.SportType = 1 THEN p.ProductSettingID ELSE @ProductSettingID1 END,
		@ProductSettingID2 = CASE WHEN d.SportType = 2 THEN p.ProductSettingID ELSE @ProductSettingID2 END
FROM Dep_ProductSettingDetail d WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK)
		ON p.ProductSettingID = d.ProductSettingID
WHERE p.ProductID = 1
		AND d.SportType IN(1,2)
		AND p.SettingType = 1

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT c1.custid, @ProductSettingID1
FROM dep_custsuper c1  WITH(NOLOCK) 
	INNER JOIN Dep_LicenseeProductSetting c2 WITH(NOLOCK)
		ON c1.custid = c2.CustID and c2.ProductSettingID = @ProductSettingID2
	LEFT JOIN Dep_LicenseeProductSetting c3 WITH(NOLOCK)
		ON c1.custid = c3.CustID and c3.ProductSettingID = @ProductSettingID1
WHERE c3.CustID IS NULL

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT c1.custid, @ProductSettingID2
FROM dep_custsuper c1  WITH(NOLOCK) 
	INNER JOIN Dep_LicenseeProductSetting c2 WITH(NOLOCK)
		ON c1.custid = c2.CustID and c2.ProductSettingID = @ProductSettingID1
	LEFT JOIN Dep_LicenseeProductSetting c3 WITH(NOLOCK)
		ON c1.custid = c3.CustID and c3.ProductSettingID = @ProductSettingID2
WHERE c3.CustID IS NULL