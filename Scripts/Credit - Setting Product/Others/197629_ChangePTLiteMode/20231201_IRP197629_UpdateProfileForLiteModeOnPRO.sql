/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20231201@Johnson
	Task: Lite Mode - Separate PT for Live & RNG Casino products group - All Credits Except 789y [redmine : #197629]
	DB: DBCUST/CUSTDB
*/

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET SubGroupID = 5,
	SubGroupOrder = 3
WHERE ProductSettingID = 9 --VGaming

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET MarketType = 1
WHERE ProductSettingID IN (196,212) --Saba Casino,Virtual Games


INSERT INTO [dbo].[ProductSettingProfile]
           ([ProductSettingID]
           ,[SettingType]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType]
           ,[GroupID]
           ,[GroupType]
           ,[GroupTypeOrder]
           ,[SubGroupID]
           ,[SubGroupOrder]
           ,[CreationStatus]
           ,[DisplayType]
           ,[MarketType])
SELECT 341,	18,	208,	2101,	0,	6,	90.00,	NULL,	NULL,	NULL,	NULL,	1,	2,	0,	NULL,	6,	NULL,	NULL,	5,	NULL,	3,	153,	2,	5, 3,	0,	2,	1
UNION SELECT 342,	18,	245,	4601,	0,	64,	90.00,	NULL,	NULL,	NULL,	NULL,	2,	2,	0,	NULL,	38,	NULL,	NULL,	8,	NULL,	3,	153,	2,	5,	3,	0,	2,	1		   


INSERT INTO [dbo].[ProductProfileSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[ProductSettingID])
SELECT SiteID,0, ProductSettingID
FROM Site WITH(NOLOCK)	
		CROSS APPLY (SELECT 196 ProductSettingID UNION SELECT 212) t
WHERE SiteLabel = '789y'
UNION 
SELECT SiteID,0, ProductSettingID
FROM Site WITH(NOLOCK)	
		CROSS APPLY (SELECT 341 ProductSettingID UNION SELECT 342) t
WHERE SiteLabel <> '789y'
	AND isDeposit = 0 
	AND isActive = 1
	
INSERT INTO [dbo].[ProductProfileSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[ProductSettingID])
SELECT SiteID,0, ProductSettingID
FROM Site WITH(NOLOCK)	
		CROSS APPLY (SELECT 196 ProductSettingID UNION SELECT 212) t
WHERE SiteLabel = '789y'
UNION 
SELECT SiteID,0, ProductSettingID
FROM Site WITH(NOLOCK)	
		CROSS APPLY (SELECT 341 ProductSettingID UNION SELECT 342) t
WHERE SiteLabel <> '789y'
	AND isDeposit = 0 
	AND isActive = 1	
	
--Init data for new group for existing PT template
INSERT INTO [dbo].[CustPTTemplateDetail]
           ([TemplateID]
           ,[GroupID]
           ,[SubGroupID]
           ,[PT])
SELECT [TemplateID]
	   ,3 [GroupID]
	   ,5 [SubGroupID]
	   ,[PT]
FROM CustPTTemplateDetail t1 (NOLOCK)
WHERE NOT EXISTS (SELECT 1
				FROM CustPTTemplateDetail t2 (NOLOCK)
				WHERE t1.TemplateID = t2.TemplateID
					AND t2.GroupID = 3
					AND t2.SubGroupID = 5
				)
	AND GroupID = 3
	AND SubGroupID = 6
				