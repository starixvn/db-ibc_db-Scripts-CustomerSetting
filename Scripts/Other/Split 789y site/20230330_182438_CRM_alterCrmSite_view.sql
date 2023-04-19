/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230330@Tacy
	Task: add SiteLabel column into view [crmSite]
		 https://nexdev.net/issues/182438 [RedmineID: #182438]
	Database: DBCRM-bodb_CRM
*/

USE [bodb_CRM]
GO

ALTER view [dbo].[crmSite]
AS
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	CASE sr.ParentID WHEN 33000 THEN 1 WHEN 33001 THEN 0 ELSE -1 END IsLicensee,
	s.IsActive,
	s.SiteOffer,SettingValueCS SiteNameCS,SettingValueCT SiteNameCT,
	s.ExtraInfo SiteLabel
	FROM dbo.crmSettingRelation sr WITH(NOLOCK)
	INNER JOIN dbo.crmSetting s WITH(NOLOCK) ON sr.SettingID = s.SettingID AND s.SettingName = 'Site'
	WHERE ParentID IN (33000,33001)
UNION ALL
SELECT s.SettingID SiteID, 
	s.SettingValue SiteName,
	s.DisplayOrder,
	0 IsLicensee,
	s.IsActive,
	s.SiteOffer,SettingValueCS SiteNameCS,SettingValueCT SiteNameCT,
	s.ExtraInfo SiteLabel
	FROM dbo.crmSetting s WITH(NOLOCK)
	WHERE s.SettingID=33002
GO