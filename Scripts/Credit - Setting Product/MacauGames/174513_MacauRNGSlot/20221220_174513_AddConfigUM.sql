/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221220@Winfred
	Task: Block Edit setting and add new customer for RNG SLOT [Redmine:#174513]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

INSERT [dbo].[UMConfig] ([ProductID], [SportType], [BetType], [IsLive], [SettingType], [FunctionType], [SiteID], [Currency], [SuperID], [BeginTime], [EndTime], [ShowTime], [LockAddingNew]) 
SELECT 18 AS ProductID,
		SportType,
		BetType,
		IsLive,
		SettingType,
		FunctionType,
		SiteID,
		Currency,
		SuperID,
		BeginTime,
		EndTime,
		BeginTime AS ShowTime,
		LockAddingNew
FROM UMConfig WITH(NOLOCK)
WHERE ProductID = 22

SELECT c.* , iSNULL(s.site,'all')
FROM UMConfig c WITH(NOLOCK) 
	LEFT JOIN Site s WITH(NOLOCK) on c.SiteID = s.siteid