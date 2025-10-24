/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250026@Elodie
	Task: Alpha - Agency Cash Service - Update profile [#231204] 
	DB: DBCust/CustDB 
*/
USE CustDB
GO


-- Update [OfferType] for specific settingTypes in ProductSettingProfile
UPDATE [dbo].[ProductSettingProfile]
SET [OfferType] = 0, RepUpdateTime = dbo.f_GetDateTime2()
WHERE [SettingType] IN (30);
