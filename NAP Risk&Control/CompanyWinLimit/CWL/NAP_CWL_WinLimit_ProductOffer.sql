/*
	Creator:	20191028@Robert
	Task:	Initial settings for #122849 - CWL - create new table WinLimit_ProductOffer
	Database:	DBTXN.bodb02
	
	Revisions:
		- 20191028@Robert:	Initial settings for #122849 - CWL - create new table WinLimit_ProductOffer
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

USE [bodb02];
GO

CREATE TABLE dbo.WinLimit_ProductOffer(
	ProductID           TINYINT NOT NULL
   , BetType             SMALLINT
   , IsActive_SMA        BIT
   , IsActive_Company    BIT
	CONSTRAINT PK_WinLimit_ProductOffer PRIMARY KEY CLUSTERED (ProductID ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [winlimit_table])
ON [winlimit_table];
GO

INSERT INTO dbo.WinLimit_ProductOffer(ProductID
							 , BetType
							 , IsActive_SMA
							 , IsActive_Company)
	  SELECT 3 AS ProductId
		  , 81 AS BetType
		  , 0 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 4 AS ProductId
		  , 1101 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 5 AS ProductId
		  , 1201 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 6 AS ProductId
		  , 2101 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 8 AS ProductId
		  , 1501 AS BetType
		  , 0 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 12 AS ProductId
		  , 1701 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 21 AS ProductId
		  , 2401 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 22 AS ProductId
		  , 4001 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 24 AS ProductId
		  , 1011 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 27 AS ProductId
		  , 2701 AS BetType
		  , 0 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 28 AS ProductId
		  , 1021 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 32 AS ProductId
		  , 4001 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 34 AS ProductId
		  , 4001 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 36 AS ProductId
		  , 4001 AS BetType
		  , 1 AS IsActive_SMA
		  , 1 AS IsActive_Company
	  UNION ALL
	  SELECT 38 AS ProductId
		  , 4601 AS BetType
		  , 0 AS IsActive_SMA
		  , 1 AS IsActive_Company