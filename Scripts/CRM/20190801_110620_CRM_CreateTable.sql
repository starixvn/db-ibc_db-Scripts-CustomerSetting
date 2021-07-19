/*
	Created: 20190801@Winnie
	Task: Create table
	DB: DBCRM.bodb_CRM
*/
CREATE TABLE [dbo].[crmInformHeadline_Log](
	[LogID] [int] NOT NULL IDENTITY(1,1),
	[LogDate] [datetime] NULL,
	[EditedBy] [nvarchar](50) NULL,
	[TitleID] [int] NULL,
 CONSTRAINT [PK_crmInformHeadline_Log] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

USE [bodb_CRM]
GO

CREATE TABLE [dbo].[crmInformHeadline_History](
	[LogID] [int] NOT NULL,
	[HeadlineID] [int] NOT NULL,
	[InformHeadlineStatusID] [int] NULL,
	[GroupID] [int] NULL,
	[UpdatedTime] [datetime] NULL,
	[Remark] [nvarchar](4000) NULL,
	[Handler] [int] NULL,
	[Extension] [int] NULL,
	[ProductStatus] [int] NULL,
	[IsInform] [bit] NULL,
 CONSTRAINT [PK_crmInformHeadline_History] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC,
	[HeadlineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO



