/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220310
	Task: Insert Setting StakeLevel - Deposit - Real Currency API Licensees  RedmineID:#168831
	DB: DBCUST/CustDB
	
	P/s : Step 0 initial Setting StakeLevel
*/

USE CustDB
GO

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId INT,
								GameGroupID INT DEFAULT(22))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7001, 9    UNION ALL --AUD
SELECT 7001, 41   UNION ALL --CHF
SELECT 7001, 71			    --KHR

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7001

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,
	StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(22))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--AUD
SELECT 7001 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7002 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7003 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7004 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7005 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7006 ,'0.08'     ,'40'          ,0.08     ,40          ,9    UNION ALL	--AUD	--AUD
SELECT 7007 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7008 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7009 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7010 ,'0.28'     ,'140'         ,0.28     ,140         ,9    UNION ALL	--AUD	--AUD
SELECT 7011 ,'0.1'      ,'50'          ,0.1      ,50          ,9    UNION ALL	--AUD	--AUD
SELECT 7012 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7013 ,'0.28'     ,'140'         ,0.28     ,140         ,9    UNION ALL	--AUD	--AUD
SELECT 7014 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7015 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7016 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7017 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7018 ,'0.28'     ,'140'         ,0.28     ,140         ,9    UNION ALL	--AUD	--AUD
SELECT 7019 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7020 ,'0.25'     ,'25'          ,0.25     ,25          ,9    UNION ALL	--AUD	--AUD
SELECT 7021 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7022 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7023 ,'0.88'     ,'88'          ,0.88     ,88          ,9    UNION ALL	--AUD	--AUD
SELECT 7024 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7025 ,'0.4'      ,'100'         ,0.4      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7026 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7027 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7028 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7029 ,'0.28'     ,'140'         ,0.28     ,140         ,9    UNION ALL	--AUD	--AUD
SELECT 7030 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7031 ,'0.18'     ,'90'          ,0.18     ,90          ,9    UNION ALL	--AUD	--AUD
SELECT 7032 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7033 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7034 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7035 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7036 ,'0.15'     ,'75'          ,0.15     ,75          ,9    UNION ALL	--AUD	--AUD
SELECT 7037 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7038 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7039 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7040 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7041 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7042 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7043 ,'0.18'     ,'90'          ,0.18     ,90          ,9    UNION ALL	--AUD	--AUD
SELECT 7044 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7045 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7046 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7047 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7048 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7049 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7050 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7051 ,'0.18'     ,'90'          ,0.18     ,90          ,9    UNION ALL	--AUD	--AUD
SELECT 7052 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7053 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7054 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7055 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7056 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7057 ,'0.28'     ,'140'         ,0.28     ,140         ,9    UNION ALL	--AUD	--AUD
SELECT 7058 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7059 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7060 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7061 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7062 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7063 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7064 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7065 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7066 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7067 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7068 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7069 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7070 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7071 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7072 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7073 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7074 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7075 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7076 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7077 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7078 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7079 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7080 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7081 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7082 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7083 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7084 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7085 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7086 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7087 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7088 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7089 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7090 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7091 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7092 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7093 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7094 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7095 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7096 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7097 ,'0.3'      ,'150'         ,0.3      ,150         ,9    UNION ALL	--AUD	--AUD
SELECT 7098 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7099 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7101 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7102 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 7103 ,'0.5'      ,'125'         ,0.5      ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7104 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7105 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7106 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7107 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7108 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7109 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7110 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7111 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7112 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7113 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7114 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7115 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
SELECT 7116 ,'0.25'     ,'125'         ,0.25     ,125         ,9    UNION ALL	--AUD	--AUD
--CHF
SELECT 7001 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7002 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7003 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7004 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7005 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7006 ,'0.08'     ,'40'          ,0.08     ,40          ,41   UNION ALL	--CHF	--CHF
SELECT 7007 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7008 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7009 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7010 ,'0.28'     ,'140'         ,0.28     ,140         ,41   UNION ALL	--CHF	--CHF
SELECT 7011 ,'0.1'      ,'50'          ,0.1      ,50          ,41   UNION ALL	--CHF	--CHF
SELECT 7012 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7013 ,'0.28'     ,'140'         ,0.28     ,140         ,41   UNION ALL	--CHF	--CHF
SELECT 7014 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7015 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7016 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7017 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7018 ,'0.28'     ,'140'         ,0.28     ,140         ,41   UNION ALL	--CHF	--CHF
SELECT 7019 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7020 ,'0.25'     ,'25'          ,0.25     ,25          ,41   UNION ALL	--CHF	--CHF
SELECT 7021 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7022 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7023 ,'0.88'     ,'88'          ,0.88     ,88          ,41   UNION ALL	--CHF	--CHF
SELECT 7024 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7025 ,'0.4'      ,'100'         ,0.4      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7026 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7027 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7028 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7029 ,'0.28'     ,'140'         ,0.28     ,140         ,41   UNION ALL	--CHF	--CHF
SELECT 7030 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7031 ,'0.18'     ,'90'          ,0.18     ,90          ,41   UNION ALL	--CHF	--CHF
SELECT 7032 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7033 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7034 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7035 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7036 ,'0.15'     ,'75'          ,0.15     ,75          ,41   UNION ALL	--CHF	--CHF
SELECT 7037 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7038 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7039 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7040 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7041 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7042 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7043 ,'0.18'     ,'90'          ,0.18     ,90          ,41   UNION ALL	--CHF	--CHF
SELECT 7044 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7045 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7046 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7047 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7048 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7049 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7050 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7051 ,'0.18'     ,'90'          ,0.18     ,90          ,41   UNION ALL	--CHF	--CHF
SELECT 7052 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7053 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7054 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7055 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7056 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7057 ,'0.28'     ,'140'         ,0.28     ,140         ,41   UNION ALL	--CHF	--CHF
SELECT 7058 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7059 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7060 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7061 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7062 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7063 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7064 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7065 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7066 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7067 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7068 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7069 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7070 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7071 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7072 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7073 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7074 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7075 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7076 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7077 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7078 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7079 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7080 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7081 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7082 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7083 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7084 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7085 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7086 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7087 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7088 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7089 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7090 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7091 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7092 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7093 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7094 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7095 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7096 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7097 ,'0.3'      ,'150'         ,0.3      ,150         ,41   UNION ALL	--CHF	--CHF
SELECT 7098 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7099 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7101 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7102 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 7103 ,'0.5'      ,'125'         ,0.5      ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7104 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7105 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7106 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7107 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7108 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7109 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7110 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7111 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7112 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7113 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7114 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7115 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
SELECT 7116 ,'0.25'     ,'125'         ,0.25     ,125         ,41   UNION ALL	--CHF	--CHF
--KHR
SELECT 7001 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7002 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7003 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7004 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7005 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7006 ,'0.08'     ,'160'         ,0.08     ,160         ,71   UNION ALL	--KHR	--KHR
SELECT 7007 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7008 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7009 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7010 ,'0.28'     ,'560'         ,0.28     ,560         ,71   UNION ALL	--KHR	--KHR
SELECT 7011 ,'0.1'      ,'500'         ,0.1      ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7012 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7013 ,'0.28'     ,'560'         ,0.28     ,560         ,71   UNION ALL	--KHR	--KHR
SELECT 7014 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7015 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7016 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7017 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7018 ,'0.28'     ,'560'         ,0.28     ,560         ,71   UNION ALL	--KHR	--KHR
SELECT 7019 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7020 ,'0.25'     ,'250'         ,0.25     ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7021 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7022 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7023 ,'0.88'     ,'220'         ,0.88     ,220         ,71   UNION ALL	--KHR	--KHR
SELECT 7024 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7025 ,'0.4'      ,'200'         ,0.4      ,200         ,71   UNION ALL	--KHR	--KHR
SELECT 7026 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7027 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7028 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7029 ,'0.28'     ,'560'         ,0.28     ,560         ,71   UNION ALL	--KHR	--KHR
SELECT 7030 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7031 ,'0.18'     ,'360'         ,0.18     ,360         ,71   UNION ALL	--KHR	--KHR
SELECT 7032 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7033 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7034 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7035 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7036 ,'0.15'     ,'750'         ,0.15     ,750         ,71   UNION ALL	--KHR	--KHR
SELECT 7037 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7038 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7039 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7040 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7041 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7042 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7043 ,'0.18'     ,'360'         ,0.18     ,360         ,71   UNION ALL	--KHR	--KHR
SELECT 7044 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7045 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7046 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7047 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7048 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7049 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7050 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7051 ,'0.18'     ,'360'         ,0.18     ,360         ,71   UNION ALL	--KHR	--KHR
SELECT 7052 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7053 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7054 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7055 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7056 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7057 ,'0.28'     ,'560'         ,0.28     ,560         ,71   UNION ALL	--KHR	--KHR
SELECT 7058 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7059 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7060 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7061 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7062 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7063 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7064 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7065 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7066 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7067 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7068 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7069 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7070 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7071 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7072 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7073 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7074 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7075 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7076 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7077 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7078 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7079 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7080 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7081 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7082 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7083 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7084 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7085 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7086 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7087 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7088 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7089 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7090 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7091 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7092 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7093 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7094 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7095 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7096 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7097 ,'0.3'      ,'600'         ,0.3      ,600         ,71   UNION ALL	--KHR	--KHR
SELECT 7098 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7099 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7101 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7102 ,'0.2'      ,'400'         ,0.2      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 7103 ,'0.5'      ,'250'         ,0.5      ,250         ,71   UNION ALL	--KHR	--KHR
SELECT 7104 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7105 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7106 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7107 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7108 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7109 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7110 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7111 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7112 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7113 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7114 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7115 ,'0.25'     ,'500'         ,0.25     ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 7116 ,'0.25'     ,'500'         ,0.25     ,500         ,71				--KHR	--KHR

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7001)

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

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 


