/*
	Created: 20200811@Johnson
	Task: CRM - Missing create feedback for Void Abnormal Bet [redemine: #139158]
	DB: DBCRM/bodb_CRM
*/
---Migrate structure for crmMessageImport
 
--step 1: rename table crmMessageImport to crmMessageImport_tmp
sp_rename 'crmMessageImport', 'crmMessageImport_tmp'
GO

sp_rename 'PK_crmMessageImport', 'PK_crmMessageImport_tmp'
GO
--end step 1
---------------------------------------------------------------

----------------------------------------------------------------
--step 2: create table crmMessageImport again

CREATE TABLE [dbo].[crmMessageImport](
	[MessageID] [int] NOT NULL,
	[RequestID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[IsProcessed] [bit] NULL,	
 CONSTRAINT [PK_crmMessageImport] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC,
	[RequestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE crmMessageImport ADD CONSTRAINT DF_crmMessageImport_IsProcessed DEFAULT 0 FOR IsProcessed
GO
--end step 2
----------------------------------------------------------------


--Migrate structure for crmAutoFeedbackInfo
----------------------------------------------------------------
--Step 3: rename table crmAutoFeedbackInfo to crmAutoFeedbackInfo_tmp

sp_rename 'crmAutoFeedbackInfo', 'crmAutoFeedbackInfo_tmp'
GO

--End step 3
----------------------------------------------------------------

----------------------------------------------------------------
--Step 4: create table crmAutoFeedbackInfo to add new column RequestID 

CREATE TABLE [dbo].[crmAutoFeedbackInfo](
	[MessageID] [int] NOT NULL,
	[RequestID] [int] NOT NULL,
	[CustID] [int] NOT NULL,	
	[HeadlineID] [int] NULL,
	[RelatedCustID] [int] NULL,
	[EventInfo] [varchar](500) NULL,
	[Status] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[Description] [varchar](1000) NULL,
	[RetryCount] [tinyint] NULL
) ON [DATA]

GO

CREATE CLUSTERED INDEX [CIX_crmAutoFeedbackInfo] ON [dbo].[crmAutoFeedbackInfo] 
(
	[MessageID] ASC,
	[RequestID] ASC,
	[CustID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[crmAutoFeedbackInfo] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

--end step 4
----------------------------------------------------------------

----------------------------------------------------------------
--step 5: add new column into table SystemSetting
ALTER TABLE  SystemSetting ADD ServiceName VARCHAR(100)

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET ServiceName = 'AutoFB'

GO
--end step 5
----------------------------------------------------------------

--step 6: drop table crmMessageImport_tmp after done release
--wait signal from dev team to check service ok before run this step

--DROP TABLE crmMessageImport_tmp
--DROP TABLE crmAutoFeedbackInfo_tmp


