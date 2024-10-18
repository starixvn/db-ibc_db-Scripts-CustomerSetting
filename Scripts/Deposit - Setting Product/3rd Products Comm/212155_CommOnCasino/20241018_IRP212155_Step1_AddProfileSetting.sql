/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241018@Johnson
	Task: Add profile for Comm Setting for new products [redmine: #212155]
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
SELECT 216, 96, 9, 0, 4, 1, dbo.f_GetDateTime2()		   

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
SELECT 216, 138, 11850,  0, 0, 0, NULL, 0, dbo.f_GetDateTime2()  


INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID,RepUpdateTime)
SELECT s.custid, t.ProductSettingID, dbo.f_GetDateTime2()
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = s.site
	CROSS APPLY(SELECT 	216	ProductSettingID,	96 ProductID				
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