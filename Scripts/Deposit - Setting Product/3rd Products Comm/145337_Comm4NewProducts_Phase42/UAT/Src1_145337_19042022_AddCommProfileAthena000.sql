/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220419@Winfred
	Task: Insert Dep_LicenseeProductSetting to Offer commission - Athena000  [Redmine: #145337]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductID	SportType	BetType	ProductName
	49			231			5301	Virtual Sports 3
	62			167			7301	CG
	67			172			7701	AdvantPlay
	68			174			7801	AdvantPlay Mini
*/

USE CUSTDB
GO

INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(	SELECT 147 AS ProductSettingID, 62 AS ProductID UNION ALL
					SELECT 148,	67	UNION ALL
					SELECT 149,	68	UNION ALL
					SELECT 150,	49	
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
