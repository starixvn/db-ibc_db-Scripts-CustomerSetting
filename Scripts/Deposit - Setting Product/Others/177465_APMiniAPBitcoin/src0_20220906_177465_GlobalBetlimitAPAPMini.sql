/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20220907
	Task:	 Insert Setting StakeLevel [AdvantPlay & AdvantPlay Mini] - deposit RedmineID:#177465
	DB:		 DBCUST/CustDB
	P/s : Step 0 Insert Setting StakeLevel AdvantPlay & AdvantPlay Mini
*/
-- BEGIN STEP 0.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
PRINT N'Step 0: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT, ExchangeId INT, GameGroupID INT)
--AdvantPlay Mini								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,GameGroupID,ExchangeId)
SELECT 7801,30,9	UNION ALL     -- AUD
SELECT 7801,30,41				  -- CHF

--AdvantPlay
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,GameGroupID,ExchangeId)
SELECT 7701,28,86   UNION ALL     -- ARS
SELECT 7701,28,97	UNION ALL     -- BDT
SELECT 7701,28,46   UNION ALL     -- BND
SELECT 7701,28,82   UNION ALL     -- BRL
SELECT 7701,28,83   UNION ALL     -- CLP
SELECT 7701,28,6    UNION ALL     -- EURO
SELECT 7701,28,12   UNION ALL     -- GBP
SELECT 7701,28,80   UNION ALL     -- GHS
SELECT 7701,28,5    UNION ALL     -- HK$
SELECT 7701,28,92   UNION ALL     -- HID
SELECT 7701,28,32   UNION ALL     -- JPY
SELECT 7701,28,79   UNION ALL     -- KES
SELECT 7701,28,71   UNION ALL     -- KHR
SELECT 7701,28,93   UNION ALL     -- LAK
SELECT 7701,28,70   UNION ALL     -- MKK
SELECT 7701,28,94   UNION ALL     -- MK
SELECT 7701,28,49   UNION ALL     -- MXN
SELECT 7701,28,85   UNION ALL     -- PEN
SELECT 7701,28,56   UNION ALL     -- PLN
SELECT 7701,28,55	UNION ALL	  -- RUB
SELECT 7701,28,9	UNION ALL     -- AUD
SELECT 7701,28,41				  -- CHF

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = a.GameTypeID

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

--INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 0: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
--===============================================================================================
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevelGroupMini_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID INT DEFAULT(30))
								
INSERT INTO #Dep_StakeLevelGroupMini_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--AUD
SELECT 7801  ,'0.25'   ,'85'  ,0.25   ,85   ,9   UNION ALL	--AUD	--AUD
SELECT 7802  ,'0.25'   ,'85'  ,0.25   ,85   ,9   UNION ALL	--AUD	--AUD
-- CHF
SELECT 7801  ,'0.25'  ,'50'   ,0.25  ,50   ,41   UNION ALL	--CHF	--CHF
SELECT 7802  ,'0.25'  ,'50'   ,0.25  ,50   ,41				--CHF	--CHF

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevelGroupMini_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7801)

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
DROP TABLE #Dep_StakeLevelGroupMini_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
--===============================================================================================
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevelGroup_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID INT DEFAULT(28))
								
INSERT INTO #Dep_StakeLevelGroup_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--ARS
SELECT 7701 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7702 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7703 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7704 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7705 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7706 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7707 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7708 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7709 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7710 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7711 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7712 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7713 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7714 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7715 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7716 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7717 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7718 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7719 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7720 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7721 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7722 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7723 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7724 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
SELECT 7725 ,'20'   ,'5000'    ,20   ,5000    ,86   UNION ALL	--ARS	
-- BDT
SELECT 7701 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7702 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7703 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7704 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7705 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7706 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7707 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7708 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7709 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7710 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7711 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7712 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7713 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7714 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7715 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7716 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7717 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7718 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7719 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7720 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7721 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7722 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7723 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7724 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
SELECT 7725 ,'15'   ,'5000'    ,15   ,5000    ,97   UNION ALL	--BDT	
-- BND
SELECT 7701 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7702 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7703 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7704 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7705 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7706 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7707 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7708 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7709 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7710 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7711 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7712 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7713 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7714 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7715 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7716 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7717 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7718 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7719 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7720 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7721 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7722 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7723 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7724 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND	
SELECT 7725 ,'1'    ,'100'     ,1    ,100     ,46   UNION ALL	--BND
-- BRL
SELECT 7701 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7702 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7703 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7704 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7705 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7706 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7707 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7708 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7709 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7710 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7711 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7712 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7713 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7714 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7715 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7716 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7717 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7718 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7719 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7720 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7721 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7722 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7723 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7724 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL	
SELECT 7725 ,'1'    ,'500'     ,1    ,500     ,82   UNION ALL	--BRL
-- CLP
SELECT 7701 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7702 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7703 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7704 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7705 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7706 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7707 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7708 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7709 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7710 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7711 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7712 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7713 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7714 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7715 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7716 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7717 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7718 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7719 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7720 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7721 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7722 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7723 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7724 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP	
SELECT 7725 ,'150'  ,'50000'   ,150  ,50000   ,83   UNION ALL	--CLP
-- EURO
SELECT 7701 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7702 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7703 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7704 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7705 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7706 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7707 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7708 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7709 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7710 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7711 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7712 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7713 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7714 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7715 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7716 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7717 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7718 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7719 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7720 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7721 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7722 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7723 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7724 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
SELECT 7725 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO
-- GBP
SELECT 7701 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7702 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7703 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7704 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7705 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7706 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7707 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7708 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7709 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7710 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7711 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7712 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7713 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7714 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7715 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7716 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7717 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7718 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7719 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7720 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7721 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7722 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7723 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7724 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP
SELECT 7725 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP										    
-- GHS
SELECT 7701 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7702 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7703 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7704 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7705 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7706 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7707 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7708 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7709 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7710 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7711 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7712 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7713 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7714 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7715 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7716 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7717 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7718 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7719 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7720 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7721 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7722 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7723 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7724 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
SELECT 7725 ,'1'    ,'500'     ,1    ,500     ,80   UNION ALL	--GHS
-- HK$
SELECT 7701 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7702 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7703 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7704 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7705 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7706 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7707 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7708 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7709 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7710 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7711 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7712 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7713 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7714 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7715 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7716 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7717 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7718 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7719 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7720 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7721 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7722 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7723 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7724 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
SELECT 7725 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$
-- HID
SELECT 7701 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7702 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7703 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7704 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7705 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7706 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7707 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7708 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7709 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7710 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7711 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7712 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7713 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7714 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7715 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7716 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7717 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7718 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7719 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7720 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7721 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7722 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7723 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7724 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
SELECT 7725 ,'1'    ,'500'     ,1    ,500     ,92   UNION ALL	--HID
-- JPY
SELECT 7701 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7702 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7703 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7704 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7705 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7706 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7707 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7708 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7709 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7710 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7711 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7712 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7713 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7714 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7715 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7716 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7717 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7718 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7719 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7720 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7721 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7722 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7723 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7724 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
SELECT 7725 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY
-- KES
SELECT 7701 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7702 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7703 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7704 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7705 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7706 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7707 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7708 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7709 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7710 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7711 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7712 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7713 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7714 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7715 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7716 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7717 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7718 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7719 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7720 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7721 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7722 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7723 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7724 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
SELECT 7725 ,'25'   ,'10000'   ,25   ,10000   ,79   UNION ALL	--KES
-- LAK
SELECT 7701 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7702 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7703 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7704 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7705 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7706 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7707 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7708 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7709 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7710 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7711 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7712 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7713 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7714 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7715 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7716 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7717 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7718 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7719 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7720 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7721 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7722 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7723 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7724 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
SELECT 7725 ,'2000' ,'1000000' ,2000 ,1000000 ,93   UNION ALL	--LAK
-- MKK
SELECT 7701 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7702 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7703 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7704 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7705 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7706 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7707 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7708 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7709 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7710 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7711 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7712 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7713 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7714 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7715 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7716 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7717 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7718 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7719 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7720 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7721 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7722 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7723 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7724 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
SELECT 7725 ,'1'    ,'150'     ,1    ,150     ,70   UNION ALL	--MKK
-- MK
SELECT 7701 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7702 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7703 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7704 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7705 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7706 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7707 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7708 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7709 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7710 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7711 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7712 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7713 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7714 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7715 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7716 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7717 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7718 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7719 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7720 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7721 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7722 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7723 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7724 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
SELECT 7725 ,'1'    ,'150'     ,1    ,150     ,94   UNION ALL	--MK
-- MXN
SELECT 7701 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7702 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7703 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7704 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7705 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7706 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7707 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7708 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7709 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7710 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7711 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7712 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7713 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7714 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7715 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7716 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7717 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7718 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7719 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7720 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7721 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7722 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7723 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7724 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
SELECT 7725 ,'5'    ,'2000'    ,5    ,2000    ,49   UNION ALL	--MXN
-- PEN
SELECT 7701 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7702 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7703 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7704 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7705 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7706 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7707 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7708 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7709 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7710 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7711 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7712 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7713 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7714 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7715 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7716 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7717 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7718 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7719 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7720 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7721 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7722 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7723 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7724 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
SELECT 7725 ,'1'    ,'450'     ,1    ,450     ,85   UNION ALL	--PEN
-- PLN
SELECT 7701 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7702 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7703 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7704 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7705 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7706 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7707 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7708 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7709 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7710 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7711 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7712 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7713 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7714 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7715 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7716 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7717 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7718 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7719 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7720 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7721 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7722 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7723 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7724 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
SELECT 7725 ,'1'    ,'450'     ,1    ,450     ,56   UNION ALL	--PLN
-- RUB
SELECT 7701 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7702 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7703 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7704 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7705 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7706 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7707 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7708 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7709 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7710 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7711 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7712 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7713 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7714 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7715 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7716 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7717 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7718 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7719 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7720 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7721 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7722 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7723 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7724 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
SELECT 7725 ,'15'   ,'8000'    ,15   ,8000    ,55   UNION ALL	--RUB
-- AUD
SELECT 7701 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7702 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7703 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7704 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7705 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7706 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7707 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7708 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7709 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7710 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7711 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7712 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7713 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7714 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7715 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7716 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7717 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7718 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7719 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7720 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7721 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7722 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7723 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7724 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
SELECT 7725 ,'1'    ,'150'     ,1    ,150     ,9    UNION ALL	--AUD
-- AUD
SELECT 7701 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7702 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7703 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7704 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7705 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7706 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7707 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7708 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7709 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7710 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7711 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7712 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7713 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7714 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7715 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7716 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7717 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7718 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7719 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7720 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7721 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7722 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7723 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7724 ,'1'    ,'100'     ,1    ,100     ,41   UNION ALL	--CHF
SELECT 7725 ,'1'    ,'100'     ,1    ,100     ,41				--CHF

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevelGroup_Temp t
WHERE MaxStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #Dep_StakeLevelGroup_Temp t
WHERE MaxStake > 999999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevelGroup_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7701)

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
DROP TABLE #Dep_StakeLevelGroup_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';