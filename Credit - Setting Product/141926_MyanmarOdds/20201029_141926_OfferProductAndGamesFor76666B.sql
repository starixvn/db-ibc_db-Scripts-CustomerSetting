/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201029
	Task: offer product and games for new site 76666B currency MMK RedmineID:#141926
	DB: DBCust/CustDB
*/

USE CustDB
GO

--============================================================================== 
--Update PT RNG Keno

UPDATE ProductGlobalSetting  WITH(UPDLOCK,ROWLOCK)
SET MaxPositiontaking = 0.9
WHERE Sporttype = 202 --RNG Keno

--Update PT Lottery, Table Game, RNG War

UPDATE ProductSettingDetail  WITH(UPDLOCK,ROWLOCK)
SET MaxPT = 90
WHERE Sporttype in (220,222,224) AND SettingType = 18 AND ProductID = 44

--==============================================================================
--Add Bet Limit Arcadia Mini Games and Arcadia Lotto

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(9))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--MMK
SELECT 1902 ,'1'    ,'500'     ,1    ,500     ,69   UNION ALL	--BigSmall 
SELECT 1903 ,'1'    ,'500'     ,1    ,500     ,69	UNION ALL	--OddEven
SELECT 1904 ,'1'    ,'500'     ,1    ,500     ,69   UNION ALL	--Lotto3
SELECT 1905 ,'1'    ,'500'     ,1    ,500     ,69				--11HiLo

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 1901)

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


--==============================================================================
--Offer Arcadia Mini Games and Arcadia Lotto for 789y and 76666B

CREATE TABLE #Sport_Temp (SportType SMALLINT,BetType INT)

INSERT INTO #Sport_Temp (SportType,BetType)
SELECT 165 as SportType,1902 as BetType --BigSmall 
UNION ALL
SELECT 165 as SportType,1903 as BetType --OddEven
UNION ALL
SELECT 165 as SportType,1904 as BetType --Lotto3
UNION ALL
SELECT 165 as SportType,1905 as BetType --11HiLo

--Delete data exists
DELETE a FROM SportNonOfferedSiteCurrency a INNER JOIN #Sport_Temp b ON a.SportType = b.SportType AND a.BetType = b.BetType

INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
-- Sited non Offered games
SELECT b.SportType,b.BetType,0 AS Currency,a.siteid AS SiteID
FROM Site  a WITH(NOLOCK)
INNER JOIN #Sport_Temp b ON a.isActive = 1 AND a.isLicensee = 0 AND a.isDeposit = 0 AND siteid not in (3,547,1)
UNION ALl
-- Site BEST-ODDS Currency UUS
SELECT b.SportType,b.BetType,a.ExchangeId AS Currency,1 AS SiteID
FROM exchange  a WITH(NOLOCK)
INNER JOIN #Sport_Temp b ON a.isActive = 1 AND a.OfferSite in (0,1) AND a.ExchangeId <> 20

DROP TABLE #Sport_Temp