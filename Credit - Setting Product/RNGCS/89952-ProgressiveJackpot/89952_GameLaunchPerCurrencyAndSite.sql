CREATE TABLE [dbo].[GameLaunchPerCurrency](
    [SportType] SMALLINT NOT NULL,
    [BetType] INT NOT NULL,
    [Currency] INT NOT NULL,
    [IsLaunched] BIT NOT NULL DEFAULT 0,
    [IsTest] BIT NOT NULL DEFAULT 0,
 CONSTRAINT [PK_GameLaunchPerCurrency] PRIMARY KEY CLUSTERED 
(
    [SportType] ASC,
    [BetType] ASC,
    [Currency] ASC
))

CREATE TABLE [dbo].[GameLaunchPerSite](
    [SportType] SMALLINT NOT NULL,
    [BetType] INT NOT NULL,
    [Site] NVARCHAR(50) NOT NULL,
    [IsLaunched] [BIT] NOT NULL DEFAULT 0,
    [IsTest] [BIT] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_GameLaunchPerSite] PRIMARY KEY CLUSTERED 
(
    [SportType] ASC,
    [BetType] ASC,
    [Site] ASC
))

INSERT INTO GameLaunchPerCurrency(SportType,BetType,Currency,IsLaunched,IsTest)
SELECT 208,2199,exchangeid,(CASE WHEN currency = 'HKK' THEN 0 ELSE 1 END),0
FROM exchange

INSERT INTO GameLaunchPerSite(SportType,BetType,[Site],IsLaunched,IsTest)
SELECT 208,2199,[site],0,0
FROM [Site]
