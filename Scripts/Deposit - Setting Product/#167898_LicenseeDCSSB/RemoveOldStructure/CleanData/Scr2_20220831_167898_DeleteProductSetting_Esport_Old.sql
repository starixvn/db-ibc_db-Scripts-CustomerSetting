/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220831
	Task: Clean Data Dep_ProductSetting, Dep_ProductSettingDetail Esport Old [Redmine:#167898]
	DB: DBCUST/CustDB
*/
DELETE p
FROM Dep_ProductSetting d WITH(NOLOCK)
	INNER JOIN Dep_ProductSettingDetail p WITH(ROWLOCK,UPDLOCK)
		ON p.ProductSettingID = d.ProductSettingID
WHERE ProductID = 16
	AND p.SettingStatus = 2

DELETE d
FROM Dep_ProductSetting d WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 16