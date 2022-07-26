/*<info serverAlias="DBBOT-bodb_ChatBot" ></info>*/

/*
	Created: 20220509@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Create new tables
*/

CREATE TABLE dbo.NotificationReferenceLog
(
	NotificationID	BIGINT NULL
	,ReferenceID	BIGINT NULL
	,FunctionID		SMALLINT NULL
	,Environment    VARCHAR(20)
	,CreatedDate	DATETIME DEFAULT GETDATE()
) ON [DATA]

CREATE CLUSTERED INDEX CIX_NotificationID_ReferenceID ON dbo.NotificationReferenceLog (NotificationID, ReferenceID) ON [DATA]

CREATE NONCLUSTERED INDEX IX_FunctionID_ReferenceID ON dbo.NotificationReferenceLog (FunctionID, ReferenceID) ON [DATA]

CREATE TABLE dbo.CustBotNotification (
	NotificationID	BIGINT IDENTITY(1,1) NOT NULL
	,UserID			INT	NOT NULL
	,FunctionID		SMALLINT NOT NULL
	,Message		NVARCHAR(MAX) NULL
	,Status			VARCHAR(20) NOT NULL
	,Description	NVARCHAR(1000) NULL
	,CreatedDate	DATETIME NULL
	,UpdatedTime	DATETIME NULL
	,Retry			TINYINT NULL
	,ReferenceId	BIGINT NULL
	 CONSTRAINT PK_Notification PRIMARY KEY CLUSTERED 
	(
		NotificationID ASC
		,FunctionID ASC
		,Status ASC
	) ON [DATA]
) ON [DATA] 
GO

CREATE NONCLUSTERED INDEX [IX_UpdatedTime] ON [dbo].[CustBotNotification]
(	
	[UpdatedTime] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

