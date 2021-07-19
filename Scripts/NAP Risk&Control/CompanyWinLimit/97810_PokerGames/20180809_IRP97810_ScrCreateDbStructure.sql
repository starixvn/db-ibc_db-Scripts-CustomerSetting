/*
	Created: Johnson
	Date: 2018-08-09
	Task: add new table Winlimit_ProductOffer to config product which offer winlimit
	DB: DBCUST/CUSTDB
*/

USE [CustDB]
GO

/****** Object:  Table [dbo].[Winlimit_ProductOffer]    Script Date: 08/09/2018 13:30:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Winlimit_ProductOffer](
	[ProductID] [tinyint] NOT NULL,
	[BettypeID] [smallint] NOT NULL,
	[isActive_SMA] [bit] NOT NULL,
	[isActive_Company] [bit] NOT NULL,
 CONSTRAINT [PK_Winlimit_ProductOffer] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BettypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WinlimitSetting_Tables]
) ON [WinlimitSetting_Tables]

GO

ALTER TABLE [dbo].[Winlimit_ProductOffer] ADD  CONSTRAINT [DF_Winlimit_ProductOffer_isActive_SMA]  DEFAULT ((0)) FOR [isActive_SMA]
GO

ALTER TABLE [dbo].[Winlimit_ProductOffer] ADD  CONSTRAINT [DF_Winlimit_ProductOffer_isActive_Company]  DEFAULT ((0)) FOR [isActive_Company]
GO
---------------------------------------------------------------------------------


--initial data for Winlimit_ProductOffer
INSERT INTO Winlimit_ProductOffer(ProductID,BettypeID,isActive_SMA,isActive_Company)
SELECT 4 AS ProductId, 1101 AS BetType, 1 AS IsActive_SMA, 1 AS IsActive_Company 
UNION ALL
SELECT 6, 2101, 1, 1 -- RNG Casino
UNION ALL
SELECT 12, 1701, 1, 1 -- Gold Deluxe
UNION ALL
SELECT 13, 2001, 0, 1 -- Microgaming - Live Casino
UNION ALL 
SELECT 17, 2008, 0, 1 -- Microgaming - RNG Casino
UNION ALL
SELECT 22, 4001, 1, 1 -- Macau Games
UNION ALL
SELECT 21, 2401, 1, 1 -- Allbet
UNION ALL
SELECT 24, 1011, 1, 1 -- Fishing World
UNION ALL
-- Phase 3: add more
SELECT 3, 81, 0, 1 --Number Game
UNION ALL				
SELECT 5, 1201, 1, 1 --Virtual Sports
UNION ALL
SELECT 8, 1501, 0, 1  -- Keno
UNION ALL		
SELECT 28, 1021, 1, 1  -- Lottery 
--UNION ALL
--SELECT 14, 1900, 0, 1  -- Macau

UNION ALL
SELECT 27, 2701, 0, 1  -- BetradarVS
						
UNION ALL
SELECT 26, 1600, 0,1 --Lucky 3
UNION ALL
SELECT 30, 1004, 1, 1  -- BullFighting
UNION ALL 
SELECT 32, 4101, 0, 1 --Pragmatic Integration
UNION ALL 
SELECT 33, 1401, 1, 1 --PockerGames