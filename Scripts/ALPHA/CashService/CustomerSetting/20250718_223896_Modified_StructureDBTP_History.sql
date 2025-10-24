/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20250415@Elodie
	Task: Alpha - Agency Cash Service - modified Structure [#223896] 
	DB: DBTP/bodb_CustHistory 
*/
USE bodb_CustHistory
GO

IF OBJECT_ID ('CustProductStatus_history')	IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[CustProductStatus_History]
	ADD [ServiceType] [tinyint] NULL CONSTRAINT [DF_CustProductStatus_History_ServiceType] DEFAULT (0);
END
GO

IF OBJECT_ID ('CustWinLossLimit_Member_History') IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[CustWinLossLimit_Member_History] ALTER COLUMN [MaxWinLimit] MONEY WITH (ONLINE = ON);
END

