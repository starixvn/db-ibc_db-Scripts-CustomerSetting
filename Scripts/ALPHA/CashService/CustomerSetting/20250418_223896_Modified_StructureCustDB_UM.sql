/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250415@Elodie
	Task: Alpha - Agency Cash Service - modified Structure [#223896] 
	DB: DBCust/CustDB 
*/
USE CustDB
GO

IF OBJECT_ID ('CustProductStatus')	IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[CustProductStatus]
	ADD [ServiceType] [tinyint] NULL CONSTRAINT [DF_CustProductStatus_ServiceType] DEFAULT (0);
END
GO

IF OBJECT_ID ('CustWinLossLimit_Member') IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[CustWinLossLimit_Member] ALTER COLUMN [MaxWinLimit] MONEY WITH (ONLINE = ON);
END

