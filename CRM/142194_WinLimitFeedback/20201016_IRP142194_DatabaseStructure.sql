/*
	Created: 20201016@Johnson
	Task : database structure for auto feedback winlimit [redmine:#142194]
	DB: DBCRM/bodb_CRM	
*/

CREATE TABLE crmWinLimitFeedbackInfo(
	LogID		INT
	,CustID		INT
	,HeadlineID	INT
	,HeadlineName	VARCHAR(50)
	,RelatedCustID	INT
	,ProductID		INT
	,ProductGroup	VARCHAR(200)
	,Level		VARCHAR(50)
	,MaxWinLimitSetting	MONEY
	,TotalWinAmt	MONEY
	,TotalWinAmt_RM	MONEY
	,ReachedTime	DATETIME
	,BettypeIDList	VARCHAR(1024)
	,Status			VARCHAR(20)
	,CreatedDate	DATETIME
	,UpdatedTime	DATETIME
	,Description	VARCHAR(1000)
	,RetryCount		TINYINT
) ON DATA 
GO

CREATE CLUSTERED INDEX [CIX_crmWinLimitFeedbackInfo] ON [dbo].[crmWinLimitFeedbackInfo] 
(
	[LogID] ASC,	
	[CustID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO


