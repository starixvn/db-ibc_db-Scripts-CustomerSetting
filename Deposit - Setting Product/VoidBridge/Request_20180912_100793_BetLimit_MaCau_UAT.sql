/*
	Created By: Winnie
	Created Date: 20180912
	Description: Stakelevel for MaCau UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO
CREATE TABLE #Betlimit(
	GameType varchar(50) NULL,
	Game varchar(50) NULL,
	Level varchar(50) NULL,
	Currency varchar(50) NULL,
	BetLimit varchar(50) NULL
)
GO

GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' UUS ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' UUS ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' UUS ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' UUS ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' UUS ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' UUS ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' UUS ', N'0.15 - 30')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' UUS ', N'0.25 - 50')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' UUS ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' UUS ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' UUS ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' UUS ', N'0.09 - 18')
GO

CREATE TABLE #BetlimitDeposit(	
	GameType		INT			NOT NULL,		
	CurrencyID		INT			NOT NULL,
	BetLimit		VARCHAR(50)	NOT NULL,
	StakeLevelID	INT			NOT NULL
) 
CREATE TABLE #BetlimitCredit(
	GameType		INT				NOT NULL,		
	Level			INT				NOT NULL,
	CurrencyID		INT				NOT NULL,
	BetLimit		VARCHAR(50)		NOT NULL,
	StakeLevelID	INT				NOT NULL
) 
INSERT INTO #BetlimitDeposit(GameType,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) 
		ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=3
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE Level=1 

INSERT INTO #BetlimitCredit(GameType,Level,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		Level,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		s.StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=1 AND t.Level=1
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM #Betlimit WHERE Level=2 )

INSERT INTO #BetlimitCredit(GameType,Level,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		Level,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		s.StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=2 AND t.Level=2
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM #Betlimit WHERE Level=2 ) 

INSERT INTO StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT	StakeLevelID,
		GameType,
		REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','') AS MinLabel,
		CAST(CONVERT(FLOAT, REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS VARCHAR(100)) AS MaxLabel,
		CONVERT(DECIMAL(19,2),REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','')) AS Min,
		CONVERT(DECIMAL(19,2), REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS Max
FROM #BetlimitCredit

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT	StakeLevelID,
		GameType,
		REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','') AS MinLabel,
		CAST(CONVERT(FLOAT, REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS VARCHAR(100)) AS MaxLabel,
		CONVERT(DECIMAL(19,2),REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','')) AS Min,
		CONVERT(DECIMAL(19,2), REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS Max
FROM #BetlimitDeposit

DROP TABLE #BetlimitDeposit
DROP TABLE #BetlimitCredit
DROP TABLE #Betlimit
