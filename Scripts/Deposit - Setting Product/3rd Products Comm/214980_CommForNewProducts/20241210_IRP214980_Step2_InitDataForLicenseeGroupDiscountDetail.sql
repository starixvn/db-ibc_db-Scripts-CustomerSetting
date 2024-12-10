/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20241210@Johnson
	Task: Init data LicenseeGroupDiscountDetail for new products [redmine: #214980]
	DB: DBCUST/bodb_Licensee
*/

INSERT INTO [dbo].[LicenseeGroupDiscountDetail]
		   ([GroupDiscountID]
		   ,[Licenseeid]
		   ,[SportType]
		   ,[BetType]
		   ,[Discount])
SELECT GroupDiscountID, gd.Licenseeid, t.SportType, t.BetType, 0 as Discount
FROM LicenseeGroupDiscount gd WITH(NOLOCK)
	CROSS APPLY (SELECT DISTINCT l.LicenseeID, pd.SportType, pd.BetType
				FROM CustDB.dbo.Dep_CustSuper cs WITH(NOLOCK)
					INNER JOIN Licensees l WITH(NOLOCK) ON cs.site = l.LicenseeName
					INNER JOIN CustDB.dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) on cs.custid = lp.CustID
					INNER JOIN CustDB.dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
					INNER JOIN CustDB.dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID 
				WHERE p.SettingType = 4
					AND p.ProductID IN (100,48,90)
					AND l.IsActive = 1
					AND l.LicenseeID = gd.LicenseeID
				)t