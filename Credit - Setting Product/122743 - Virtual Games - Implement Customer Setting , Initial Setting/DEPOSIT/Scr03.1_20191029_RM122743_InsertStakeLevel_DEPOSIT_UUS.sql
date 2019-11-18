/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games DEPOSIT - UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DELETE  
FROM DEP_StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	  AND exchangeid = 20

DECLARE @DEP_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 5.00, 500.00) -- 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 10.00, 1000.00) -- 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 15.00, 2000.00) -- 

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

BEGIN --/* Insert StakeLevel
	INSERT INTO DEP_StakeLevel(
		 GameTypeID
		,MinLabel
		,MaxLabel
		,MinStake
		,MaxStake
		,ExchangeId
		,GameGroupID
		,StakeLevelID
	)
	SELECT	t.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,t.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,t.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0,
			StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
	FROM @DEP_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
END -- Insert StakeLevel */
