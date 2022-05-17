/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220322@Johnson
	Task: Database structure change for telegram bot service [#RedmineID:#165682]
	DB: DBBOT/bodb_Chatbot
*/

----------------------------------------------------------------------------------
---Bot

CREATE TABLE [dbo].[Bot](
	[BotId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [VARCHAR](200) NOT NULL,
	[System] [VARCHAR](50) NOT NULL,
	[Accesstoken] [VARCHAR](500) NOT NULL,
	[Status] [bit],
	[IsTest] [bit],	
 CONSTRAINT [PK_Bot] PRIMARY KEY CLUSTERED 
(
	[BotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotAccount

CREATE TABLE [dbo].[CustBotAccount](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[CustId] [int] NOT NULL,
	[SubAccId] [int] NOT NULL,
	[Language] [varchar](10) NULL,
	[CustomerLevel] [tinyint] NOT NULL,	
 CONSTRAINT [PK_CustBotAccount] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
CREATE CLUSTERED INDEX [CIX_CustID] ON [dbo].[CustBotAccount]
(
	[CustId] ASC,
	[SubAccId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotMessenger

CREATE TABLE [dbo].[CustBotMessenger](
	[UserId] [int] NOT NULL,
	[BotId] [int] NOT NULL,
	[ChatId] [bigint] NOT NULL,	
	[Status] [bit] NULL,	
	[IsVerifyOTP] [bit] NULL,
 CONSTRAINT [PK_CustBotMessenger] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[BotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---BotFunction

CREATE TABLE [dbo].[BotFunction](
	[FunctionID] [SMALLINT] NOT NULL,
	[FunctionName] [VARCHAR](500) NOT NULL,
	[FunctionKey] [VARCHAR](50),
	[Type] [TINYINT],
	[Command] [VARCHAR](50),	
	[Status] [TINYINT] NULL,
	[Order] [SMALLINT],
 CONSTRAINT [PK_BotFunction] PRIMARY KEY CLUSTERED 
(
	[FunctionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---BotAction

CREATE TABLE [dbo].[BotAction](
	[ActionID] [SMALLINT] NOT NULL,
	[ActionName] [VARCHAR](500) NOT NULL,	
	[Type] [TINYINT],
	[Command] [VARCHAR](50),	
	[FunctionID] SMALLINT,
	[ParentID] SMALLINT,
	[Status] [TINYINT] NULL,
	[IsEndAction] [BIT],	
 CONSTRAINT [PK_BotAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotFunction

CREATE TABLE [dbo].[CustBotFunction](
	[UserID] [INT] NOT NULL,
	[FunctionID] [INT] NOT NULL,	
	[Status] [TINYINT] NULL,		
 CONSTRAINT [PK_CustBotFunction] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[FunctionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotAction

CREATE TABLE [dbo].[CustBotAction](
	[LogActionID] [BIGINT] NOT NULL IDENTITY(1,1),
	[UserID] [INT] NOT NULL,
	[ActionID] [INT] NOT NULL,	
	[UserResponse] [NVARCHAR](500),		
	[CompiledCommand] [NVARCHAR](500),
	[CreatedDate] DATETIME,
	[Status] TINYINT
 CONSTRAINT [PK_CustBotAction] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotMessage

CREATE TABLE [dbo].[CustBotMessage](
	[MessageID] [BIGINT] NOT NULL IDENTITY(1,1),
	[Sender] [INT] NOT NULL,
	[Receiver] [INT] NOT NULL,	
	[ChatID] [BIGINT],
	[BotID] [INT],
	[FunctionId] [SMALLINT],
	[Message] [NVARCHAR](4000),			
	[CreatedDate] [DATETIME],
	[Status] [TINYINT]
 CONSTRAINT [PK_CustBotMessage] PRIMARY KEY NONCLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_CreatedDate] ON [dbo].[CustBotMessage]
(
	[CreatedDate] ASC,
	[FunctionId] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

----------------------------------------------------------------------------------
---BotResource

CREATE TABLE [dbo].[BotResource](
	[ResourceName] [VARCHAR](100),
	[ResourceKey] [VARCHAR](100),
	[Language]  [VARCHAR](10),	
	[Value] [VARCHAR](1000)) ON DATA
GO
	
CREATE CLUSTERED INDEX [CIX_BotResource] ON BotResource
(
	[ResourceName] ASC,
	[ResourceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]

GO

----------------------------------------------------------------------------------
---BotSystemSetting

CREATE TABLE [dbo].[BotSystemSetting](
	[ID] [SMALLINT] NOT NULL IDENTITY(1,1),
	[ServiceName] [VARCHAR](100),
	[SettingName] [VARCHAR](100),	
	[Value] [VARCHAR](1000),
CONSTRAINT [PK_BotSystemSetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

----------------------------------------------------------------------------------
---CustBotNotification


CREATE TABLE [dbo].[CustBotNotification](
	[NotificationID] [BIGINT] NOT NULL IDENTITY(1,1),
	[UserID] [INT] NOT NULL,	
	[FunctionID] [SMALLINT] NOT NULL,		
	[Message] [NVARCHAR](MAX),
	[Status] [VARCHAR](20),
	[Description] [NVARCHAR](1000),			
	[CreatedDate] [DATETIME],
	[UpdatedTime] [DATETIME],
	[Environment] [VARCHAR](10),
 CONSTRAINT [PK_CustBotNotification] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO



