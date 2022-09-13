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

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
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
SELECT 7801  ,'1'      ,'150'     ,1      ,150      ,9   UNION ALL	--AUD	--AUD
SELECT 7802  ,'1'      ,'150'     ,1      ,150      ,9   UNION ALL	--AUD	--AUD
-- CHF
SELECT 7801  ,'1'      ,'100'     ,1      ,100      ,41   UNION ALL	--CHF	--CHF
SELECT 7802  ,'1'      ,'100'     ,1      ,100      ,41				--CHF	--CHF

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
SELECT 7701 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7702 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7703 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7704 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7705 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7706 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7707 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7708 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7709 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7710 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7711 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7712 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7713 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7714 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7715 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7716 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7717 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7718 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7719 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7720 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7721 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7722 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7723 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7724 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
SELECT 7725 ,'6'    ,'6000'    ,6    ,6000    ,86   UNION ALL	--ARS	
-- BDT
SELECT 7701 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7702 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7703 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7704 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7705 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7706 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7707 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7708 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7709 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7710 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7711 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7712 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7713 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7714 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7715 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7716 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7717 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7718 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7719 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7720 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7721 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7722 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7723 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7724 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
SELECT 7725 ,'5'    ,'5000'    ,5    ,5000    ,97   UNION ALL	--BDT	
-- BND
SELECT 7701 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7702 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7703 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7704 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7705 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7706 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7707 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7708 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7709 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7710 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7711 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7712 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7713 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7714 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7715 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7716 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7717 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7718 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7719 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7720 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7721 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7722 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7723 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7724 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND	
SELECT 7725 ,'0.25' ,'80'      ,0.25  ,80     ,46   UNION ALL	--BND
-- BRL
SELECT 7701 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7702 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7703 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7704 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7705 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7706 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7707 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7708 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7709 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7710 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7711 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7712 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7713 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7714 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7715 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7716 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7717 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7718 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7719 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7720 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7721 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7722 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7723 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7724 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL	
SELECT 7725 ,'0.3'    ,'350'     ,0.3    ,350     ,82   UNION ALL	--BRL
-- CLP
SELECT 7701 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7702 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7703 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7704 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7705 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7706 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7707 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7708 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7709 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7710 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7711 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7712 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7713 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7714 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7715 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7716 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7717 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7718 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7719 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7720 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7721 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7722 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7723 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7724 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP	
SELECT 7725 ,'50'  ,'50000'   ,50  ,50000   ,83   UNION ALL	--CLP
-- EURO
SELECT 7701 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7702 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7703 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7704 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7705 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7706 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7707 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7708 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7709 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7710 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7711 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7712 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7713 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7714 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7715 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7716 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7717 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7718 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7719 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7720 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7721 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7722 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7723 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7724 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
SELECT 7725 ,'0.25'    ,'50'     ,0.25    ,50     ,6    UNION ALL	--EURO
-- GBP
SELECT 7701 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7702 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7703 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7704 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7705 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7706 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7707 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7708 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7709 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7710 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7711 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7712 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7713 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7714 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7715 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7716 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7717 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7718 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7719 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7720 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7721 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7722 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7723 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7724 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP
SELECT 7725 ,'0.25'    ,'45'     ,0.25    ,45     ,12   UNION ALL	--GBP										    
-- GHS
SELECT 7701 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7702 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7703 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7704 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7705 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7706 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7707 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7708 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7709 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7710 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7711 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7712 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7713 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7714 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7715 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7716 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7717 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7718 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7719 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7720 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7721 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7722 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7723 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7724 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
SELECT 7725 ,'0.5'    ,'400'     ,0.5    ,400     ,80   UNION ALL	--GHS
-- HK$
SELECT 7701 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7702 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7703 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7704 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7705 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7706 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7707 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7708 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7709 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7710 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7711 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7712 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7713 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7714 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7715 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7716 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7717 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7718 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7719 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7720 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7721 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7722 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7723 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7724 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
SELECT 7725 ,'0.5'    ,'450'     ,0.5    ,450     ,5    UNION ALL	--HK$
-- HID	
SELECT 7701 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7702 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7703 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7704 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7705 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7706 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7707 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7708 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7709 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7710 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7711 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7712 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7713 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7714 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7715 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7716 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7717 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7718 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7719 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7720 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7721 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7722 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7723 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7724 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
SELECT 7725 ,'0.5'    ,'450'     ,0.5    ,450     ,92   UNION ALL	--HID
-- JPY
SELECT 7701 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7702 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7703 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7704 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7705 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7706 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7707 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7708 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7709 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7710 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7711 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7712 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7713 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7714 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7715 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7716 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7717 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7718 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7719 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7720 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7721 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7722 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7723 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7724 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
SELECT 7725 ,'7.5'   ,'7000'   ,7.5   ,7000   ,32   UNION ALL	--JPY
-- KES
SELECT 7701 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7702 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7703 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7704 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7705 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7706 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7707 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7708 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7709 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7710 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7711 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7712 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7713 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7714 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7715 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7716 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7717 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7718 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7719 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7720 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7721 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7722 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7723 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7724 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
SELECT 7725 ,'7.5'   ,'7000'   ,7.5   ,7000   ,79   UNION ALL	--KES
-- KHR
SELECT 7701 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7702 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7703 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7704 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7705 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7706 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7707 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7708 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7709 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7710 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7711 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7712 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7713 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7714 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7715 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7716 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7717 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7718 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7719 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7720 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7721 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7722 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7723 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7724 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
SELECT 7725 ,'0.25'   ,'250'   ,0.25   ,250   ,71   UNION ALL	--KHR
-- LAK
SELECT 7701 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7702 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7703 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7704 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7705 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7706 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7707 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7708 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7709 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7710 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7711 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7712 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7713 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7714 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7715 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7716 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7717 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7718 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7719 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7720 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7721 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7722 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7723 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7724 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
SELECT 7725 ,'0.75'   ,'700'   ,0.75   ,700   ,93   UNION ALL	--LAK
-- MKK
SELECT 7701 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7702 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7703 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7704 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7705 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7706 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7707 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7708 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7709 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7710 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7711 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7712 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7713 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7714 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7715 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7716 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7717 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7718 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7719 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7720 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7721 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7722 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7723 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7724 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
SELECT 7725 ,'0.25'    ,'100'     ,0.25    ,100     ,70   UNION ALL	--MKK
-- MK		  
SELECT 7701 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7702 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7703 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7704 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7705 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7706 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7707 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7708 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7709 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7710 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7711 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7712 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7713 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7714 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7715 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7716 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7717 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7718 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7719 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7720 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7721 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7722 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7723 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7724 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
SELECT 7725 ,'0.25'    ,'100'     ,0.25    ,100     ,94   UNION ALL	--MK
-- MXN
SELECT 7701 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7702 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7703 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7704 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7705 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7706 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7707 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7708 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7709 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7710 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7711 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7712 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7713 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7714 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7715 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7716 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7717 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7718 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7719 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7720 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7721 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7722 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7723 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7724 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
SELECT 7725 ,'1.25'    ,'1200'    ,1.25    ,1200    ,49   UNION ALL	--MXN
-- PEN
SELECT 7701 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7702 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7703 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7704 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7705 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7706 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7707 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7708 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7709 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7710 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7711 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7712 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7713 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7714 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7715 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7716 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7717 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7718 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7719 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7720 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7721 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7722 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7723 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7724 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
SELECT 7725 ,'0.25'    ,'250'     ,0.25    ,250     ,85   UNION ALL	--PEN
-- PLN		 
SELECT 7701 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7702 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7703 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7704 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7705 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7706 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7707 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7708 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7709 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7710 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7711 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7712 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7713 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7714 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7715 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7716 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7717 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7718 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7719 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7720 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7721 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7722 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7723 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7724 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
SELECT 7725 ,'0.25'    ,'250'     ,0.25    ,250     ,56   UNION ALL	--PLN
-- RUB
SELECT 7701 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7702 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7703 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7704 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7705 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7706 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7707 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7708 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7709 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7710 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7711 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7712 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7713 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7714 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7715 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7716 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7717 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7718 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7719 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7720 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7721 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7722 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7723 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7724 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
SELECT 7725 ,'5'    ,'4500'    ,5    ,4500    ,55   UNION ALL	--RUB
-- AUD
SELECT 7701 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7702 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7703 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7704 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7705 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7706 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7707 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7708 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7709 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7710 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7711 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7712 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7713 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7714 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7715 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7716 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7717 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7718 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7719 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7720 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7721 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7722 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7723 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7724 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
SELECT 7725 ,'0.25'    ,'85'     ,0.25    ,85     ,9    UNION ALL	--AUD
-- AUD		
SELECT 7701 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7702 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7703 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7704 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7705 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7706 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7707 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7708 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7709 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7710 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7711 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7712 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7713 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7714 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7715 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7716 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7717 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7718 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7719 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7720 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7721 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7722 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7723 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7724 ,'0.25'    ,'50'     ,0.25    ,50     ,41   UNION ALL	--CHF
SELECT 7725 ,'0.25'    ,'50'     ,0.25    ,50     ,41				--CHF

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