/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBCust/CustDB
*/ 
/*
	SportBettypeSettingMatrix
	ProductSettingDetail [_UAT]
	ProductStatusProfile
	ProductStatusSiteCurrency
	ProductBetSetting
	ProductSettingSystemDisplay 
	BetLimitControlProduct 
*/

------------------------------CREDIT-----------------------------------
--> SportBettypeSettingMatrix
DELETE a
FROM SportBettypeSettingMatrix a WITH(ROWLOCK) 
WHERE RealProductId=23

--> ProductStatusSiteCurrency
DELETE a
FROM ProductStatusSiteCurrency a WITH(ROWLOCK)
WHERE SportType BETWEEN 213 and 218

--> ProductSettingDetail
DELETE a
FROM dbo.ProductSettingDetail a WITH(ROWLOCK)
WHERE ProductId=23

DELETE a
FROM dbo.ProductSettingDetail_UAT a WITH(ROWLOCK)
WHERE ProductId=23

-->ProductStatusProfile
DELETE a
FROM ProductStatusProfile  a WITH(ROWLOCK) 
WHERE SportType=213

-->ProductSettingSystemDisplay
DELETE a
FROM ProductSettingSystemDisplay a WITH(ROWLOCK) 
WHERE ProductId=23

-->ProductBetSetting
DELETE a
FROM ProductBetSetting a WITH(ROWLOCK)
WHERE SportType BETWEEN 213 and 218

-->BetLimitControlProduct 
DELETE a
FROM BetLimitControlProduct  a WITH(ROWLOCK)
WHERE ProductId=23
