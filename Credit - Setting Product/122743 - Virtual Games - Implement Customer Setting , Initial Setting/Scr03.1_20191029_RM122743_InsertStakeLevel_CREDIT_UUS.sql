/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games CREDIT - UUS
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
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 1, 5.00, 500.00) -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 2, 10.00, 1000.00) -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 3, 15.00, 2000.00) -- 

CREATE TABLE #BetlimitCredit(
	 GameTypeID   INT NOT NULL, 
	 Level        INT NOT NULL, 
	 CurrencyID   INT NOT NULL, 
	 [MinStake]   [MONEY] NULL, 
	 [MaxStake]   [MONEY] NULL, 
	 StakeLevelID INT NOT NULL,
	 PRIMARY KEY (StakeLevelID,GameTypeID)
);

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 0 AND GroupName = 'Level 1') gg
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND t.Level = 1
        AND e.exchangeid = s.ExchangeID

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 0 AND GroupName = 'Level 2') gg
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND t.Level = 2
        AND e.exchangeid = s.ExchangeID

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 0 AND GroupName = 'Level 3') gg
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND t.Level = 3
        AND e.exchangeid = s.ExchangeID
 
BEGIN --/* Insert StakeLevelGroupDetail
	INSERT INTO StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
	SELECT	a.StakeLevelID,
			a.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),a.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),a.MaxStake) AS MaxStake
	FROM #BetlimitCredit a
		LEFT JOIN StakeLevelGroupDetail s WITH(NOLOCK) ON a.StakeLevelID = s.StakeLevelID AND a.GameTypeID = S.GameTypeID
	WHERE s.StakeLevelID IS NULL
END -- Insert StakeLevelGroupDetail */

DROP TABLE #BetlimitCredit
