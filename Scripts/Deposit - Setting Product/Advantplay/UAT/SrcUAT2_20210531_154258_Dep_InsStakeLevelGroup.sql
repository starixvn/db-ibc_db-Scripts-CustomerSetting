/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:Winfred
	Date:	20210531
	Task:	Insert Setting StakeLevelGroupDetail [AdvantPlay] - UUS deposit RedmineID:#154258
	DB:		DBCust/CustDB
	P/s :	Step 2 Insert Setting StakeLevelGroupDetail UUS
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS,YNG
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,72   			--YNG	--UUS,YNG

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
WHERE s.GameTypeID = 7701)

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