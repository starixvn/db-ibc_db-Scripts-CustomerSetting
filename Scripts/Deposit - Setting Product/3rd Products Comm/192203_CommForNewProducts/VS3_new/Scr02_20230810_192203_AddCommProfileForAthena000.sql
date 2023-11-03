/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230807@Tacy
	Task: VS3 (new): Add comm profile setting for Athena000 - UAT
	DB: DBCust/CustDB
*/
USE CustDB
GO

INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY (SELECT ProductSettingID, ProductID
				 FROM Dep_ProductSetting WITH (NOLOCK)
				 WHERE SettingType=9 AND ProductID IN (77)
				) t
	CROSS APPLY (SELECT TOP 1 lp.CustID 
				FROM Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN Dep_ProductSetting pd WITH (NOLOCK) ON pd.ProductSettingID = lp.ProductSettingID
				WHERE lp.CustID = s.custid AND pd.SettingType = 4
					AND pd.ProductID = t.ProductID
				) AS p_tmp
	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) 
		ON p.custid = s.custid
		AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL							
	AND s.site = 'Athena000'
