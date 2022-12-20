/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221220@Winfred
	Task: Block Edit setting and add new customer for RNG SLOT [Redmine:#174513]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

DECLARE @BeginTime SMALLDATETIME = DATEADD(hh,-12,'2022/12/22 8:00:00')
DECLARE @EndTime SMALLDATETIME = DATEADD(minute,20,@BeginTime) 
DECLARE @ShowTime SMALLDATETIME = DATEADD(DD,-1,@BeginTime) 

INSERT [dbo].[UMConfig] ([ProductID], [SportType], [BetType], [IsLive], [SettingType], [FunctionType], [SiteID], [Currency], [SuperID], [BeginTime], [EndTime], [ShowTime], [LockAddingNew]) 
VALUES (18, 0, 0, 0, 0, 1, 0, 0, 0, @BeginTime, @EndTime, @ShowTime, 1)

SELECT c.* , iSNULL(s.site,'all')
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid