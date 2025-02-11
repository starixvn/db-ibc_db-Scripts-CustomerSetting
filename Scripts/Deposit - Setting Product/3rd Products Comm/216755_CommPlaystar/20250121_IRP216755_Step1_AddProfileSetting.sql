/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250121@Johnson
	Task: Add profile for Comm Setting for Playstar [redmine: #216755]
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
SELECT 227, 91, 9, 0, 4, 1, dbo.f_GetDateTime2()	


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
SELECT 227, 143, 11600,  0, 0, 0, NULL, 0, dbo.f_GetDateTime2()  

INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID,RepUpdateTime)
SELECT s.custid, t.ProductSettingID, dbo.f_GetDateTime2()
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = s.site
	CROSS APPLY(SELECT 	227	ProductSettingID,	91 ProductID					
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