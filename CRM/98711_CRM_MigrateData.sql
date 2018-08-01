/*
	Created by: Winnie
	Created Date: 20180801
	Description: Roll back data for Multiple Review Incident RedmineID: #98711
	Database: DB054/bodb_CRM
		
*/
USE [bodb_CRM]
GO
--Step 1: create table tmpFeedback on DB054/bodb_CRM
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

-- Step2: Insert data into the table tmpFeedback
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

-- Step3: Update data from table tmpFeedback on DB054 to table crmFeedback on DB052 by FeedbackID