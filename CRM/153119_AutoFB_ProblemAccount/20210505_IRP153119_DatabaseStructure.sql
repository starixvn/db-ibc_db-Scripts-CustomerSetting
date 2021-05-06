/*
	Created: 20210505@Johnson
	DB: DBCRM/bodb_CRM
	Task: Auto-create Feedback - Integrate Problem Account Marked
*/

--step 1: create table crmProblemAccountFeedbackInfo
CREATE TABLE [dbo].[crmProblemAccountFeedbackInfo](	
	LogID		INT NOT NULL,
	CustID		INT NOT NULL,
	CategoryID	SMALLINT,
	HeadlineID	INT NULL,
	RelatedCustID INT NULL,	
	Status	VARCHAR(20),
	CreatedDate	DATETIME,
	UpdatedTime	DATETIME,
	Description	VARCHAR(1000) NULL,
	RetryCount	TINYINT 
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_crmProblemAccountFeedbackInfo] ON [dbo].crmProblemAccountFeedbackInfo 
(
	[LogID] ASC,
	[CustID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].crmProblemAccountFeedbackInfo 
(
	CreatedDate ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO
