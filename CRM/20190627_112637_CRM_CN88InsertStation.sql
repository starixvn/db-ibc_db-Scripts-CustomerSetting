USE [bodb_CRM]
GO

/*
	Created: 20190509@Winnie
	Task: CN88 Insert crmsetting RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/


DECLARE @ID INT

SELECT @ID=MAX(SettingID) from crmSetting(NOLOCK) where SettingName='Station'

INSERT INTO crmSetting(SettingID,SettingName,SettingValue,IsActive,DisplayOrder,SiteOffer)
VALUES (@ID+1,N'Station', N'N/A', 0, 1, 1)


INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
VALUES (@ID+1, 0, 0)
