/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230118@Tacy
	Task: Insert 4 new sites (YUT, Y789, Y889, YOther) 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCRM-bodb_CRM
*/

USE bodb_CRM
GO

DECLARE @maxSettingID INT

SELECT @maxSettingID=MAX(SettingID)
FROM crmSetting WITH (NOLOCK)

INSERT INTO crmSetting ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer])
SELECT [SettingName], @maxSettingID+1, 'yUT', [DisplayOrder], 1, [SiteOffer]
FROM crmSetting s WITH (NOLOCK) WHERE SettingName  = 'SITE' and SettingValue='789y'
UNION ALL 
SELECT [SettingName], @maxSettingID+2, 'y789', [DisplayOrder], 1, [SiteOffer]
FROM crmSetting s WITH (NOLOCK) WHERE SettingName  = 'SITE' and SettingValue='789y'
UNION ALL 
SELECT [SettingName], @maxSettingID+3, 'y889', [DisplayOrder], 1, [SiteOffer]
FROM crmSetting s WITH (NOLOCK) WHERE SettingName  = 'SITE' and SettingValue='789y'
UNION ALL 
SELECT [SettingName], @maxSettingID+4, 'yOther', [DisplayOrder], 1, [SiteOffer]
FROM crmSetting s WITH (NOLOCK) WHERE SettingName  = 'SITE' and SettingValue='789y'