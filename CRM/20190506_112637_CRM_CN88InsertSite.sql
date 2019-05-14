
/*
	Created: 20190506@Winnie
	Task: CN88 RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO

ALTER TABLE crmSetting
        ADD SiteOffer TINYINT NULL 
 CONSTRAINT DF_crmSetting_SiteOffer 
    DEFAULT (2)
GO
ALTER VIEW [dbo].[crmLanguage] 
AS 
SELECT SettingID LanguageID, SettingValue Name, s.DisplayOrder, s.IsActive,s.SiteOffer
FROM crmSetting(NOLOCK) s
WHERE SettingName = 'Language'
GO
ALTER VIEW [dbo].[crmSubCategory]
AS
SELECT        s.SettingID AS SubCategoryID, s.SettingValue AS Name, sr.ParentID AS MainCategoryID, sr.DisplayOrder, s.IsActive,s.SiteOffer
FROM            dbo.crmSetting AS s WITH (nolock) INNER JOIN
                         dbo.crmSettingRelation AS sr WITH (nolock) ON sr.SettingID = s.SettingID
WHERE        (s.SettingName = 'SubCategory') AND (sr.ParentID <> 0)

GO

ALTER VIEW [dbo].[crmStatus]
AS
SELECT SettingID StatusID,
		SettingValue Name,
		DisplayOrder,
		IsActive,
		SiteOffer
FROM crmSetting(NOLOCK)
WHERE SettingName = 'Status'
GO


ALTER VIEW [dbo].[crmCommunicationTool]
AS
SELECT SettingID CommunicationID, SettingValue Name,DisplayOrder,IsActive,SiteOffer
FROM crmSetting(NOLOCK) WHERE SettingName='Communication'
GO

ALTER view [dbo].[crmMainCategory] AS
select SettingID MainCategoryID, 
	SettingValue Name, 
	DisplayOrder,
	IsActive,
	SiteOffer
from crmsetting
where settingname = 'MainCategory'
GO

ALTER view [dbo].[crmBettype] 
as
select s.SettingID BettypeID, SettingValue Name, sr.ParentID ProductID,s.DisplayOrder,IsActive,SiteOffer
from crmSetting(nolock) s
inner join crmSettingRelation(NOLOCK) sr on sr.SettingID = s.SettingID
where SettingName='Bettype'
GO


