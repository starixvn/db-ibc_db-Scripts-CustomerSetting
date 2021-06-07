/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210602
	Task: Insert Product Profiler to Offer commission [Redmine: #154048]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductName		ProductID	SportType	BetType
	WM				51			233			3401
	Joker			56			234			6401
	BG				57			239			3501
	Sports Lottery	63			169			3611
	GDG				59			236			5701
	Habanero		61			238			7001
*/
USE CustDB
GO
INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 107,51, 9, 0, 4, 1 UNION ALL -- WM				
SELECT 108,56, 9, 0, 4, 1 UNION ALL -- Joker			
SELECT 109,57, 9, 0, 4, 1 UNION ALL -- BG				
SELECT 110,63, 9, 0, 4, 1 UNION ALL -- Sports Lottery	
SELECT 111,59, 9, 0, 4, 1 UNION ALL -- GDG				
SELECT 112,61, 9, 0, 4, 1			 -- Habanero		

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 107,233,3401,0,0,0,0 UNION ALL 
SELECT 108,234,6401,0,0,0,0 UNION ALL 
SELECT 109,239,3501,0,0,0,0 UNION ALL 
SELECT 110,169,3611,0,0,0,0 UNION ALL 
SELECT 111,236,5701,0,0,0,0 UNION ALL 
SELECT 112,238,7001,0,0,0,0

/*
SELECT s.ProductName, p.*, s1.sportname
FROM [Dep_ProductSetting] p(NOLOCK)
     INNER JOIN [Dep_ProductSettingDetail] d(NOLOCK)
       ON p.ProductSettingID = d.ProductSettingID
     INNER JOIN dbacc.bodb02.dbo.products s(NOLOCK)
       ON p.ProductID = s.ProductID
     INNER JOIN dbacc.bodb02.dbo.sports s1(NOLOCK)
       ON d.SportType = s1.sporttype
WHERE p.ProductSettingID BETWEEN 107 AND 112
ORDER BY d.ProductSettingID

*/
