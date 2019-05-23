
/*
	Created: 20190506@Winnie
	Task: CN88 RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO

ALTER TABLE crmSetting  ADD SiteOffer TINYINT NULL 
 CONSTRAINT DF_crmSetting_SiteOffer   DEFAULT (2)
GO

ALTER TABLE crmSetting  ADD SettingValueCS NVARCHAR(100) 
GO
ALTER TABLE crmSetting  ADD SettingValueCT NVARCHAR(100) 
GO

ALTER TABLE [dbo].[crmCustomer] ADD ProvinceID INT
GO
ALTER TABLE [dbo].crmFeedback ADD ProvinceID INT
GO

ALTER TABLE crmCountry  ADD SiteOffer TINYINT NULL 
 CONSTRAINT DF_crmCountry_SiteOffer   DEFAULT (2)
GO

ALTER TABLE dbo.crmLogAction ADD ExcludedForCn88 BIT
GO

CREATE TABLE [dbo].[crmProvince](
	[ProvinceID] [int] NOT NULL IDENTITY(1,1),
	[CountryID] [int] NULL,
	[ProvinceName] [nvarchar](150) NULL,
	[isActive] [bit] NULL,
	[DisplayOrder] [tinyint] NULL,
	[ProvinceNameCS] [nvarchar](150) NULL,
	[ProvinceNameCT] [nvarchar](150) NULL,
 CONSTRAINT [PK_crmProvince] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[crmSubjectTemplate] ADD SiteOffer TINYINT NULL
 CONSTRAINT DF_crmSubjectTemplate_SiteOffer   DEFAULT (2)
GO
ALTER TABLE [crmSubjectTemplate]  ADD subjectCS NVARCHAR(200) 
GO
ALTER TABLE [crmSubjectTemplate]  ADD subjectCT NVARCHAR(200) 
GO

ALTER VIEW [dbo].[crmLanguage] 
AS 
SELECT SettingID LanguageID, SettingValue Name, s.DisplayOrder, s.IsActive,s.SiteOffer
FROM crmSetting s WITH(NOLOCK) 
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
from crmsetting WITH(NOLOCK)
where settingname = 'MainCategory'
GO

ALTER view [dbo].[crmBettype] 
as
select s.SettingID BettypeID, SettingValue Name, sr.ParentID ProductID,s.DisplayOrder,IsActive,SiteOffer
from crmSetting(nolock) s
inner join crmSettingRelation(NOLOCK) sr on sr.SettingID = s.SettingID
where SettingName='Bettype'
GO


ALTER view [dbo].[crmSite]
AS
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	CASE sr.ParentID WHEN 33000 THEN 1 WHEN 33001 THEN 0 ELSE -1 END IsLicensee,
	s.IsActive,
	s.SiteOffer
	FROM dbo.crmSettingRelation sr WITH(NOLOCK)
	INNER JOIN dbo.crmSetting s WITH(NOLOCK) ON sr.SettingID = s.SettingID AND s.SettingName = 'Site'
	WHERE ParentID IN (33000,33001)
UNION ALL
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	0 IsLicensee,
	s.IsActive,
	s.SiteOffer
	FROM dbo.crmSetting s WITH(NOLOCK)
	WHERE s.SettingID=33002
GO