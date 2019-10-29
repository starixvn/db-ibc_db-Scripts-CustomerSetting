/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @CRE_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[Level] [int] NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 


DECLARE @DEP_Stake TABLE(
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[Level] [int] NOT NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 

INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 1, 5, 2250)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'UUS', 1, 1, 2250)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'UUS', 1, 1, 2250)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'UUS', 1, 2, 500)

--------------------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 1, 5, 2250)
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'UUS', 1, 1, 2250)
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'UUS', 1, 1, 2250)
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'UUS', 1, 2, 500)

CREATE TABLE #BetlimitCredit(
	 GameTypeID   INT NOT NULL, 
	 Level        INT NOT NULL, 
	 CurrencyID   INT NOT NULL, 
	 [MinStake]   [MONEY] NULL, 
	 [MaxStake]   [MONEY] NULL, 
	 StakeLevelID INT NOT NULL,
	 PRIMARY KEY (StakeLevelID,GameTypeID)
);

CREATE TABLE #BetlimitDeposit(
	 GameTypeID   INT NOT NULL, 
	 CurrencyID   INT NOT NULL, 
	 [MinStake]   [MONEY] NULL, 
	 [MaxStake]   [MONEY] NULL, 
	 StakeLevelID INT NOT NULL,
	 PRIMARY KEY (StakeLevelID,GameTypeID)
);

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END, 
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency)) = e.Code
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = 13
        AND t.Level = 1
        AND CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END = s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM @CRE_Stake WHERE Level = 1);


INSERT INTO #BetlimitDeposit(GameTypeID,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID,
       CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END, 
       t.MinStake, 
       t.MaxStake, 
       StakeLevelID
FROM @DEP_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency)) = e.Code
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = 14
        AND CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END = s.ExchangeID
WHERE Level = 1;
 
BEGIN --/* Insert StakeLevelGroupDetail

	INSERT INTO StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
	SELECT	a.StakeLevelID,
			a.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),a.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),a.MaxStake) AS MaxStake
	FROM #BetlimitCredit a

	INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
	SELECT	a.StakeLevelID,
			a.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),a.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),a.MaxStake) AS MaxStake
	FROM #BetlimitDeposit a

END -- Insert StakeLevelGroupDetail */

DROP TABLE #BetlimitDeposit
DROP TABLE #BetlimitCredit
