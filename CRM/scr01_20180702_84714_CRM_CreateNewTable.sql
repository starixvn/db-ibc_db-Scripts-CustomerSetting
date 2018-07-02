USE [bodb_CRM]
GO
/*
Created: 20180702@Winnie
Task: Create new table RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

CREATE TABLE [dbo].[crmFeedbackSetting](
	[FeedbackID] [int] NOT NULL,
	[SettingID] [int] NOT NULL,
	[SubSettingID] [int] NOT NULL,
	[SubSettingIDLevel3] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC,
	[SettingID] ASC,
	[SubSettingID] ASC,
	[SubSettingIDLevel3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [feedback_table]
) ON [feedback_table]

GO


