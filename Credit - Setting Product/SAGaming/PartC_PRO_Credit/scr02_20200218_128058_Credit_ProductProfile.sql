/*
	Created: 20200321@Tiara
	Task: Insert product profile for Allbet, SA Gaming and Sexy Gaming - PRO [Redmine:130678]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE P
FROM ProductSettingDetail P WITH (ROWLOCK)
WHERE P.SportType IN (211, 243, 244) --Allbet, Sexy Gaming, SA Gaming

DECLARE @SettingStatus INT = 0 -- PRO

INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,211,2401,0,41,93,NULL,NULL,NULL,NULL,2,3,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,211,2401,0,41,NULL,0.01,NULL,NULL,NULL,2,2,@SettingStatus,0.0005)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,4,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,5,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,211,2401,0,41,NULL,NULL,1,0,0,2,1,@SettingStatus,NULL)

INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,244,3001,0,41,93,NULL,NULL,NULL,NULL,2,3,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,244,3001,0,41,NULL,0.01,NULL,NULL,NULL,2,2,@SettingStatus,0.0005)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,244,3001,0,41,NULL,NULL,NULL,NULL,NULL,2,4,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,244,3001,0,41,NULL,NULL,NULL,NULL,NULL,2,5,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,244,3001,0,41,NULL,NULL,1,0,0,2,1,@SettingStatus,NULL)

INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,243,3101,0,41,90,NULL,NULL,NULL,NULL,2,3,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,243,3101,0,41,NULL,0.005,NULL,NULL,NULL,2,2,@SettingStatus,0.0005)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,243,3101,0,41,NULL,NULL,NULL,NULL,NULL,2,4,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,243,3101,0,41,NULL,NULL,NULL,NULL,NULL,2,5,@SettingStatus,NULL)
INSERT INTO [dbo].[ProductSettingDetail] ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,243,3101,0,41,NULL,NULL,1,0,0,2,1,@SettingStatus,NULL)
