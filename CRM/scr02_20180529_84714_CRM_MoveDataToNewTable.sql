/*
Created: 20180628@Winnie
Task: Move data to new table RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

INSERT INTO crmFeedbackSetting([FeedbackID],[SettingID],[SubSettingID],[SubSettingIDLevel3])
SELECT FeedbackID,MainCategoryID, CASE WHEN SubCategoryID=0 THEN 4029 ELSE ISNULL(SubCategoryID,4029) END,0
FROM crmFeedback WITH(NOLOCK)
WHERE MainCategoryID IS NOT NULL 

INSERT INTO crmFeedbackSetting([FeedbackID],[SettingID],[SubSettingID],[SubSettingIDLevel3])
SELECT FeedbackID,
	CASE WHEN ProductID=0 THEN 46004 ELSE ISNULL(ProductID,46004) END,
	CASE WHEN SubProductID=0 THEN 8062 ELSE ISNULL(SubProductID,8062) END,
	CASE WHEN BetTypeID=0 THEN 9145 ELSE ISNULL(BetTypeID,9145) END
FROM crmFeedback WITH(NOLOCK)
WHERE MainCategoryID IS NOT NULL 

INSERT INTO crmFeedbackSetting([FeedbackID],[SettingID],[SubSettingID],[SubSettingIDLevel3])
SELECT FeedbackID,
	CASE WHEN CommunicationID=0 THEN 1005 ELSE ISNULL(CommunicationID,1005) END,0,0
FROM crmFeedback WITH(NOLOCK)
WHERE MainCategoryID IS NOT NULL 

INSERT INTO crmFeedbackSetting([FeedbackID],[SettingID],[SubSettingID],[SubSettingIDLevel3])
SELECT FeedbackID,
	CASE WHEN StationID=0 THEN 2022 ELSE ISNULL(StationID,2022) END,0,0
FROM crmFeedback WITH(NOLOCK)
WHERE MainCategoryID IS NOT NULL 

