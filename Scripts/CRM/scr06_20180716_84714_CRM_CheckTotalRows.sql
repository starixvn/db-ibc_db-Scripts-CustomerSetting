/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @TotalFB				INT
DECLARE @TotalFSMainCategory	INT
DECLARE @TotalFS				INT
DECLARE @TotalFSProduct			INT

DECLARE @TotalFSCommunication	INT
DECLARE @TotalFSStation			INT
SELECT @TotalFB= COUNT(1) FROM crmfeedback (NOLOCK)
SELECT @TotalFS= COUNT(1) FROM crmFeedbackSetting (NOLOCK)

SELECT @TotalFSMainCategory = COUNT(FeedbackID)
FROM crmFeedbackSetting fs WITH(NOLOCK)
 INNER JOIN crmMainCategory m WITH(NOLOCK) ON fs.SettingID=m.MainCategoryID

SELECT @TotalFSProduct = COUNT(FeedbackID)
FROM crmFeedbackSetting fs WITH(NOLOCK)
 INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Product'

SELECT @TotalFSCommunication = COUNT(FeedbackID)
FROM crmFeedbackSetting fs WITH(NOLOCK)
 INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Communication'

SELECT @TotalFSStation = COUNT(FeedbackID)
FROM crmFeedbackSetting fs WITH(NOLOCK)
 INNER JOIN crmSetting m WITH(NOLOCK) ON fs.SettingID=m.SettingID AND m.SettingName='Station'

IF(@TotalFB<>@TotalFSMainCategory OR @TotalFB<>@TotalFSCommunication
OR @TotalFB <> @TotalFSProduct OR @TotalFB*4 <> @TotalFS)
PRINT 'There are some wrong data'
