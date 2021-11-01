/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211007
	Task:  Add 20 New Games for [Joker] - Deposit UUS RedmineID:#162717
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,20				--UUS	--IN,UUS


;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6401)

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
