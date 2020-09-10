/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200909@Eden
	Task: Create testing Data for UMConfig table [Redmine:#136464]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
DELETE FROM [UMConfig] WITH(ROWLOCK)

INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(1, 0, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(1, 0, 0, 0, 0, 1, 22, 20, 42689203)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(6, 0, 0, 0, 0, 1, 0, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(8, 0, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(12, 0, 0, 0, 0, 1, 0, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(23, 213, 0, 0, 0, 1, 3, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(42, 200, 0, 0, 0, 1, 0, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(22, 212, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(22, 165, 0, 0, 0, 1, 1, 20, 1176070)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(38, 245, 0, 0, 1, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(24, 219, 0, 0, 13, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 211, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 225, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 243, 0, 0, 0, 1, 22, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(44, 220, 0, 0, 0, 1, 1, 20, 0)
INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(44, 222, 0, 0, 0, 1, 1, 20, 0)

;WITH tmp AS(
SELECT ProductID,SportType,SiteID,SuperID,ROW_NUMBER () OVER (ORDER BY %%physloc%%) AS rownum
FROM [UMConfig] c WITH(NOLOCK)
)
UPDATE c
SET  c.BeginTime = DATEADD(HOUR,- tmp.rownum,GETDATE())
	,c.EndTime = DATEADD(HOUR,tmp.rownum,GETDATE())
FROM [UMConfig] c WITH(ROWLOCK)
	INNER JOIN tmp ON c.ProductID = tmp.ProductID
	AND c.SportType = tmp.SportType
	AND c.SiteID = tmp.SiteID
	AND c.SuperID = tmp.SuperID

SELECT c.* , s.site
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid


