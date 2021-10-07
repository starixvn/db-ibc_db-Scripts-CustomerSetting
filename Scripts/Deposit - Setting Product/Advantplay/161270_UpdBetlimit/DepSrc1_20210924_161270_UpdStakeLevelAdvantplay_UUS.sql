/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210924
	Task:  Update Setting StakeLevelGroupDetail for AdvantPlay UUS Deposit RedmineID:#161270
	DB: DBCust/CustDB
	P/s : Update Setting StakeLevelGroupDetail AdvantPlay  UUS Deposit
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 7701 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7702 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7703 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7704 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7705 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7706 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7707 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7708 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7709 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7710 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7711 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7712 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
--YNG
SELECT 7701 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7702 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7703 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7704 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7705 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7706 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7707 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7708 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7709 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7710 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7711 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7712 ,'5'  	,'200'     ,5  	 ,200     ,72				--YNG	--UUS,YNG

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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 