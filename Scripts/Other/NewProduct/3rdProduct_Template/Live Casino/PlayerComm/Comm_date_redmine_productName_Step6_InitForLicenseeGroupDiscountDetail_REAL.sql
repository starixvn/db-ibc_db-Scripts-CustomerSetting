/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: {Nickname}@{date}
	Task: Init data LicenseeGroupDiscountDetail for {ProductName} [redmine: #xxx]
	DB: DBCUST/bodb_Licensee
*/
USE bodb_Licensee
GO

DECLARE @tmpProduct TABLE (ProductID INT, IsFinished BIT DEFAULT 0)
DECLARE @ProductID INT
	
INSERT INTO @tmpProduct	(ProductID)
SELECT ({ProductID})
	
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
						AND NOT (l.licenseeName IN ('Athena000', 'spondemo') AND cs.currency=20)
					)t

	WAITFOR DELAY '0:0:0.280'
END
