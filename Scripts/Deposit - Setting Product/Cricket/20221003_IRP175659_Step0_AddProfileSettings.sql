/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221003@Johnson
	Task: Add profile setting for Cricket & Saba Cricket [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT 154, 1 , 10, 0, 2, 4
UNION SELECT 155, 1, 10, 0, 2, 4		   
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT 154, 50, 1, 0, 0, 1, NULL, 0		   
UNION SELECT 155, 9907, 1, 0, 0, 1, NULL, 0
GO

DELETE SportBettypeSettingMatrix WITH(ROWLOCK)
WHERE SportType = 50 and isLicensee = 1

GO
INSERT INTO [dbo].[SportBettypeSettingMatrix]
           ([SportType]
           ,[BetType]
           ,[isLicensee]
           ,[isLive]
           ,[Site]
           ,[isActive]
           ,[SportTypeRefPT]
           ,[BetTypeRefPT]
           ,[isLivePT]
           ,[TablePT]
           ,[StructureVerPT]
           ,[SportTypeRefComm]
           ,[BetTypeRefComm]
           ,[TableComm]
           ,[StructureVerComm]
           ,[SportTypeRefBetSetting]
           ,[BetTypeRefBetSetting]
           ,[TableBetSetting]
           ,[StructureVerBetSetting]
           ,[IsLiveComm]
           ,[IsLiveBetSetting])
SELECT t.SportType, s.Bettype, 1 as isLicensee, 'ALL' Site, 1 as isActive, 
	1 SportTypeRefPT, 1 BetTypeRefPT, 0 isLivePT, 'Dep_CustPTGroupSetting_Member' TablePT, 'default' StructureVerPT,
	1 SportTypeRefComm, 1 BetTypeRefComm, 'Dep_CustDiscountGroupSetting_Member' TableComm, 'default' StructureVerComm,
	t.Sporttype as SportTypeRefBetSetting, 1 BetTypeRefBetSetting, 'Dep_CustBetSettingGameGroup_Member' TableBetSetting, 'default' StructureVerBetSetting, 0 IsLiveComm, 0 IsLiveBetSetting	
FROM DBTXN.bodb02.dbo.SportBettypeMatrix s WITH(NOLOCK)
	CROSS APPLY (SELECT 50 as SportType
				UNION SELECT 9907) t
WHERE s.SportType = 50				   