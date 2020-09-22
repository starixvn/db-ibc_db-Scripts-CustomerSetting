/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200909@Eden
	Task: Create testing Data for UMConfig table [Redmine:#136464]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DELETE FROM [UMConfig] WITH(ROWLOCK)
--INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(1, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(6, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(8, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(12, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(24, 219, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(5, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(16, 43, 0, 0, 1, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(22, 232, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(22, 212, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(22, 0, 0, 0, 0, 1, 3, 20, 45127140)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(38, 245, 0, 0, 13, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 0, 0, 0, 0, 1, 3, 20, 42710230)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 211, 0, 0, 17, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 211, 0, 0, 18, 1, 3, 20, 45127140)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 225, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 243, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(42, 200, 0, 0, 0, 1, 3, 20, 42710230)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(42, 200, 0, 0, 0, 1, 3, 20, 43181359)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(44, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(44, 220, 0, 0, 0, 1, 3, 20, 42710230)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(44, 222, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(23, 0, 0, 0, 0, 1, 3, 20, 42710230)

;WITH tmp AS(
SELECT ProductID,SportType,SiteID,SuperID,ROW_NUMBER () OVER (ORDER BY %%physloc%%) AS rownum
FROM [UMConfig] c WITH(NOLOCK)
)
UPDATE c
SET  --c.BeginTime = DATEADD(HOUR,- tmp.rownum,GETDATE()),
	--c.EndTime = DATEADD(MINUTE,tmp.rownum * 5,'2020-09-17 0:20:00')
	c.BeginTime = DATEADD(MINUTE,tmp.rownum + 10,GETDATE()),
	c.EndTime = DATEADD(MINUTE,tmp.rownum,'2020-09-22') 
FROM [UMConfig] c WITH(ROWLOCK)
	INNER JOIN tmp ON c.ProductID = tmp.ProductID
	AND c.SportType = tmp.SportType
	AND c.SiteID = tmp.SiteID
	AND c.SuperID = tmp.SuperID

SELECT c.* , iSNULL(s.site,'all')
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid

