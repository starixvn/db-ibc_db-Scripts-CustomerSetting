/*
	Created: 20210224@Tina
	Task: Insert StakeLevelGroupDetail for Habanero - UUS Credit
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO 

PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(21))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 7001 ,'0.5' ,'1250'	,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7002 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7003 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7004 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7005 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7006 ,'0.16' ,'400'  ,0.16 ,400      ,20   UNION ALL --UUS
SELECT 7007 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7008 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7009 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7010 ,'0.56' ,'1400' ,0.56 ,1400      ,20   UNION ALL --UUS
SELECT 7011 ,'0.2' ,'500'   ,0.2 ,500      ,20   UNION ALL --UUS
SELECT 7012 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7013 ,'0.56' ,'1400' ,0.56 ,1400      ,20   UNION ALL --UUS
SELECT 7014 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7015 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7016 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7017 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7018 ,'0.56' ,'1400' ,0.56 ,1400      ,20   UNION ALL --UUS
SELECT 7019 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7020 ,'0.5' ,'250'   ,0.5 ,250      ,20   UNION ALL --UUS
SELECT 7021 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7022 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7023 ,'1.76' ,'880'  ,1.76 ,880      ,20   UNION ALL --UUS
SELECT 7024 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7025 ,'0.8' ,'1000'  ,0.8 ,1000      ,20   UNION ALL --UUS
SELECT 7026 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7027 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7028 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7029 ,'0.56' ,'1400' ,0.56 ,1400      ,20   UNION ALL --UUS
SELECT 7030 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7031 ,'0.36' ,'900'  ,0.36 ,900      ,20   UNION ALL --UUS
SELECT 7032 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7033 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7034 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7035 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7036 ,'0.3' ,'750'   ,0.3 ,750      ,20   UNION ALL --UUS
SELECT 7037 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7038 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7039 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7040 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7041 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7042 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7043 ,'0.36' ,'900'  ,0.36 ,900      ,20   UNION ALL --UUS
SELECT 7044 ,'0.6' ,'1500'  ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7045 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7046 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7047 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7048 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7049 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7050 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7051 ,'0.36' ,'900'  ,0.36 ,900      ,20   UNION ALL --UUS
SELECT 7052 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7053 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7054 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7055 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7056 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7057 ,'0.56' ,'1400' ,0.56 ,1400      ,20   UNION ALL --UUS
SELECT 7058 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7059 ,'0.5' ,'1250'  ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7060 ,'0.4' ,'1000'  ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7061 ,'1' ,'1250'    ,1 ,1250      ,20   UNION ALL --UUS
SELECT 7062 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7063 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7064 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7065 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7066 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7067 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7068 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7069 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7070 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7071 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7072 ,'0.6' ,'1500'      ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7073 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7074 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7075 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7076 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7077 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7078 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7079 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7080 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7081 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7082 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7083 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7084 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7085 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7086 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7087 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7088 ,'1'   ,'1250'      ,1   ,1250      ,20   UNION ALL --UUS
SELECT 7089 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7090 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7091 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7092 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7093 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7094 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7095 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7096 ,'1'   ,'1250'      ,1   ,1250      ,20   UNION ALL --UUS
SELECT 7097 ,'0.6' ,'1500'      ,0.6 ,1500      ,20   UNION ALL --UUS
SELECT 7098 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7099 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7101 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7102 ,'0.4' ,'1000'      ,0.4 ,1000      ,20   UNION ALL --UUS
SELECT 7103 ,'1'   ,'1250'      ,1   ,1250      ,20   UNION ALL --UUS
SELECT 7104 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7105 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7106 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7107 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7108 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7109 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7110 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7111 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7112 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7113 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7114 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7115 ,'0.5' ,'1250'      ,0.5 ,1250      ,20   UNION ALL --UUS
SELECT 7116 ,'0.5' ,'1250'      ,0.5 ,1250      ,20	  UNION ALL --UUS
--YNG
SELECT 7001 ,'0.5' ,'1250'	,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7002 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7003 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7004 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7005 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7006 ,'0.16' ,'400'  ,0.16 ,400      ,72   UNION ALL --YNG
SELECT 7007 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7008 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7009 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7010 ,'0.56' ,'1400' ,0.56 ,1400      ,72   UNION ALL --YNG
SELECT 7011 ,'0.2' ,'500'   ,0.2 ,500      ,72   UNION ALL --YNG
SELECT 7012 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7013 ,'0.56' ,'1400' ,0.56 ,1400      ,72   UNION ALL --YNG
SELECT 7014 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7015 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7016 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7017 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7018 ,'0.56' ,'1400' ,0.56 ,1400      ,72   UNION ALL --YNG
SELECT 7019 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7020 ,'0.5' ,'250'   ,0.5 ,250      ,72   UNION ALL --YNG
SELECT 7021 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7022 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7023 ,'1.76' ,'880'  ,1.76 ,880      ,72   UNION ALL --YNG
SELECT 7024 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7025 ,'0.8' ,'1000'  ,0.8 ,1000      ,72   UNION ALL --YNG
SELECT 7026 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7027 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7028 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7029 ,'0.56' ,'1400' ,0.56 ,1400      ,72   UNION ALL --YNG
SELECT 7030 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7031 ,'0.36' ,'900'  ,0.36 ,900      ,72   UNION ALL --YNG
SELECT 7032 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7033 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7034 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7035 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7036 ,'0.3' ,'750'   ,0.3 ,750      ,72   UNION ALL --YNG
SELECT 7037 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7038 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7039 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7040 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7041 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7042 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7043 ,'0.36' ,'900'  ,0.36 ,900      ,72   UNION ALL --YNG
SELECT 7044 ,'0.6' ,'1500'  ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7045 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7046 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7047 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7048 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7049 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7050 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7051 ,'0.36' ,'900'  ,0.36 ,900      ,72   UNION ALL --YNG
SELECT 7052 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7053 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7054 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7055 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7056 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7057 ,'0.56' ,'1400' ,0.56 ,1400      ,72   UNION ALL --YNG
SELECT 7058 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7059 ,'0.5' ,'1250'  ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7060 ,'0.4' ,'1000'  ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7061 ,'1' ,'1250'    ,1 ,1250      ,72   UNION ALL --YNG
SELECT 7062 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7063 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7064 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7065 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7066 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7067 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7068 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7069 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7070 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7071 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7072 ,'0.6' ,'1500'      ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7073 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7074 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7075 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7076 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7077 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7078 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7079 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7080 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7081 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7082 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7083 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7084 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7085 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7086 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7087 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7088 ,'1'   ,'1250'      ,1   ,1250      ,72   UNION ALL --YNG
SELECT 7089 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7090 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7091 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7092 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7093 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7094 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7095 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7096 ,'1'   ,'1250'      ,1   ,1250      ,72   UNION ALL --YNG
SELECT 7097 ,'0.6' ,'1500'      ,0.6 ,1500      ,72   UNION ALL --YNG
SELECT 7098 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7099 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7101 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7102 ,'0.4' ,'1000'      ,0.4 ,1000      ,72   UNION ALL --YNG
SELECT 7103 ,'1'   ,'1250'      ,1   ,1250      ,72   UNION ALL --YNG
SELECT 7104 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7105 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7106 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7107 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7108 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7109 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7110 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7111 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7112 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7113 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7114 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7115 ,'0.5' ,'1250'      ,0.5 ,1250      ,72   UNION ALL --YNG
SELECT 7116 ,'0.5' ,'1250'      ,0.5 ,1250      ,72				--YNG

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

DELETE  a
FROM StakeLevelGroupDetail a
INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 7001 AND b.ExchangeId IN (SELECT DISTINCT ExchangeId FROM #StakeLevel_Temp)

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7001)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 