/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/CustDB

	Notes: insert settingtype =9 for 7 Product below into Dep_ProductSetting
		1.SEXY GAMING
		2.SpadeGaming
		3.Keno (non DCS)
		4.Lottery
		5.Virtual Sport
		6.Virtual Sport 2
		7.Table Game
*/
USE CustDB
GO
INSERT INTO dbo.Dep_ProductSetting(
							ProductSettingID
							,ProductID
							,SettingType
							,TemplateID
							,DisplayOrder
							,SettingLevel
							)
SELECT 63, 28, 9, 0, 4, 1 -- Lottery
--UNION ALL SELECT 64,8, 9, 0, 4, 1--RNG Keno
UNION ALL SELECT 65,45, 9, 0, 4, 1--Sexy Gaming
UNION ALL SELECT 66,36, 9, 0, 4, 1--SG
UNION ALL SELECT 67,40, 9, 0, 4, 1--Table Game
UNION ALL SELECT 68,5, 9, 0, 4, 1 --VS
UNION ALL SELECT 69,27, 9, 0, 4, 1--VS 2

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]           
           ,[IsApplyBA]) 

SELECT 63, 220,	1021, 0,0,0,0 -- Lottery
--UNION ALL SELECT 64, 202,	1501, 0,0,0,0--RNG Keno
UNION ALL SELECT 65, 243,	3101, 0,0,0,0--Sexy Gaming
UNION ALL SELECT 66, 247,	4301, 0,0,0,0--SG
UNION ALL SELECT 67, 222,	4901, 0,0,0,0--Table Game
UNION ALL SELECT 68, 180,	1201, 0,0,0,0 --VS
UNION ALL SELECT 69, 190,	2701, 0,0,0,0--VS 2
             
--offer Allbet,Macau,PP comm for licensees
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT s.custid, t.ProductSettingID
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(SELECT 28 ProductID,63 ProductSettingID--Lottery 
				--UNION SELECT 8,64 --RNG Keno
				UNION SELECT 45,65 --Sexy Gaming
				UNION SELECT 36,66 --SG
				UNION SELECT 40,67 --Table Game
				UNION SELECT 5,68 --VS
				UNION SELECT 27,69 --VS 2
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
