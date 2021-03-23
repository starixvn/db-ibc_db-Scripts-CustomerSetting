/*<info serverAlias="DBCUST-CUSTDB"></info>*/

/*
	Created: 20210323@Tina
	Task: GDG - Remove un-used bet limit for Macaubet licensee [RedmineID: 152114]
	DB: DBCUST/CUSTDB
*/

USE [CustDB]
GO

DECLARE @MinStackLevelID INT
DECLARE @AdjustList TABLE (StakeLevelID INT, MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8))

INSERT INTO @AdjustList (StakeLevelID, MinStake, MaxStake)
SELECT StakeLevelID, MinStake, MaxStake
FROM Dep_StakeLevel D WITH (NOLOCK)
WHERE D.GameTypeID = 5701 AND SiteID = 53 AND ExchangeID = 15

;WITH tempMinStack AS
(
	SELECT DISTINCT M.StakeLevelList
	FROM Dep_CustStakeLevel_Member M WITH (NOLOCK)
		JOIN Customer C WITH (NOLOCK) ON M.CustID = C.CustID
	WHERE C.currency = 15 AND C.site = 'Macaubet' AND M.BetType = 5701
)
SELECT TOP 1 @MinStackLevelID = CAST(StakeLevelList AS INT)
FROM tempMinStack
WHERE StakeLevelList NOT LIKE '%,%'

DELETE @AdjustList WHERE StakeLevelID = @MinStackLevelID

--Step 1: Update table Dep_CustStakeLevel_Agent
	UPDATE M SET M.StakeLevelList = CAST(@MinStackLevelID AS VARCHAR(8))
	FROM Dep_CustStakeLevel_Agent M WITH (ROWLOCK)
		JOIN Customer C WITH (NOLOCK) ON M.CustID = C.CustID
	WHERE C.currency = 15 AND C.site = 'Macaubet' AND M.BetType = 5701

--Step 2: Remove StakeLevel not used anymore
	DELETE SL
	FROM @AdjustList AL 
		JOIN Dep_StakeLevel SL WITH (ROWLOCK) ON SL.StakeLevelID = AL.StakeLevelID

--Step 3: Update MaxBet of 1st level to "15000"
	UPDATE Dep_StakeLevel WITH (ROWLOCK) SET MaxStake = 15000
							 ,MaxLabel = '15,000'
	WHERE StakeLevelID = @MinStackLevelID


SELECT @MinStackLevelID Remaining
SELECT * FROM @AdjustList
/*
SELECT StakeLevelID, MinStake, MaxStake, MinLabel, MaxLabel
FROM Dep_StakeLevel D WITH (NOLOCK)
WHERE D.GameTypeID = 5701 AND SiteID = 53 AND ExchangeID = 15

SELECT DISTINCT M.StakeLevelList
FROM Dep_CustStakeLevel_Member M WITH (NOLOCK)
	JOIN Customer C WITH (NOLOCK) ON M.CustID = C.CustID
WHERE C.currency = 15 AND C.site = 'Macaubet' AND M.BetType = 5701

SELECT DISTINCT M.StakeLevelList
FROM Dep_CustStakeLevel_Agent M WITH (NOLOCK)
	JOIN Customer C WITH (NOLOCK) ON M.CustID = C.CustID
WHERE C.currency = 15 AND C.site = 'Macaubet' AND M.BetType = 5701
*/
