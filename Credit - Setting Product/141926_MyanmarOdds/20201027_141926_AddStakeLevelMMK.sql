/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevel for ION offer site 76666B - Credit RedmineID:#141926
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								MinLabel NVARCHAR(50),
								MaxLabel NVARCHAR(50),
								MinStake DECIMAL(19,8),
								MaxStake DECIMAL(19,8),
								ExchangeId int,
								GameGroupID int default(0))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
SELECT 5601,'500' ,'5,000,000'   ,500 ,5000000 ,69    -- MMK

MERGE StakeLevel as g 
USING #StakeLevel_Temp s on g.GameTypeID = s.GameTypeID AND g.ExchangeId =  s.ExchangeId
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake = s.MinStake,
					g.MaxStake = s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
					VALUES (s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake,s.ExchangeId)					
					 ;

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 