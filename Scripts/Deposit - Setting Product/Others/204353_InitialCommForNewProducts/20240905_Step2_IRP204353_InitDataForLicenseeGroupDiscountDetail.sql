/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240905@Johnson
	Task: Init data LicenseeGroupDiscountDetail for new products [redmine: #204353]
	DB: DBCUST/bodb_Licensee
*/
	DECLARE @tmpProduct TABLE (ProductID INT, IsFinished BIT DEFAULT 0)
	DECLARE @ProductID INT
	
	INSERT INTO @tmpProduct	(ProductID)
	SELECT 72 
	UNION SELECT 78 
	UNION SELECT 79 
	UNION SELECT 80
	UNION SELECT 85 
	UNION SELECT 87 
	UNION SELECT 89
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (1) t
		SET IsFinished = 1,
			@ProductID = ProductID
		FROM @tmpProduct t
		WHERE IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		--3k rows
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
							AND p.ProductID = @ProductID
							AND l.IsActive = 1
							AND l.LicenseeID = gd.LicenseeID
						)t
						
	END
