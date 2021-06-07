/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210602
	Task: Insert Dep_LicenseeProductSetting to Offer commission [Redmine: #154048]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductName		ProductID	SportType	BetType
	WM				51			233			3401
	Joker			56			234			6401
	BG				57			239			3501
	Sports Lottery	63			169			3611
	GDG				59			236			5701
	Habanero		61			238			7001
		
*/
USE CustDB
GO

INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(	SELECT 107 AS ProductSettingID, 	51 AS ProductID UNION ALL
					SELECT 108,	56	UNION ALL
					SELECT 109,	57	UNION ALL
					SELECT 110,	63	UNION ALL
					SELECT 111,	59	UNION ALL
					SELECT 112,	61
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


							
