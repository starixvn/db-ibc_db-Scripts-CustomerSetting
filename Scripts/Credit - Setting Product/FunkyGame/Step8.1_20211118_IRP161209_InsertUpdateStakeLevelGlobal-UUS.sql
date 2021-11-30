/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20211118
	Task: Insert Update global settings for Funky Games- UUS [RM#161209]
		GametypeID : 5510- 5528
	DB: DBCust/CustDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(32))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 5500, 20, '20', '20,000', 20, 20000 UNION ALL -- UUS
------------------------------------------------------------
SELECT 5510, 20, '5.4', '108', 5.40, 108.00 UNION ALL -- UUS
SELECT 5511, 20, '4.5', '90', 4.50, 90.00 UNION ALL -- UUS
SELECT 5512, 20, '4.8', '96', 4.80, 96.00 UNION ALL -- UUS
SELECT 5513, 20, '3', '960', 3.00, 960.00 UNION ALL -- UUS
SELECT 5514, 20, '4.5', '90', 4.50, 90.00 UNION ALL -- UUS
SELECT 5515, 20, '1.2', '132', 1.20, 132.00 UNION ALL -- UUS
SELECT 5516, 20, '1.2', '132', 1.20, 132.00 UNION ALL -- UUS
SELECT 5517, 20, '4', '80', 4.00, 80.00 UNION ALL -- UUS
SELECT 5518, 20, '5', '100', 5.00, 100.00 UNION ALL -- UUS
SELECT 5519, 20, '4.5', '90', 4.50, 90.00 UNION ALL -- UUS
SELECT 5520, 20, '4.5', '90', 4.50, 90.00 UNION ALL -- UUS
SELECT 5521, 20, '5', '100', 5.00, 100.00 UNION ALL -- UUS
SELECT 5522, 20, '5.7', '114', 5.70, 114.00 UNION ALL -- UUS
SELECT 5523, 20, '5.7', '114', 5.70, 114.00 UNION ALL -- UUS
SELECT 5524, 20, '5', '325', 5.00, 325.00 UNION ALL -- UUS
SELECT 5525, 20, '1', '800', 1.00, 800.00 UNION ALL -- UUS
SELECT 5526, 20, '1', '400', 1.00, 400.00 UNION ALL -- UUS
SELECT 5527, 20, '1', '20', 1.00, 20.00 UNION ALL -- UUS
SELECT 5528, 20, '2', '800', 2.00, 800.00 -- UUS

;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 5500
)
MERGE StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake);

DROP TABLE #StakeLevel_Temp

