/*
	Created: Helen
	Date: 2020-05-07
	Task: Insert profile for licensee when offer comm AB,Macau,PP, Fishing World
	DB: DBCUST/CustDB
*/
--insert settingtype =9 for Fishing World into Dep_ProductSetting
INSERT INTO dbo.Dep_ProductSetting(
							ProductSettingID
							,ProductID
							,SettingType
							,TemplateID
							,DisplayOrder
							,SettingLevel
							)
SELECT 	53,	24,	9, 0, 4, 1	--FishingWorld

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]           
           ,[IsApplyBA])   
SELECT 53,219,1011,0,0,0,0
------------ correct comm setting for licensee
-- Delete comm setting AB,Macau,PP 
DELETE t
FROM Dep_LicenseeProductSetting t WITH (ROWLOCK)
WHERE t.ProductSettingID IN (18,51,52,53)

--Insert comm setting for licensees offered Allbet,Macau,PP, Fishing 
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(SELECT 21 AS ProductID, 18 ProductSettingID--AB 
			UNION SELECT 22, 51
			UNION SELECT 32, 52
			UNION SELECT 24, 53) t
	CROSS APPLY (SELECT TOP 1 lp.CustID 
				FROM Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN Dep_ProductSetting pd WITH (NOLOCK) ON pd.ProductSettingID = lp.ProductSettingID
				WHERE lp.CustID = s.custid AND pd.SettingType = 4
					AND pd.ProductID = t.ProductID
				) AS p_tmp

	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) ON p.custid = s.custid
														AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL		
									