/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20230803
	Task: Add columns for In House Replication [Redmine:#189389] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

ALTER TABLE SportBettypeSettingMatrix ADD [ProductID] [tinyint] NULL;
ALTER TABLE SportBettypeSettingMatrix ADD [isDeleted] BIT NULL;
ALTER TABLE SportBettypeSettingMatrix ADD [RepUpdateTime] [datetime2](7) NULL;


ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix]
(
	[RepUpdateTime] ASC
)