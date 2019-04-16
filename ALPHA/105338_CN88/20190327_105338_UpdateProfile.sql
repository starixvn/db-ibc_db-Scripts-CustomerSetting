/*
	Created: 20190327@Elodie
	Task: Update product profile for CN88
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE FROM CS_GroupConfig

INSERT INTO dbo.CS_GroupConfig (GroupId, SportType, BetType, IsLive, GroupName, uGroup, MaxValue)
SELECT 1, 1, 1, 0,'A', 'a', 0.0225 UNION ALL 
SELECT 2, 1, 1, 0,'B', 'b', 0.0125 UNION ALL 
SELECT 3, 1, 1, 0,'C', 'd', 0.0075 UNION ALL 
SELECT 4, 1, 1, 0,'D', 'd', 0 UNION ALL 
SELECT 5, 1, 1, 1,'A', 'a', 0.0225 UNION ALL 
SELECT 6, 1, 1, 1,'B', 'b', 0.0125 UNION ALL 
SELECT 7, 1, 1, 1,'C', 'c', 0.0075 UNION ALL 
SELECT 8, 1, 1, 1,'D', 'd', 0 UNION ALL 
SELECT 9, 2, 1, 0,'A', 'a', 0.0225 UNION ALL 
SELECT 10, 2, 1, 0,'B', 'b', 0.0125 UNION ALL 
SELECT 11, 2, 1, 0,'C', 'd', 0.0075 UNION ALL 
SELECT 12, 2, 1, 0,'D', 'd', 0 UNION ALL 
SELECT 13, 2, 1, 1,'A', 'a', 0.0225 UNION ALL 
SELECT 14, 2, 1, 1,'B', 'b', 0.0125 UNION ALL 
SELECT 15, 2, 1, 1,'C', 'c', 0.0075 UNION ALL 
SELECT 16, 2, 1, 1,'D', 'd', 0 UNION ALL 
SELECT 17, 99, 1, 0,'A', 'a', 0.0225 UNION ALL 
SELECT 18, 99, 1, 0,'B', 'b', 0.0125 UNION ALL 
SELECT 19, 99, 1, 0,'C', 'c', 0.0075 UNION ALL 
SELECT 20, 99, 1, 0,'D', 'd', 0 UNION ALL 
SELECT 21, 99, 1, 1,'A', 'a', 0.0225 UNION ALL 
SELECT 22, 99, 1, 1,'B', 'b', 0.0125 UNION ALL 
SELECT 23, 99, 1, 1,'C', 'c', 0.0075 UNION ALL 
SELECT 24, 99, 1, 1,'D', 'd', 0