/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220419@Winfred
	Task: Database structure for Creative Gaming, VS3 , AdvantPlay and AdvantPlay Mini  commission for LAP  [Redmine: #145337]  
	DB: DBCUST/CUSTDB

	Notes: 
	ProductID	SportType	BetType	ProductName
	49			231			5301	Virtual Sports 3
	62			167			7301	CG
	67			172			7701	AdvantPlay
	68			174			7801	AdvantPlay Mini
*/

USE CUSTDB
GO

INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 150,49, 9, 0, 4, 1 UNION ALL -- Virtual Sports 3				
SELECT 147,62, 9, 0, 4, 1 UNION ALL -- CG			
SELECT 148,67, 9, 0, 4, 1 UNION ALL -- AdvantPlay				
SELECT 149,68, 9, 0, 4, 1			-- AdvantPlay Mini

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 150,231,5301,0,0,0,0 UNION ALL -- Virtual Sports 3			
SELECT 147,167,7301,0,0,0,0 UNION ALL -- CG			
SELECT 148,172,7701,0,0,0,0 UNION ALL -- AdvantPlay				
SELECT 149,174,7801,0,0,0,0 		  -- AdvantPlay Mini

/*
SELECT s.ProductName, p.*, s1.sportname
FROM [Dep_ProductSetting] p(NOLOCK)
     INNER JOIN [Dep_ProductSettingDetail] d(NOLOCK)
       ON p.ProductSettingID = d.ProductSettingID
     INNER JOIN dbacc.bodb02.dbo.products s(NOLOCK)
       ON p.ProductID = s.ProductID
     INNER JOIN dbacc.bodb02.dbo.sports s1(NOLOCK)
       ON d.SportType = s1.sporttype
WHERE p.ProductSettingID BETWEEN 147 AND 150
ORDER BY d.ProductSettingID

*/
