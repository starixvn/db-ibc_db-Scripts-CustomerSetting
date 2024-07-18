/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240429 
	Task: Licensee/NAP - Integrate Exchange [RedmineID: #201239]
		- Initial product setting into [Dep_LicenseeProductSetting] - Athena000
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE	 @ProductID		TINYINT = 31
		,@bitmapOrder	TINYINT = 7
		,@curDate		DATE

SET @curDate = CAST(GETDATE() AS DATE)

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT cs.CustID, 195 AS ProductSettingID
FROM Dep_LicenseeProductSetting lps WITH (NOLOCK)
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON lps.CustID=cs.custid
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=lps.ProductSettingID
CROSS APPLY (SELECT cps.CustID
			 FROM Dep_CustProductStatus cps WITH(NOLOCK) 
			 WHERE cps.custid = cs.custid
				AND dbo.f_GetProductStatus(cps.bitmapIsDisabled, @bitmapOrder)=0) cps
WHERE ps.ProductID=@ProductID AND ps.SettingType=4
	AND cs.site='Athena000'
GO