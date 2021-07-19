/*
	Created: 20190611@Winnie
	DB: DBCRM/bodb_CRM
	Task: CRM CN88 Translate Structure #112637
*/
ALTER TABLE dbo.crmCountry ADD CountryNameCS NVARCHAR(150)
ALTER TABLE dbo.crmCountry ADD CountryNameCT NVARCHAR(150)

ALTER TABLE dbo.crmSetting ADD SettingNameCS NVARCHAR(50)
ALTER TABLE dbo.crmSetting ADD SettingNameCT NVARCHAR(50)


IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmBettype]'))
DROP VIEW [dbo].[crmBettype]
GO

CREATE view [dbo].[crmBettype] 
as
select s.SettingID BettypeID, SettingValue Name, sr.ParentID ProductID,s.DisplayOrder,IsActive,SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
from crmSetting(nolock) s
inner join crmSettingRelation(NOLOCK) sr on sr.SettingID = s.SettingID
where SettingName='Bettype'
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmCommunicationTool]'))
DROP VIEW [dbo].[crmCommunicationTool]
GO

CREATE VIEW [dbo].[crmCommunicationTool]
AS
SELECT SettingID CommunicationID, SettingValue Name,DisplayOrder,IsActive,SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
FROM crmSetting(NOLOCK) WHERE SettingName='Communication'
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmLanguage]'))
DROP VIEW [dbo].[crmLanguage]
GO

CREATE VIEW [dbo].[crmLanguage] 
AS 
SELECT SettingID LanguageID, SettingValue Name, s.DisplayOrder, s.IsActive,s.SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
FROM crmSetting s WITH(NOLOCK) 
WHERE SettingName = 'Language'
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmMainCategory]'))
DROP VIEW [dbo].[crmMainCategory]
GO

CREATE view [dbo].[crmMainCategory] AS
select SettingID MainCategoryID, 
	SettingValue Name, 
	DisplayOrder,
	IsActive,
	SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
from crmsetting
where settingname = 'MainCategory'

GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmSite]'))
DROP VIEW [dbo].[crmSite]
GO

CREATE view [dbo].[crmSite]
AS
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	CASE sr.ParentID WHEN 33000 THEN 1 WHEN 33001 THEN 0 ELSE -1 END IsLicensee,
	s.IsActive,
	s.SiteOffer,SettingValueCS SiteNameCS,SettingValueCT SiteNameCT
	FROM dbo.crmSettingRelation sr WITH(NOLOCK)
	INNER JOIN dbo.crmSetting s WITH(NOLOCK) ON sr.SettingID = s.SettingID AND s.SettingName = 'Site'
	WHERE ParentID IN (33000,33001)
UNION ALL
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	0 IsLicensee,
	s.IsActive,
	s.SiteOffer,SettingValueCS SiteNameCS,SettingValueCT SiteNameCT
	FROM dbo.crmSetting s WITH(NOLOCK)
	WHERE s.SettingID=33002

GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmStation]'))
DROP VIEW [dbo].[crmStation]
GO

CREATE VIEW [dbo].[crmStation]
AS
SELECT	SettingID StationID,
		SettingValue Name,
		DisplayOrder,
		IsActive,
		SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
FROM crmSetting WITH (NOLOCK)
WHERE SettingName = 'Station'
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmStatus]'))
DROP VIEW [dbo].[crmStatus]
GO

CREATE VIEW [dbo].[crmStatus]
AS
SELECT SettingID StatusID,
		SettingValue Name,
		DisplayOrder,
		IsActive,
		SiteOffer,SettingValueCS NameCS,SettingValueCT NameCT
FROM crmSetting(NOLOCK)
WHERE SettingName = 'Status'

GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[crmSubCategory]'))
DROP VIEW [dbo].[crmSubCategory]
GO

CREATE VIEW [dbo].[crmSubCategory]
AS
SELECT        s.SettingID AS SubCategoryID, s.SettingValue AS Name, sr.ParentID AS MainCategoryID, sr.DisplayOrder, s.IsActive,s.SiteOffer
			,s.SettingValueCS NameCS,s.SettingValueCT NameCT
FROM            dbo.crmSetting AS s WITH (nolock) INNER JOIN
                         dbo.crmSettingRelation AS sr WITH (nolock) ON sr.SettingID = s.SettingID
WHERE        (s.SettingName = 'SubCategory') AND (sr.ParentID <> 0)
GO