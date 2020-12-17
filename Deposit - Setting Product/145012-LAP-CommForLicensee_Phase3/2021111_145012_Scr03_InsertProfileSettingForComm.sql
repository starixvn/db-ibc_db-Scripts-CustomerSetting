/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 3 - [Redmine: #145012]   
	DB: DBCUST/CustDB

	Notes: 
	ProductID	Name			Sporttype
	38			Virtual Games	245
	34			Arcadia Gaming	165
	42			Saba.club		200
	39			SA Gaming		244
	55			PG Soft			232
	21			Allbet			211
		
*/
USE CustDB
GO
INSERT INTO dbo.Dep_ProductSetting(
							ProductSettingID
							,ProductID
							,SettingType
							,TemplateID
							,DisplayOrder
							,SettingLevel
							)
SELECT 76, 38, 9, 0, 4, 1 -- Virtual Games
UNION ALL SELECT 77,34, 9, 0, 4, 1--Arcadia Gaming
UNION ALL SELECT 78,42, 9, 0, 4, 1--Saba.club
UNION ALL SELECT 79,39, 9, 0, 4, 1--SA Gaming
UNION ALL SELECT 80,55, 9, 0, 4, 1 --PG Soft
UNION ALL SELECT 81,21, 9, 0, 4, 1 --Allbet

INSERT INTO [CustDB].[dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]           
           ,[IsApplyBA]) 

SELECT 76,245,4601,0,0,0,0
UNION ALL 
SELECT 77,165,1901,0,0,0,0
UNION ALL 
SELECT 78,200,1611,0,0,0,0
UNION ALL 
SELECT 79,244,3001,0,0,0,0
UNION ALL 
SELECT 80,232,6001,0,0,0,0
UNION ALL 
SELECT 81,211,2401,0,0,0,0