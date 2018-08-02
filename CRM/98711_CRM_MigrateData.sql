/*
	Created by: Winnie
	Created Date: 20180801
	Description: Roll back data for Multiple Review Incident RedmineID: #98711
	Database: DB054/bodb_CRM_20180725
		
*/
USE [bodb_CRM]
GO
--Step 1: create table tmpFeedback on DB054/bodb_CRM_20180725
CREATE TABLE [dbo].[tmpFeedback](
	[FeedbackID] [int]  NOT NULL,
	[CustID] [int] NOT NULL,
	[TitleID] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](254) NULL,
	[LanguageID] [int] NULL,
	[CountryID] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreatorID] [int] NULL,
	[FeedbackDate] [datetime] NULL,
	[SolveDate] [datetime] NULL,
	[CommunicationID] [int] NULL,
	[StationID] [int] NULL,
	[MainCategoryID] [int] NULL,
	[SubCategoryID] [int] NULL,
	[SiteID] [int] NULL,
	[RoleID] [int] NULL,
	[ProductID] [int] NULL,
	[BetTypeID] [int] NULL,
	[ResponseID] [int] NULL,
	[StatusID] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Solution] [nvarchar](max) NULL,
	[IsReviewed] [bit] NOT NULL CONSTRAINT [DF_tmp_feedback_IsReviewed]  DEFAULT ((0)),
	[Review] [nvarchar](max) NULL,
	[ReviewerID] [int] NULL,
	[Subject] [nvarchar](200) NULL,
	[Skype] [nvarchar](100) NULL DEFAULT (NULL),
	[MSN] [nvarchar](100) NULL DEFAULT (NULL),
	[ResolutionDate] [datetime] NULL,
	[Pic1] [nvarchar](100) NULL,
	[Pic2] [nvarchar](100) NULL,
	[Pic3] [nvarchar](100) NULL,
	[PhoneCountryCode] [nvarchar](20) NULL,
	[PhoneAreaCode] [nvarchar](20) NULL,
	[Phone2] [nvarchar](100) NULL,
	[Phone2CountryCode] [nvarchar](20) NULL,
	[Phone2AreaCode] [nvarchar](20) NULL,
	[Phone3] [nvarchar](100) NULL,
	[Phone3CountryCode] [nvarchar](20) NULL,
	[Phone3AreaCode] [nvarchar](20) NULL,
	[MobilePhoneCountryCode] [nvarchar](20) NULL,
	[MobilePhoneAreaCode] [nvarchar](20) NULL,
	[FaxCountryCode] [nvarchar](20) NULL,
	[FaxAreaCode] [nvarchar](20) NULL,
	[Pic4] [nvarchar](100) NULL,
	[Passport] [nvarchar](100) NULL,
	[Line1] [nvarchar](100) NULL,
	[Line2] [nvarchar](100) NULL,
	[Line3] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[Postcode] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[BankLine1] [nvarchar](100) NULL,
	[BankLine2] [nvarchar](100) NULL,
	[BankLine3] [nvarchar](100) NULL,
	[BankCity] [nvarchar](100) NULL,
	[BankCode] [nvarchar](100) NULL,
	[BankState] [nvarchar](100) NULL,
	[Birthday] [datetime] NULL,
	[RefCode1] [nvarchar](50) NULL,
	[RefCode2] [nvarchar](50) NULL,
	[IsVip] [bit] NULL,
	[Pic1Name] [nvarchar](200) NULL,
	[Pic2Name] [nvarchar](200) NULL,
	[Pic3Name] [nvarchar](200) NULL,
	[Pic4Name] [nvarchar](200) NULL,
	[WhatsApp] [nvarchar](100) NULL,
	[Line] [nvarchar](100) NULL,
	[WeChat] [nvarchar](100) NULL,
	[Yahoo] [nvarchar](100) NULL,
	[BBM] [nvarchar](100) NULL,
	[LicenseeType] [int] NULL,
	[QQ] [nvarchar](100) NULL,
	[SubProductID] [int] NULL,
 CONSTRAINT [PK_tmp_Feedback] PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [feedback_table]
) ON [feedback_table] TEXTIMAGE_ON [feedback_table]

GO

-- Step2: Insert data into the table tmpFeedback  on DB054/bodb_CRM_20180725
INSERT INTO [dbo].[tmpFeedback]
           (FeedbackID
		   ,[CustID]
           ,[TitleID]
           ,[FirstName]
           ,[LastName]
           ,[Phone]
           ,[MobilePhone]
           ,[Fax]
           ,[Email]
           ,[LanguageID]
           ,[CountryID]
           ,[CreateDate]
           ,[CreatorID]
           ,[FeedbackDate]
           ,[SolveDate]
           ,[CommunicationID]
           ,[StationID]
           ,[MainCategoryID]
           ,[SubCategoryID]
           ,[SiteID]
           ,[RoleID]
           ,[ProductID]
           ,[BetTypeID]
           ,[ResponseID]
           ,[StatusID]
           ,[Description]
           ,[Solution]
           ,[IsReviewed]
           ,[Review]
           ,[ReviewerID]
           ,[Subject]
           ,[Skype]
           ,[MSN]
           ,[ResolutionDate]
           ,[Pic1]
           ,[Pic2]
           ,[Pic3]
           ,[PhoneCountryCode]
           ,[PhoneAreaCode]
           ,[Phone2]
           ,[Phone2CountryCode]
           ,[Phone2AreaCode]
           ,[Phone3]
           ,[Phone3CountryCode]
           ,[Phone3AreaCode]
           ,[MobilePhoneCountryCode]
           ,[MobilePhoneAreaCode]
           ,[FaxCountryCode]
           ,[FaxAreaCode]
           ,[Pic4]
           ,[Passport]
           ,[Line1]
           ,[Line2]
           ,[Line3]
           ,[City]
           ,[Postcode]
           ,[State]
           ,[BankLine1]
           ,[BankLine2]
           ,[BankLine3]
           ,[BankCity]
           ,[BankCode]
           ,[BankState]
           ,[Birthday]
           ,[RefCode1]
           ,[RefCode2]
           ,[IsVip]
           ,[Pic1Name]
           ,[Pic2Name]
           ,[Pic3Name]
           ,[Pic4Name]
           ,[WhatsApp]
           ,[Line]
           ,[WeChat]
           ,[Yahoo]
           ,[BBM]
           ,[LicenseeType]
           ,[QQ]
           ,[SubProductID])
	SELECT	
			f.FeedbackID	
		   ,f.[CustID]
           ,f.[TitleID]
           ,f.[FirstName]
           ,f.[LastName]
           ,f.[Phone]
           ,f.[MobilePhone]
           ,f.[Fax]
           ,f.[Email]
           ,f.[LanguageID]
           ,f.[CountryID]
           ,f.[CreateDate]
           ,f.[CreatorID]
           ,f.[FeedbackDate]
           ,f.[SolveDate]
           ,f.[CommunicationID]
           ,f.[StationID]
           ,f.[MainCategoryID]
           ,f.[SubCategoryID]
           ,f.[SiteID]
           ,f.[RoleID]
           ,f.[ProductID]
           ,f.[BetTypeID]
           ,f.[ResponseID]
           ,f.[StatusID]
           ,f.[Description]
           ,f.[Solution]
           ,f.[IsReviewed]
           ,f.[Review]
           ,f.[ReviewerID]
           ,f.[Subject]
           ,f.[Skype]
           ,f.[MSN]
           ,f.[ResolutionDate]
           ,f.[Pic1]
           ,f.[Pic2]
           ,f.[Pic3]
           ,f.[PhoneCountryCode]
           ,f.[PhoneAreaCode]
           ,f.[Phone2]
           ,f.[Phone2CountryCode]
           ,f.[Phone2AreaCode]
           ,f.[Phone3]
           ,f.[Phone3CountryCode]
           ,f.[Phone3AreaCode]
           ,f.[MobilePhoneCountryCode]
           ,f.[MobilePhoneAreaCode]
           ,f.[FaxCountryCode]
           ,f.[FaxAreaCode]
           ,f.[Pic4]
           ,f.[Passport]
           ,f.[Line1]
           ,f.[Line2]
           ,f.[Line3]
           ,f.[City]
           ,f.[Postcode]
           ,f.[State]
           ,f.[BankLine1]
           ,f.[BankLine2]
           ,f.[BankLine3]
           ,f.[BankCity]
           ,f.[BankCode]
           ,f.[BankState]
           ,f.[Birthday]
           ,f.[RefCode1]
           ,f.[RefCode2]
           ,f.[IsVip]
           ,f.[Pic1Name]
           ,f.[Pic2Name]
           ,f.[Pic3Name]
           ,f.[Pic4Name]
           ,f.[WhatsApp]
           ,f.[Line]
           ,f.[WeChat]
           ,f.[Yahoo]
           ,f.[BBM]
           ,f.[LicenseeType]
           ,f.[QQ]
           ,f.[SubProductID]
	FROM [dbo].[tmpFB__bk__001] t WITH(NOLOCK)
		INNER JOIN crmFeedback f WITH(NOLOCK) ON t.FeedbackId=f.FeedbackID
	WHERE t.FeedbackId<>533816

-- Step3: Bring table tmpFeedback on DB054/bodb_CRM_20180725 to DB052/bodb_CRM 
SELECT * INTO tmpFeedback FROM DB054.bodb_CRM_20180725.dbo.tmpFeedback

-- Step 4: Run on DB052/bodb_CRM
UPDATE fb
   SET fb.[CustID] = t.[CustID]
      ,fb.[TitleID]=t.TitleID
      ,fb.[FirstName] = t.[FirstName]
      ,fb.[LastName] = t.[LastName]
      ,fb.[Phone] = t.[Phone]
      ,fb.[MobilePhone] = t.[MobilePhone]
      ,fb.[Fax] = t.[Fax]
      ,fb.[Email] = t.[Email]
      ,fb.[LanguageID] = t.[LanguageID]
      ,fb.[CountryID] = t.[CountryID]
      ,fb.[CreateDate] = t.[CreateDate]
      ,fb.[CreatorID] = t.[CreatorID]
      ,fb.[FeedbackDate] = t.[FeedbackDate]
      ,fb.[SolveDate] = t.[SolveDate]
      ,fb.[CommunicationID] = t.[CommunicationID]
      ,fb.[StationID] = t.[StationID]
      ,fb.[MainCategoryID] = t.[MainCategoryID]
      ,fb.[SubCategoryID] = t.[SubCategoryID]
      ,fb.[SiteID] = t.[SiteID]
      ,fb.[RoleID] = t.[RoleID]
      ,fb.[ProductID] = t.[ProductID]
      ,fb.[BetTypeID] = t.[BetTypeID]
      ,fb.[ResponseID] = t.[ResponseID]
      ,fb.[StatusID] = t.[StatusID]
      ,fb.[Description] = t.[Description]
      ,fb.[Solution] = t.[Solution]
      ,fb.[IsReviewed] = t.[IsReviewed]
      ,fb.[Review] = t.[Review]
      ,fb.[ReviewerID] = t.[ReviewerID]
      ,fb.[Subject] = t.[Subject]
      ,fb.[Skype] = t.[Skype]
      ,fb.[MSN] = t.[MSN]
      ,fb.[ResolutionDate] = t.[ResolutionDate]
      ,fb.[Pic1] = t.[Pic1]
      ,fb.[Pic2] = t.[Pic2]
      ,fb.[Pic3] = t.[Pic3]
      ,fb.[PhoneCountryCode] = t.[PhoneCountryCode]
      ,fb.[PhoneAreaCode] = t.[PhoneAreaCode]
      ,fb.[Phone2] = t.[Phone2]
      ,fb.[Phone2CountryCode] = t.[Phone2CountryCode]
      ,fb.[Phone2AreaCode] = t.[Phone2AreaCode]
      ,fb.[Phone3] = t.[Phone3]
      ,fb.[Phone3CountryCode] = t.[Phone3CountryCode]
      ,fb.[Phone3AreaCode] = t.[Phone3AreaCode]
      ,fb.[MobilePhoneCountryCode] = t.[MobilePhoneCountryCode]
      ,fb.[MobilePhoneAreaCode] = t.[MobilePhoneAreaCode]
      ,fb.[FaxCountryCode] = t.[FaxCountryCode]
      ,fb.[FaxAreaCode] = t.[FaxAreaCode]
      ,fb.[Pic4] = t.[Pic4]
      ,fb.[Passport] = t.[Passport]
      ,fb.[Line1] = t.[Line1]
      ,fb.[Line2] = t.[Line2]
      ,fb.[Line3] = t.[Line3]
      ,fb.[City] = t.[City]
      ,fb.[Postcode] = t.[Postcode]
      ,fb.[State] = t.[State]
      ,fb.[BankLine1] = t.[BankLine1]
      ,fb.[BankLine2] = t.[BankLine2]
      ,fb.[BankLine3] = t.[BankLine3]
      ,fb.[BankCity] = t.[BankCity]
      ,fb.[BankCode] = t.[BankCode]
      ,fb.[BankState] = t.[BankState]
      ,fb.[Birthday] = t.[Birthday]
      ,fb.[RefCode1] = t.[RefCode1]
      ,fb.[RefCode2] = t.[RefCode2]
      ,fb.[IsVip] = t.[IsVip]
      ,fb.[Pic1Name] = t.[Pic1Name]
      ,fb.[Pic2Name] = t.[Pic2Name]
      ,fb.[Pic3Name] = t.[Pic3Name]
      ,fb.[Pic4Name] = t.[Pic4Name]
      ,fb.[WhatsApp] = t.[WhatsApp]
      ,fb.[Line] = t.[Line]
      ,fb.[WeChat] = t.[WeChat]
      ,fb.[Yahoo] = t.[Yahoo]
      ,fb.[BBM] = t.[BBM]
      ,fb.[LicenseeType] = t.[LicenseeType]
      ,fb.[QQ] = t.[QQ]
      ,fb.[SubProductID] = t.[SubProductID]
FROM crmfeedback fb WITH(ROWLOCK,UPDLOCK)
	INNER JOIN tmpFeedback t WITH(NOLOCK) ON t.feedbackID=fb.FeedbackID