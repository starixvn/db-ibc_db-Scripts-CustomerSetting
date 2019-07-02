/*
	Date: 2019-07-02
	Created: Elodie
	Task: Update translation
	DB: DB052/[bodb_CRM]
*/

USE bodb_CRM
GO

UPDATE s
SET s.SettingNameCS = CASE	WHEN SettingName = 'InformHeadlineStatus' THEN N'通知大股东状态'
							WHEN SettingName = 'Station' THEN N'座机'
							WHEN SettingName = 'Inform New Product' THEN N'新产品通知'
							WHEN SettingName = 'SiteCategory' THEN N'网站范畴' END,   

	s.SettingNameCT = CASE	WHEN SettingName = 'InformHeadlineStatus' THEN N'通知大股東狀態'
							WHEN SettingName = 'Station' THEN N'座機'
							WHEN SettingName = 'Inform New Product' THEN N'新產品通知'
							WHEN SettingName = 'SiteCategory' THEN N'網站範疇' END   							                         
FROM dbo.crmSetting s WITH (ROWLOCK)
WHERE SettingName IN ('InformHeadlineStatus','Station','Inform New Product','SiteCategory')
	AND SiteOffer = 1

SELECT *
FROM dbo.crmSetting WITH (NOLOCK)
WHERE SettingName IN ('InformHeadlineStatus','Station','Inform New Product','SiteCategory')
	AND SiteOffer = 1