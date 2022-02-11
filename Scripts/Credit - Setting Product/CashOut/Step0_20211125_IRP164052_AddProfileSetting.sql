/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211125@Johnson
	Task: add profile setting for Cash Out
	DB: DBCust/CustDB
*/

USE [CustDB]
GO

INSERT INTO [dbo].[ProductSettingDetail]
           ([SettingType]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice])
SELECT 4,9903,1,0,25,NULL,NULL,1,1,1,1,1,1,NULL,25,NULL
GO

INSERT INTO [dbo].[ProductStatusProfile]
           ([Sporttype]
           ,[Bettype]
           ,[bitmapOrder])
SELECT 9903,1,36   