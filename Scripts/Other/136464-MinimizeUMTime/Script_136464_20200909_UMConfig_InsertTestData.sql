/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200909@Eden
	Task: Create testing Data for UMConfig table [Redmine:#136464]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
DELETE FROM [UMConfig] WITH(ROWLOCK)

INSERT INTO [dbo].[UMConfig](ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID) VALUES(41, 211, 0, 0, 0, 1, 21, 20, 0)


;WITH tmp AS(
SELECT ProductID,SportType,SiteID,SuperID,ROW_NUMBER () OVER (ORDER BY %%physloc%%) AS rownum
FROM [UMConfig] c WITH(NOLOCK)
)
UPDATE c
SET  --c.BeginTime = DATEADD(HOUR,- tmp.rownum,GETDATE()),
	--c.EndTime = DATEADD(MINUTE,tmp.rownum * 5,'2020-09-17 0:20:00')
	c.BeginTime = DATEADD(MINUTE,10,GETDATE()),
	c.EndTime = '2020-09-22'
FROM [UMConfig] c WITH(ROWLOCK)
	INNER JOIN tmp ON c.ProductID = tmp.ProductID
	AND c.SportType = tmp.SportType
	AND c.SiteID = tmp.SiteID
	AND c.SuperID = tmp.SuperID

SELECT c.* , iSNULL(s.site,'all')
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid


