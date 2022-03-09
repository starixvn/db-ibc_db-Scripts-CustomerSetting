/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211210
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate 20 new games for Deposit UUS [Redmine:165393]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId INT)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--YNG
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,72				--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
WHERE s.GameTypeID = 4101)

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
DROP TABLE #StakeLevel_Temp