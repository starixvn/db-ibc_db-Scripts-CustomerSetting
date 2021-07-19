/*
Created: 20180709@Winnie
Task: Rollback data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

DECLARE @ReleaseDate	DATETIME
DECLARE @LogID			BIGINT
SELECT @ReleaseDate='2018-07-02'
SELECT @LogID=78000
CREATE TABLE #tempFB(FeedbackID INT PRIMARY KEY,ProductID INT,SubProductID INT,BettypeID INT,MainCategoryID INT,SubCategoryID INT,CommunicationID INT,StationID INT)

INSERT INTO #tempFB(FeedbackID)
SELECT FeedbackID 
FROM [dbo].crmFeedback WITH(NOLOCK) 
WHERE MainCategoryID IS NULL AND CreateDate>@ReleaseDate
UNION
SELECT DISTINCT FeedbackID 
FROM [dbo].[crmLogFeedback] WITH(NOLOCK) 
WHERE LogID>@LogID AND ActionID IN(201,203)

UPDATE t
SET t.MainCategoryID=fs.SettingID,t.SubCategoryID=fs.SubSettingID
FROM #tempFB t
	INNER JOIN crmFeedbackSetting fs WITH(NOLOCK) ON t.FeedbackID=fs.FeedbackID
	INNER JOIN crmMainCategory m ON fs.SettingID=m.MainCategoryID

UPDATE t
SET t.ProductID=fs.SettingID,t.SubProductID=fs.SubSettingID,t.BettypeID=fs.SubSettingIDLevel3
FROM #tempFB t
	INNER JOIN crmFeedbackSetting fs WITH(NOLOCK) ON t.FeedbackID=fs.FeedbackID
	INNER JOIN crmSetting m ON fs.SettingID=m.SettingID AND m.SettingName='Product'

UPDATE t
SET t.CommunicationID=fs.SettingID
FROM #tempFB t
	INNER JOIN crmFeedbackSetting fs WITH(NOLOCK) ON t.FeedbackID=fs.FeedbackID
	INNER JOIN crmSetting m ON fs.SettingID=m.SettingID AND m.SettingName='Communication'

UPDATE t
SET t.StationID=fs.SettingID
FROM #tempFB t
	INNER JOIN crmFeedbackSetting fs WITH(NOLOCK) ON t.FeedbackID=fs.FeedbackID
	INNER JOIN crmSetting m ON fs.SettingID=m.SettingID AND m.SettingName='Station'

UPDATE fb
	SET fb.MainCategoryID=t.MainCategoryID,fb.SubCategoryID=t.SubCategoryID,fb.ProductID=t.ProductID,fb.SubProductID=t.SubProductID,fb.BetTypeID=t.BettypeID,
	fb.CommunicationID=t.CommunicationID,fb.StationID=t.StationID
FROM crmFeedback fb WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tempFB t ON fb.FeedbackID=t.FeedbackID
WHERE t.MainCategoryID IS NOT NULL

DROP TABLE #tempFB
