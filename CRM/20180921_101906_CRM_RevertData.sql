/*
	Created by: Winnie
	Created Date: 20180921
	Description: Roll back data for Multiple Review Incident RedmineID: #101906
	Database: DBCRM/bodb_CRM
		
*/
CREATE TABLE #tmpMultiUpdate(FeedbackID INT PRIMARY KEY)
CREATE TABLE #tmpFB(FeedbackID INT PRIMARY KEY,[TitleID] [int] NULL,[FirstName] [nvarchar](50) NULL,[LastName] [nvarchar](50) NULL,[Phone] [nvarchar](50) NULL,[MobilePhone] [nvarchar](50) NULL,[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](254) NULL,[LanguageID] [int] NULL,[CountryID] [int] NULL,[FeedbackDate] [datetime] NULL,[CommunicationID] [int] NULL,[StationID] [int] NULL,[MainCategoryID] [int] NULL,[SubCategoryID] [int] NULL,
	[SiteID] [int] NULL,[RoleID] [int] NULL,[ProductID] [int] NULL,[BetTypeID] [int] NULL,[ResponseID] [int] NULL,[StatusID] [int] NULL,[Description] [nvarchar](max) NULL,[Solution] [nvarchar](max) NULL,
	[Review] [nvarchar](max) NULL,[ReviewerID] [int] NULL,[Subject] [nvarchar](200) NULL,[Skype] [nvarchar](100) NULL DEFAULT (NULL),
	[MSN] [nvarchar](100) NULL DEFAULT (NULL),[ResolutionDate] [datetime] NULL,[Pic1] [nvarchar](100) NULL,[Pic2] [nvarchar](100) NULL,[Pic3] [nvarchar](100) NULL,[PhoneCountryCode] [nvarchar](20) NULL,	
	[PhoneAreaCode] [nvarchar](20) NULL,[Phone2] [nvarchar](100) NULL,[Phone2CountryCode] [nvarchar](20) NULL,[Phone2AreaCode] [nvarchar](20) NULL,[Phone3] [nvarchar](100) NULL,[Phone3CountryCode] [nvarchar](20) NULL,
	[Phone3AreaCode] [nvarchar](20) NULL,[MobilePhoneCountryCode] [nvarchar](20) NULL,[MobilePhoneAreaCode] [nvarchar](20) NULL,[FaxCountryCode] [nvarchar](20) NULL,[FaxAreaCode] [nvarchar](20) NULL,
	[Pic4] [nvarchar](100) NULL,[Passport] [nvarchar](100) NULL,[Birthday] [datetime] NULL,[RefCode2] [nvarchar](50) NULL,[IsVip] [bit] NULL,[WhatsApp] [nvarchar](100) NULL,[Line] [nvarchar](100) NULL,
	[WeChat] [nvarchar](100) NULL,[Yahoo] [nvarchar](100) NULL,[BBM] [nvarchar](100) NULL,[LicenseeType] [int] NULL,[QQ] [nvarchar](100) NULL,[SubProductID] [int] NULL,
	AutoField VARCHAR(MAX),Remark VARCHAR(MAX) )

INSERT INTO #tmpMultiUpdate(FeedbackID)
SELECT 552151
UNION ALL 
SELECT 552152
UNION ALL 
SELECT 552157
UNION ALL 
SELECT 552159
UNION ALL 
SELECT 552162
UNION ALL 
SELECT 552163
UNION ALL 
SELECT 552164
UNION ALL 
SELECT 552169
UNION ALL 
SELECT 552170
UNION ALL 
SELECT 552172
UNION ALL 
SELECT 552182
UNION ALL 
SELECT 552186
UNION ALL 
SELECT 552187
UNION ALL 
SELECT 552200
UNION ALL 
SELECT 552254
UNION ALL 
SELECT 552256
UNION ALL 
SELECT 552721

INSERT INTO #tmpFB
(
	FeedbackID ,[TitleID],[FirstName] ,[LastName],[Phone],[MobilePhone] ,[Fax] ,
	[Email] ,[LanguageID],[CountryID] ,[FeedbackDate],[CommunicationID] ,[StationID],[MainCategoryID],[SubCategoryID],[SiteID],[RoleID],[ProductID],[BetTypeID] ,[ResponseID],[StatusID] ,[Description],
	[Solution],[Review] ,[ReviewerID],[Subject],[Skype],[MSN],[ResolutionDate],[Pic1] ,[Pic2],[Pic3] ,[PhoneCountryCode],[PhoneAreaCode],[Phone2] ,[Phone2CountryCode] ,[Phone2AreaCode],
	[Phone3],[Phone3CountryCode],[Phone3AreaCode],[MobilePhoneCountryCode],[MobilePhoneAreaCode],[FaxCountryCode],[FaxAreaCode] ,[Pic4],[Passport],[Birthday],[RefCode2],[IsVip],[WhatsApp],[Line],
	[WeChat],[Yahoo],[BBM],[LicenseeType] ,[QQ] ,[SubProductID],
	AutoField ,Remark )
SELECT t.FeedbackID,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/TitleID)[1]','INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/FirstName)[1]','NVARCHAR(50)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/LastName)[1]','NVARCHAR(50)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone)[1]','NVARCHAR(50)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/MobilePhone)[1]','NVARCHAR(50)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Fax)[1]','NVARCHAR(50)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Email)[1]','NVARCHAR(254)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/LanguageID)[1]','INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/CountryID)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/FeedbackDate)[1]', 'DATETIME'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/CommunicationID)[1]','INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/StationID)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/MainCategoryID)[1]', 'INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/SubCategoryID)[1]','INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/SiteID)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/RoleID)[1]', 'INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/ProductID)[1]','INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/BettypeID)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/ResponseID)[1]', 'INT'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/StatusID)[1]','INT'),NULL
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Solution)[1]', 'NVARCHAR(MAX)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Review)[1]','NVARCHAR(MAX)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Reviewer)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Subject)[1]', 'NVARCHAR(200)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Skype)[1]','NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/MSN)[1]','NVARCHAR(100)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/ResolutionDate)[1]', 'DATETIME'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Pic1)[1]','NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Pic2)[1]','NVARCHAR(100)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Pic3)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/PhoneCountryCode)[1]','NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/PhoneAreaCode)[1]','NVARCHAR(20)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone2)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone2CountryCode)[1]','NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone2AreaCode)[1]','NVARCHAR(20)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone3)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone3CountryCode)[1]','NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Phone3AreaCode)[1]','NVARCHAR(20)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/MobilePhoneCountryCode)[1]', 'NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/MobilePhoneAreaCode)[1]','NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/FaxCountryCode)[1]','NVARCHAR(20)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/FaxAreaCode)[1]', 'NVARCHAR(20)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Pic4)[1]','NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Passport)[1]','NVARCHAR(100)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Birthday)[1]', 'DATETIME'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/RefCode2)[1]','NVARCHAR(50)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/IsVip)[1]','BIT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/WhatsApp)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Line)[1]','NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/WeChat)[1]','NVARCHAR(100)')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Yahoo)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/BBM)[1]','NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/LicenseeType)[1]','INT')
,l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/QQ)[1]', 'NVARCHAR(100)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/SubProductID)[1]','INT'),
l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/AutoField)[1]','NVARCHAR(MAX)'),l.Oldvalues.value('(/Acc_CRM_FeedbackUpd/Remark)[1]','NVARCHAR(MAX)')
from crmLogFeedback l (nolock)				
	INNER JOIN #tmpMultiUpdate t ON l.FeedbackID=t.FeedbackID
WHERE ActionID = 201	
	AND l.LogID IN(1928609,1928610,1928611,1928612,1928613,1928614,1928615,1928616,1928617,1928618,1928619,1928620,1928621,1928622,1928623,1928624,1928625)

UPDATE  t
	SET t.Description= (SELECT AutoField AS AutoField, Remark AS Remark  FOR XML RAW,ROOT('ROOT'))
FROM #tmpFB t

UPDATE fb
SET 
	fb.[TitleID]=t.TitleID,fb.[FirstName]=t.FirstName ,fb.[LastName]=t.LastName,fb.[Phone]=t.Phone,fb.[MobilePhone]=t.MobilePhone ,fb.[Fax]=t.Fax,
	fb.[Email]=t.Email ,fb.[LanguageID]=t.LanguageID,fb.[CountryID]=t.CountryID ,fb.[FeedbackDate]=t.FeedbackDate,	
	fb.[SiteID]=t.SiteID,fb.[RoleID]=t.RoleID,
	fb.[ResponseID]=t.ResponseID,fb.[StatusID]=t.StatusID ,fb.[Description]=t.Description,
	fb.[Solution]=t.Solution,fb.[Review]=t.Review ,fb.[ReviewerID]=t.ReviewerID,fb.[Subject]=t.Subject,fb.[Skype]=t.Skype,fb.[MSN]=t.MSN,fb.[ResolutionDate]=t.ResolutionDate,
	fb.[Pic1]=t.Pic1 ,fb.[Pic2]=t.Pic2,fb.[Pic3]=t.Pic3 ,fb.[PhoneCountryCode]=t.PhoneCountryCode,fb.[PhoneAreaCode]=t.PhoneAreaCode,fb.[Phone2]=t.Phone2 ,fb.[Phone2CountryCode]=t.Phone2CountryCode,
	fb.[Phone2AreaCode]=t.Phone2AreaCode,fb.[Phone3]=t.Phone3,fb.[Phone3CountryCode]=t.Phone3CountryCode,fb.[Phone3AreaCode]=t.Phone3AreaCode,fb.[MobilePhoneCountryCode]=t.MobilePhoneCountryCode,
	fb.[MobilePhoneAreaCode]=t.MobilePhoneAreaCode,fb.[FaxCountryCode]=t.FaxCountryCode,fb.[FaxAreaCode]=t.FaxAreaCode ,fb.[Pic4]=t.Pic4,fb.[Passport]=t.Passport,fb.[Birthday]=t.Birthday,
	fb.[RefCode2]=t.RefCode2,fb.[IsVip]=t.IsVip,fb.[WhatsApp]=t.WhatsApp,fb.[Line]=t.Line,fb.[WeChat]=t.WeChat,fb.[Yahoo]=t.Yahoo,
	fb.[BBM]=t.BBM,fb.[LicenseeType]=t.LicenseeType ,fb.[QQ]=t.QQ ,	
	fb.[IsReviewed]=0
FROM crmFeedback fb WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tmpFB t ON fb.FeedbackID=t.FeedbackID

DELETE fs
FROM crmFeedbackSetting fs
	INNER JOIN #tmpMultiUpdate t ON fs.FeedbackID=t.FeedbackID

INSERT INTO crmFeedbackSetting(FeedbackID,SettingID,SubSettingID,SubSettingIDLevel3)
SELECT t.FeedbackID,t.MainCategoryID,t.SubCategoryID,0
FROM #tmpFB t

INSERT INTO crmFeedbackSetting(FeedbackID,SettingID,SubSettingID,SubSettingIDLevel3)
SELECT t.FeedbackID,t.CommunicationID,0,0
FROM #tmpFB t

INSERT INTO crmFeedbackSetting(FeedbackID,SettingID,SubSettingID,SubSettingIDLevel3)
SELECT t.FeedbackID,t.StationID,0,0
FROM #tmpFB t

INSERT INTO crmFeedbackSetting(FeedbackID,SettingID,SubSettingID,SubSettingIDLevel3)
SELECT t.FeedbackID,t.ProductID,t.SubProductID,t.BetTypeID
FROM #tmpFB t

DROP TABLE #tmpMultiUpdate
DROP TABLE #tmpFB
