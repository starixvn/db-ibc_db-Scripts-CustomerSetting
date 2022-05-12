/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220413@Johnson
	Task: Dep- Virtual Games - Incorporate 6 new games of Mine & Tower scheme [#RedmineID:#169418]
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT 34,245,4605,0,0,1,NULL,0


