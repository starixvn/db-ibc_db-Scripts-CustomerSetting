/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220412@Johnson
	Task: Virtual Games - Incorporate 6 new games of Mine & Tower scheme [#RedmineID:#169418]
	DB: DBCUST/CustDB
*/

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
SELECT 7,245,4605,0,64,NULL,NULL,NULL,NULL,NULL,4,4,0,NULL,38,NULL      