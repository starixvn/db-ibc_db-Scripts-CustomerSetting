/*
	Created: Johnson
	Date: 2020-04-11
	Task: Insert profile for licensee when offer comm AB,Macau,PP
	DB: DBCUST/CustDB
*/

--AB already initial 
--insert settingtype =9 for Macau & OO into Dep_ProductSetting
INSERT INTO dbo.Dep_ProductSetting(
							ProductSettingID
							,ProductID
							,SettingType
							,TemplateID
							,DisplayOrder
							,SettingLevel
							)
SELECT 	51,	22,	9, 0, 4, 1	--Macau Game
UNION SELECT 52, 32, 9, 0, 4, 1--PP		

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]           
           ,[IsApplyBA])   
SELECT 51,212,4001,0,0,0,0
UNION SELECT 52,248,4101,0,0,0,0

--offer Allbet,Macau,PP comm for licensees
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(SELECT 18 ProductSettingID--AB 
				UNION SELECT 51
				UNION SELECT 52) t
	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) ON p.custid = s.custid
														AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL														