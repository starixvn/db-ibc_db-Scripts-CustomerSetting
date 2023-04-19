/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230202@Tacy
	Task: 02. Initial data for column ExtraInfo on table crmSetting
		 https://nexdev.net/issues/182438 [RedmineID: #182438]
	Database: DBCRM-bodb_CRM
*/

USE bodb_CRM
GO

--Inactive: Y987
UPDATE s
SET IsActive=0 
FROM crmSetting s WITH (ROWLOCK,UPDLOCK) 
WHERE SettingName = 'SITE' and SettingValue='Y987'

-- Update SiteLabel
UPDATE s
SET s.ExtraInfo = CASE  WHEN s.SettingValue IN ('789y','yUT','y789','y889','yOther')	THEN '789y'
						WHEN s.SettingValue IN ('IBCIndo','76666B')						THEN 'IBC'
																						ELSE 'Nova88'
					END
FROM crmSetting s WITH(UPDLOCK, ROWLOCK)
INNER JOIN crmSite ss WITH(NOLOCK) ON ss.SiteID=s.SettingID
WHERE s.SettingName='Site' AND ss.IsLicensee=0 
AND ss.IsActive=1 AND ss.SiteName<>'CN88'