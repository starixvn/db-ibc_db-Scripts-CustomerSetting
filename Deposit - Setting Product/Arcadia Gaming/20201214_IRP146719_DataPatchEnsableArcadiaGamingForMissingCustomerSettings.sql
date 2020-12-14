/*
	Created: 20201214@Johnson
	Task: data patch enable Arcadia Gaming for missing customers
	DB: DBCUST/CustDB
*/

DECLARE @StakeLevelList VARCHAR(10)= ''

SELECT @stakelevelList = CAST(StakeLevelID as VARCHAR(10))
	FROM Dep_StakeLevel l WITH(NOLOCK)
		INNER JOIN	Dep_ProductSettingDetail s WITH(NOLOCK) ON l.GameTypeID=s.BetType
		INNER JOIN	Dep_ProductSetting  d WITH(NOLOCK) ON s.ProductSettingID=d.ProductSettingID
	WHERE l.ExchangeID=13
		AND d.ProductID= 34
		AND d.SettingType=8
		
;WITH T AS(
	SELECT 47157595 as custid
UNION SELECT 47157609
UNION SELECT 47157610
)
INSERT INTO dbo.Dep_CustStakeLevel_Member(CustID,SportType,BetType,StakeLevelList,LastUpdated)
SELECT CustID,165 as SportType,1901 as BetType,@StakeLevelList,GETDATE()	
FROM T

