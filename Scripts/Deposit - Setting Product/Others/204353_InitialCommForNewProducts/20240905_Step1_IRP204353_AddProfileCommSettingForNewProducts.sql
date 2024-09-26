/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240905@Johnson
	Task: Add profile for Comm Setting for new products [redmine: #204353]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   ,RepUpdateTime 
           )
SELECT 207, 72, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 208, 78, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 209, 79, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 210, 80, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 211, 85, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 212, 87, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 213, 89, 9, 0, 4, 1, SYSDATETIME()	   

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA]
		   ,RepUpdateTime
           )
SELECT 207,	156, 8900, 0, 0, 0, NULL, 0	, SYSDATETIME() 
UNION SELECT 208,	216,	10000, 0, 0, 0, NULL, 0, SYSDATETIME()
UNION SELECT 209,	227,	7601, 0, 0, 0, NULL, 0, SYSDATETIME()
UNION SELECT 210,	228,	10300, 0, 0, 0, NULL, 0, SYSDATETIME()
UNION SELECT 211,	229,	10450, 0, 0, 0, NULL, 0, SYSDATETIME()
UNION SELECT 212,	230,	11100, 0, 0, 0, NULL, 0, SYSDATETIME()
UNION SELECT 213,	146,	11300, 0, 0, 0, NULL, 0, SYSDATETIME()

GO

INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID,RepUpdateTime)
SELECT s.custid, t.ProductSettingID, SYSDATETIME()
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = s.site
	CROSS APPLY(SELECT 	207	ProductSettingID,	72 ProductID
				UNION SELECT 	208	,	78
				UNION SELECT 	209	,	79
				UNION SELECT 	210	,	80
				UNION SELECT 	211	,	85
				UNION SELECT 	212	,	87
				UNION SELECT 	213	,	89
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
	AND l.IsActive = 1
	