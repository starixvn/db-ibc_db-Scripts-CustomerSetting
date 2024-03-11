/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240228
	Task: Initial data into Dep_ChargeInfoSetting - SIT [redmine: #201169]
	DB: DBCUST-CustDB
*/
INSERT INTO Dep_ChargeInfoSetting ([CustID], [SportType], [PT])
SELECT cs.[CustID], 221 AS [SportType],  86.5 AS [PT]
FROM Dep_LicenseeProductSetting lps WITH (NOLOCK)
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON lps.CustID=cs.custid
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=lps.ProductSettingID
CROSS APPLY (SELECT cps.CustID
			 FROM Dep_CustProductStatus cps WITH(NOLOCK) 
			 WHERE cps.custid = cs.custid
				AND dbo.f_GetProductStatus(cps.bitmapIsDisabled, 7)=0) cps
WHERE ps.ProductID=31 AND ps.SettingType=4
	AND site IN ('SampleSite')
GO