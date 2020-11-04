/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201103@Eden
	Task: Block Edit setting and add new customer for 789y [Redmine:#143764]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
DELETE FROM [UMconfig] WITH(ROWLOCK)

DECLARE @BeginTime SMALLDATETIME = DATEADD(hh,-12,'2020/11/23 9:30:00')
DECLARE @EndTime SMALLDATETIME = DATEADD(minute,150,@BeginTime) 
DECLARE @ShowTime SMALLDATETIME = DATEADD(DD,-1,@BeginTime) 

INSERT [dbo].[UMConfig] ([ProductID], [SportType], [BetType], [IsLive], [SettingType], [FunctionType], [SiteID], [Currency], [SuperID], [BeginTime], [EndTime], [ShowTime], [LockAddingNew]) VALUES (0, 0, 0, 0, 0, 1, 3, 0, 0, @BeginTime, @EndTime, @ShowTime, 1)

SELECT c.* , iSNULL(s.site,'all')
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid