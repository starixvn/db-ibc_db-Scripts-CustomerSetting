/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220401@Eden
	Task: Enable SB,NG,Keno [#167898]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE t
SET SettingStatus = 0
FROM [Dep_ProductSettingDetail] t WITH(ROWLOCK,UPDLOCK)
	INNER JOIN [Dep_ProductSetting] s WITH(NOLOCK) ON t.ProductSettingID = s.ProductSettingID
WHERE s.ProductID IN(1,3,8)

/*
SELECT *
FROM [Dep_ProductSettingDetail] t WITH(NOLOCK)
	INNER JOIN [Dep_ProductSetting] s WITH(NOLOCK) ON t.ProductSettingID = s.ProductSettingID
WHERE s.ProductID IN(1,3,8)
/