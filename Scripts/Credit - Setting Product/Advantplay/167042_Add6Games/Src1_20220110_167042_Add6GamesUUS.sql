/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220110
	Task: Add new 6 games for AdvantPlay UUS RedmineID:#167042
	DB: DBCust/CustDB
	P/s : Add new 6 games StakeLevelGroupDetail AdvantPlay  UUS
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(27))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 7717 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7718 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7719 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7720 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7721 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 7722 ,'5'  	,'200'     ,5  	 ,200     ,20   UNION ALL	--UUS	--UUS,YNG
--YNG
SELECT 7717 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7718 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7719 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7720 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7721 ,'5'  	,'200'     ,5  	 ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 7722 ,'5'  	,'200'     ,5  	 ,200     ,72   			--YNG	--UUS,YNG


;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7701)

MERGE StakeLevelGroupDetail as g 
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
DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 