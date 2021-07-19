USE [bodb_CRM]
GO
/*
	Date: 2019-05-30
	Created: Winnie
	Task: Alter view #112637
	DB: DBCRM/[bodb_CRM]
*/
ALTER VIEW [dbo].[crmStation]
AS
SELECT	SettingID StationID,
		SettingValue Name,
		DisplayOrder,
		IsActive,
		SiteOffer
FROM crmSetting WITH (NOLOCK)
WHERE SettingName = 'Station'

GO


