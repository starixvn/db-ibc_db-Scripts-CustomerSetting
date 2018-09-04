/*
	Created: Johnson
	Date: 20180904
	Task: initial stake level settings for GD
	DB: DBCUST/CUSTDB
*/

USE [CustDB]
GO

DELETE FROM dbo.StakeLevel WHERE GameTypeID = 1704 AND ExchangeID = 20
GO

CREATE TABLE #tmpStakeLevel( GameTypeID INT, MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8), ExchangeID INT)

INSERT INTO #tmpStakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeID)
SELECT 1704, '1' AS MinLabel, '100' AS MaxLabel, 1 AS MinStake, 100 AS MaxStake, 20
UNION ALL SELECT 1704, '20' AS MinLabel, '2,500' AS MaxLabel, 20 AS MinStake, 2500 AS MaxStake, 20
UNION ALL SELECT 1704, '50' AS MinLabel, '500' AS MaxLabel, 50 AS MinStake, 500 AS MaxStake, 20
UNION ALL SELECT 1704, '1,000' AS MinLabel, '5,000' AS MaxLabel, 1000 AS MinStake, 5000 AS MaxStake, 20
UNION ALL SELECT 1704, '25,000' AS MinLabel, '1,000,000' AS MaxLabel, 25000 AS MinStake, 1000000 AS MaxStake, 20

INSERT INTO [dbo].[StakeLevel]
           ([GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           )
SELECT [GameTypeID]
	   ,[MinLabel]
	   ,[MaxLabel]
	   ,[MinStake]
	   ,[MaxStake]
	   ,[ExchangeId]
FROM #tmpStakeLevel 		   
