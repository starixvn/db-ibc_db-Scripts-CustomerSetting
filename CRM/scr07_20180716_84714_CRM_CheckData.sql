/*
Created: 20180716@Winnie
Task: Check data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmMainCategory m WITH(NOLOCK) ON fs.SettingID=m.MainCategoryID
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.SettingID<>f.MainCategoryID

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSubCategory m WITH(NOLOCK) ON fs.SettingID=m.MainCategoryID
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.SubSettingID<>f.SubCategoryID

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Product'
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.SettingID<>f.ProductID

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='SubProduct'
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.SubSettingID<>f.SubProductID


SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Bettype'
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.SubSettingIDLevel3<>f.BetTypeID

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Communication'
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.settingID<>f.communicationID AND (fs.settingID<>1005 AND f.CommunicationID<>0)

SELECT fs. FeedbackID
FROM crmFeedbackSetting fs WITH(NOLOCK)
	INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Station'
	INNER JOIN crmFeedback f WITH(NOLOCK) ON fs.FeedbackID=f.FeedbackID
WHERE fs.settingID<>f.StationID AND (fs.settingID<>2022 AND f.StationID<>0)



