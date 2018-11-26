/*
	Created: Winnie
	Date: 20181123
	Task: VS Betradar 3 - Virtual Soccer Asian Cup [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

CREATE TABLE #tmpProductLaunchedSiteCurrency(
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[IsLaunched] [bit] NOT NULL,
	[IsTest] [tinyint] NOT NULL,
)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (1, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (3, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (11, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (13, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (16, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (20, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (21, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (22, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (23, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (24, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (25, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (29, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (32, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (35, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (109, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (147, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (184, 0, 194, 0, 0)
GO
INSERT #tmpProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest]) VALUES (188, 0, 194, 0, 0)
GO


UPDATE #tmpProductLaunchedSiteCurrency
SET IsLaunched=1

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest])
SELECT [SiteID], [Currency], [SportType], [IsLaunched], [IsTest]
FROM #tmpProductLaunchedSiteCurrency