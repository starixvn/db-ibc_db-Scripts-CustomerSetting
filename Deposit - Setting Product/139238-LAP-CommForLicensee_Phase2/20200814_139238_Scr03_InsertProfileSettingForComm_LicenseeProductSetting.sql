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
					AND t.ProductSettingID = lp.ProductSettingID
				) AS p_tmp
			
	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) ON p.custid = s.custid
														AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL														
