/*
    Created: Vicky
    Task: create table GameLaunchPerCurrency
    DB: DBCUST/CustDB
    Date: 20180220
*/

CREATE TABLE [dbo].[GameLaunchPerCurrency](
    [SportType] SMALLINT NOT NULL,
    [BetType] INT NOT NULL,
    [Currency] INT NOT NULL,
    [IsLaunched] BIT NOT NULL DEFAULT 0,
    [IsTest] BIT NOT NULL DEFAULT 0,
 CONSTRAINT [PK_GameLaunchPerCurrency] PRIMARY KEY CLUSTERED 
(
    [Currency] ASC,
    [SportType] ASC,
    [BetType] ASC
))

CREATE TABLE [dbo].[GameLaunchPerSite](
    [SportType] SMALLINT NOT NULL,
    [BetType] INT NOT NULL,
    [SiteID] INT NOT NULL,
    [IsLaunched] BIT NOT NULL DEFAULT 0,
    [IsTest] BIT NOT NULL DEFAULT 0,
 CONSTRAINT [PK_GameLaunchPerSite] PRIMARY KEY CLUSTERED 
(
    [SiteID] ASC,
    [SportType] ASC,
    [BetType] ASC

))

INSERT INTO GameLaunchPerCurrency(SportType,BetType,Currency,IsLaunched,IsTest)
SELECT 208,2179,exchangeid,(CASE WHEN currency = 'HKK' THEN 0 ELSE 1 END),1
FROM exchange

INSERT INTO GameLaunchPerSite(SportType,BetType,[SiteId],IsLaunched,IsTest)
SELECT 208,2179,[siteId],0,1
FROM [Site]
