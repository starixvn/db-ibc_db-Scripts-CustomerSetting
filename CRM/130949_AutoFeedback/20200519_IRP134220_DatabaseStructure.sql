/*
	Created: 20200519@@Johnson
	Task : prepare structure for tracking auto feedback info [redmine:#134220]
	DB: DBCRM/bodb_CRM	
*/
--step 1: create table crmAutoFeedbackInfo
CREATE TABLE [dbo].[crmAutoFeedbackInfo](	
	MessageID	INT NOT NULL,
	CustID		INT NOT NULL,
	HeadlineID	INT NULL,
	RelatedCustID INT NULL,
	EventInfo	VARCHAR(500) NULL,
	Status	VARCHAR(20),
	CreatedDate	DATETIME,
	UpdatedTime	DATETIME,
	Description	VARCHAR(1000) NULL,
	RetryCount	TINYINT 
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_crmAutoFeedbackInfo] ON [dbo].crmAutoFeedbackInfo 
(
	[MessageID] ASC,
	[CustID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].crmAutoFeedbackInfo 
(
	CreatedDate ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

--step 2: add new config setting
INSERT INTO SystemSetting(SettingName, Value)
SELECT 'ServiceFlag','1'
UNION SELECT 'LastRuntime',CAST(GETDATE() AS VARCHAR(20))
