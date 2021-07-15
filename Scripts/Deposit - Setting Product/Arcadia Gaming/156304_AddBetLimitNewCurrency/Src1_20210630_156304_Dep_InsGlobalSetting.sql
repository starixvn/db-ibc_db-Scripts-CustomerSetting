/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210630
	Task:  Arcadia Gaming - Add more bet limit for deposit currencies (offer for 12bet Lic) RedmineID:#156304
	DB: DBCust/CustDB
*/
-- Stake level
CREATE TABLE #Dep_StakeLevel ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(10))
								
INSERT INTO #Dep_StakeLevel(GameTypeID,ExchangeId)
SELECT 1901,12     UNION ALL     -- GBP
SELECT 1901,41     UNION ALL     -- CHF
SELECT 1901,71     UNION ALL     -- KHR	
SELECT 1901,61	   UNION ALL	 -- INR	
SELECT 1901,96	   UNION ALL	 -- USDT	
SELECT 1901,121 			     -- PKR	

DELETE a
FROM #Dep_StakeLevel a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 1901

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel a

DROP TABLE #Dep_StakeLevel

-- Stake level Group
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(10))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 1902 ,'1'	,'500'		,1	 ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1903 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1904 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1905 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1907 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1908 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1909 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
SELECT 1910 ,'1'	,'500'		,1   ,500	  ,12   UNION ALL	--GBP	--GBP
SELECT 1911 ,'1'	,'500'		,1   ,500     ,12   UNION ALL	--GBP	--GBP
--CHF
SELECT 1902 ,'1'	,'500'		,1	 ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1903 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1904 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1905 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1907 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1908 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1909 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
SELECT 1910 ,'1'	,'500'		,1   ,500	  ,41   UNION ALL	--CHF	--CHF
SELECT 1911 ,'1'	,'500'		,1   ,500     ,41   UNION ALL	--CHF	--CHF
--KHR
SELECT 1902 ,'1'	,'1000'		,1	 ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1903 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1904 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1905 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1907 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1908 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1909 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1910 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
SELECT 1911 ,'1'	,'1000'		,1   ,1000    ,71   UNION ALL	--KHR	--KHR
--INR
SELECT 1902 ,'10'	,'10000'	,10	 ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1903 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1904 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1905 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1907 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1908 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1909 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1910 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 1911 ,'10'	,'10000'	,10  ,10000   ,61   UNION ALL	--INR	--INR
--RMB
SELECT 1902 ,'2'	,'1000'		,2	,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1903 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1904 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1905 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1907 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1908 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1909 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1910 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
SELECT 1911 ,'2'	,'1000'		,2  ,1000	 ,13   UNION ALL	--RMB	--RMB
--PKR
SELECT 1902 ,'10'	,'10000'	,10	 ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1903 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1904 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1905 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1907 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1908 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1909 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1910 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
SELECT 1911 ,'10'	,'10000'	,10  ,10000  ,121  UNION ALL	--PKR	--PKR
--GBP
SELECT 1902 ,'1'	,'500'		,1	 ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1903 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1904 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1905 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1907 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1908 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1909 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
SELECT 1910 ,'1'	,'500'		,1   ,500	 ,96   UNION ALL	--USDT	--USD
SELECT 1911 ,'1'	,'500'		,1   ,500    ,96   UNION ALL	--USDT	--USD
--YUN
SELECT 1904 ,'2'	,'1000'		,2  ,1000	 ,66   UNION ALL	--YUN	--YUN
SELECT 1907 ,'2'	,'1000'		,2  ,1000	 ,66   UNION ALL	--YUN	--YUN
SELECT 1908 ,'2'	,'1000'		,2  ,1000	 ,66   UNION ALL	--YUN	--YUN
SELECT 1909 ,'2'	,'1000'		,2  ,1000	 ,66   UNION ALL	--YUN	--YUN
SELECT 1910 ,'2'	,'1000'		,2  ,1000	 ,66   UNION ALL	--YUN	--YUN
SELECT 1911 ,'2'	,'1000'		,2  ,1000	 ,66				--YUN	--YUN

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 1901)

MERGE Dep_StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;
DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 