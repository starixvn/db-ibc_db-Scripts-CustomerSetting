/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 3 - [Redmine: #145012]   
	DB: DBCUST/CustDB

	Notes:
		ProductID	Name			Sporttype
		38			Virtual Games	245
		34			Arcadia Gaming	165
		42			Saba.club		200
		39			SA Gaming		244
		55			PG Soft			232
		21			Allbet			211
*/
USE CustDB
GO
   
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(SELECT 38 ProductID,76 ProductSettingID
				UNION SELECT 34,77 
				UNION SELECT 42,78 
				UNION SELECT 39,79 
				UNION SELECT 55,80 
				UNION SELECT 21,81 
				) t
	CROSS APPLY (SELECT TOP 1 lp.CustID 
				FROM Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN Dep_ProductSetting pd WITH (NOLOCK) ON pd.ProductSettingID = lp.ProductSettingID
				WHERE lp.CustID = s.custid AND pd.SettingType = 4
					AND pd.ProductID = t.ProductID
				) AS p_tmp
			
	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) ON p.custid = s.custid
														AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL														
